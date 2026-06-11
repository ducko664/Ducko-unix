
_calc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        }
    }
    return result;
}

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    if (argc < 2) {
  11:	83 39 01             	cmpl   $0x1,(%ecx)
int main(int argc, char *argv[]) {
  14:	8b 41 04             	mov    0x4(%ecx),%eax
    if (argc < 2) {
  17:	7e 20                	jle    39 <main+0x39>
        printf(2, "Usage: calc \"[expression]\" (e.g., calc \"10*5+2\"(There cant be any spaces!!!))\n");
        exit();
    }

    int res = calculate(argv[1]);
  19:	83 ec 0c             	sub    $0xc,%esp
  1c:	ff 70 04             	push   0x4(%eax)
  1f:	e8 2c 00 00 00       	call   50 <calculate>
    printf(1, "= %d\n", res);
  24:	83 c4 0c             	add    $0xc,%esp
  27:	50                   	push   %eax
  28:	68 3d 08 00 00       	push   $0x83d
  2d:	6a 01                	push   $0x1
  2f:	e8 cc 04 00 00       	call   500 <printf>
    exit();
  34:	e8 6a 03 00 00       	call   3a3 <exit>
        printf(2, "Usage: calc \"[expression]\" (e.g., calc \"10*5+2\"(There cant be any spaces!!!))\n");
  39:	50                   	push   %eax
  3a:	50                   	push   %eax
  3b:	68 10 09 00 00       	push   $0x910
  40:	6a 02                	push   $0x2
  42:	e8 b9 04 00 00       	call   500 <printf>
        exit();
  47:	e8 57 03 00 00       	call   3a3 <exit>
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <calculate>:
int calculate(char *str) {
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	57                   	push   %edi
  54:	56                   	push   %esi
  55:	53                   	push   %ebx
  56:	83 ec 1c             	sub    $0x1c,%esp
  59:	8b 4d 08             	mov    0x8(%ebp),%ecx
    while (*str) {
  5c:	0f be 11             	movsbl (%ecx),%edx
  5f:	84 d2                	test   %dl,%dl
  61:	74 38                	je     9b <calculate+0x4b>
    int result = 0;
  63:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    char op = '+';
  6a:	bb 2b 00 00 00       	mov    $0x2b,%ebx
        if (*str == ' ' || *str == '\t') {
  6f:	8d 72 f7             	lea    -0x9(%edx),%esi
  72:	89 f0                	mov    %esi,%eax
  74:	3c 30                	cmp    $0x30,%al
  76:	77 10                	ja     88 <calculate+0x38>
  78:	0f b6 f0             	movzbl %al,%esi
  7b:	ff 24 b5 4c 08 00 00 	jmp    *0x84c(,%esi,4)
  82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printf(2, "calc: Unknown symbol '%c'\n", *str);
  88:	83 ec 04             	sub    $0x4,%esp
  8b:	52                   	push   %edx
  8c:	68 22 08 00 00       	push   $0x822
  91:	6a 02                	push   $0x2
  93:	e8 68 04 00 00       	call   500 <printf>
            return 0;
  98:	83 c4 10             	add    $0x10,%esp
                    return 0;
  9b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
  a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  a8:	5b                   	pop    %ebx
  a9:	5e                   	pop    %esi
  aa:	5f                   	pop    %edi
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret
  ad:	8d 76 00             	lea    0x0(%esi),%esi
            while (*str >= '0' && *str <= '9') {
  b0:	0f b6 11             	movzbl (%ecx),%edx
  b3:	31 f6                	xor    %esi,%esi
  b5:	8d 7a d0             	lea    -0x30(%edx),%edi
  b8:	89 f8                	mov    %edi,%eax
  ba:	3c 09                	cmp    $0x9,%al
  bc:	77 1d                	ja     db <calculate+0x8b>
  be:	66 90                	xchg   %ax,%ax
                num = num * 10 + (*str - '0');
  c0:	83 ea 30             	sub    $0x30,%edx
  c3:	8d 34 b6             	lea    (%esi,%esi,4),%esi
                str++;
  c6:	83 c1 01             	add    $0x1,%ecx
                num = num * 10 + (*str - '0');
  c9:	0f be d2             	movsbl %dl,%edx
  cc:	8d 34 72             	lea    (%edx,%esi,2),%esi
            while (*str >= '0' && *str <= '9') {
  cf:	0f b6 11             	movzbl (%ecx),%edx
  d2:	8d 7a d0             	lea    -0x30(%edx),%edi
  d5:	89 f8                	mov    %edi,%eax
  d7:	3c 09                	cmp    $0x9,%al
  d9:	76 e5                	jbe    c0 <calculate+0x70>
            if (op == '+') result += num;
  db:	80 fb 2b             	cmp    $0x2b,%bl
  de:	74 68                	je     148 <calculate+0xf8>
            else if (op == '-') result -= num;
  e0:	80 fb 2d             	cmp    $0x2d,%bl
  e3:	74 6b                	je     150 <calculate+0x100>
            else if (op == '*') result *= num;
  e5:	80 fb 2a             	cmp    $0x2a,%bl
  e8:	74 36                	je     120 <calculate+0xd0>
            else if (op == '/') {
  ea:	80 fb 2f             	cmp    $0x2f,%bl
  ed:	75 16                	jne    105 <calculate+0xb5>
                if (num == 0) {
  ef:	85 f6                	test   %esi,%esi
  f1:	74 38                	je     12b <calculate+0xdb>
                result /= num;
  f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f6:	99                   	cltd
  f7:	f7 fe                	idiv   %esi
  f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fc:	eb 07                	jmp    105 <calculate+0xb5>
  fe:	66 90                	xchg   %ax,%ax
            str++;
 100:	83 c1 01             	add    $0x1,%ecx
            op = *str;
 103:	89 d3                	mov    %edx,%ebx
    while (*str) {
 105:	0f be 11             	movsbl (%ecx),%edx
 108:	84 d2                	test   %dl,%dl
 10a:	0f 85 5f ff ff ff    	jne    6f <calculate+0x1f>
 110:	eb 90                	jmp    a2 <calculate+0x52>
 112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            str++;
 118:	83 c1 01             	add    $0x1,%ecx
            continue;
 11b:	eb e8                	jmp    105 <calculate+0xb5>
 11d:	8d 76 00             	lea    0x0(%esi),%esi
            else if (op == '*') result *= num;
 120:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 123:	0f af c6             	imul   %esi,%eax
 126:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 129:	eb da                	jmp    105 <calculate+0xb5>
                    printf(2, "Error: Division by zero!\n");
 12b:	83 ec 08             	sub    $0x8,%esp
 12e:	68 08 08 00 00       	push   $0x808
 133:	6a 02                	push   $0x2
 135:	e8 c6 03 00 00       	call   500 <printf>
                    return 0;
 13a:	83 c4 10             	add    $0x10,%esp
 13d:	e9 59 ff ff ff       	jmp    9b <calculate+0x4b>
 142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if (op == '+') result += num;
 148:	01 75 e4             	add    %esi,-0x1c(%ebp)
 14b:	eb b8                	jmp    105 <calculate+0xb5>
 14d:	8d 76 00             	lea    0x0(%esi),%esi
            else if (op == '-') result -= num;
 150:	29 75 e4             	sub    %esi,-0x1c(%ebp)
 153:	eb b0                	jmp    105 <calculate+0xb5>
 155:	66 90                	xchg   %ax,%ax
 157:	66 90                	xchg   %ax,%ax
 159:	66 90                	xchg   %ax,%ax
 15b:	66 90                	xchg   %ax,%ax
 15d:	66 90                	xchg   %ax,%ax
 15f:	90                   	nop

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 161:	31 c0                	xor    %eax,%eax
{
 163:	89 e5                	mov    %esp,%ebp
 165:	53                   	push   %ebx
 166:	8b 4d 08             	mov    0x8(%ebp),%ecx
 169:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 181:	89 c8                	mov    %ecx,%eax
 183:	c9                   	leave
 184:	c3                   	ret
 185:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18c:	00 
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 55 08             	mov    0x8(%ebp),%edx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 17                	jne    1b8 <strcmp+0x28>
 1a1:	eb 3a                	jmp    1dd <strcmp+0x4d>
 1a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1ac:	83 c2 01             	add    $0x1,%edx
 1af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1b2:	84 c0                	test   %al,%al
 1b4:	74 1a                	je     1d0 <strcmp+0x40>
 1b6:	89 d9                	mov    %ebx,%ecx
 1b8:	0f b6 19             	movzbl (%ecx),%ebx
 1bb:	38 c3                	cmp    %al,%bl
 1bd:	74 e9                	je     1a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1bf:	29 d8                	sub    %ebx,%eax
}
 1c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c4:	c9                   	leave
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1d4:	31 c0                	xor    %eax,%eax
 1d6:	29 d8                	sub    %ebx,%eax
}
 1d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1db:	c9                   	leave
 1dc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1dd:	0f b6 19             	movzbl (%ecx),%ebx
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	eb db                	jmp    1bf <strcmp+0x2f>
 1e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1eb:	00 
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 3a 00             	cmpb   $0x0,(%edx)
 1f9:	74 15                	je     210 <strlen+0x20>
 1fb:	31 c0                	xor    %eax,%eax
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c0 01             	add    $0x1,%eax
 203:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 207:	89 c1                	mov    %eax,%ecx
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	89 c8                	mov    %ecx,%eax
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret
 20f:	90                   	nop
  for(n = 0; s[n]; n++)
 210:	31 c9                	xor    %ecx,%ecx
}
 212:	5d                   	pop    %ebp
 213:	89 c8                	mov    %ecx,%eax
 215:	c3                   	ret
 216:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21d:	00 
 21e:	66 90                	xchg   %ax,%ax

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 227:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	8b 7d fc             	mov    -0x4(%ebp),%edi
 235:	89 d0                	mov    %edx,%eax
 237:	c9                   	leave
 238:	c3                   	ret
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	75 12                	jne    263 <strchr+0x23>
 251:	eb 1d                	jmp    270 <strchr+0x30>
 253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 258:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 25c:	83 c0 01             	add    $0x1,%eax
 25f:	84 d2                	test   %dl,%dl
 261:	74 0d                	je     270 <strchr+0x30>
    if(*s == c)
 263:	38 d1                	cmp    %dl,%cl
 265:	75 f1                	jne    258 <strchr+0x18>
      return (char*)s;
  return 0;
}
 267:	5d                   	pop    %ebp
 268:	c3                   	ret
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 270:	31 c0                	xor    %eax,%eax
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret
 274:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27b:	00 
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 285:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 288:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 289:	31 db                	xor    %ebx,%ebx
{
 28b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 28e:	eb 27                	jmp    2b7 <gets+0x37>
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	6a 01                	push   $0x1
 295:	56                   	push   %esi
 296:	6a 00                	push   $0x0
 298:	e8 1e 01 00 00       	call   3bb <read>
    if(cc < 1)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7e 1d                	jle    2c1 <gets+0x41>
      break;
    buf[i++] = c;
 2a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2af:	3c 0a                	cmp    $0xa,%al
 2b1:	74 10                	je     2c3 <gets+0x43>
 2b3:	3c 0d                	cmp    $0xd,%al
 2b5:	74 0c                	je     2c3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2b7:	89 df                	mov    %ebx,%edi
 2b9:	83 c3 01             	add    $0x1,%ebx
 2bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bf:	7c cf                	jl     290 <gets+0x10>
 2c1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cd:	5b                   	pop    %ebx
 2ce:	5e                   	pop    %esi
 2cf:	5f                   	pop    %edi
 2d0:	5d                   	pop    %ebp
 2d1:	c3                   	ret
 2d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d9:	00 
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e5:	83 ec 08             	sub    $0x8,%esp
 2e8:	6a 00                	push   $0x0
 2ea:	ff 75 08             	push   0x8(%ebp)
 2ed:	e8 f1 00 00 00       	call   3e3 <open>
  if(fd < 0)
 2f2:	83 c4 10             	add    $0x10,%esp
 2f5:	85 c0                	test   %eax,%eax
 2f7:	78 27                	js     320 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2f9:	83 ec 08             	sub    $0x8,%esp
 2fc:	ff 75 0c             	push   0xc(%ebp)
 2ff:	89 c3                	mov    %eax,%ebx
 301:	50                   	push   %eax
 302:	e8 f4 00 00 00       	call   3fb <fstat>
  close(fd);
 307:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 30a:	89 c6                	mov    %eax,%esi
  close(fd);
 30c:	e8 ba 00 00 00       	call   3cb <close>
  return r;
 311:	83 c4 10             	add    $0x10,%esp
}
 314:	8d 65 f8             	lea    -0x8(%ebp),%esp
 317:	89 f0                	mov    %esi,%eax
 319:	5b                   	pop    %ebx
 31a:	5e                   	pop    %esi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret
 31d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 320:	be ff ff ff ff       	mov    $0xffffffff,%esi
 325:	eb ed                	jmp    314 <stat+0x34>
 327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32e:	00 
 32f:	90                   	nop

00000330 <atoi>:

int
atoi(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 337:	0f be 02             	movsbl (%edx),%eax
 33a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 33d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 340:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 345:	77 1e                	ja     365 <atoi+0x35>
 347:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34e:	00 
 34f:	90                   	nop
    n = n*10 + *s++ - '0';
 350:	83 c2 01             	add    $0x1,%edx
 353:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 356:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 35a:	0f be 02             	movsbl (%edx),%eax
 35d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 360:	80 fb 09             	cmp    $0x9,%bl
 363:	76 eb                	jbe    350 <atoi+0x20>
  return n;
}
 365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 368:	89 c8                	mov    %ecx,%eax
 36a:	c9                   	leave
 36b:	c3                   	ret
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	8b 45 10             	mov    0x10(%ebp),%eax
 377:	8b 55 08             	mov    0x8(%ebp),%edx
 37a:	56                   	push   %esi
 37b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	85 c0                	test   %eax,%eax
 380:	7e 13                	jle    395 <memmove+0x25>
 382:	01 d0                	add    %edx,%eax
  dst = vdst;
 384:	89 d7                	mov    %edx,%edi
 386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38d:	00 
 38e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 390:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 391:	39 f8                	cmp    %edi,%eax
 393:	75 fb                	jne    390 <memmove+0x20>
  return vdst;
}
 395:	5e                   	pop    %esi
 396:	89 d0                	mov    %edx,%eax
 398:	5f                   	pop    %edi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret

0000039b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39b:	b8 01 00 00 00       	mov    $0x1,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <exit>:
SYSCALL(exit)
 3a3:	b8 02 00 00 00       	mov    $0x2,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <wait>:
SYSCALL(wait)
 3ab:	b8 03 00 00 00       	mov    $0x3,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <pipe>:
SYSCALL(pipe)
 3b3:	b8 04 00 00 00       	mov    $0x4,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <read>:
SYSCALL(read)
 3bb:	b8 05 00 00 00       	mov    $0x5,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <write>:
SYSCALL(write)
 3c3:	b8 10 00 00 00       	mov    $0x10,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <close>:
SYSCALL(close)
 3cb:	b8 15 00 00 00       	mov    $0x15,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <kill>:
SYSCALL(kill)
 3d3:	b8 06 00 00 00       	mov    $0x6,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <exec>:
SYSCALL(exec)
 3db:	b8 07 00 00 00       	mov    $0x7,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <open>:
SYSCALL(open)
 3e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <mknod>:
SYSCALL(mknod)
 3eb:	b8 11 00 00 00       	mov    $0x11,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <unlink>:
SYSCALL(unlink)
 3f3:	b8 12 00 00 00       	mov    $0x12,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <fstat>:
SYSCALL(fstat)
 3fb:	b8 08 00 00 00       	mov    $0x8,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <link>:
SYSCALL(link)
 403:	b8 13 00 00 00       	mov    $0x13,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <mkdir>:
SYSCALL(mkdir)
 40b:	b8 14 00 00 00       	mov    $0x14,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <chdir>:
SYSCALL(chdir)
 413:	b8 09 00 00 00       	mov    $0x9,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <dup>:
SYSCALL(dup)
 41b:	b8 0a 00 00 00       	mov    $0xa,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <getpid>:
SYSCALL(getpid)
 423:	b8 0b 00 00 00       	mov    $0xb,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <sbrk>:
SYSCALL(sbrk)
 42b:	b8 0c 00 00 00       	mov    $0xc,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <sleep>:
SYSCALL(sleep)
 433:	b8 0d 00 00 00       	mov    $0xd,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <uptime>:
SYSCALL(uptime)
 43b:	b8 0e 00 00 00       	mov    $0xe,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <getproccount>:
SYSCALL(getproccount)
 443:	b8 16 00 00 00       	mov    $0x16,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <reboot>:
SYSCALL(reboot)
 44b:	b8 17 00 00 00       	mov    $0x17,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret
 453:	66 90                	xchg   %ax,%ax
 455:	66 90                	xchg   %ax,%ax
 457:	66 90                	xchg   %ax,%ax
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 468:	89 d1                	mov    %edx,%ecx
{
 46a:	83 ec 3c             	sub    $0x3c,%esp
 46d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 470:	85 d2                	test   %edx,%edx
 472:	0f 89 80 00 00 00    	jns    4f8 <printint+0x98>
 478:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47c:	74 7a                	je     4f8 <printint+0x98>
    x = -xx;
 47e:	f7 d9                	neg    %ecx
    neg = 1;
 480:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 485:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 488:	31 f6                	xor    %esi,%esi
 48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 490:	89 c8                	mov    %ecx,%eax
 492:	31 d2                	xor    %edx,%edx
 494:	89 f7                	mov    %esi,%edi
 496:	f7 f3                	div    %ebx
 498:	8d 76 01             	lea    0x1(%esi),%esi
 49b:	0f b6 92 b8 09 00 00 	movzbl 0x9b8(%edx),%edx
 4a2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4a6:	89 ca                	mov    %ecx,%edx
 4a8:	89 c1                	mov    %eax,%ecx
 4aa:	39 da                	cmp    %ebx,%edx
 4ac:	73 e2                	jae    490 <printint+0x30>
  if(neg)
 4ae:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4b1:	85 c0                	test   %eax,%eax
 4b3:	74 07                	je     4bc <printint+0x5c>
    buf[i++] = '-';
 4b5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 4ba:	89 f7                	mov    %esi,%edi
 4bc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4bf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4c2:	01 df                	add    %ebx,%edi
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4c8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4cb:	83 ec 04             	sub    $0x4,%esp
 4ce:	88 45 d7             	mov    %al,-0x29(%ebp)
 4d1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4d4:	6a 01                	push   $0x1
 4d6:	50                   	push   %eax
 4d7:	56                   	push   %esi
 4d8:	e8 e6 fe ff ff       	call   3c3 <write>
  while(--i >= 0)
 4dd:	89 f8                	mov    %edi,%eax
 4df:	83 c4 10             	add    $0x10,%esp
 4e2:	83 ef 01             	sub    $0x1,%edi
 4e5:	39 c3                	cmp    %eax,%ebx
 4e7:	75 df                	jne    4c8 <printint+0x68>
}
 4e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ec:	5b                   	pop    %ebx
 4ed:	5e                   	pop    %esi
 4ee:	5f                   	pop    %edi
 4ef:	5d                   	pop    %ebp
 4f0:	c3                   	ret
 4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4f8:	31 c0                	xor    %eax,%eax
 4fa:	eb 89                	jmp    485 <printint+0x25>
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000500 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 509:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 50c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 50f:	0f b6 1e             	movzbl (%esi),%ebx
 512:	83 c6 01             	add    $0x1,%esi
 515:	84 db                	test   %bl,%bl
 517:	74 67                	je     580 <printf+0x80>
 519:	8d 4d 10             	lea    0x10(%ebp),%ecx
 51c:	31 d2                	xor    %edx,%edx
 51e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 521:	eb 34                	jmp    557 <printf+0x57>
 523:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 528:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 52b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 530:	83 f8 25             	cmp    $0x25,%eax
 533:	74 18                	je     54d <printf+0x4d>
  write(fd, &c, 1);
 535:	83 ec 04             	sub    $0x4,%esp
 538:	8d 45 e7             	lea    -0x19(%ebp),%eax
 53b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 53e:	6a 01                	push   $0x1
 540:	50                   	push   %eax
 541:	57                   	push   %edi
 542:	e8 7c fe ff ff       	call   3c3 <write>
 547:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 54a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 54d:	0f b6 1e             	movzbl (%esi),%ebx
 550:	83 c6 01             	add    $0x1,%esi
 553:	84 db                	test   %bl,%bl
 555:	74 29                	je     580 <printf+0x80>
    c = fmt[i] & 0xff;
 557:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 55a:	85 d2                	test   %edx,%edx
 55c:	74 ca                	je     528 <printf+0x28>
      }
    } else if(state == '%'){
 55e:	83 fa 25             	cmp    $0x25,%edx
 561:	75 ea                	jne    54d <printf+0x4d>
      if(c == 'd'){
 563:	83 f8 25             	cmp    $0x25,%eax
 566:	0f 84 04 01 00 00    	je     670 <printf+0x170>
 56c:	83 e8 63             	sub    $0x63,%eax
 56f:	83 f8 15             	cmp    $0x15,%eax
 572:	77 1c                	ja     590 <printf+0x90>
 574:	ff 24 85 60 09 00 00 	jmp    *0x960(,%eax,4)
 57b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 580:	8d 65 f4             	lea    -0xc(%ebp),%esp
 583:	5b                   	pop    %ebx
 584:	5e                   	pop    %esi
 585:	5f                   	pop    %edi
 586:	5d                   	pop    %ebp
 587:	c3                   	ret
 588:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58f:	00 
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	8d 55 e7             	lea    -0x19(%ebp),%edx
 596:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 59a:	6a 01                	push   $0x1
 59c:	52                   	push   %edx
 59d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5a0:	57                   	push   %edi
 5a1:	e8 1d fe ff ff       	call   3c3 <write>
 5a6:	83 c4 0c             	add    $0xc,%esp
 5a9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5ac:	6a 01                	push   $0x1
 5ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5b1:	52                   	push   %edx
 5b2:	57                   	push   %edi
 5b3:	e8 0b fe ff ff       	call   3c3 <write>
        putc(fd, c);
 5b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bb:	31 d2                	xor    %edx,%edx
 5bd:	eb 8e                	jmp    54d <printf+0x4d>
 5bf:	90                   	nop
        printint(fd, *ap, 16, 0);
 5c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5c3:	83 ec 0c             	sub    $0xc,%esp
 5c6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5cb:	8b 13                	mov    (%ebx),%edx
 5cd:	6a 00                	push   $0x0
 5cf:	89 f8                	mov    %edi,%eax
        ap++;
 5d1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5d4:	e8 87 fe ff ff       	call   460 <printint>
        ap++;
 5d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5df:	31 d2                	xor    %edx,%edx
 5e1:	e9 67 ff ff ff       	jmp    54d <printf+0x4d>
        s = (char*)*ap;
 5e6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5e9:	8b 18                	mov    (%eax),%ebx
        ap++;
 5eb:	83 c0 04             	add    $0x4,%eax
 5ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5f1:	85 db                	test   %ebx,%ebx
 5f3:	0f 84 87 00 00 00    	je     680 <printf+0x180>
        while(*s != 0){
 5f9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5fc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5fe:	84 c0                	test   %al,%al
 600:	0f 84 47 ff ff ff    	je     54d <printf+0x4d>
 606:	8d 55 e7             	lea    -0x19(%ebp),%edx
 609:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 60c:	89 de                	mov    %ebx,%esi
 60e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 616:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 619:	6a 01                	push   $0x1
 61b:	53                   	push   %ebx
 61c:	57                   	push   %edi
 61d:	e8 a1 fd ff ff       	call   3c3 <write>
        while(*s != 0){
 622:	0f b6 06             	movzbl (%esi),%eax
 625:	83 c4 10             	add    $0x10,%esp
 628:	84 c0                	test   %al,%al
 62a:	75 e4                	jne    610 <printf+0x110>
      state = 0;
 62c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 17 ff ff ff       	jmp    54d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 636:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 639:	83 ec 0c             	sub    $0xc,%esp
 63c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 641:	8b 13                	mov    (%ebx),%edx
 643:	6a 01                	push   $0x1
 645:	eb 88                	jmp    5cf <printf+0xcf>
        putc(fd, *ap);
 647:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 64a:	83 ec 04             	sub    $0x4,%esp
 64d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 650:	8b 03                	mov    (%ebx),%eax
        ap++;
 652:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 655:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 658:	6a 01                	push   $0x1
 65a:	52                   	push   %edx
 65b:	57                   	push   %edi
 65c:	e8 62 fd ff ff       	call   3c3 <write>
        ap++;
 661:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 664:	83 c4 10             	add    $0x10,%esp
      state = 0;
 667:	31 d2                	xor    %edx,%edx
 669:	e9 df fe ff ff       	jmp    54d <printf+0x4d>
 66e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 5d e7             	mov    %bl,-0x19(%ebp)
 676:	8d 55 e7             	lea    -0x19(%ebp),%edx
 679:	6a 01                	push   $0x1
 67b:	e9 31 ff ff ff       	jmp    5b1 <printf+0xb1>
 680:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 685:	bb 43 08 00 00       	mov    $0x843,%ebx
 68a:	e9 77 ff ff ff       	jmp    606 <printf+0x106>
 68f:	90                   	nop

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 84 0c 00 00       	mov    0xc84,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6aa:	39 c8                	cmp    %ecx,%eax
 6ac:	73 32                	jae    6e0 <free+0x50>
 6ae:	39 d1                	cmp    %edx,%ecx
 6b0:	72 04                	jb     6b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b2:	39 d0                	cmp    %edx,%eax
 6b4:	72 32                	jb     6e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6bc:	39 fa                	cmp    %edi,%edx
 6be:	74 30                	je     6f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c3:	8b 50 04             	mov    0x4(%eax),%edx
 6c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c9:	39 f1                	cmp    %esi,%ecx
 6cb:	74 3a                	je     707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6cd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6cf:	5b                   	pop    %ebx
  freep = p;
 6d0:	a3 84 0c 00 00       	mov    %eax,0xc84
}
 6d5:	5e                   	pop    %esi
 6d6:	5f                   	pop    %edi
 6d7:	5d                   	pop    %ebp
 6d8:	c3                   	ret
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	39 d0                	cmp    %edx,%eax
 6e2:	72 04                	jb     6e8 <free+0x58>
 6e4:	39 d1                	cmp    %edx,%ecx
 6e6:	72 ce                	jb     6b6 <free+0x26>
{
 6e8:	89 d0                	mov    %edx,%eax
 6ea:	eb bc                	jmp    6a8 <free+0x18>
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 72 04             	add    0x4(%edx),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 c6                	jne    6cd <free+0x3d>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 70a:	a3 84 0c 00 00       	mov    %eax,0xc84
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 715:	89 08                	mov    %ecx,(%eax)
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	5d                   	pop    %ebp
 71b:	c3                   	ret
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 84 0c 00 00    	mov    0xc84,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 8d 00 00 00    	je     7d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 745:	8b 48 04             	mov    0x4(%eax),%ecx
 748:	39 f9                	cmp    %edi,%ecx
 74a:	73 64                	jae    7b0 <malloc+0x90>
  if(nu < 4096)
 74c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 751:	39 df                	cmp    %ebx,%edi
 753:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 756:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75d:	eb 0a                	jmp    769 <malloc+0x49>
 75f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 762:	8b 48 04             	mov    0x4(%eax),%ecx
 765:	39 f9                	cmp    %edi,%ecx
 767:	73 47                	jae    7b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 769:	89 c2                	mov    %eax,%edx
 76b:	3b 05 84 0c 00 00    	cmp    0xc84,%eax
 771:	75 ed                	jne    760 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 773:	83 ec 0c             	sub    $0xc,%esp
 776:	56                   	push   %esi
 777:	e8 af fc ff ff       	call   42b <sbrk>
  if(p == (char*)-1)
 77c:	83 c4 10             	add    $0x10,%esp
 77f:	83 f8 ff             	cmp    $0xffffffff,%eax
 782:	74 1c                	je     7a0 <malloc+0x80>
  hp->s.size = nu;
 784:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	83 c0 08             	add    $0x8,%eax
 78d:	50                   	push   %eax
 78e:	e8 fd fe ff ff       	call   690 <free>
  return freep;
 793:	8b 15 84 0c 00 00    	mov    0xc84,%edx
      if((p = morecore(nunits)) == 0)
 799:	83 c4 10             	add    $0x10,%esp
 79c:	85 d2                	test   %edx,%edx
 79e:	75 c0                	jne    760 <malloc+0x40>
        return 0;
  }
}
 7a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7a3:	31 c0                	xor    %eax,%eax
}
 7a5:	5b                   	pop    %ebx
 7a6:	5e                   	pop    %esi
 7a7:	5f                   	pop    %edi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 4c                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7bf:	89 15 84 0c 00 00    	mov    %edx,0xc84
}
 7c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
}
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 84 0c 00 00 88 	movl   $0xc88,0xc84
 7d7:	0c 00 00 
    base.s.size = 0;
 7da:	b8 88 0c 00 00       	mov    $0xc88,%eax
    base.s.ptr = freep = prevp = &base;
 7df:	c7 05 88 0c 00 00 88 	movl   $0xc88,0xc88
 7e6:	0c 00 00 
    base.s.size = 0;
 7e9:	c7 05 8c 0c 00 00 00 	movl   $0x0,0xc8c
 7f0:	00 00 00 
    if(p->s.size >= nunits){
 7f3:	e9 54 ff ff ff       	jmp    74c <malloc+0x2c>
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b9                	jmp    7bf <malloc+0x9f>
