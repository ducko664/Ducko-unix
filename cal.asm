
_cal:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    if (year % 100 == 0) return 0;
    if (year % 4 == 0) return 1;
    return 0;
}

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 68             	sub    $0x68,%esp
    if(argc < 3) {
  14:	83 39 02             	cmpl   $0x2,(%ecx)
int main(int argc, char *argv[]) {
  17:	8b 59 04             	mov    0x4(%ecx),%ebx
    if(argc < 3) {
  1a:	7f 13                	jg     2f <main+0x2f>
        printf(1, "Usage: cal <month 1-12> <year e.g. 2026>\n");
  1c:	50                   	push   %eax
  1d:	50                   	push   %eax
  1e:	68 a0 09 00 00       	push   $0x9a0
  23:	6a 01                	push   $0x1
  25:	e8 66 06 00 00       	call   690 <printf>
        exit();
  2a:	e8 04 05 00 00       	call   533 <exit>
    }

    int month = atoi(argv[1]);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	ff 73 04             	push   0x4(%ebx)
  35:	e8 86 04 00 00       	call   4c0 <atoi>
  3a:	89 c6                	mov    %eax,%esi
    int year = atoi(argv[2]);
  3c:	58                   	pop    %eax
  3d:	ff 73 08             	push   0x8(%ebx)

    if(month < 1 || month > 12 || year < 1) {
  40:	8d 7e ff             	lea    -0x1(%esi),%edi
    int year = atoi(argv[2]);
  43:	e8 78 04 00 00       	call   4c0 <atoi>
    if(month < 1 || month > 12 || year < 1) {
  48:	83 c4 10             	add    $0x10,%esp
    int year = atoi(argv[2]);
  4b:	89 c3                	mov    %eax,%ebx
    if(month < 1 || month > 12 || year < 1) {
  4d:	83 ff 0b             	cmp    $0xb,%edi
  50:	0f 87 63 01 00 00    	ja     1b9 <main+0x1b9>
  56:	85 c0                	test   %eax,%eax
  58:	0f 8e 5b 01 00 00    	jle    1b9 <main+0x1b9>
        printf(1, "Invalid month or year!\n");
        exit();
    }

    int days_in_month[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
  5e:	c7 45 88 1f 00 00 00 	movl   $0x1f,-0x78(%ebp)
  65:	c7 45 8c 1c 00 00 00 	movl   $0x1c,-0x74(%ebp)
  6c:	c7 45 90 1f 00 00 00 	movl   $0x1f,-0x70(%ebp)
  73:	c7 45 94 1e 00 00 00 	movl   $0x1e,-0x6c(%ebp)
  7a:	c7 45 98 1f 00 00 00 	movl   $0x1f,-0x68(%ebp)
  81:	c7 45 9c 1e 00 00 00 	movl   $0x1e,-0x64(%ebp)
  88:	c7 45 a0 1f 00 00 00 	movl   $0x1f,-0x60(%ebp)
  8f:	c7 45 a4 1f 00 00 00 	movl   $0x1f,-0x5c(%ebp)
  96:	c7 45 a8 1e 00 00 00 	movl   $0x1e,-0x58(%ebp)
  9d:	c7 45 ac 1f 00 00 00 	movl   $0x1f,-0x54(%ebp)
  a4:	c7 45 b0 1e 00 00 00 	movl   $0x1e,-0x50(%ebp)
  ab:	c7 45 b4 1f 00 00 00 	movl   $0x1f,-0x4c(%ebp)
    char *months[] = { "January", "February", "March", "April", "May", "June", 
  b2:	c7 45 b8 e2 09 00 00 	movl   $0x9e2,-0x48(%ebp)
  b9:	c7 45 bc ea 09 00 00 	movl   $0x9ea,-0x44(%ebp)
  c0:	c7 45 c0 f3 09 00 00 	movl   $0x9f3,-0x40(%ebp)
  c7:	c7 45 c4 f9 09 00 00 	movl   $0x9f9,-0x3c(%ebp)
  ce:	c7 45 c8 ff 09 00 00 	movl   $0x9ff,-0x38(%ebp)
  d5:	c7 45 cc 03 0a 00 00 	movl   $0xa03,-0x34(%ebp)
  dc:	c7 45 d0 08 0a 00 00 	movl   $0xa08,-0x30(%ebp)
  e3:	c7 45 d4 0d 0a 00 00 	movl   $0xa0d,-0x2c(%ebp)
  ea:	c7 45 d8 14 0a 00 00 	movl   $0xa14,-0x28(%ebp)
  f1:	c7 45 dc 1e 0a 00 00 	movl   $0xa1e,-0x24(%ebp)
  f8:	c7 45 e0 26 0a 00 00 	movl   $0xa26,-0x20(%ebp)
  ff:	c7 45 e4 2f 0a 00 00 	movl   $0xa2f,-0x1c(%ebp)
                       "July", "August", "September", "October", "November", "December" };

    if (month == 2 && is_leap_year(year)) {
 106:	83 fe 02             	cmp    $0x2,%esi
 109:	0f 84 e3 00 00 00    	je     1f2 <main+0x1f2>
        days_in_month[1] = 29;
    }

    printf(1, "    %s %d\n", months[month-1], year);
 10f:	53                   	push   %ebx
 110:	ff 74 bd b8          	push   -0x48(%ebp,%edi,4)
 114:	68 38 0a 00 00       	push   $0xa38
 119:	6a 01                	push   $0x1
 11b:	e8 70 05 00 00       	call   690 <printf>
    printf(1, " Su Mo Tu We Th Fr Sa\n");
 120:	59                   	pop    %ecx
 121:	58                   	pop    %eax
 122:	68 43 0a 00 00       	push   $0xa43
 127:	6a 01                	push   $0x1
 129:	e8 62 05 00 00       	call   690 <printf>

    // Find starting day of the month
    int start_day = dayofweek(1, month, year);
 12e:	83 c4 0c             	add    $0xc,%esp
 131:	53                   	push   %ebx
 132:	56                   	push   %esi
 133:	6a 01                	push   $0x1
 135:	e8 f6 00 00 00       	call   230 <dayofweek>
 13a:	83 c4 10             	add    $0x10,%esp
 13d:	89 c6                	mov    %eax,%esi

    // Print initial spaces
    int i;
    for(i = 0; i < start_day; i++) {
 13f:	85 c0                	test   %eax,%eax
 141:	7e 1e                	jle    161 <main+0x161>
 143:	31 db                	xor    %ebx,%ebx
 145:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "   ");
 148:	83 ec 08             	sub    $0x8,%esp
    for(i = 0; i < start_day; i++) {
 14b:	83 c3 01             	add    $0x1,%ebx
        printf(1, "   ");
 14e:	68 5a 0a 00 00       	push   $0xa5a
 153:	6a 01                	push   $0x1
 155:	e8 36 05 00 00       	call   690 <printf>
    for(i = 0; i < start_day; i++) {
 15a:	83 c4 10             	add    $0x10,%esp
 15d:	39 de                	cmp    %ebx,%esi
 15f:	75 e7                	jne    148 <main+0x148>
    }

    // Print all the days
    int day;
    for(day = 1; day <= days_in_month[month-1]; day++) {
 161:	8b 7c bd 88          	mov    -0x78(%ebp,%edi,4),%edi
 165:	85 ff                	test   %edi,%edi
 167:	7e 76                	jle    1df <main+0x1df>
 169:	bb 01 00 00 00       	mov    $0x1,%ebx
 16e:	eb 2f                	jmp    19f <main+0x19f>
        if(day < 10) printf(1, "  %d", day);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	53                   	push   %ebx
 174:	68 5e 0a 00 00       	push   $0xa5e
 179:	6a 01                	push   $0x1
 17b:	e8 10 05 00 00       	call   690 <printf>
 180:	83 c4 10             	add    $0x10,%esp
        else printf(1, " %d", day);

        if((day + start_day) % 7 == 0) {
 183:	8d 04 33             	lea    (%ebx,%esi,1),%eax
        else printf(1, " %d", day);
 186:	69 c0 b7 6d db b6    	imul   $0xb6db6db7,%eax,%eax
 18c:	05 92 24 49 12       	add    $0x12492492,%eax
        if((day + start_day) % 7 == 0) {
 191:	3d 24 49 92 24       	cmp    $0x24924924,%eax
 196:	76 34                	jbe    1cc <main+0x1cc>
    for(day = 1; day <= days_in_month[month-1]; day++) {
 198:	83 c3 01             	add    $0x1,%ebx
 19b:	39 fb                	cmp    %edi,%ebx
 19d:	7f 40                	jg     1df <main+0x1df>
        if(day < 10) printf(1, "  %d", day);
 19f:	83 fb 09             	cmp    $0x9,%ebx
 1a2:	7e cc                	jle    170 <main+0x170>
        else printf(1, " %d", day);
 1a4:	83 ec 04             	sub    $0x4,%esp
 1a7:	53                   	push   %ebx
 1a8:	68 5f 0a 00 00       	push   $0xa5f
 1ad:	6a 01                	push   $0x1
 1af:	e8 dc 04 00 00       	call   690 <printf>
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	eb ca                	jmp    183 <main+0x183>
        printf(1, "Invalid month or year!\n");
 1b9:	50                   	push   %eax
 1ba:	50                   	push   %eax
 1bb:	68 ca 09 00 00       	push   $0x9ca
 1c0:	6a 01                	push   $0x1
 1c2:	e8 c9 04 00 00       	call   690 <printf>
        exit();
 1c7:	e8 67 03 00 00       	call   533 <exit>
            printf(1, "\n");
 1cc:	52                   	push   %edx
 1cd:	52                   	push   %edx
 1ce:	68 64 0a 00 00       	push   $0xa64
 1d3:	6a 01                	push   $0x1
 1d5:	e8 b6 04 00 00       	call   690 <printf>
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	eb b9                	jmp    198 <main+0x198>
        }
    }
    printf(1, "\n\n");
 1df:	50                   	push   %eax
 1e0:	50                   	push   %eax
 1e1:	68 63 0a 00 00       	push   $0xa63
 1e6:	6a 01                	push   $0x1
 1e8:	e8 a3 04 00 00       	call   690 <printf>
    exit();
 1ed:	e8 41 03 00 00       	call   533 <exit>
    if (year % 400 == 0) return 1;
 1f2:	b9 90 01 00 00       	mov    $0x190,%ecx
 1f7:	99                   	cltd
 1f8:	f7 f9                	idiv   %ecx
 1fa:	85 d2                	test   %edx,%edx
 1fc:	74 1b                	je     219 <main+0x219>
    if (year % 100 == 0) return 0;
 1fe:	89 d8                	mov    %ebx,%eax
 200:	b9 64 00 00 00       	mov    $0x64,%ecx
 205:	99                   	cltd
 206:	f7 f9                	idiv   %ecx
 208:	85 d2                	test   %edx,%edx
 20a:	0f 84 ff fe ff ff    	je     10f <main+0x10f>
    if (year % 4 == 0) return 1;
 210:	f6 c3 03             	test   $0x3,%bl
 213:	0f 85 f6 fe ff ff    	jne    10f <main+0x10f>
        days_in_month[1] = 29;
 219:	c7 45 8c 1d 00 00 00 	movl   $0x1d,-0x74(%ebp)
 220:	e9 ea fe ff ff       	jmp    10f <main+0x10f>
 225:	66 90                	xchg   %ax,%ax
 227:	66 90                	xchg   %ax,%ax
 229:	66 90                	xchg   %ax,%ax
 22b:	66 90                	xchg   %ax,%ax
 22d:	66 90                	xchg   %ax,%ax
 22f:	90                   	nop

00000230 <dayofweek>:
int dayofweek(int d, int m, int y) {
 230:	55                   	push   %ebp
    if (m < 3) y -= 1;
 231:	31 c0                	xor    %eax,%eax
int dayofweek(int d, int m, int y) {
 233:	89 e5                	mov    %esp,%ebp
 235:	57                   	push   %edi
 236:	56                   	push   %esi
 237:	8b 75 0c             	mov    0xc(%ebp),%esi
 23a:	53                   	push   %ebx
 23b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    if (m < 3) y -= 1;
 23e:	83 fe 03             	cmp    $0x3,%esi
 241:	0f 9c c0             	setl   %al
 244:	29 c3                	sub    %eax,%ebx
    return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
 246:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
 24b:	8d 4b 03             	lea    0x3(%ebx),%ecx
 24e:	0f 49 cb             	cmovns %ebx,%ecx
 251:	f7 eb                	imul   %ebx
 253:	c1 f9 02             	sar    $0x2,%ecx
 256:	01 d9                	add    %ebx,%ecx
 258:	89 d0                	mov    %edx,%eax
 25a:	c1 fb 1f             	sar    $0x1f,%ebx
 25d:	c1 f8 05             	sar    $0x5,%eax
 260:	89 df                	mov    %ebx,%edi
 262:	c1 fa 07             	sar    $0x7,%edx
 265:	29 c7                	sub    %eax,%edi
 267:	29 da                	sub    %ebx,%edx
 269:	b8 93 24 49 92       	mov    $0x92492493,%eax
}
 26e:	5b                   	pop    %ebx
    return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
 26f:	01 f9                	add    %edi,%ecx
 271:	01 d1                	add    %edx,%ecx
 273:	03 0c b5 7c 0a 00 00 	add    0xa7c(,%esi,4),%ecx
 27a:	03 4d 08             	add    0x8(%ebp),%ecx
 27d:	f7 e9                	imul   %ecx
}
 27f:	5e                   	pop    %esi
 280:	5f                   	pop    %edi
 281:	5d                   	pop    %ebp
    return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
 282:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
 285:	89 ca                	mov    %ecx,%edx
 287:	c1 fa 1f             	sar    $0x1f,%edx
 28a:	c1 f8 02             	sar    $0x2,%eax
 28d:	29 d0                	sub    %edx,%eax
 28f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 296:	29 c2                	sub    %eax,%edx
 298:	89 c8                	mov    %ecx,%eax
 29a:	29 d0                	sub    %edx,%eax
}
 29c:	c3                   	ret
 29d:	8d 76 00             	lea    0x0(%esi),%esi

000002a0 <is_leap_year>:
int is_leap_year(int year) {
 2a0:	55                   	push   %ebp
    if (year % 400 == 0) return 1;
 2a1:	b8 01 00 00 00       	mov    $0x1,%eax
int is_leap_year(int year) {
 2a6:	89 e5                	mov    %esp,%ebp
 2a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if (year % 400 == 0) return 1;
 2ab:	69 d1 29 5c 8f c2    	imul   $0xc28f5c29,%ecx,%edx
 2b1:	81 c2 50 b8 1e 05    	add    $0x51eb850,%edx
 2b7:	c1 ca 04             	ror    $0x4,%edx
 2ba:	81 fa 0a d7 a3 00    	cmp    $0xa3d70a,%edx
 2c0:	76 24                	jbe    2e6 <is_leap_year+0x46>
    if (year % 100 == 0) return 0;
 2c2:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
 2c7:	f7 e9                	imul   %ecx
 2c9:	89 d0                	mov    %edx,%eax
 2cb:	89 ca                	mov    %ecx,%edx
 2cd:	c1 fa 1f             	sar    $0x1f,%edx
 2d0:	c1 f8 05             	sar    $0x5,%eax
 2d3:	29 d0                	sub    %edx,%eax
 2d5:	6b d0 64             	imul   $0x64,%eax,%edx
 2d8:	89 c8                	mov    %ecx,%eax
 2da:	29 d0                	sub    %edx,%eax
 2dc:	74 08                	je     2e6 <is_leap_year+0x46>
    if (year % 4 == 0) return 1;
 2de:	31 c0                	xor    %eax,%eax
 2e0:	83 e1 03             	and    $0x3,%ecx
 2e3:	0f 94 c0             	sete   %al
}
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret
 2e8:	66 90                	xchg   %ax,%ax
 2ea:	66 90                	xchg   %ax,%ax
 2ec:	66 90                	xchg   %ax,%ax
 2ee:	66 90                	xchg   %ax,%ax

000002f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2f1:	31 c0                	xor    %eax,%eax
{
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	53                   	push   %ebx
 2f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 300:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 304:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 307:	83 c0 01             	add    $0x1,%eax
 30a:	84 d2                	test   %dl,%dl
 30c:	75 f2                	jne    300 <strcpy+0x10>
    ;
  return os;
}
 30e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 311:	89 c8                	mov    %ecx,%eax
 313:	c9                   	leave
 314:	c3                   	ret
 315:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31c:	00 
 31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
 327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 32a:	0f b6 02             	movzbl (%edx),%eax
 32d:	84 c0                	test   %al,%al
 32f:	75 17                	jne    348 <strcmp+0x28>
 331:	eb 3a                	jmp    36d <strcmp+0x4d>
 333:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 338:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 33c:	83 c2 01             	add    $0x1,%edx
 33f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 342:	84 c0                	test   %al,%al
 344:	74 1a                	je     360 <strcmp+0x40>
 346:	89 d9                	mov    %ebx,%ecx
 348:	0f b6 19             	movzbl (%ecx),%ebx
 34b:	38 c3                	cmp    %al,%bl
 34d:	74 e9                	je     338 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 34f:	29 d8                	sub    %ebx,%eax
}
 351:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 354:	c9                   	leave
 355:	c3                   	ret
 356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35d:	00 
 35e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 360:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 364:	31 c0                	xor    %eax,%eax
 366:	29 d8                	sub    %ebx,%eax
}
 368:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 36b:	c9                   	leave
 36c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 36d:	0f b6 19             	movzbl (%ecx),%ebx
 370:	31 c0                	xor    %eax,%eax
 372:	eb db                	jmp    34f <strcmp+0x2f>
 374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37b:	00 
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <strlen>:

uint
strlen(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 386:	80 3a 00             	cmpb   $0x0,(%edx)
 389:	74 15                	je     3a0 <strlen+0x20>
 38b:	31 c0                	xor    %eax,%eax
 38d:	8d 76 00             	lea    0x0(%esi),%esi
 390:	83 c0 01             	add    $0x1,%eax
 393:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 397:	89 c1                	mov    %eax,%ecx
 399:	75 f5                	jne    390 <strlen+0x10>
    ;
  return n;
}
 39b:	89 c8                	mov    %ecx,%eax
 39d:	5d                   	pop    %ebp
 39e:	c3                   	ret
 39f:	90                   	nop
  for(n = 0; s[n]; n++)
 3a0:	31 c9                	xor    %ecx,%ecx
}
 3a2:	5d                   	pop    %ebp
 3a3:	89 c8                	mov    %ecx,%eax
 3a5:	c3                   	ret
 3a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ad:	00 
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	89 d7                	mov    %edx,%edi
 3bf:	fc                   	cld
 3c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 3c5:	89 d0                	mov    %edx,%eax
 3c7:	c9                   	leave
 3c8:	c3                   	ret
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <strchr>:

char*
strchr(const char *s, char c)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3da:	0f b6 10             	movzbl (%eax),%edx
 3dd:	84 d2                	test   %dl,%dl
 3df:	75 12                	jne    3f3 <strchr+0x23>
 3e1:	eb 1d                	jmp    400 <strchr+0x30>
 3e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3ec:	83 c0 01             	add    $0x1,%eax
 3ef:	84 d2                	test   %dl,%dl
 3f1:	74 0d                	je     400 <strchr+0x30>
    if(*s == c)
 3f3:	38 d1                	cmp    %dl,%cl
 3f5:	75 f1                	jne    3e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 3f7:	5d                   	pop    %ebp
 3f8:	c3                   	ret
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 400:	31 c0                	xor    %eax,%eax
}
 402:	5d                   	pop    %ebp
 403:	c3                   	ret
 404:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40b:	00 
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <gets>:

char*
gets(char *buf, int max)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 415:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 418:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 419:	31 db                	xor    %ebx,%ebx
{
 41b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 41e:	eb 27                	jmp    447 <gets+0x37>
    cc = read(0, &c, 1);
 420:	83 ec 04             	sub    $0x4,%esp
 423:	6a 01                	push   $0x1
 425:	56                   	push   %esi
 426:	6a 00                	push   $0x0
 428:	e8 1e 01 00 00       	call   54b <read>
    if(cc < 1)
 42d:	83 c4 10             	add    $0x10,%esp
 430:	85 c0                	test   %eax,%eax
 432:	7e 1d                	jle    451 <gets+0x41>
      break;
    buf[i++] = c;
 434:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 438:	8b 55 08             	mov    0x8(%ebp),%edx
 43b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 43f:	3c 0a                	cmp    $0xa,%al
 441:	74 10                	je     453 <gets+0x43>
 443:	3c 0d                	cmp    $0xd,%al
 445:	74 0c                	je     453 <gets+0x43>
  for(i=0; i+1 < max; ){
 447:	89 df                	mov    %ebx,%edi
 449:	83 c3 01             	add    $0x1,%ebx
 44c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 44f:	7c cf                	jl     420 <gets+0x10>
 451:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 45a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45d:	5b                   	pop    %ebx
 45e:	5e                   	pop    %esi
 45f:	5f                   	pop    %edi
 460:	5d                   	pop    %ebp
 461:	c3                   	ret
 462:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 469:	00 
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000470 <stat>:

int
stat(const char *n, struct stat *st)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 475:	83 ec 08             	sub    $0x8,%esp
 478:	6a 00                	push   $0x0
 47a:	ff 75 08             	push   0x8(%ebp)
 47d:	e8 f1 00 00 00       	call   573 <open>
  if(fd < 0)
 482:	83 c4 10             	add    $0x10,%esp
 485:	85 c0                	test   %eax,%eax
 487:	78 27                	js     4b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 489:	83 ec 08             	sub    $0x8,%esp
 48c:	ff 75 0c             	push   0xc(%ebp)
 48f:	89 c3                	mov    %eax,%ebx
 491:	50                   	push   %eax
 492:	e8 f4 00 00 00       	call   58b <fstat>
  close(fd);
 497:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 49a:	89 c6                	mov    %eax,%esi
  close(fd);
 49c:	e8 ba 00 00 00       	call   55b <close>
  return r;
 4a1:	83 c4 10             	add    $0x10,%esp
}
 4a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4a7:	89 f0                	mov    %esi,%eax
 4a9:	5b                   	pop    %ebx
 4aa:	5e                   	pop    %esi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4b5:	eb ed                	jmp    4a4 <stat+0x34>
 4b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4be:	00 
 4bf:	90                   	nop

000004c0 <atoi>:

int
atoi(const char *s)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	53                   	push   %ebx
 4c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c7:	0f be 02             	movsbl (%edx),%eax
 4ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4d5:	77 1e                	ja     4f5 <atoi+0x35>
 4d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4de:	00 
 4df:	90                   	nop
    n = n*10 + *s++ - '0';
 4e0:	83 c2 01             	add    $0x1,%edx
 4e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4ea:	0f be 02             	movsbl (%edx),%eax
 4ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4f0:	80 fb 09             	cmp    $0x9,%bl
 4f3:	76 eb                	jbe    4e0 <atoi+0x20>
  return n;
}
 4f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f8:	89 c8                	mov    %ecx,%eax
 4fa:	c9                   	leave
 4fb:	c3                   	ret
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000500 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	8b 45 10             	mov    0x10(%ebp),%eax
 507:	8b 55 08             	mov    0x8(%ebp),%edx
 50a:	56                   	push   %esi
 50b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 50e:	85 c0                	test   %eax,%eax
 510:	7e 13                	jle    525 <memmove+0x25>
 512:	01 d0                	add    %edx,%eax
  dst = vdst;
 514:	89 d7                	mov    %edx,%edi
 516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51d:	00 
 51e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 520:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 521:	39 f8                	cmp    %edi,%eax
 523:	75 fb                	jne    520 <memmove+0x20>
  return vdst;
}
 525:	5e                   	pop    %esi
 526:	89 d0                	mov    %edx,%eax
 528:	5f                   	pop    %edi
 529:	5d                   	pop    %ebp
 52a:	c3                   	ret

0000052b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 52b:	b8 01 00 00 00       	mov    $0x1,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret

00000533 <exit>:
SYSCALL(exit)
 533:	b8 02 00 00 00       	mov    $0x2,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret

0000053b <wait>:
SYSCALL(wait)
 53b:	b8 03 00 00 00       	mov    $0x3,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret

00000543 <pipe>:
SYSCALL(pipe)
 543:	b8 04 00 00 00       	mov    $0x4,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret

0000054b <read>:
SYSCALL(read)
 54b:	b8 05 00 00 00       	mov    $0x5,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret

00000553 <write>:
SYSCALL(write)
 553:	b8 10 00 00 00       	mov    $0x10,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret

0000055b <close>:
SYSCALL(close)
 55b:	b8 15 00 00 00       	mov    $0x15,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret

00000563 <kill>:
SYSCALL(kill)
 563:	b8 06 00 00 00       	mov    $0x6,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret

0000056b <exec>:
SYSCALL(exec)
 56b:	b8 07 00 00 00       	mov    $0x7,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret

00000573 <open>:
SYSCALL(open)
 573:	b8 0f 00 00 00       	mov    $0xf,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret

0000057b <mknod>:
SYSCALL(mknod)
 57b:	b8 11 00 00 00       	mov    $0x11,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret

00000583 <unlink>:
SYSCALL(unlink)
 583:	b8 12 00 00 00       	mov    $0x12,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret

0000058b <fstat>:
SYSCALL(fstat)
 58b:	b8 08 00 00 00       	mov    $0x8,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret

00000593 <link>:
SYSCALL(link)
 593:	b8 13 00 00 00       	mov    $0x13,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret

0000059b <mkdir>:
SYSCALL(mkdir)
 59b:	b8 14 00 00 00       	mov    $0x14,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret

000005a3 <chdir>:
SYSCALL(chdir)
 5a3:	b8 09 00 00 00       	mov    $0x9,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret

000005ab <dup>:
SYSCALL(dup)
 5ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <getpid>:
SYSCALL(getpid)
 5b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <sbrk>:
SYSCALL(sbrk)
 5bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <sleep>:
SYSCALL(sleep)
 5c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <uptime>:
SYSCALL(uptime)
 5cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <getproccount>:
SYSCALL(getproccount)
 5d3:	b8 16 00 00 00       	mov    $0x16,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <reboot>:
SYSCALL(reboot)
 5db:	b8 17 00 00 00       	mov    $0x17,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret
 5e3:	66 90                	xchg   %ax,%ax
 5e5:	66 90                	xchg   %ax,%ax
 5e7:	66 90                	xchg   %ax,%ax
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5f8:	89 d1                	mov    %edx,%ecx
{
 5fa:	83 ec 3c             	sub    $0x3c,%esp
 5fd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 600:	85 d2                	test   %edx,%edx
 602:	0f 89 80 00 00 00    	jns    688 <printint+0x98>
 608:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 60c:	74 7a                	je     688 <printint+0x98>
    x = -xx;
 60e:	f7 d9                	neg    %ecx
    neg = 1;
 610:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 615:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 618:	31 f6                	xor    %esi,%esi
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 620:	89 c8                	mov    %ecx,%eax
 622:	31 d2                	xor    %edx,%edx
 624:	89 f7                	mov    %esi,%edi
 626:	f7 f3                	div    %ebx
 628:	8d 76 01             	lea    0x1(%esi),%esi
 62b:	0f b6 92 08 0b 00 00 	movzbl 0xb08(%edx),%edx
 632:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 636:	89 ca                	mov    %ecx,%edx
 638:	89 c1                	mov    %eax,%ecx
 63a:	39 da                	cmp    %ebx,%edx
 63c:	73 e2                	jae    620 <printint+0x30>
  if(neg)
 63e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 641:	85 c0                	test   %eax,%eax
 643:	74 07                	je     64c <printint+0x5c>
    buf[i++] = '-';
 645:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 64a:	89 f7                	mov    %esi,%edi
 64c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 64f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 652:	01 df                	add    %ebx,%edi
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 658:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 65b:	83 ec 04             	sub    $0x4,%esp
 65e:	88 45 d7             	mov    %al,-0x29(%ebp)
 661:	8d 45 d7             	lea    -0x29(%ebp),%eax
 664:	6a 01                	push   $0x1
 666:	50                   	push   %eax
 667:	56                   	push   %esi
 668:	e8 e6 fe ff ff       	call   553 <write>
  while(--i >= 0)
 66d:	89 f8                	mov    %edi,%eax
 66f:	83 c4 10             	add    $0x10,%esp
 672:	83 ef 01             	sub    $0x1,%edi
 675:	39 c3                	cmp    %eax,%ebx
 677:	75 df                	jne    658 <printint+0x68>
}
 679:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67c:	5b                   	pop    %ebx
 67d:	5e                   	pop    %esi
 67e:	5f                   	pop    %edi
 67f:	5d                   	pop    %ebp
 680:	c3                   	ret
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 688:	31 c0                	xor    %eax,%eax
 68a:	eb 89                	jmp    615 <printint+0x25>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 699:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 69c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 69f:	0f b6 1e             	movzbl (%esi),%ebx
 6a2:	83 c6 01             	add    $0x1,%esi
 6a5:	84 db                	test   %bl,%bl
 6a7:	74 67                	je     710 <printf+0x80>
 6a9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6ac:	31 d2                	xor    %edx,%edx
 6ae:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6b1:	eb 34                	jmp    6e7 <printf+0x57>
 6b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6bb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6c0:	83 f8 25             	cmp    $0x25,%eax
 6c3:	74 18                	je     6dd <printf+0x4d>
  write(fd, &c, 1);
 6c5:	83 ec 04             	sub    $0x4,%esp
 6c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6cb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6ce:	6a 01                	push   $0x1
 6d0:	50                   	push   %eax
 6d1:	57                   	push   %edi
 6d2:	e8 7c fe ff ff       	call   553 <write>
 6d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 6da:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6dd:	0f b6 1e             	movzbl (%esi),%ebx
 6e0:	83 c6 01             	add    $0x1,%esi
 6e3:	84 db                	test   %bl,%bl
 6e5:	74 29                	je     710 <printf+0x80>
    c = fmt[i] & 0xff;
 6e7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6ea:	85 d2                	test   %edx,%edx
 6ec:	74 ca                	je     6b8 <printf+0x28>
      }
    } else if(state == '%'){
 6ee:	83 fa 25             	cmp    $0x25,%edx
 6f1:	75 ea                	jne    6dd <printf+0x4d>
      if(c == 'd'){
 6f3:	83 f8 25             	cmp    $0x25,%eax
 6f6:	0f 84 04 01 00 00    	je     800 <printf+0x170>
 6fc:	83 e8 63             	sub    $0x63,%eax
 6ff:	83 f8 15             	cmp    $0x15,%eax
 702:	77 1c                	ja     720 <printf+0x90>
 704:	ff 24 85 b0 0a 00 00 	jmp    *0xab0(,%eax,4)
 70b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 710:	8d 65 f4             	lea    -0xc(%ebp),%esp
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret
 718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71f:	00 
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
 723:	8d 55 e7             	lea    -0x19(%ebp),%edx
 726:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 72a:	6a 01                	push   $0x1
 72c:	52                   	push   %edx
 72d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 730:	57                   	push   %edi
 731:	e8 1d fe ff ff       	call   553 <write>
 736:	83 c4 0c             	add    $0xc,%esp
 739:	88 5d e7             	mov    %bl,-0x19(%ebp)
 73c:	6a 01                	push   $0x1
 73e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 741:	52                   	push   %edx
 742:	57                   	push   %edi
 743:	e8 0b fe ff ff       	call   553 <write>
        putc(fd, c);
 748:	83 c4 10             	add    $0x10,%esp
      state = 0;
 74b:	31 d2                	xor    %edx,%edx
 74d:	eb 8e                	jmp    6dd <printf+0x4d>
 74f:	90                   	nop
        printint(fd, *ap, 16, 0);
 750:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 753:	83 ec 0c             	sub    $0xc,%esp
 756:	b9 10 00 00 00       	mov    $0x10,%ecx
 75b:	8b 13                	mov    (%ebx),%edx
 75d:	6a 00                	push   $0x0
 75f:	89 f8                	mov    %edi,%eax
        ap++;
 761:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 764:	e8 87 fe ff ff       	call   5f0 <printint>
        ap++;
 769:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 76c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 76f:	31 d2                	xor    %edx,%edx
 771:	e9 67 ff ff ff       	jmp    6dd <printf+0x4d>
        s = (char*)*ap;
 776:	8b 45 d0             	mov    -0x30(%ebp),%eax
 779:	8b 18                	mov    (%eax),%ebx
        ap++;
 77b:	83 c0 04             	add    $0x4,%eax
 77e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 781:	85 db                	test   %ebx,%ebx
 783:	0f 84 87 00 00 00    	je     810 <printf+0x180>
        while(*s != 0){
 789:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 78c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 78e:	84 c0                	test   %al,%al
 790:	0f 84 47 ff ff ff    	je     6dd <printf+0x4d>
 796:	8d 55 e7             	lea    -0x19(%ebp),%edx
 799:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 79c:	89 de                	mov    %ebx,%esi
 79e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
 7a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 7a6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 7a9:	6a 01                	push   $0x1
 7ab:	53                   	push   %ebx
 7ac:	57                   	push   %edi
 7ad:	e8 a1 fd ff ff       	call   553 <write>
        while(*s != 0){
 7b2:	0f b6 06             	movzbl (%esi),%eax
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	84 c0                	test   %al,%al
 7ba:	75 e4                	jne    7a0 <printf+0x110>
      state = 0;
 7bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 7bf:	31 d2                	xor    %edx,%edx
 7c1:	e9 17 ff ff ff       	jmp    6dd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 7c6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7c9:	83 ec 0c             	sub    $0xc,%esp
 7cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7d1:	8b 13                	mov    (%ebx),%edx
 7d3:	6a 01                	push   $0x1
 7d5:	eb 88                	jmp    75f <printf+0xcf>
        putc(fd, *ap);
 7d7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 7da:	83 ec 04             	sub    $0x4,%esp
 7dd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 7e0:	8b 03                	mov    (%ebx),%eax
        ap++;
 7e2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 7e5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7e8:	6a 01                	push   $0x1
 7ea:	52                   	push   %edx
 7eb:	57                   	push   %edi
 7ec:	e8 62 fd ff ff       	call   553 <write>
        ap++;
 7f1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 7f4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7f7:	31 d2                	xor    %edx,%edx
 7f9:	e9 df fe ff ff       	jmp    6dd <printf+0x4d>
 7fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
 803:	88 5d e7             	mov    %bl,-0x19(%ebp)
 806:	8d 55 e7             	lea    -0x19(%ebp),%edx
 809:	6a 01                	push   $0x1
 80b:	e9 31 ff ff ff       	jmp    741 <printf+0xb1>
 810:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 815:	bb 66 0a 00 00       	mov    $0xa66,%ebx
 81a:	e9 77 ff ff ff       	jmp    796 <printf+0x106>
 81f:	90                   	nop

00000820 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 820:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 821:	a1 fc 0d 00 00       	mov    0xdfc,%eax
{
 826:	89 e5                	mov    %esp,%ebp
 828:	57                   	push   %edi
 829:	56                   	push   %esi
 82a:	53                   	push   %ebx
 82b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 82e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 838:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	39 c8                	cmp    %ecx,%eax
 83c:	73 32                	jae    870 <free+0x50>
 83e:	39 d1                	cmp    %edx,%ecx
 840:	72 04                	jb     846 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 842:	39 d0                	cmp    %edx,%eax
 844:	72 32                	jb     878 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 846:	8b 73 fc             	mov    -0x4(%ebx),%esi
 849:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 84c:	39 fa                	cmp    %edi,%edx
 84e:	74 30                	je     880 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 850:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 853:	8b 50 04             	mov    0x4(%eax),%edx
 856:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 859:	39 f1                	cmp    %esi,%ecx
 85b:	74 3a                	je     897 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 85d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 85f:	5b                   	pop    %ebx
  freep = p;
 860:	a3 fc 0d 00 00       	mov    %eax,0xdfc
}
 865:	5e                   	pop    %esi
 866:	5f                   	pop    %edi
 867:	5d                   	pop    %ebp
 868:	c3                   	ret
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	39 d0                	cmp    %edx,%eax
 872:	72 04                	jb     878 <free+0x58>
 874:	39 d1                	cmp    %edx,%ecx
 876:	72 ce                	jb     846 <free+0x26>
{
 878:	89 d0                	mov    %edx,%eax
 87a:	eb bc                	jmp    838 <free+0x18>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 880:	03 72 04             	add    0x4(%edx),%esi
 883:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	8b 10                	mov    (%eax),%edx
 888:	8b 12                	mov    (%edx),%edx
 88a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 88d:	8b 50 04             	mov    0x4(%eax),%edx
 890:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 893:	39 f1                	cmp    %esi,%ecx
 895:	75 c6                	jne    85d <free+0x3d>
    p->s.size += bp->s.size;
 897:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 89a:	a3 fc 0d 00 00       	mov    %eax,0xdfc
    p->s.size += bp->s.size;
 89f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8a2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 8a5:	89 08                	mov    %ecx,(%eax)
}
 8a7:	5b                   	pop    %ebx
 8a8:	5e                   	pop    %esi
 8a9:	5f                   	pop    %edi
 8aa:	5d                   	pop    %ebp
 8ab:	c3                   	ret
 8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8bc:	8b 15 fc 0d 00 00    	mov    0xdfc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c2:	8d 78 07             	lea    0x7(%eax),%edi
 8c5:	c1 ef 03             	shr    $0x3,%edi
 8c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8cb:	85 d2                	test   %edx,%edx
 8cd:	0f 84 8d 00 00 00    	je     960 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8d5:	8b 48 04             	mov    0x4(%eax),%ecx
 8d8:	39 f9                	cmp    %edi,%ecx
 8da:	73 64                	jae    940 <malloc+0x90>
  if(nu < 4096)
 8dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8e1:	39 df                	cmp    %ebx,%edi
 8e3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 8e6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8ed:	eb 0a                	jmp    8f9 <malloc+0x49>
 8ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8f2:	8b 48 04             	mov    0x4(%eax),%ecx
 8f5:	39 f9                	cmp    %edi,%ecx
 8f7:	73 47                	jae    940 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f9:	89 c2                	mov    %eax,%edx
 8fb:	3b 05 fc 0d 00 00    	cmp    0xdfc,%eax
 901:	75 ed                	jne    8f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 903:	83 ec 0c             	sub    $0xc,%esp
 906:	56                   	push   %esi
 907:	e8 af fc ff ff       	call   5bb <sbrk>
  if(p == (char*)-1)
 90c:	83 c4 10             	add    $0x10,%esp
 90f:	83 f8 ff             	cmp    $0xffffffff,%eax
 912:	74 1c                	je     930 <malloc+0x80>
  hp->s.size = nu;
 914:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 917:	83 ec 0c             	sub    $0xc,%esp
 91a:	83 c0 08             	add    $0x8,%eax
 91d:	50                   	push   %eax
 91e:	e8 fd fe ff ff       	call   820 <free>
  return freep;
 923:	8b 15 fc 0d 00 00    	mov    0xdfc,%edx
      if((p = morecore(nunits)) == 0)
 929:	83 c4 10             	add    $0x10,%esp
 92c:	85 d2                	test   %edx,%edx
 92e:	75 c0                	jne    8f0 <malloc+0x40>
        return 0;
  }
}
 930:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 933:	31 c0                	xor    %eax,%eax
}
 935:	5b                   	pop    %ebx
 936:	5e                   	pop    %esi
 937:	5f                   	pop    %edi
 938:	5d                   	pop    %ebp
 939:	c3                   	ret
 93a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 940:	39 cf                	cmp    %ecx,%edi
 942:	74 4c                	je     990 <malloc+0xe0>
        p->s.size -= nunits;
 944:	29 f9                	sub    %edi,%ecx
 946:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 949:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 94c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 94f:	89 15 fc 0d 00 00    	mov    %edx,0xdfc
}
 955:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 958:	83 c0 08             	add    $0x8,%eax
}
 95b:	5b                   	pop    %ebx
 95c:	5e                   	pop    %esi
 95d:	5f                   	pop    %edi
 95e:	5d                   	pop    %ebp
 95f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 960:	c7 05 fc 0d 00 00 00 	movl   $0xe00,0xdfc
 967:	0e 00 00 
    base.s.size = 0;
 96a:	b8 00 0e 00 00       	mov    $0xe00,%eax
    base.s.ptr = freep = prevp = &base;
 96f:	c7 05 00 0e 00 00 00 	movl   $0xe00,0xe00
 976:	0e 00 00 
    base.s.size = 0;
 979:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 980:	00 00 00 
    if(p->s.size >= nunits){
 983:	e9 54 ff ff ff       	jmp    8dc <malloc+0x2c>
 988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 98f:	00 
        prevp->s.ptr = p->s.ptr;
 990:	8b 08                	mov    (%eax),%ecx
 992:	89 0a                	mov    %ecx,(%edx)
 994:	eb b9                	jmp    94f <malloc+0x9f>
