// Shell.

#include "types.h"
#include "user.h"
#include "fcntl.h"

#define HISTORY_SIZE 10
#define CMD_BUF_SIZE 100
// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define MAXARGS 10
char current_dir[100] = "/";
// Custom string concatenation for xv6
char* strcat(char *dst, const char *src) {
    char *p = dst;
    while (*p) p++;        // Find the end of the destination string
    while ((*p++ = *src++)); // Copy source onto the end
    return dst;
}

struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;
  struct cmd *cmd;
  char *file;
  char *efile;
  int mode;
  int fd;
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      exit();
    char path[128];
    if(ecmd->argv[0][0] != '/') {
      strcpy(path, "/");
      strcat(path, ecmd->argv[0]);
      exec(path, ecmd->argv);
  } else {
      exec(ecmd->argv[0], ecmd->argv);
  }

  printf(2, "exec %s failed\n", ecmd->argv[0]);
  break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
      exit();
    }
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
    wait();
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    close(p[1]);
    wait();
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
}

char history[HISTORY_SIZE][CMD_BUF_SIZE];
int history_count = 0;
int history_index = -1;

int
getcmd(char *buf, int nbuf) {
    // 1. THE CUSTOM PROMPT
    // Prints a sleek, multi-colored modern prompt: [ducko@xv6:/]$
    // \x1b[32m = Green, \x1b[34m = Blue, \x1b[0m = Reset color
    printf(1, "[ducko@xv6:%s]$ ", current_dir);

    memset(buf, 0, nbuf);
    int i = 0;
    char c;

    // Read input character by character to catch arrow keys
    while(read(0, &c, 1) == 1) {
        if(c == '\n' || c == '\r') {
            buf[i] = '\0';
            printf(1, "\n");
            
            // Save non-empty commands to history ring buffer
            if(i > 0) {
                if(history_count < HISTORY_SIZE) {
                    strcpy(history[history_count], buf);
                    history_count++;
                } else {
                    // Shift older history left
                    for(int j = 1; j < HISTORY_SIZE; j++) {
                        strcpy(history[j-1], history[j]);
                    }
                    strcpy(history[HISTORY_SIZE-1], buf);
                }
            }
            history_index = history_count; // Reset history selector
            break;
        }

        // BACKSPACE handling
        if(c == '\b' || c == 127) {
            if(i > 0) {
                i--;
                printf(1, "\b \b");
            }
            continue;
        }

        // 2. ARROW KEY INTERCEPTION (Escape sequences)
        // Arrow keys send 3-byte sequences: \x1b, '[', and then 'A'(Up) or 'B'(Down)
        if(c == '\x1b') {
            char seq[2];
            if(read(0, &seq[0], 1) == 1 && read(0, &seq[1], 1) == 1) {
                if(seq[0] == '[') {
                    if(seq[1] == 'A') { // UP ARROW
                        if(history_count > 0 && history_index > 0) {
                            history_index--;
                            // Clear current typed line on screen
                            while(i > 0) { printf(1, "\b \b"); i--; }
                            // Load and print historical command
                            strcpy(buf, history[history_index]);
                            i = strlen(buf);
                            printf(1, "%s", buf);
                        }
                    } 
                    else if(seq[1] == 'B') { // DOWN ARROW
                        if(history_index < history_count - 1) {
                            history_index++;
                            while(i > 0) { printf(1, "\b \b"); i--; }
                            strcpy(buf, history[history_index]);
                            i = strlen(buf);
                            printf(1, "%s", buf);
                        } else if(history_index == history_count - 1) {
                            history_index++;
                            while(i > 0) { printf(1, "\b \b"); i--; }
                            buf[0] = '\0';
                            i = 0;
                        }
                    }
                }
            }
            continue;
        }

        // Standard character entry
        if(i < nbuf - 1) {
            buf[i++] = c;
           // printf(1, "%c", c); // Echo character back to screen
        }
    }

    if(buf[0] == 0 && i == 0) return -1; // EOF handling
    return 0;
}

int
main(void)
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
  if(strcmp(buf, "reboot") == 0) strcpy(buf, "power reboot");
  if(strcmp(buf, "shutdown") == 0) strcpy(buf, "power shutdown");
    }
  }

  // Read and run input commands.
  // Read and run commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
     // buf[strlen(buf)-1] = 0;  // chop \n
      
      // --- THIS IS THE NEW MODIFIED BLOCK ---
      if(chdir(buf+3) < 0){
        printf(2, "cannot cd %s\n", buf+3);
      } else {
        if(strcmp(buf+3, "/") == 0 || strcmp(buf+3, "..") == 0) {
            strcpy(current_dir, "/");
        } else {
            if(strcmp(current_dir, "/") != 0) {
                strcat(current_dir, "/");
            }
            strcat(current_dir, buf+3);
        }
      }
      // --------------------------------------

      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
}

void
panic(char *s)
{
  printf(2, "%s\n", s);
  exit();
}

int
fork1(void)
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
