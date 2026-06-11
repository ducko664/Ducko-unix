
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f de 00 00 00    	jg     ff <main+0xff>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 a0 16 00 00       	push   $0x16a0
      2b:	e8 93 11 00 00       	call   11c3 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 32                	jmp    6b <main+0x6b>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Read and run input commands.
  // Read and run commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 22 22 00 00 20 	cmpb   $0x20,0x2222
      47:	74 59                	je     a2 <main+0xa2>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 26 11 00 00       	call   117b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 28 01 00 00    	je     186 <main+0x186>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 0b 01 00 00    	je     171 <main+0x171>
    wait();
      66:	e8 20 11 00 00       	call   118b <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      6b:	83 ec 08             	sub    $0x8,%esp
      6e:	6a 64                	push   $0x64
      70:	68 20 22 00 00       	push   $0x2220
      75:	e8 66 01 00 00       	call   1e0 <getcmd>
      7a:	83 c4 10             	add    $0x10,%esp
      7d:	85 c0                	test   %eax,%eax
      7f:	78 17                	js     98 <main+0x98>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      81:	80 3d 20 22 00 00 63 	cmpb   $0x63,0x2220
      88:	75 c6                	jne    50 <main+0x50>
      8a:	80 3d 21 22 00 00 64 	cmpb   $0x64,0x2221
      91:	75 bd                	jne    50 <main+0x50>
      93:	eb ab                	jmp    40 <main+0x40>
      95:	8d 76 00             	lea    0x0(%esi),%esi
}
      98:	8b 4d fc             	mov    -0x4(%ebp),%ecx
      9b:	31 c0                	xor    %eax,%eax
      9d:	c9                   	leave
      9e:	8d 61 fc             	lea    -0x4(%ecx),%esp
      a1:	c3                   	ret
      if(chdir(buf+3) < 0){
      a2:	83 ec 0c             	sub    $0xc,%esp
      a5:	68 23 22 00 00       	push   $0x2223
      aa:	e8 44 11 00 00       	call   11f3 <chdir>
      af:	83 c4 10             	add    $0x10,%esp
      b2:	85 c0                	test   %eax,%eax
      b4:	78 5a                	js     110 <main+0x110>
        if(strcmp(buf+3, "/") == 0 || strcmp(buf+3, "..") == 0) {
      b6:	50                   	push   %eax
      b7:	50                   	push   %eax
      b8:	68 0c 16 00 00       	push   $0x160c
      bd:	68 23 22 00 00       	push   $0x2223
      c2:	e8 a9 0e 00 00       	call   f70 <strcmp>
      c7:	83 c4 10             	add    $0x10,%esp
      ca:	85 c0                	test   %eax,%eax
      cc:	74 18                	je     e6 <main+0xe6>
      ce:	50                   	push   %eax
      cf:	50                   	push   %eax
      d0:	68 b6 16 00 00       	push   $0x16b6
      d5:	68 23 22 00 00       	push   $0x2223
      da:	e8 91 0e 00 00       	call   f70 <strcmp>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	85 c0                	test   %eax,%eax
      e4:	75 44                	jne    12a <main+0x12a>
            strcpy(current_dir, "/");
      e6:	50                   	push   %eax
      e7:	50                   	push   %eax
      e8:	68 0c 16 00 00       	push   $0x160c
      ed:	68 80 1d 00 00       	push   $0x1d80
      f2:	e8 49 0e 00 00       	call   f40 <strcpy>
      f7:	83 c4 10             	add    $0x10,%esp
      fa:	e9 6c ff ff ff       	jmp    6b <main+0x6b>
      close(fd);
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 a3 10 00 00       	call   11ab <close>
      break;
     108:	83 c4 10             	add    $0x10,%esp
     10b:	e9 5b ff ff ff       	jmp    6b <main+0x6b>
        printf(2, "cannot cd %s\n", buf+3);
     110:	50                   	push   %eax
     111:	68 23 22 00 00       	push   $0x2223
     116:	68 a8 16 00 00       	push   $0x16a8
     11b:	6a 02                	push   $0x2
     11d:	e8 be 11 00 00       	call   12e0 <printf>
     122:	83 c4 10             	add    $0x10,%esp
     125:	e9 41 ff ff ff       	jmp    6b <main+0x6b>
            if(strcmp(current_dir, "/") != 0) {
     12a:	51                   	push   %ecx
     12b:	51                   	push   %ecx
     12c:	68 0c 16 00 00       	push   $0x160c
     131:	68 80 1d 00 00       	push   $0x1d80
     136:	e8 35 0e 00 00       	call   f70 <strcmp>
     13b:	83 c4 10             	add    $0x10,%esp
     13e:	85 c0                	test   %eax,%eax
     140:	75 19                	jne    15b <main+0x15b>
            strcat(current_dir, buf+3);
     142:	50                   	push   %eax
     143:	50                   	push   %eax
     144:	68 23 22 00 00       	push   $0x2223
     149:	68 80 1d 00 00       	push   $0x1d80
     14e:	e8 4d 00 00 00       	call   1a0 <strcat>
     153:	83 c4 10             	add    $0x10,%esp
     156:	e9 10 ff ff ff       	jmp    6b <main+0x6b>
                strcat(current_dir, "/");
     15b:	52                   	push   %edx
     15c:	52                   	push   %edx
     15d:	68 0c 16 00 00       	push   $0x160c
     162:	68 80 1d 00 00       	push   $0x1d80
     167:	e8 34 00 00 00       	call   1a0 <strcat>
     16c:	83 c4 10             	add    $0x10,%esp
     16f:	eb d1                	jmp    142 <main+0x142>
      runcmd(parsecmd(buf));
     171:	83 ec 0c             	sub    $0xc,%esp
     174:	68 20 22 00 00       	push   $0x2220
     179:	e8 52 0d 00 00       	call   ed0 <parsecmd>
     17e:	89 04 24             	mov    %eax,(%esp)
     181:	e8 4a 03 00 00       	call   4d0 <runcmd>
    panic("fork");
     186:	83 ec 0c             	sub    $0xc,%esp
     189:	68 00 16 00 00       	push   $0x1600
     18e:	e8 fd 02 00 00       	call   490 <panic>
     193:	66 90                	xchg   %ax,%ax
     195:	66 90                	xchg   %ax,%ax
     197:	66 90                	xchg   %ax,%ax
     199:	66 90                	xchg   %ax,%ax
     19b:	66 90                	xchg   %ax,%ax
     19d:	66 90                	xchg   %ax,%ax
     19f:	90                   	nop

000001a0 <strcat>:
char* strcat(char *dst, const char *src) {
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	56                   	push   %esi
     1a4:	8b 75 08             	mov    0x8(%ebp),%esi
     1a7:	53                   	push   %ebx
     1a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*p) p++;        // Find the end of the destination string
     1ab:	80 3e 00             	cmpb   $0x0,(%esi)
    char *p = dst;
     1ae:	89 f2                	mov    %esi,%edx
    while (*p) p++;        // Find the end of the destination string
     1b0:	74 0e                	je     1c0 <strcat+0x20>
     1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1b8:	83 c2 01             	add    $0x1,%edx
     1bb:	80 3a 00             	cmpb   $0x0,(%edx)
     1be:	75 f8                	jne    1b8 <strcat+0x18>
    char *p = dst;
     1c0:	31 c0                	xor    %eax,%eax
     1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*p++ = *src++)); // Copy source onto the end
     1c8:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
     1cc:	88 0c 02             	mov    %cl,(%edx,%eax,1)
     1cf:	83 c0 01             	add    $0x1,%eax
     1d2:	84 c9                	test   %cl,%cl
     1d4:	75 f2                	jne    1c8 <strcat+0x28>
}
     1d6:	89 f0                	mov    %esi,%eax
     1d8:	5b                   	pop    %ebx
     1d9:	5e                   	pop    %esi
     1da:	5d                   	pop    %ebp
     1db:	c3                   	ret
     1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <getcmd>:
getcmd(char *buf, int nbuf) {
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	57                   	push   %edi
     1e4:	56                   	push   %esi
     1e5:	8d 75 e5             	lea    -0x1b(%ebp),%esi
     1e8:	53                   	push   %ebx
    int i = 0;
     1e9:	31 db                	xor    %ebx,%ebx
getcmd(char *buf, int nbuf) {
     1eb:	83 ec 20             	sub    $0x20,%esp
     1ee:	8b 7d 0c             	mov    0xc(%ebp),%edi
    printf(1, "[ducko@xv6:%s]$ ", current_dir);
     1f1:	68 80 1d 00 00       	push   $0x1d80
     1f6:	68 e8 15 00 00       	push   $0x15e8
     1fb:	6a 01                	push   $0x1
     1fd:	e8 de 10 00 00       	call   12e0 <printf>
    memset(buf, 0, nbuf);
     202:	83 c4 0c             	add    $0xc,%esp
     205:	57                   	push   %edi
        if(i < nbuf - 1) {
     206:	83 ef 01             	sub    $0x1,%edi
    memset(buf, 0, nbuf);
     209:	6a 00                	push   $0x0
     20b:	ff 75 08             	push   0x8(%ebp)
     20e:	e8 ed 0d 00 00       	call   1000 <memset>
    while(read(0, &c, 1) == 1) {
     213:	83 c4 10             	add    $0x10,%esp
     216:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     21d:	00 
     21e:	66 90                	xchg   %ax,%ax
     220:	83 ec 04             	sub    $0x4,%esp
     223:	6a 01                	push   $0x1
     225:	56                   	push   %esi
     226:	6a 00                	push   $0x0
     228:	e8 6e 0f 00 00       	call   119b <read>
     22d:	83 c4 10             	add    $0x10,%esp
     230:	83 f8 01             	cmp    $0x1,%eax
     233:	75 58                	jne    28d <getcmd+0xad>
        if(c == '\n' || c == '\r') {
     235:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
     239:	3c 0a                	cmp    $0xa,%al
     23b:	0f 84 0f 01 00 00    	je     350 <getcmd+0x170>
     241:	3c 0d                	cmp    $0xd,%al
     243:	0f 84 07 01 00 00    	je     350 <getcmd+0x170>
        if(c == '\b' || c == 127) {
     249:	3c 08                	cmp    $0x8,%al
     24b:	74 1b                	je     268 <getcmd+0x88>
     24d:	3c 7f                	cmp    $0x7f,%al
     24f:	74 17                	je     268 <getcmd+0x88>
        if(c == '\x1b') {
     251:	3c 1b                	cmp    $0x1b,%al
     253:	74 5b                	je     2b0 <getcmd+0xd0>
        if(i < nbuf - 1) {
     255:	39 df                	cmp    %ebx,%edi
     257:	7e c7                	jle    220 <getcmd+0x40>
            buf[i++] = c;
     259:	8b 4d 08             	mov    0x8(%ebp),%ecx
     25c:	88 04 19             	mov    %al,(%ecx,%ebx,1)
     25f:	83 c3 01             	add    $0x1,%ebx
     262:	eb bc                	jmp    220 <getcmd+0x40>
     264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(i > 0) {
     268:	85 db                	test   %ebx,%ebx
     26a:	7e b4                	jle    220 <getcmd+0x40>
                printf(1, "\b \b");
     26c:	83 ec 08             	sub    $0x8,%esp
                i--;
     26f:	83 eb 01             	sub    $0x1,%ebx
                printf(1, "\b \b");
     272:	68 f9 15 00 00       	push   $0x15f9
     277:	6a 01                	push   $0x1
     279:	e8 62 10 00 00       	call   12e0 <printf>
     27e:	83 c4 10             	add    $0x10,%esp
     281:	eb 9d                	jmp    220 <getcmd+0x40>
     283:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            history_index = history_count; // Reset history selector
     288:	a3 70 1d 00 00       	mov    %eax,0x1d70
    if(buf[0] == 0 && i == 0) return -1; // EOF handling
     28d:	8b 45 08             	mov    0x8(%ebp),%eax
     290:	80 38 00             	cmpb   $0x0,(%eax)
     293:	0f 94 c2             	sete   %dl
     296:	31 c0                	xor    %eax,%eax
     298:	85 db                	test   %ebx,%ebx
     29a:	0f 94 c0             	sete   %al
     29d:	21 d0                	and    %edx,%eax
     29f:	f7 d8                	neg    %eax
}
     2a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2a4:	5b                   	pop    %ebx
     2a5:	5e                   	pop    %esi
     2a6:	5f                   	pop    %edi
     2a7:	5d                   	pop    %ebp
     2a8:	c3                   	ret
     2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if(read(0, &seq[0], 1) == 1 && read(0, &seq[1], 1) == 1) {
     2b0:	83 ec 04             	sub    $0x4,%esp
     2b3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     2b6:	6a 01                	push   $0x1
     2b8:	50                   	push   %eax
     2b9:	6a 00                	push   $0x0
     2bb:	e8 db 0e 00 00       	call   119b <read>
     2c0:	83 c4 10             	add    $0x10,%esp
     2c3:	83 f8 01             	cmp    $0x1,%eax
     2c6:	0f 85 54 ff ff ff    	jne    220 <getcmd+0x40>
     2cc:	83 ec 04             	sub    $0x4,%esp
     2cf:	8d 45 e7             	lea    -0x19(%ebp),%eax
     2d2:	6a 01                	push   $0x1
     2d4:	50                   	push   %eax
     2d5:	6a 00                	push   $0x0
     2d7:	e8 bf 0e 00 00       	call   119b <read>
     2dc:	83 c4 10             	add    $0x10,%esp
     2df:	83 f8 01             	cmp    $0x1,%eax
     2e2:	0f 85 38 ff ff ff    	jne    220 <getcmd+0x40>
                if(seq[0] == '[') {
     2e8:	80 7d e6 5b          	cmpb   $0x5b,-0x1a(%ebp)
     2ec:	0f 85 2e ff ff ff    	jne    220 <getcmd+0x40>
                    if(seq[1] == 'A') { // UP ARROW
     2f2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     2f6:	3c 41                	cmp    $0x41,%al
     2f8:	0f 84 ed 00 00 00    	je     3eb <getcmd+0x20b>
                    else if(seq[1] == 'B') { // DOWN ARROW
     2fe:	3c 42                	cmp    $0x42,%al
     300:	0f 85 1a ff ff ff    	jne    220 <getcmd+0x40>
                        if(history_index < history_count - 1) {
     306:	8b 15 00 1e 00 00    	mov    0x1e00,%edx
     30c:	a1 70 1d 00 00       	mov    0x1d70,%eax
     311:	8d 4a ff             	lea    -0x1(%edx),%ecx
     314:	39 c1                	cmp    %eax,%ecx
     316:	0f 8f 4a 01 00 00    	jg     466 <getcmd+0x286>
                        } else if(history_index == history_count - 1) {
     31c:	0f 85 fe fe ff ff    	jne    220 <getcmd+0x40>
                            history_index++;
     322:	89 15 70 1d 00 00    	mov    %edx,0x1d70
                            while(i > 0) { printf(1, "\b \b"); i--; }
     328:	85 db                	test   %ebx,%ebx
     32a:	7e 17                	jle    343 <getcmd+0x163>
     32c:	83 ec 08             	sub    $0x8,%esp
     32f:	68 f9 15 00 00       	push   $0x15f9
     334:	6a 01                	push   $0x1
     336:	e8 a5 0f 00 00       	call   12e0 <printf>
     33b:	83 c4 10             	add    $0x10,%esp
     33e:	83 eb 01             	sub    $0x1,%ebx
     341:	75 e9                	jne    32c <getcmd+0x14c>
                            buf[0] = '\0';
     343:	8b 45 08             	mov    0x8(%ebp),%eax
                            i = 0;
     346:	31 db                	xor    %ebx,%ebx
                            buf[0] = '\0';
     348:	c6 00 00             	movb   $0x0,(%eax)
            continue;
     34b:	e9 d0 fe ff ff       	jmp    220 <getcmd+0x40>
            buf[i] = '\0';
     350:	8b 45 08             	mov    0x8(%ebp),%eax
            printf(1, "\n");
     353:	83 ec 08             	sub    $0x8,%esp
            buf[i] = '\0';
     356:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
            printf(1, "\n");
     35a:	68 1c 16 00 00       	push   $0x161c
     35f:	6a 01                	push   $0x1
     361:	e8 7a 0f 00 00       	call   12e0 <printf>
                if(history_count < HISTORY_SIZE) {
     366:	a1 00 1e 00 00       	mov    0x1e00,%eax
            if(i > 0) {
     36b:	83 c4 10             	add    $0x10,%esp
     36e:	85 db                	test   %ebx,%ebx
     370:	0f 8e 12 ff ff ff    	jle    288 <getcmd+0xa8>
                if(history_count < HISTORY_SIZE) {
     376:	bb 20 1e 00 00       	mov    $0x1e20,%ebx
     37b:	be a4 21 00 00       	mov    $0x21a4,%esi
     380:	83 f8 09             	cmp    $0x9,%eax
     383:	7e 43                	jle    3c8 <getcmd+0x1e8>
     385:	8d 76 00             	lea    0x0(%esi),%esi
                        strcpy(history[j-1], history[j]);
     388:	83 ec 08             	sub    $0x8,%esp
     38b:	89 d8                	mov    %ebx,%eax
     38d:	83 c3 64             	add    $0x64,%ebx
     390:	53                   	push   %ebx
     391:	50                   	push   %eax
     392:	e8 a9 0b 00 00       	call   f40 <strcpy>
                    for(int j = 1; j < HISTORY_SIZE; j++) {
     397:	83 c4 10             	add    $0x10,%esp
     39a:	39 de                	cmp    %ebx,%esi
     39c:	75 ea                	jne    388 <getcmd+0x1a8>
                    strcpy(history[HISTORY_SIZE-1], buf);
     39e:	83 ec 08             	sub    $0x8,%esp
     3a1:	ff 75 08             	push   0x8(%ebp)
     3a4:	68 a4 21 00 00       	push   $0x21a4
     3a9:	e8 92 0b 00 00       	call   f40 <strcpy>
            history_index = history_count; // Reset history selector
     3ae:	a1 00 1e 00 00       	mov    0x1e00,%eax
     3b3:	83 c4 10             	add    $0x10,%esp
     3b6:	a3 70 1d 00 00       	mov    %eax,0x1d70
    return 0;
     3bb:	31 c0                	xor    %eax,%eax
     3bd:	e9 df fe ff ff       	jmp    2a1 <getcmd+0xc1>
     3c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                    strcpy(history[history_count], buf);
     3c8:	6b c0 64             	imul   $0x64,%eax,%eax
     3cb:	83 ec 08             	sub    $0x8,%esp
     3ce:	ff 75 08             	push   0x8(%ebp)
     3d1:	01 d8                	add    %ebx,%eax
     3d3:	50                   	push   %eax
     3d4:	e8 67 0b 00 00       	call   f40 <strcpy>
                    history_count++;
     3d9:	a1 00 1e 00 00       	mov    0x1e00,%eax
     3de:	83 c4 10             	add    $0x10,%esp
     3e1:	83 c0 01             	add    $0x1,%eax
     3e4:	a3 00 1e 00 00       	mov    %eax,0x1e00
    if(buf[0] == 0 && i == 0) return -1; // EOF handling
     3e9:	eb cb                	jmp    3b6 <getcmd+0x1d6>
                        if(history_count > 0 && history_index > 0) {
     3eb:	8b 15 00 1e 00 00    	mov    0x1e00,%edx
     3f1:	85 d2                	test   %edx,%edx
     3f3:	0f 8e 27 fe ff ff    	jle    220 <getcmd+0x40>
     3f9:	a1 70 1d 00 00       	mov    0x1d70,%eax
     3fe:	85 c0                	test   %eax,%eax
     400:	0f 8e 1a fe ff ff    	jle    220 <getcmd+0x40>
                            history_index--;
     406:	83 e8 01             	sub    $0x1,%eax
     409:	a3 70 1d 00 00       	mov    %eax,0x1d70
                            while(i > 0) { printf(1, "\b \b"); i--; }
     40e:	85 db                	test   %ebx,%ebx
     410:	7e 17                	jle    429 <getcmd+0x249>
     412:	83 ec 08             	sub    $0x8,%esp
     415:	68 f9 15 00 00       	push   $0x15f9
     41a:	6a 01                	push   $0x1
     41c:	e8 bf 0e 00 00       	call   12e0 <printf>
     421:	83 c4 10             	add    $0x10,%esp
     424:	83 eb 01             	sub    $0x1,%ebx
     427:	75 e9                	jne    412 <getcmd+0x232>
                            strcpy(buf, history[history_index]);
     429:	6b 05 70 1d 00 00 64 	imul   $0x64,0x1d70,%eax
     430:	83 ec 08             	sub    $0x8,%esp
     433:	05 20 1e 00 00       	add    $0x1e20,%eax
     438:	50                   	push   %eax
     439:	ff 75 08             	push   0x8(%ebp)
     43c:	e8 ff 0a 00 00       	call   f40 <strcpy>
                            i = strlen(buf);
     441:	58                   	pop    %eax
     442:	ff 75 08             	push   0x8(%ebp)
     445:	e8 86 0b 00 00       	call   fd0 <strlen>
                            printf(1, "%s", buf);
     44a:	83 c4 0c             	add    $0xc,%esp
     44d:	ff 75 08             	push   0x8(%ebp)
     450:	68 fd 15 00 00       	push   $0x15fd
                            i = strlen(buf);
     455:	89 c3                	mov    %eax,%ebx
                            printf(1, "%s", buf);
     457:	6a 01                	push   $0x1
     459:	e8 82 0e 00 00       	call   12e0 <printf>
     45e:	83 c4 10             	add    $0x10,%esp
     461:	e9 ba fd ff ff       	jmp    220 <getcmd+0x40>
                            history_index++;
     466:	83 c0 01             	add    $0x1,%eax
     469:	a3 70 1d 00 00       	mov    %eax,0x1d70
                            while(i > 0) { printf(1, "\b \b"); i--; }
     46e:	85 db                	test   %ebx,%ebx
     470:	7e b7                	jle    429 <getcmd+0x249>
     472:	83 ec 08             	sub    $0x8,%esp
     475:	68 f9 15 00 00       	push   $0x15f9
     47a:	6a 01                	push   $0x1
     47c:	e8 5f 0e 00 00       	call   12e0 <printf>
     481:	83 c4 10             	add    $0x10,%esp
     484:	83 eb 01             	sub    $0x1,%ebx
     487:	75 e9                	jne    472 <getcmd+0x292>
     489:	eb 9e                	jmp    429 <getcmd+0x249>
     48b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000490 <panic>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     496:	ff 75 08             	push   0x8(%ebp)
     499:	68 9c 16 00 00       	push   $0x169c
     49e:	6a 02                	push   $0x2
     4a0:	e8 3b 0e 00 00       	call   12e0 <printf>
  exit();
     4a5:	e8 d9 0c 00 00       	call   1183 <exit>
     4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004b0 <fork1>:
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     4b6:	e8 c0 0c 00 00       	call   117b <fork>
  if(pid == -1)
     4bb:	83 f8 ff             	cmp    $0xffffffff,%eax
     4be:	74 02                	je     4c2 <fork1+0x12>
  return pid;
}
     4c0:	c9                   	leave
     4c1:	c3                   	ret
    panic("fork");
     4c2:	83 ec 0c             	sub    $0xc,%esp
     4c5:	68 00 16 00 00       	push   $0x1600
     4ca:	e8 c1 ff ff ff       	call   490 <panic>
     4cf:	90                   	nop

000004d0 <runcmd>:
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	56                   	push   %esi
     4d4:	53                   	push   %ebx
     4d5:	83 c4 80             	add    $0xffffff80,%esp
     4d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     4db:	85 db                	test   %ebx,%ebx
     4dd:	74 62                	je     541 <runcmd+0x71>
  switch(cmd->type){
     4df:	83 3b 05             	cmpl   $0x5,(%ebx)
     4e2:	0f 87 0c 01 00 00    	ja     5f4 <runcmd+0x124>
     4e8:	8b 03                	mov    (%ebx),%eax
     4ea:	ff 24 85 c0 16 00 00 	jmp    *0x16c0(,%eax,4)
    if(ecmd->argv[0] == 0)
     4f1:	8b 43 04             	mov    0x4(%ebx),%eax
     4f4:	85 c0                	test   %eax,%eax
     4f6:	74 49                	je     541 <runcmd+0x71>
    if(ecmd->argv[0][0] != '/') {
     4f8:	80 38 2f             	cmpb   $0x2f,(%eax)
     4fb:	0f 84 22 01 00 00    	je     623 <runcmd+0x153>
      strcpy(path, "/");
     501:	8d b5 78 ff ff ff    	lea    -0x88(%ebp),%esi
     507:	51                   	push   %ecx
     508:	51                   	push   %ecx
     509:	68 0c 16 00 00       	push   $0x160c
     50e:	56                   	push   %esi
     50f:	e8 2c 0a 00 00       	call   f40 <strcpy>
      strcat(path, ecmd->argv[0]);
     514:	58                   	pop    %eax
     515:	5a                   	pop    %edx
     516:	ff 73 04             	push   0x4(%ebx)
     519:	56                   	push   %esi
     51a:	e8 81 fc ff ff       	call   1a0 <strcat>
      exec(path, ecmd->argv);
     51f:	59                   	pop    %ecx
     520:	58                   	pop    %eax
     521:	8d 43 04             	lea    0x4(%ebx),%eax
     524:	50                   	push   %eax
     525:	56                   	push   %esi
     526:	e8 90 0c 00 00       	call   11bb <exec>
     52b:	83 c4 10             	add    $0x10,%esp
  printf(2, "exec %s failed\n", ecmd->argv[0]);
     52e:	50                   	push   %eax
     52f:	ff 73 04             	push   0x4(%ebx)
     532:	68 0e 16 00 00       	push   $0x160e
     537:	6a 02                	push   $0x2
     539:	e8 a2 0d 00 00       	call   12e0 <printf>
  break;
     53e:	83 c4 10             	add    $0x10,%esp
  exit();
     541:	e8 3d 0c 00 00       	call   1183 <exit>
    if(fork1() == 0)
     546:	e8 65 ff ff ff       	call   4b0 <fork1>
     54b:	85 c0                	test   %eax,%eax
     54d:	75 f2                	jne    541 <runcmd+0x71>
     54f:	e9 95 00 00 00       	jmp    5e9 <runcmd+0x119>
    if(pipe(p) < 0)
     554:	83 ec 0c             	sub    $0xc,%esp
     557:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
     55d:	50                   	push   %eax
     55e:	e8 30 0c 00 00       	call   1193 <pipe>
     563:	83 c4 10             	add    $0x10,%esp
     566:	85 c0                	test   %eax,%eax
     568:	0f 88 a8 00 00 00    	js     616 <runcmd+0x146>
    if(fork1() == 0){
     56e:	e8 3d ff ff ff       	call   4b0 <fork1>
     573:	85 c0                	test   %eax,%eax
     575:	0f 84 f3 00 00 00    	je     66e <runcmd+0x19e>
    if(fork1() == 0){
     57b:	e8 30 ff ff ff       	call   4b0 <fork1>
     580:	85 c0                	test   %eax,%eax
     582:	0f 84 af 00 00 00    	je     637 <runcmd+0x167>
    close(p[0]);
     588:	83 ec 0c             	sub    $0xc,%esp
     58b:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
     591:	e8 15 0c 00 00       	call   11ab <close>
    close(p[1]);
     596:	58                   	pop    %eax
     597:	ff b5 7c ff ff ff    	push   -0x84(%ebp)
     59d:	e8 09 0c 00 00       	call   11ab <close>
    wait();
     5a2:	e8 e4 0b 00 00       	call   118b <wait>
    wait();
     5a7:	e8 df 0b 00 00       	call   118b <wait>
    break;
     5ac:	83 c4 10             	add    $0x10,%esp
     5af:	eb 90                	jmp    541 <runcmd+0x71>
    if(fork1() == 0)
     5b1:	e8 fa fe ff ff       	call   4b0 <fork1>
     5b6:	85 c0                	test   %eax,%eax
     5b8:	74 2f                	je     5e9 <runcmd+0x119>
    wait();
     5ba:	e8 cc 0b 00 00       	call   118b <wait>
    runcmd(lcmd->right);
     5bf:	83 ec 0c             	sub    $0xc,%esp
     5c2:	ff 73 08             	push   0x8(%ebx)
     5c5:	e8 06 ff ff ff       	call   4d0 <runcmd>
    close(rcmd->fd);
     5ca:	83 ec 0c             	sub    $0xc,%esp
     5cd:	ff 73 14             	push   0x14(%ebx)
     5d0:	e8 d6 0b 00 00       	call   11ab <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     5d5:	59                   	pop    %ecx
     5d6:	5e                   	pop    %esi
     5d7:	ff 73 10             	push   0x10(%ebx)
     5da:	ff 73 08             	push   0x8(%ebx)
     5dd:	e8 e1 0b 00 00       	call   11c3 <open>
     5e2:	83 c4 10             	add    $0x10,%esp
     5e5:	85 c0                	test   %eax,%eax
     5e7:	78 18                	js     601 <runcmd+0x131>
      runcmd(bcmd->cmd);
     5e9:	83 ec 0c             	sub    $0xc,%esp
     5ec:	ff 73 04             	push   0x4(%ebx)
     5ef:	e8 dc fe ff ff       	call   4d0 <runcmd>
    panic("runcmd");
     5f4:	83 ec 0c             	sub    $0xc,%esp
     5f7:	68 05 16 00 00       	push   $0x1605
     5fc:	e8 8f fe ff ff       	call   490 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     601:	52                   	push   %edx
     602:	ff 73 08             	push   0x8(%ebx)
     605:	68 1e 16 00 00       	push   $0x161e
     60a:	6a 02                	push   $0x2
     60c:	e8 cf 0c 00 00       	call   12e0 <printf>
      exit();
     611:	e8 6d 0b 00 00       	call   1183 <exit>
      panic("pipe");
     616:	83 ec 0c             	sub    $0xc,%esp
     619:	68 2e 16 00 00       	push   $0x162e
     61e:	e8 6d fe ff ff       	call   490 <panic>
      exec(ecmd->argv[0], ecmd->argv);
     623:	52                   	push   %edx
     624:	52                   	push   %edx
     625:	8d 53 04             	lea    0x4(%ebx),%edx
     628:	52                   	push   %edx
     629:	50                   	push   %eax
     62a:	e8 8c 0b 00 00       	call   11bb <exec>
     62f:	83 c4 10             	add    $0x10,%esp
     632:	e9 f7 fe ff ff       	jmp    52e <runcmd+0x5e>
      close(0);
     637:	83 ec 0c             	sub    $0xc,%esp
     63a:	6a 00                	push   $0x0
     63c:	e8 6a 0b 00 00       	call   11ab <close>
      dup(p[0]);
     641:	5a                   	pop    %edx
     642:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
     648:	e8 ae 0b 00 00       	call   11fb <dup>
      close(p[0]);
     64d:	59                   	pop    %ecx
     64e:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
     654:	e8 52 0b 00 00       	call   11ab <close>
      close(p[1]);
     659:	5e                   	pop    %esi
     65a:	ff b5 7c ff ff ff    	push   -0x84(%ebp)
     660:	e8 46 0b 00 00       	call   11ab <close>
      runcmd(pcmd->right);
     665:	58                   	pop    %eax
     666:	ff 73 08             	push   0x8(%ebx)
     669:	e8 62 fe ff ff       	call   4d0 <runcmd>
      close(1);
     66e:	83 ec 0c             	sub    $0xc,%esp
     671:	6a 01                	push   $0x1
     673:	e8 33 0b 00 00       	call   11ab <close>
      dup(p[1]);
     678:	58                   	pop    %eax
     679:	ff b5 7c ff ff ff    	push   -0x84(%ebp)
     67f:	e8 77 0b 00 00       	call   11fb <dup>
      close(p[0]);
     684:	58                   	pop    %eax
     685:	ff b5 78 ff ff ff    	push   -0x88(%ebp)
     68b:	e8 1b 0b 00 00       	call   11ab <close>
      close(p[1]);
     690:	58                   	pop    %eax
     691:	ff b5 7c ff ff ff    	push   -0x84(%ebp)
     697:	e8 0f 0b 00 00       	call   11ab <close>
      runcmd(pcmd->left);
     69c:	58                   	pop    %eax
     69d:	ff 73 04             	push   0x4(%ebx)
     6a0:	e8 2b fe ff ff       	call   4d0 <runcmd>
     6a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ac:	00 
     6ad:	8d 76 00             	lea    0x0(%esi),%esi

000006b0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	53                   	push   %ebx
     6b4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6b7:	6a 54                	push   $0x54
     6b9:	e8 42 0e 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6be:	83 c4 0c             	add    $0xc,%esp
     6c1:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     6c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6c5:	6a 00                	push   $0x0
     6c7:	50                   	push   %eax
     6c8:	e8 33 09 00 00       	call   1000 <memset>
  cmd->type = EXEC;
     6cd:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     6d3:	89 d8                	mov    %ebx,%eax
     6d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6d8:	c9                   	leave
     6d9:	c3                   	ret
     6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	53                   	push   %ebx
     6e4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6e7:	6a 18                	push   $0x18
     6e9:	e8 12 0e 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6ee:	83 c4 0c             	add    $0xc,%esp
     6f1:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     6f3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6f5:	6a 00                	push   $0x0
     6f7:	50                   	push   %eax
     6f8:	e8 03 09 00 00       	call   1000 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     6fd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     700:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     706:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     709:	8b 45 0c             	mov    0xc(%ebp),%eax
     70c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     70f:	8b 45 10             	mov    0x10(%ebp),%eax
     712:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     715:	8b 45 14             	mov    0x14(%ebp),%eax
     718:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     71b:	8b 45 18             	mov    0x18(%ebp),%eax
     71e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     721:	89 d8                	mov    %ebx,%eax
     723:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     726:	c9                   	leave
     727:	c3                   	ret
     728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     72f:	00 

00000730 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	53                   	push   %ebx
     734:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     737:	6a 0c                	push   $0xc
     739:	e8 c2 0d 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     73e:	83 c4 0c             	add    $0xc,%esp
     741:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     743:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     745:	6a 00                	push   $0x0
     747:	50                   	push   %eax
     748:	e8 b3 08 00 00       	call   1000 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     74d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     750:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     756:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     759:	8b 45 0c             	mov    0xc(%ebp),%eax
     75c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     75f:	89 d8                	mov    %ebx,%eax
     761:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     764:	c9                   	leave
     765:	c3                   	ret
     766:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     76d:	00 
     76e:	66 90                	xchg   %ax,%ax

00000770 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	53                   	push   %ebx
     774:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     777:	6a 0c                	push   $0xc
     779:	e8 82 0d 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     77e:	83 c4 0c             	add    $0xc,%esp
     781:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     783:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     785:	6a 00                	push   $0x0
     787:	50                   	push   %eax
     788:	e8 73 08 00 00       	call   1000 <memset>
  cmd->type = LIST;
  cmd->left = left;
     78d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     790:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     796:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     799:	8b 45 0c             	mov    0xc(%ebp),%eax
     79c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     79f:	89 d8                	mov    %ebx,%eax
     7a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a4:	c9                   	leave
     7a5:	c3                   	ret
     7a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7ad:	00 
     7ae:	66 90                	xchg   %ax,%ax

000007b0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	53                   	push   %ebx
     7b4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     7b7:	6a 08                	push   $0x8
     7b9:	e8 42 0d 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7be:	83 c4 0c             	add    $0xc,%esp
     7c1:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     7c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     7c5:	6a 00                	push   $0x0
     7c7:	50                   	push   %eax
     7c8:	e8 33 08 00 00       	call   1000 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     7cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     7d0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     7d6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     7d9:	89 d8                	mov    %ebx,%eax
     7db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7de:	c9                   	leave
     7df:	c3                   	ret

000007e0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	57                   	push   %edi
     7e4:	56                   	push   %esi
     7e5:	53                   	push   %ebx
     7e6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     7e9:	8b 45 08             	mov    0x8(%ebp),%eax
{
     7ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     7ef:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     7f2:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     7f4:	39 df                	cmp    %ebx,%edi
     7f6:	72 0f                	jb     807 <gettoken+0x27>
     7f8:	eb 25                	jmp    81f <gettoken+0x3f>
     7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     800:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     803:	39 fb                	cmp    %edi,%ebx
     805:	74 18                	je     81f <gettoken+0x3f>
     807:	0f be 07             	movsbl (%edi),%eax
     80a:	83 ec 08             	sub    $0x8,%esp
     80d:	50                   	push   %eax
     80e:	68 68 1d 00 00       	push   $0x1d68
     813:	e8 08 08 00 00       	call   1020 <strchr>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	85 c0                	test   %eax,%eax
     81d:	75 e1                	jne    800 <gettoken+0x20>
  if(q)
     81f:	85 f6                	test   %esi,%esi
     821:	74 02                	je     825 <gettoken+0x45>
    *q = s;
     823:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     825:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     828:	3c 3c                	cmp    $0x3c,%al
     82a:	0f 8f c8 00 00 00    	jg     8f8 <gettoken+0x118>
     830:	3c 3a                	cmp    $0x3a,%al
     832:	7f 5a                	jg     88e <gettoken+0xae>
     834:	84 c0                	test   %al,%al
     836:	75 48                	jne    880 <gettoken+0xa0>
     838:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     83a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     83d:	85 c9                	test   %ecx,%ecx
     83f:	74 05                	je     846 <gettoken+0x66>
    *eq = s;
     841:	8b 45 14             	mov    0x14(%ebp),%eax
     844:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     846:	39 df                	cmp    %ebx,%edi
     848:	72 0d                	jb     857 <gettoken+0x77>
     84a:	eb 23                	jmp    86f <gettoken+0x8f>
     84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     850:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     853:	39 fb                	cmp    %edi,%ebx
     855:	74 18                	je     86f <gettoken+0x8f>
     857:	0f be 07             	movsbl (%edi),%eax
     85a:	83 ec 08             	sub    $0x8,%esp
     85d:	50                   	push   %eax
     85e:	68 68 1d 00 00       	push   $0x1d68
     863:	e8 b8 07 00 00       	call   1020 <strchr>
     868:	83 c4 10             	add    $0x10,%esp
     86b:	85 c0                	test   %eax,%eax
     86d:	75 e1                	jne    850 <gettoken+0x70>
  *ps = s;
     86f:	8b 45 08             	mov    0x8(%ebp),%eax
     872:	89 38                	mov    %edi,(%eax)
  return ret;
}
     874:	8d 65 f4             	lea    -0xc(%ebp),%esp
     877:	89 f0                	mov    %esi,%eax
     879:	5b                   	pop    %ebx
     87a:	5e                   	pop    %esi
     87b:	5f                   	pop    %edi
     87c:	5d                   	pop    %ebp
     87d:	c3                   	ret
     87e:	66 90                	xchg   %ax,%ax
  switch(*s){
     880:	78 22                	js     8a4 <gettoken+0xc4>
     882:	3c 26                	cmp    $0x26,%al
     884:	74 08                	je     88e <gettoken+0xae>
     886:	8d 48 d8             	lea    -0x28(%eax),%ecx
     889:	80 f9 01             	cmp    $0x1,%cl
     88c:	77 16                	ja     8a4 <gettoken+0xc4>
  ret = *s;
     88e:	0f be f0             	movsbl %al,%esi
    s++;
     891:	83 c7 01             	add    $0x1,%edi
    break;
     894:	eb a4                	jmp    83a <gettoken+0x5a>
     896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     89d:	00 
     89e:	66 90                	xchg   %ax,%ax
  switch(*s){
     8a0:	3c 7c                	cmp    $0x7c,%al
     8a2:	74 ea                	je     88e <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8a4:	39 df                	cmp    %ebx,%edi
     8a6:	72 27                	jb     8cf <gettoken+0xef>
     8a8:	e9 87 00 00 00       	jmp    934 <gettoken+0x154>
     8ad:	8d 76 00             	lea    0x0(%esi),%esi
     8b0:	0f be 07             	movsbl (%edi),%eax
     8b3:	83 ec 08             	sub    $0x8,%esp
     8b6:	50                   	push   %eax
     8b7:	68 60 1d 00 00       	push   $0x1d60
     8bc:	e8 5f 07 00 00       	call   1020 <strchr>
     8c1:	83 c4 10             	add    $0x10,%esp
     8c4:	85 c0                	test   %eax,%eax
     8c6:	75 1f                	jne    8e7 <gettoken+0x107>
      s++;
     8c8:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8cb:	39 fb                	cmp    %edi,%ebx
     8cd:	74 4d                	je     91c <gettoken+0x13c>
     8cf:	0f be 07             	movsbl (%edi),%eax
     8d2:	83 ec 08             	sub    $0x8,%esp
     8d5:	50                   	push   %eax
     8d6:	68 68 1d 00 00       	push   $0x1d68
     8db:	e8 40 07 00 00       	call   1020 <strchr>
     8e0:	83 c4 10             	add    $0x10,%esp
     8e3:	85 c0                	test   %eax,%eax
     8e5:	74 c9                	je     8b0 <gettoken+0xd0>
    ret = 'a';
     8e7:	be 61 00 00 00       	mov    $0x61,%esi
     8ec:	e9 49 ff ff ff       	jmp    83a <gettoken+0x5a>
     8f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     8f8:	3c 3e                	cmp    $0x3e,%al
     8fa:	75 a4                	jne    8a0 <gettoken+0xc0>
    if(*s == '>'){
     8fc:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     900:	74 0d                	je     90f <gettoken+0x12f>
    s++;
     902:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     905:	be 3e 00 00 00       	mov    $0x3e,%esi
     90a:	e9 2b ff ff ff       	jmp    83a <gettoken+0x5a>
      s++;
     90f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     912:	be 2b 00 00 00       	mov    $0x2b,%esi
     917:	e9 1e ff ff ff       	jmp    83a <gettoken+0x5a>
  if(eq)
     91c:	8b 45 14             	mov    0x14(%ebp),%eax
     91f:	85 c0                	test   %eax,%eax
     921:	74 05                	je     928 <gettoken+0x148>
    *eq = s;
     923:	8b 45 14             	mov    0x14(%ebp),%eax
     926:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     928:	89 df                	mov    %ebx,%edi
    ret = 'a';
     92a:	be 61 00 00 00       	mov    $0x61,%esi
     92f:	e9 3b ff ff ff       	jmp    86f <gettoken+0x8f>
  if(eq)
     934:	8b 55 14             	mov    0x14(%ebp),%edx
     937:	85 d2                	test   %edx,%edx
     939:	74 ef                	je     92a <gettoken+0x14a>
    *eq = s;
     93b:	8b 45 14             	mov    0x14(%ebp),%eax
     93e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     940:	eb e8                	jmp    92a <gettoken+0x14a>
     942:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     949:	00 
     94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000950 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 0c             	sub    $0xc,%esp
     959:	8b 7d 08             	mov    0x8(%ebp),%edi
     95c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     95f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     961:	39 f3                	cmp    %esi,%ebx
     963:	72 12                	jb     977 <peek+0x27>
     965:	eb 28                	jmp    98f <peek+0x3f>
     967:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     96e:	00 
     96f:	90                   	nop
    s++;
     970:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     973:	39 de                	cmp    %ebx,%esi
     975:	74 18                	je     98f <peek+0x3f>
     977:	0f be 03             	movsbl (%ebx),%eax
     97a:	83 ec 08             	sub    $0x8,%esp
     97d:	50                   	push   %eax
     97e:	68 68 1d 00 00       	push   $0x1d68
     983:	e8 98 06 00 00       	call   1020 <strchr>
     988:	83 c4 10             	add    $0x10,%esp
     98b:	85 c0                	test   %eax,%eax
     98d:	75 e1                	jne    970 <peek+0x20>
  *ps = s;
     98f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     991:	0f be 03             	movsbl (%ebx),%eax
     994:	31 d2                	xor    %edx,%edx
     996:	84 c0                	test   %al,%al
     998:	75 0e                	jne    9a8 <peek+0x58>
}
     99a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     99d:	89 d0                	mov    %edx,%eax
     99f:	5b                   	pop    %ebx
     9a0:	5e                   	pop    %esi
     9a1:	5f                   	pop    %edi
     9a2:	5d                   	pop    %ebp
     9a3:	c3                   	ret
     9a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     9a8:	83 ec 08             	sub    $0x8,%esp
     9ab:	50                   	push   %eax
     9ac:	ff 75 10             	push   0x10(%ebp)
     9af:	e8 6c 06 00 00       	call   1020 <strchr>
     9b4:	83 c4 10             	add    $0x10,%esp
     9b7:	31 d2                	xor    %edx,%edx
     9b9:	85 c0                	test   %eax,%eax
     9bb:	0f 95 c2             	setne  %dl
}
     9be:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c1:	5b                   	pop    %ebx
     9c2:	89 d0                	mov    %edx,%eax
     9c4:	5e                   	pop    %esi
     9c5:	5f                   	pop    %edi
     9c6:	5d                   	pop    %ebp
     9c7:	c3                   	ret
     9c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9cf:	00 

000009d0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	57                   	push   %edi
     9d4:	56                   	push   %esi
     9d5:	53                   	push   %ebx
     9d6:	83 ec 2c             	sub    $0x2c,%esp
     9d9:	8b 75 0c             	mov    0xc(%ebp),%esi
     9dc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9df:	90                   	nop
     9e0:	83 ec 04             	sub    $0x4,%esp
     9e3:	68 50 16 00 00       	push   $0x1650
     9e8:	53                   	push   %ebx
     9e9:	56                   	push   %esi
     9ea:	e8 61 ff ff ff       	call   950 <peek>
     9ef:	83 c4 10             	add    $0x10,%esp
     9f2:	85 c0                	test   %eax,%eax
     9f4:	0f 84 f6 00 00 00    	je     af0 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     9fa:	6a 00                	push   $0x0
     9fc:	6a 00                	push   $0x0
     9fe:	53                   	push   %ebx
     9ff:	56                   	push   %esi
     a00:	e8 db fd ff ff       	call   7e0 <gettoken>
     a05:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     a07:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a0a:	50                   	push   %eax
     a0b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a0e:	50                   	push   %eax
     a0f:	53                   	push   %ebx
     a10:	56                   	push   %esi
     a11:	e8 ca fd ff ff       	call   7e0 <gettoken>
     a16:	83 c4 20             	add    $0x20,%esp
     a19:	83 f8 61             	cmp    $0x61,%eax
     a1c:	0f 85 d9 00 00 00    	jne    afb <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     a22:	83 ff 3c             	cmp    $0x3c,%edi
     a25:	74 69                	je     a90 <parseredirs+0xc0>
     a27:	83 ff 3e             	cmp    $0x3e,%edi
     a2a:	74 05                	je     a31 <parseredirs+0x61>
     a2c:	83 ff 2b             	cmp    $0x2b,%edi
     a2f:	75 af                	jne    9e0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a31:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     a34:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     a37:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a3a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     a3d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     a40:	6a 18                	push   $0x18
     a42:	e8 b9 0a 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a47:	83 c4 0c             	add    $0xc,%esp
     a4a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     a4c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     a4e:	6a 00                	push   $0x0
     a50:	50                   	push   %eax
     a51:	e8 aa 05 00 00       	call   1000 <memset>
  cmd->type = REDIR;
     a56:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     a5c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     a5f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     a62:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     a65:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a68:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     a6b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     a6e:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     a75:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     a78:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a7f:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     a82:	e9 59 ff ff ff       	jmp    9e0 <parseredirs+0x10>
     a87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a8e:	00 
     a8f:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a90:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     a93:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     a96:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a99:	89 55 d0             	mov    %edx,-0x30(%ebp)
     a9c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     a9f:	6a 18                	push   $0x18
     aa1:	e8 5a 0a 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     aa6:	83 c4 0c             	add    $0xc,%esp
     aa9:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     aab:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     aad:	6a 00                	push   $0x0
     aaf:	50                   	push   %eax
     ab0:	e8 4b 05 00 00       	call   1000 <memset>
  cmd->cmd = subcmd;
     ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     ab8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     abb:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     abe:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     ac1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     ac7:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     aca:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     acd:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     ad0:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     ad7:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     ade:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     ae1:	e9 fa fe ff ff       	jmp    9e0 <parseredirs+0x10>
     ae6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     aed:	00 
     aee:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     af0:	8b 45 08             	mov    0x8(%ebp),%eax
     af3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     af6:	5b                   	pop    %ebx
     af7:	5e                   	pop    %esi
     af8:	5f                   	pop    %edi
     af9:	5d                   	pop    %ebp
     afa:	c3                   	ret
      panic("missing file for redirection");
     afb:	83 ec 0c             	sub    $0xc,%esp
     afe:	68 33 16 00 00       	push   $0x1633
     b03:	e8 88 f9 ff ff       	call   490 <panic>
     b08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b0f:	00 

00000b10 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
     b16:	83 ec 30             	sub    $0x30,%esp
     b19:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     b1f:	68 53 16 00 00       	push   $0x1653
     b24:	56                   	push   %esi
     b25:	53                   	push   %ebx
     b26:	e8 25 fe ff ff       	call   950 <peek>
     b2b:	83 c4 10             	add    $0x10,%esp
     b2e:	85 c0                	test   %eax,%eax
     b30:	0f 85 aa 00 00 00    	jne    be0 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	89 c7                	mov    %eax,%edi
     b3b:	6a 54                	push   $0x54
     b3d:	e8 be 09 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b42:	83 c4 0c             	add    $0xc,%esp
     b45:	6a 54                	push   $0x54
     b47:	6a 00                	push   $0x0
     b49:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b4c:	50                   	push   %eax
     b4d:	e8 ae 04 00 00       	call   1000 <memset>
  cmd->type = EXEC;
     b52:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     b55:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     b58:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     b5e:	56                   	push   %esi
     b5f:	53                   	push   %ebx
     b60:	50                   	push   %eax
     b61:	e8 6a fe ff ff       	call   9d0 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     b66:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     b69:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     b6c:	eb 15                	jmp    b83 <parseexec+0x73>
     b6e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     b70:	83 ec 04             	sub    $0x4,%esp
     b73:	56                   	push   %esi
     b74:	53                   	push   %ebx
     b75:	ff 75 d4             	push   -0x2c(%ebp)
     b78:	e8 53 fe ff ff       	call   9d0 <parseredirs>
     b7d:	83 c4 10             	add    $0x10,%esp
     b80:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     b83:	83 ec 04             	sub    $0x4,%esp
     b86:	68 6a 16 00 00       	push   $0x166a
     b8b:	56                   	push   %esi
     b8c:	53                   	push   %ebx
     b8d:	e8 be fd ff ff       	call   950 <peek>
     b92:	83 c4 10             	add    $0x10,%esp
     b95:	85 c0                	test   %eax,%eax
     b97:	75 5f                	jne    bf8 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b99:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b9c:	50                   	push   %eax
     b9d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ba0:	50                   	push   %eax
     ba1:	56                   	push   %esi
     ba2:	53                   	push   %ebx
     ba3:	e8 38 fc ff ff       	call   7e0 <gettoken>
     ba8:	83 c4 10             	add    $0x10,%esp
     bab:	85 c0                	test   %eax,%eax
     bad:	74 49                	je     bf8 <parseexec+0xe8>
    if(tok != 'a')
     baf:	83 f8 61             	cmp    $0x61,%eax
     bb2:	75 62                	jne    c16 <parseexec+0x106>
    cmd->argv[argc] = q;
     bb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bb7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bba:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     bbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bc1:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     bc5:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     bc8:	83 ff 0a             	cmp    $0xa,%edi
     bcb:	75 a3                	jne    b70 <parseexec+0x60>
      panic("too many args");
     bcd:	83 ec 0c             	sub    $0xc,%esp
     bd0:	68 5c 16 00 00       	push   $0x165c
     bd5:	e8 b6 f8 ff ff       	call   490 <panic>
     bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     be0:	89 75 0c             	mov    %esi,0xc(%ebp)
     be3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     be6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     be9:	5b                   	pop    %ebx
     bea:	5e                   	pop    %esi
     beb:	5f                   	pop    %edi
     bec:	5d                   	pop    %ebp
    return parseblock(ps, es);
     bed:	e9 ae 01 00 00       	jmp    da0 <parseblock>
     bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     bf8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     bfb:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     c02:	00 
  cmd->eargv[argc] = 0;
     c03:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     c0a:	00 
}
     c0b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     c0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c11:	5b                   	pop    %ebx
     c12:	5e                   	pop    %esi
     c13:	5f                   	pop    %edi
     c14:	5d                   	pop    %ebp
     c15:	c3                   	ret
      panic("syntax");
     c16:	83 ec 0c             	sub    $0xc,%esp
     c19:	68 55 16 00 00       	push   $0x1655
     c1e:	e8 6d f8 ff ff       	call   490 <panic>
     c23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c2a:	00 
     c2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000c30 <parsepipe>:
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	57                   	push   %edi
     c34:	56                   	push   %esi
     c35:	53                   	push   %ebx
     c36:	83 ec 14             	sub    $0x14,%esp
     c39:	8b 75 08             	mov    0x8(%ebp),%esi
     c3c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     c3f:	57                   	push   %edi
     c40:	56                   	push   %esi
     c41:	e8 ca fe ff ff       	call   b10 <parseexec>
  if(peek(ps, es, "|")){
     c46:	83 c4 0c             	add    $0xc,%esp
     c49:	68 6f 16 00 00       	push   $0x166f
  cmd = parseexec(ps, es);
     c4e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     c50:	57                   	push   %edi
     c51:	56                   	push   %esi
     c52:	e8 f9 fc ff ff       	call   950 <peek>
     c57:	83 c4 10             	add    $0x10,%esp
     c5a:	85 c0                	test   %eax,%eax
     c5c:	75 12                	jne    c70 <parsepipe+0x40>
}
     c5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c61:	89 d8                	mov    %ebx,%eax
     c63:	5b                   	pop    %ebx
     c64:	5e                   	pop    %esi
     c65:	5f                   	pop    %edi
     c66:	5d                   	pop    %ebp
     c67:	c3                   	ret
     c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c6f:	00 
    gettoken(ps, es, 0, 0);
     c70:	6a 00                	push   $0x0
     c72:	6a 00                	push   $0x0
     c74:	57                   	push   %edi
     c75:	56                   	push   %esi
     c76:	e8 65 fb ff ff       	call   7e0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	57                   	push   %edi
     c7e:	56                   	push   %esi
     c7f:	e8 ac ff ff ff       	call   c30 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     c84:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     c8b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     c8d:	e8 6e 08 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     c92:	83 c4 0c             	add    $0xc,%esp
     c95:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     c97:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     c99:	6a 00                	push   $0x0
     c9b:	50                   	push   %eax
     c9c:	e8 5f 03 00 00       	call   1000 <memset>
  cmd->left = left;
     ca1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ca4:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     ca7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     ca9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     caf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     cb1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     cb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb7:	5b                   	pop    %ebx
     cb8:	5e                   	pop    %esi
     cb9:	5f                   	pop    %edi
     cba:	5d                   	pop    %ebp
     cbb:	c3                   	ret
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cc0 <parseline>:
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	57                   	push   %edi
     cc4:	56                   	push   %esi
     cc5:	53                   	push   %ebx
     cc6:	83 ec 24             	sub    $0x24,%esp
     cc9:	8b 75 08             	mov    0x8(%ebp),%esi
     ccc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     ccf:	57                   	push   %edi
     cd0:	56                   	push   %esi
     cd1:	e8 5a ff ff ff       	call   c30 <parsepipe>
  while(peek(ps, es, "&")){
     cd6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     cd9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     cdb:	eb 3b                	jmp    d18 <parseline+0x58>
     cdd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     ce0:	6a 00                	push   $0x0
     ce2:	6a 00                	push   $0x0
     ce4:	57                   	push   %edi
     ce5:	56                   	push   %esi
     ce6:	e8 f5 fa ff ff       	call   7e0 <gettoken>
  cmd = malloc(sizeof(*cmd));
     ceb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     cf2:	e8 09 08 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     cf7:	83 c4 0c             	add    $0xc,%esp
     cfa:	6a 08                	push   $0x8
     cfc:	6a 00                	push   $0x0
     cfe:	50                   	push   %eax
     cff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     d02:	e8 f9 02 00 00       	call   1000 <memset>
  cmd->type = BACK;
     d07:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     d0a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     d0d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     d13:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     d16:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     d18:	83 ec 04             	sub    $0x4,%esp
     d1b:	68 71 16 00 00       	push   $0x1671
     d20:	57                   	push   %edi
     d21:	56                   	push   %esi
     d22:	e8 29 fc ff ff       	call   950 <peek>
     d27:	83 c4 10             	add    $0x10,%esp
     d2a:	85 c0                	test   %eax,%eax
     d2c:	75 b2                	jne    ce0 <parseline+0x20>
  if(peek(ps, es, ";")){
     d2e:	83 ec 04             	sub    $0x4,%esp
     d31:	68 6d 16 00 00       	push   $0x166d
     d36:	57                   	push   %edi
     d37:	56                   	push   %esi
     d38:	e8 13 fc ff ff       	call   950 <peek>
     d3d:	83 c4 10             	add    $0x10,%esp
     d40:	85 c0                	test   %eax,%eax
     d42:	75 0c                	jne    d50 <parseline+0x90>
}
     d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d47:	89 d8                	mov    %ebx,%eax
     d49:	5b                   	pop    %ebx
     d4a:	5e                   	pop    %esi
     d4b:	5f                   	pop    %edi
     d4c:	5d                   	pop    %ebp
     d4d:	c3                   	ret
     d4e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     d50:	6a 00                	push   $0x0
     d52:	6a 00                	push   $0x0
     d54:	57                   	push   %edi
     d55:	56                   	push   %esi
     d56:	e8 85 fa ff ff       	call   7e0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     d5b:	58                   	pop    %eax
     d5c:	5a                   	pop    %edx
     d5d:	57                   	push   %edi
     d5e:	56                   	push   %esi
     d5f:	e8 5c ff ff ff       	call   cc0 <parseline>
  cmd = malloc(sizeof(*cmd));
     d64:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     d6b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     d6d:	e8 8e 07 00 00       	call   1500 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     d72:	83 c4 0c             	add    $0xc,%esp
     d75:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     d77:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     d79:	6a 00                	push   $0x0
     d7b:	50                   	push   %eax
     d7c:	e8 7f 02 00 00       	call   1000 <memset>
  cmd->left = left;
     d81:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     d84:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     d87:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     d89:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     d8f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     d91:	89 7e 08             	mov    %edi,0x8(%esi)
}
     d94:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d97:	5b                   	pop    %ebx
     d98:	5e                   	pop    %esi
     d99:	5f                   	pop    %edi
     d9a:	5d                   	pop    %ebp
     d9b:	c3                   	ret
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000da0 <parseblock>:
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	57                   	push   %edi
     da4:	56                   	push   %esi
     da5:	53                   	push   %ebx
     da6:	83 ec 10             	sub    $0x10,%esp
     da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dac:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     daf:	68 53 16 00 00       	push   $0x1653
     db4:	56                   	push   %esi
     db5:	53                   	push   %ebx
     db6:	e8 95 fb ff ff       	call   950 <peek>
     dbb:	83 c4 10             	add    $0x10,%esp
     dbe:	85 c0                	test   %eax,%eax
     dc0:	74 4a                	je     e0c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     dc2:	6a 00                	push   $0x0
     dc4:	6a 00                	push   $0x0
     dc6:	56                   	push   %esi
     dc7:	53                   	push   %ebx
     dc8:	e8 13 fa ff ff       	call   7e0 <gettoken>
  cmd = parseline(ps, es);
     dcd:	58                   	pop    %eax
     dce:	5a                   	pop    %edx
     dcf:	56                   	push   %esi
     dd0:	53                   	push   %ebx
     dd1:	e8 ea fe ff ff       	call   cc0 <parseline>
  if(!peek(ps, es, ")"))
     dd6:	83 c4 0c             	add    $0xc,%esp
     dd9:	68 8f 16 00 00       	push   $0x168f
  cmd = parseline(ps, es);
     dde:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     de0:	56                   	push   %esi
     de1:	53                   	push   %ebx
     de2:	e8 69 fb ff ff       	call   950 <peek>
     de7:	83 c4 10             	add    $0x10,%esp
     dea:	85 c0                	test   %eax,%eax
     dec:	74 2b                	je     e19 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     dee:	6a 00                	push   $0x0
     df0:	6a 00                	push   $0x0
     df2:	56                   	push   %esi
     df3:	53                   	push   %ebx
     df4:	e8 e7 f9 ff ff       	call   7e0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     df9:	83 c4 0c             	add    $0xc,%esp
     dfc:	56                   	push   %esi
     dfd:	53                   	push   %ebx
     dfe:	57                   	push   %edi
     dff:	e8 cc fb ff ff       	call   9d0 <parseredirs>
}
     e04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e07:	5b                   	pop    %ebx
     e08:	5e                   	pop    %esi
     e09:	5f                   	pop    %edi
     e0a:	5d                   	pop    %ebp
     e0b:	c3                   	ret
    panic("parseblock");
     e0c:	83 ec 0c             	sub    $0xc,%esp
     e0f:	68 73 16 00 00       	push   $0x1673
     e14:	e8 77 f6 ff ff       	call   490 <panic>
    panic("syntax - missing )");
     e19:	83 ec 0c             	sub    $0xc,%esp
     e1c:	68 7e 16 00 00       	push   $0x167e
     e21:	e8 6a f6 ff ff       	call   490 <panic>
     e26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e2d:	00 
     e2e:	66 90                	xchg   %ax,%ax

00000e30 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	53                   	push   %ebx
     e34:	83 ec 04             	sub    $0x4,%esp
     e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     e3a:	85 db                	test   %ebx,%ebx
     e3c:	74 29                	je     e67 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     e3e:	83 3b 05             	cmpl   $0x5,(%ebx)
     e41:	77 24                	ja     e67 <nulterminate+0x37>
     e43:	8b 03                	mov    (%ebx),%eax
     e45:	ff 24 85 d8 16 00 00 	jmp    *0x16d8(,%eax,4)
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     e50:	83 ec 0c             	sub    $0xc,%esp
     e53:	ff 73 04             	push   0x4(%ebx)
     e56:	e8 d5 ff ff ff       	call   e30 <nulterminate>
    nulterminate(lcmd->right);
     e5b:	58                   	pop    %eax
     e5c:	ff 73 08             	push   0x8(%ebx)
     e5f:	e8 cc ff ff ff       	call   e30 <nulterminate>
    break;
     e64:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     e67:	89 d8                	mov    %ebx,%eax
     e69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e6c:	c9                   	leave
     e6d:	c3                   	ret
     e6e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     e70:	83 ec 0c             	sub    $0xc,%esp
     e73:	ff 73 04             	push   0x4(%ebx)
     e76:	e8 b5 ff ff ff       	call   e30 <nulterminate>
}
     e7b:	89 d8                	mov    %ebx,%eax
    break;
     e7d:	83 c4 10             	add    $0x10,%esp
}
     e80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e83:	c9                   	leave
     e84:	c3                   	ret
     e85:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     e88:	8b 4b 04             	mov    0x4(%ebx),%ecx
     e8b:	85 c9                	test   %ecx,%ecx
     e8d:	74 d8                	je     e67 <nulterminate+0x37>
     e8f:	8d 43 08             	lea    0x8(%ebx),%eax
     e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     e98:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     e9b:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     e9e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     ea1:	8b 50 fc             	mov    -0x4(%eax),%edx
     ea4:	85 d2                	test   %edx,%edx
     ea6:	75 f0                	jne    e98 <nulterminate+0x68>
}
     ea8:	89 d8                	mov    %ebx,%eax
     eaa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ead:	c9                   	leave
     eae:	c3                   	ret
     eaf:	90                   	nop
    nulterminate(rcmd->cmd);
     eb0:	83 ec 0c             	sub    $0xc,%esp
     eb3:	ff 73 04             	push   0x4(%ebx)
     eb6:	e8 75 ff ff ff       	call   e30 <nulterminate>
    *rcmd->efile = 0;
     ebb:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     ebe:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     ec1:	c6 00 00             	movb   $0x0,(%eax)
}
     ec4:	89 d8                	mov    %ebx,%eax
     ec6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec9:	c9                   	leave
     eca:	c3                   	ret
     ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000ed0 <parsecmd>:
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	56                   	push   %esi
  cmd = parseline(&s, es);
     ed5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     ed8:	53                   	push   %ebx
     ed9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     edc:	8b 5d 08             	mov    0x8(%ebp),%ebx
     edf:	53                   	push   %ebx
     ee0:	e8 eb 00 00 00       	call   fd0 <strlen>
  cmd = parseline(&s, es);
     ee5:	59                   	pop    %ecx
     ee6:	5e                   	pop    %esi
  es = s + strlen(s);
     ee7:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     ee9:	53                   	push   %ebx
     eea:	57                   	push   %edi
     eeb:	e8 d0 fd ff ff       	call   cc0 <parseline>
  peek(&s, es, "");
     ef0:	83 c4 0c             	add    $0xc,%esp
     ef3:	68 fc 15 00 00       	push   $0x15fc
  cmd = parseline(&s, es);
     ef8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     efa:	53                   	push   %ebx
     efb:	57                   	push   %edi
     efc:	e8 4f fa ff ff       	call   950 <peek>
  if(s != es){
     f01:	8b 45 08             	mov    0x8(%ebp),%eax
     f04:	83 c4 10             	add    $0x10,%esp
     f07:	39 d8                	cmp    %ebx,%eax
     f09:	75 13                	jne    f1e <parsecmd+0x4e>
  nulterminate(cmd);
     f0b:	83 ec 0c             	sub    $0xc,%esp
     f0e:	56                   	push   %esi
     f0f:	e8 1c ff ff ff       	call   e30 <nulterminate>
}
     f14:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f17:	89 f0                	mov    %esi,%eax
     f19:	5b                   	pop    %ebx
     f1a:	5e                   	pop    %esi
     f1b:	5f                   	pop    %edi
     f1c:	5d                   	pop    %ebp
     f1d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     f1e:	52                   	push   %edx
     f1f:	50                   	push   %eax
     f20:	68 91 16 00 00       	push   $0x1691
     f25:	6a 02                	push   $0x2
     f27:	e8 b4 03 00 00       	call   12e0 <printf>
    panic("syntax");
     f2c:	c7 04 24 55 16 00 00 	movl   $0x1655,(%esp)
     f33:	e8 58 f5 ff ff       	call   490 <panic>
     f38:	66 90                	xchg   %ax,%ax
     f3a:	66 90                	xchg   %ax,%ax
     f3c:	66 90                	xchg   %ax,%ax
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f40:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f41:	31 c0                	xor    %eax,%eax
{
     f43:	89 e5                	mov    %esp,%ebp
     f45:	53                   	push   %ebx
     f46:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     f50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     f54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     f57:	83 c0 01             	add    $0x1,%eax
     f5a:	84 d2                	test   %dl,%dl
     f5c:	75 f2                	jne    f50 <strcpy+0x10>
    ;
  return os;
}
     f5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f61:	89 c8                	mov    %ecx,%eax
     f63:	c9                   	leave
     f64:	c3                   	ret
     f65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f6c:	00 
     f6d:	8d 76 00             	lea    0x0(%esi),%esi

00000f70 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	53                   	push   %ebx
     f74:	8b 55 08             	mov    0x8(%ebp),%edx
     f77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     f7a:	0f b6 02             	movzbl (%edx),%eax
     f7d:	84 c0                	test   %al,%al
     f7f:	75 17                	jne    f98 <strcmp+0x28>
     f81:	eb 3a                	jmp    fbd <strcmp+0x4d>
     f83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f88:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     f8c:	83 c2 01             	add    $0x1,%edx
     f8f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     f92:	84 c0                	test   %al,%al
     f94:	74 1a                	je     fb0 <strcmp+0x40>
     f96:	89 d9                	mov    %ebx,%ecx
     f98:	0f b6 19             	movzbl (%ecx),%ebx
     f9b:	38 c3                	cmp    %al,%bl
     f9d:	74 e9                	je     f88 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     f9f:	29 d8                	sub    %ebx,%eax
}
     fa1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fa4:	c9                   	leave
     fa5:	c3                   	ret
     fa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     fad:	00 
     fae:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     fb0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     fb4:	31 c0                	xor    %eax,%eax
     fb6:	29 d8                	sub    %ebx,%eax
}
     fb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fbb:	c9                   	leave
     fbc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     fbd:	0f b6 19             	movzbl (%ecx),%ebx
     fc0:	31 c0                	xor    %eax,%eax
     fc2:	eb db                	jmp    f9f <strcmp+0x2f>
     fc4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     fcb:	00 
     fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fd0 <strlen>:

uint
strlen(const char *s)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     fd6:	80 3a 00             	cmpb   $0x0,(%edx)
     fd9:	74 15                	je     ff0 <strlen+0x20>
     fdb:	31 c0                	xor    %eax,%eax
     fdd:	8d 76 00             	lea    0x0(%esi),%esi
     fe0:	83 c0 01             	add    $0x1,%eax
     fe3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     fe7:	89 c1                	mov    %eax,%ecx
     fe9:	75 f5                	jne    fe0 <strlen+0x10>
    ;
  return n;
}
     feb:	89 c8                	mov    %ecx,%eax
     fed:	5d                   	pop    %ebp
     fee:	c3                   	ret
     fef:	90                   	nop
  for(n = 0; s[n]; n++)
     ff0:	31 c9                	xor    %ecx,%ecx
}
     ff2:	5d                   	pop    %ebp
     ff3:	89 c8                	mov    %ecx,%eax
     ff5:	c3                   	ret
     ff6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ffd:	00 
     ffe:	66 90                	xchg   %ax,%ax

00001000 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1007:	8b 4d 10             	mov    0x10(%ebp),%ecx
    100a:	8b 45 0c             	mov    0xc(%ebp),%eax
    100d:	89 d7                	mov    %edx,%edi
    100f:	fc                   	cld
    1010:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1012:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1015:	89 d0                	mov    %edx,%eax
    1017:	c9                   	leave
    1018:	c3                   	ret
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001020 <strchr>:

char*
strchr(const char *s, char c)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	8b 45 08             	mov    0x8(%ebp),%eax
    1026:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    102a:	0f b6 10             	movzbl (%eax),%edx
    102d:	84 d2                	test   %dl,%dl
    102f:	75 12                	jne    1043 <strchr+0x23>
    1031:	eb 1d                	jmp    1050 <strchr+0x30>
    1033:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1038:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    103c:	83 c0 01             	add    $0x1,%eax
    103f:	84 d2                	test   %dl,%dl
    1041:	74 0d                	je     1050 <strchr+0x30>
    if(*s == c)
    1043:	38 d1                	cmp    %dl,%cl
    1045:	75 f1                	jne    1038 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1047:	5d                   	pop    %ebp
    1048:	c3                   	ret
    1049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1050:	31 c0                	xor    %eax,%eax
}
    1052:	5d                   	pop    %ebp
    1053:	c3                   	ret
    1054:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    105b:	00 
    105c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001060 <gets>:

char*
gets(char *buf, int max)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	57                   	push   %edi
    1064:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    1065:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
    1068:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    1069:	31 db                	xor    %ebx,%ebx
{
    106b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    106e:	eb 27                	jmp    1097 <gets+0x37>
    cc = read(0, &c, 1);
    1070:	83 ec 04             	sub    $0x4,%esp
    1073:	6a 01                	push   $0x1
    1075:	56                   	push   %esi
    1076:	6a 00                	push   $0x0
    1078:	e8 1e 01 00 00       	call   119b <read>
    if(cc < 1)
    107d:	83 c4 10             	add    $0x10,%esp
    1080:	85 c0                	test   %eax,%eax
    1082:	7e 1d                	jle    10a1 <gets+0x41>
      break;
    buf[i++] = c;
    1084:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1088:	8b 55 08             	mov    0x8(%ebp),%edx
    108b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    108f:	3c 0a                	cmp    $0xa,%al
    1091:	74 10                	je     10a3 <gets+0x43>
    1093:	3c 0d                	cmp    $0xd,%al
    1095:	74 0c                	je     10a3 <gets+0x43>
  for(i=0; i+1 < max; ){
    1097:	89 df                	mov    %ebx,%edi
    1099:	83 c3 01             	add    $0x1,%ebx
    109c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    109f:	7c cf                	jl     1070 <gets+0x10>
    10a1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    10aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ad:	5b                   	pop    %ebx
    10ae:	5e                   	pop    %esi
    10af:	5f                   	pop    %edi
    10b0:	5d                   	pop    %ebp
    10b1:	c3                   	ret
    10b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10b9:	00 
    10ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000010c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	56                   	push   %esi
    10c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10c5:	83 ec 08             	sub    $0x8,%esp
    10c8:	6a 00                	push   $0x0
    10ca:	ff 75 08             	push   0x8(%ebp)
    10cd:	e8 f1 00 00 00       	call   11c3 <open>
  if(fd < 0)
    10d2:	83 c4 10             	add    $0x10,%esp
    10d5:	85 c0                	test   %eax,%eax
    10d7:	78 27                	js     1100 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    10d9:	83 ec 08             	sub    $0x8,%esp
    10dc:	ff 75 0c             	push   0xc(%ebp)
    10df:	89 c3                	mov    %eax,%ebx
    10e1:	50                   	push   %eax
    10e2:	e8 f4 00 00 00       	call   11db <fstat>
  close(fd);
    10e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10ea:	89 c6                	mov    %eax,%esi
  close(fd);
    10ec:	e8 ba 00 00 00       	call   11ab <close>
  return r;
    10f1:	83 c4 10             	add    $0x10,%esp
}
    10f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10f7:	89 f0                	mov    %esi,%eax
    10f9:	5b                   	pop    %ebx
    10fa:	5e                   	pop    %esi
    10fb:	5d                   	pop    %ebp
    10fc:	c3                   	ret
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1100:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1105:	eb ed                	jmp    10f4 <stat+0x34>
    1107:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    110e:	00 
    110f:	90                   	nop

00001110 <atoi>:

int
atoi(const char *s)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	53                   	push   %ebx
    1114:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1117:	0f be 02             	movsbl (%edx),%eax
    111a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    111d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1120:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1125:	77 1e                	ja     1145 <atoi+0x35>
    1127:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    112e:	00 
    112f:	90                   	nop
    n = n*10 + *s++ - '0';
    1130:	83 c2 01             	add    $0x1,%edx
    1133:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1136:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    113a:	0f be 02             	movsbl (%edx),%eax
    113d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1140:	80 fb 09             	cmp    $0x9,%bl
    1143:	76 eb                	jbe    1130 <atoi+0x20>
  return n;
}
    1145:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1148:	89 c8                	mov    %ecx,%eax
    114a:	c9                   	leave
    114b:	c3                   	ret
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001150 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	8b 45 10             	mov    0x10(%ebp),%eax
    1157:	8b 55 08             	mov    0x8(%ebp),%edx
    115a:	56                   	push   %esi
    115b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    115e:	85 c0                	test   %eax,%eax
    1160:	7e 13                	jle    1175 <memmove+0x25>
    1162:	01 d0                	add    %edx,%eax
  dst = vdst;
    1164:	89 d7                	mov    %edx,%edi
    1166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    116d:	00 
    116e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    1170:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1171:	39 f8                	cmp    %edi,%eax
    1173:	75 fb                	jne    1170 <memmove+0x20>
  return vdst;
}
    1175:	5e                   	pop    %esi
    1176:	89 d0                	mov    %edx,%eax
    1178:	5f                   	pop    %edi
    1179:	5d                   	pop    %ebp
    117a:	c3                   	ret

0000117b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    117b:	b8 01 00 00 00       	mov    $0x1,%eax
    1180:	cd 40                	int    $0x40
    1182:	c3                   	ret

00001183 <exit>:
SYSCALL(exit)
    1183:	b8 02 00 00 00       	mov    $0x2,%eax
    1188:	cd 40                	int    $0x40
    118a:	c3                   	ret

0000118b <wait>:
SYSCALL(wait)
    118b:	b8 03 00 00 00       	mov    $0x3,%eax
    1190:	cd 40                	int    $0x40
    1192:	c3                   	ret

00001193 <pipe>:
SYSCALL(pipe)
    1193:	b8 04 00 00 00       	mov    $0x4,%eax
    1198:	cd 40                	int    $0x40
    119a:	c3                   	ret

0000119b <read>:
SYSCALL(read)
    119b:	b8 05 00 00 00       	mov    $0x5,%eax
    11a0:	cd 40                	int    $0x40
    11a2:	c3                   	ret

000011a3 <write>:
SYSCALL(write)
    11a3:	b8 10 00 00 00       	mov    $0x10,%eax
    11a8:	cd 40                	int    $0x40
    11aa:	c3                   	ret

000011ab <close>:
SYSCALL(close)
    11ab:	b8 15 00 00 00       	mov    $0x15,%eax
    11b0:	cd 40                	int    $0x40
    11b2:	c3                   	ret

000011b3 <kill>:
SYSCALL(kill)
    11b3:	b8 06 00 00 00       	mov    $0x6,%eax
    11b8:	cd 40                	int    $0x40
    11ba:	c3                   	ret

000011bb <exec>:
SYSCALL(exec)
    11bb:	b8 07 00 00 00       	mov    $0x7,%eax
    11c0:	cd 40                	int    $0x40
    11c2:	c3                   	ret

000011c3 <open>:
SYSCALL(open)
    11c3:	b8 0f 00 00 00       	mov    $0xf,%eax
    11c8:	cd 40                	int    $0x40
    11ca:	c3                   	ret

000011cb <mknod>:
SYSCALL(mknod)
    11cb:	b8 11 00 00 00       	mov    $0x11,%eax
    11d0:	cd 40                	int    $0x40
    11d2:	c3                   	ret

000011d3 <unlink>:
SYSCALL(unlink)
    11d3:	b8 12 00 00 00       	mov    $0x12,%eax
    11d8:	cd 40                	int    $0x40
    11da:	c3                   	ret

000011db <fstat>:
SYSCALL(fstat)
    11db:	b8 08 00 00 00       	mov    $0x8,%eax
    11e0:	cd 40                	int    $0x40
    11e2:	c3                   	ret

000011e3 <link>:
SYSCALL(link)
    11e3:	b8 13 00 00 00       	mov    $0x13,%eax
    11e8:	cd 40                	int    $0x40
    11ea:	c3                   	ret

000011eb <mkdir>:
SYSCALL(mkdir)
    11eb:	b8 14 00 00 00       	mov    $0x14,%eax
    11f0:	cd 40                	int    $0x40
    11f2:	c3                   	ret

000011f3 <chdir>:
SYSCALL(chdir)
    11f3:	b8 09 00 00 00       	mov    $0x9,%eax
    11f8:	cd 40                	int    $0x40
    11fa:	c3                   	ret

000011fb <dup>:
SYSCALL(dup)
    11fb:	b8 0a 00 00 00       	mov    $0xa,%eax
    1200:	cd 40                	int    $0x40
    1202:	c3                   	ret

00001203 <getpid>:
SYSCALL(getpid)
    1203:	b8 0b 00 00 00       	mov    $0xb,%eax
    1208:	cd 40                	int    $0x40
    120a:	c3                   	ret

0000120b <sbrk>:
SYSCALL(sbrk)
    120b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1210:	cd 40                	int    $0x40
    1212:	c3                   	ret

00001213 <sleep>:
SYSCALL(sleep)
    1213:	b8 0d 00 00 00       	mov    $0xd,%eax
    1218:	cd 40                	int    $0x40
    121a:	c3                   	ret

0000121b <uptime>:
SYSCALL(uptime)
    121b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1220:	cd 40                	int    $0x40
    1222:	c3                   	ret

00001223 <getproccount>:
SYSCALL(getproccount)
    1223:	b8 16 00 00 00       	mov    $0x16,%eax
    1228:	cd 40                	int    $0x40
    122a:	c3                   	ret

0000122b <reboot>:
SYSCALL(reboot)
    122b:	b8 17 00 00 00       	mov    $0x17,%eax
    1230:	cd 40                	int    $0x40
    1232:	c3                   	ret
    1233:	66 90                	xchg   %ax,%ax
    1235:	66 90                	xchg   %ax,%ax
    1237:	66 90                	xchg   %ax,%ax
    1239:	66 90                	xchg   %ax,%ax
    123b:	66 90                	xchg   %ax,%ax
    123d:	66 90                	xchg   %ax,%ax
    123f:	90                   	nop

00001240 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	57                   	push   %edi
    1244:	56                   	push   %esi
    1245:	53                   	push   %ebx
    1246:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1248:	89 d1                	mov    %edx,%ecx
{
    124a:	83 ec 3c             	sub    $0x3c,%esp
    124d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    1250:	85 d2                	test   %edx,%edx
    1252:	0f 89 80 00 00 00    	jns    12d8 <printint+0x98>
    1258:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    125c:	74 7a                	je     12d8 <printint+0x98>
    x = -xx;
    125e:	f7 d9                	neg    %ecx
    neg = 1;
    1260:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    1265:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    1268:	31 f6                	xor    %esi,%esi
    126a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1270:	89 c8                	mov    %ecx,%eax
    1272:	31 d2                	xor    %edx,%edx
    1274:	89 f7                	mov    %esi,%edi
    1276:	f7 f3                	div    %ebx
    1278:	8d 76 01             	lea    0x1(%esi),%esi
    127b:	0f b6 92 48 17 00 00 	movzbl 0x1748(%edx),%edx
    1282:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    1286:	89 ca                	mov    %ecx,%edx
    1288:	89 c1                	mov    %eax,%ecx
    128a:	39 da                	cmp    %ebx,%edx
    128c:	73 e2                	jae    1270 <printint+0x30>
  if(neg)
    128e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1291:	85 c0                	test   %eax,%eax
    1293:	74 07                	je     129c <printint+0x5c>
    buf[i++] = '-';
    1295:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    129a:	89 f7                	mov    %esi,%edi
    129c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    129f:	8b 75 c0             	mov    -0x40(%ebp),%esi
    12a2:	01 df                	add    %ebx,%edi
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    12a8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    12ab:	83 ec 04             	sub    $0x4,%esp
    12ae:	88 45 d7             	mov    %al,-0x29(%ebp)
    12b1:	8d 45 d7             	lea    -0x29(%ebp),%eax
    12b4:	6a 01                	push   $0x1
    12b6:	50                   	push   %eax
    12b7:	56                   	push   %esi
    12b8:	e8 e6 fe ff ff       	call   11a3 <write>
  while(--i >= 0)
    12bd:	89 f8                	mov    %edi,%eax
    12bf:	83 c4 10             	add    $0x10,%esp
    12c2:	83 ef 01             	sub    $0x1,%edi
    12c5:	39 c3                	cmp    %eax,%ebx
    12c7:	75 df                	jne    12a8 <printint+0x68>
}
    12c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12cc:	5b                   	pop    %ebx
    12cd:	5e                   	pop    %esi
    12ce:	5f                   	pop    %edi
    12cf:	5d                   	pop    %ebp
    12d0:	c3                   	ret
    12d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    12d8:	31 c0                	xor    %eax,%eax
    12da:	eb 89                	jmp    1265 <printint+0x25>
    12dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	57                   	push   %edi
    12e4:	56                   	push   %esi
    12e5:	53                   	push   %ebx
    12e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    12e9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    12ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    12ef:	0f b6 1e             	movzbl (%esi),%ebx
    12f2:	83 c6 01             	add    $0x1,%esi
    12f5:	84 db                	test   %bl,%bl
    12f7:	74 67                	je     1360 <printf+0x80>
    12f9:	8d 4d 10             	lea    0x10(%ebp),%ecx
    12fc:	31 d2                	xor    %edx,%edx
    12fe:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1301:	eb 34                	jmp    1337 <printf+0x57>
    1303:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1308:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    130b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1310:	83 f8 25             	cmp    $0x25,%eax
    1313:	74 18                	je     132d <printf+0x4d>
  write(fd, &c, 1);
    1315:	83 ec 04             	sub    $0x4,%esp
    1318:	8d 45 e7             	lea    -0x19(%ebp),%eax
    131b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    131e:	6a 01                	push   $0x1
    1320:	50                   	push   %eax
    1321:	57                   	push   %edi
    1322:	e8 7c fe ff ff       	call   11a3 <write>
    1327:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    132a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    132d:	0f b6 1e             	movzbl (%esi),%ebx
    1330:	83 c6 01             	add    $0x1,%esi
    1333:	84 db                	test   %bl,%bl
    1335:	74 29                	je     1360 <printf+0x80>
    c = fmt[i] & 0xff;
    1337:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    133a:	85 d2                	test   %edx,%edx
    133c:	74 ca                	je     1308 <printf+0x28>
      }
    } else if(state == '%'){
    133e:	83 fa 25             	cmp    $0x25,%edx
    1341:	75 ea                	jne    132d <printf+0x4d>
      if(c == 'd'){
    1343:	83 f8 25             	cmp    $0x25,%eax
    1346:	0f 84 04 01 00 00    	je     1450 <printf+0x170>
    134c:	83 e8 63             	sub    $0x63,%eax
    134f:	83 f8 15             	cmp    $0x15,%eax
    1352:	77 1c                	ja     1370 <printf+0x90>
    1354:	ff 24 85 f0 16 00 00 	jmp    *0x16f0(,%eax,4)
    135b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1360:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1363:	5b                   	pop    %ebx
    1364:	5e                   	pop    %esi
    1365:	5f                   	pop    %edi
    1366:	5d                   	pop    %ebp
    1367:	c3                   	ret
    1368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    136f:	00 
  write(fd, &c, 1);
    1370:	83 ec 04             	sub    $0x4,%esp
    1373:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1376:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    137a:	6a 01                	push   $0x1
    137c:	52                   	push   %edx
    137d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1380:	57                   	push   %edi
    1381:	e8 1d fe ff ff       	call   11a3 <write>
    1386:	83 c4 0c             	add    $0xc,%esp
    1389:	88 5d e7             	mov    %bl,-0x19(%ebp)
    138c:	6a 01                	push   $0x1
    138e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1391:	52                   	push   %edx
    1392:	57                   	push   %edi
    1393:	e8 0b fe ff ff       	call   11a3 <write>
        putc(fd, c);
    1398:	83 c4 10             	add    $0x10,%esp
      state = 0;
    139b:	31 d2                	xor    %edx,%edx
    139d:	eb 8e                	jmp    132d <printf+0x4d>
    139f:	90                   	nop
        printint(fd, *ap, 16, 0);
    13a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13a3:	83 ec 0c             	sub    $0xc,%esp
    13a6:	b9 10 00 00 00       	mov    $0x10,%ecx
    13ab:	8b 13                	mov    (%ebx),%edx
    13ad:	6a 00                	push   $0x0
    13af:	89 f8                	mov    %edi,%eax
        ap++;
    13b1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    13b4:	e8 87 fe ff ff       	call   1240 <printint>
        ap++;
    13b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    13bc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    13bf:	31 d2                	xor    %edx,%edx
    13c1:	e9 67 ff ff ff       	jmp    132d <printf+0x4d>
        s = (char*)*ap;
    13c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13c9:	8b 18                	mov    (%eax),%ebx
        ap++;
    13cb:	83 c0 04             	add    $0x4,%eax
    13ce:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    13d1:	85 db                	test   %ebx,%ebx
    13d3:	0f 84 87 00 00 00    	je     1460 <printf+0x180>
        while(*s != 0){
    13d9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    13dc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    13de:	84 c0                	test   %al,%al
    13e0:	0f 84 47 ff ff ff    	je     132d <printf+0x4d>
    13e6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    13e9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    13ec:	89 de                	mov    %ebx,%esi
    13ee:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    13f0:	83 ec 04             	sub    $0x4,%esp
    13f3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    13f6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    13f9:	6a 01                	push   $0x1
    13fb:	53                   	push   %ebx
    13fc:	57                   	push   %edi
    13fd:	e8 a1 fd ff ff       	call   11a3 <write>
        while(*s != 0){
    1402:	0f b6 06             	movzbl (%esi),%eax
    1405:	83 c4 10             	add    $0x10,%esp
    1408:	84 c0                	test   %al,%al
    140a:	75 e4                	jne    13f0 <printf+0x110>
      state = 0;
    140c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    140f:	31 d2                	xor    %edx,%edx
    1411:	e9 17 ff ff ff       	jmp    132d <printf+0x4d>
        printint(fd, *ap, 10, 1);
    1416:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1419:	83 ec 0c             	sub    $0xc,%esp
    141c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1421:	8b 13                	mov    (%ebx),%edx
    1423:	6a 01                	push   $0x1
    1425:	eb 88                	jmp    13af <printf+0xcf>
        putc(fd, *ap);
    1427:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    142a:	83 ec 04             	sub    $0x4,%esp
    142d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1430:	8b 03                	mov    (%ebx),%eax
        ap++;
    1432:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1435:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1438:	6a 01                	push   $0x1
    143a:	52                   	push   %edx
    143b:	57                   	push   %edi
    143c:	e8 62 fd ff ff       	call   11a3 <write>
        ap++;
    1441:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1444:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1447:	31 d2                	xor    %edx,%edx
    1449:	e9 df fe ff ff       	jmp    132d <printf+0x4d>
    144e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1450:	83 ec 04             	sub    $0x4,%esp
    1453:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1456:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1459:	6a 01                	push   $0x1
    145b:	e9 31 ff ff ff       	jmp    1391 <printf+0xb1>
    1460:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1465:	bb b9 16 00 00       	mov    $0x16b9,%ebx
    146a:	e9 77 ff ff ff       	jmp    13e6 <printf+0x106>
    146f:	90                   	nop

00001470 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1470:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1471:	a1 84 22 00 00       	mov    0x2284,%eax
{
    1476:	89 e5                	mov    %esp,%ebp
    1478:	57                   	push   %edi
    1479:	56                   	push   %esi
    147a:	53                   	push   %ebx
    147b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    147e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1488:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    148a:	39 c8                	cmp    %ecx,%eax
    148c:	73 32                	jae    14c0 <free+0x50>
    148e:	39 d1                	cmp    %edx,%ecx
    1490:	72 04                	jb     1496 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1492:	39 d0                	cmp    %edx,%eax
    1494:	72 32                	jb     14c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1496:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1499:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    149c:	39 fa                	cmp    %edi,%edx
    149e:	74 30                	je     14d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    14a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    14a3:	8b 50 04             	mov    0x4(%eax),%edx
    14a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14a9:	39 f1                	cmp    %esi,%ecx
    14ab:	74 3a                	je     14e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    14ad:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    14af:	5b                   	pop    %ebx
  freep = p;
    14b0:	a3 84 22 00 00       	mov    %eax,0x2284
}
    14b5:	5e                   	pop    %esi
    14b6:	5f                   	pop    %edi
    14b7:	5d                   	pop    %ebp
    14b8:	c3                   	ret
    14b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14c0:	39 d0                	cmp    %edx,%eax
    14c2:	72 04                	jb     14c8 <free+0x58>
    14c4:	39 d1                	cmp    %edx,%ecx
    14c6:	72 ce                	jb     1496 <free+0x26>
{
    14c8:	89 d0                	mov    %edx,%eax
    14ca:	eb bc                	jmp    1488 <free+0x18>
    14cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    14d0:	03 72 04             	add    0x4(%edx),%esi
    14d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    14d6:	8b 10                	mov    (%eax),%edx
    14d8:	8b 12                	mov    (%edx),%edx
    14da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14dd:	8b 50 04             	mov    0x4(%eax),%edx
    14e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14e3:	39 f1                	cmp    %esi,%ecx
    14e5:	75 c6                	jne    14ad <free+0x3d>
    p->s.size += bp->s.size;
    14e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    14ea:	a3 84 22 00 00       	mov    %eax,0x2284
    p->s.size += bp->s.size;
    14ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    14f2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    14f5:	89 08                	mov    %ecx,(%eax)
}
    14f7:	5b                   	pop    %ebx
    14f8:	5e                   	pop    %esi
    14f9:	5f                   	pop    %edi
    14fa:	5d                   	pop    %ebp
    14fb:	c3                   	ret
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001500 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1500:	55                   	push   %ebp
    1501:	89 e5                	mov    %esp,%ebp
    1503:	57                   	push   %edi
    1504:	56                   	push   %esi
    1505:	53                   	push   %ebx
    1506:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1509:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    150c:	8b 15 84 22 00 00    	mov    0x2284,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1512:	8d 78 07             	lea    0x7(%eax),%edi
    1515:	c1 ef 03             	shr    $0x3,%edi
    1518:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    151b:	85 d2                	test   %edx,%edx
    151d:	0f 84 8d 00 00 00    	je     15b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1523:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1525:	8b 48 04             	mov    0x4(%eax),%ecx
    1528:	39 f9                	cmp    %edi,%ecx
    152a:	73 64                	jae    1590 <malloc+0x90>
  if(nu < 4096)
    152c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1531:	39 df                	cmp    %ebx,%edi
    1533:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1536:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    153d:	eb 0a                	jmp    1549 <malloc+0x49>
    153f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1540:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1542:	8b 48 04             	mov    0x4(%eax),%ecx
    1545:	39 f9                	cmp    %edi,%ecx
    1547:	73 47                	jae    1590 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1549:	89 c2                	mov    %eax,%edx
    154b:	3b 05 84 22 00 00    	cmp    0x2284,%eax
    1551:	75 ed                	jne    1540 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1553:	83 ec 0c             	sub    $0xc,%esp
    1556:	56                   	push   %esi
    1557:	e8 af fc ff ff       	call   120b <sbrk>
  if(p == (char*)-1)
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1562:	74 1c                	je     1580 <malloc+0x80>
  hp->s.size = nu;
    1564:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1567:	83 ec 0c             	sub    $0xc,%esp
    156a:	83 c0 08             	add    $0x8,%eax
    156d:	50                   	push   %eax
    156e:	e8 fd fe ff ff       	call   1470 <free>
  return freep;
    1573:	8b 15 84 22 00 00    	mov    0x2284,%edx
      if((p = morecore(nunits)) == 0)
    1579:	83 c4 10             	add    $0x10,%esp
    157c:	85 d2                	test   %edx,%edx
    157e:	75 c0                	jne    1540 <malloc+0x40>
        return 0;
  }
}
    1580:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1583:	31 c0                	xor    %eax,%eax
}
    1585:	5b                   	pop    %ebx
    1586:	5e                   	pop    %esi
    1587:	5f                   	pop    %edi
    1588:	5d                   	pop    %ebp
    1589:	c3                   	ret
    158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1590:	39 cf                	cmp    %ecx,%edi
    1592:	74 4c                	je     15e0 <malloc+0xe0>
        p->s.size -= nunits;
    1594:	29 f9                	sub    %edi,%ecx
    1596:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1599:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    159c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    159f:	89 15 84 22 00 00    	mov    %edx,0x2284
}
    15a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    15a8:	83 c0 08             	add    $0x8,%eax
}
    15ab:	5b                   	pop    %ebx
    15ac:	5e                   	pop    %esi
    15ad:	5f                   	pop    %edi
    15ae:	5d                   	pop    %ebp
    15af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    15b0:	c7 05 84 22 00 00 88 	movl   $0x2288,0x2284
    15b7:	22 00 00 
    base.s.size = 0;
    15ba:	b8 88 22 00 00       	mov    $0x2288,%eax
    base.s.ptr = freep = prevp = &base;
    15bf:	c7 05 88 22 00 00 88 	movl   $0x2288,0x2288
    15c6:	22 00 00 
    base.s.size = 0;
    15c9:	c7 05 8c 22 00 00 00 	movl   $0x0,0x228c
    15d0:	00 00 00 
    if(p->s.size >= nunits){
    15d3:	e9 54 ff ff ff       	jmp    152c <malloc+0x2c>
    15d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    15df:	00 
        prevp->s.ptr = p->s.ptr;
    15e0:	8b 08                	mov    (%eax),%ecx
    15e2:	89 0a                	mov    %ecx,(%edx)
    15e4:	eb b9                	jmp    159f <malloc+0x9f>
