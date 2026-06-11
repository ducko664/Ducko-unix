
_dcc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    elfhdr[73] = (total_size >> 8) & 0xFF;

    write(fd, elfhdr, 84);
}

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
    if (argc < 3) {
  13:	83 39 02             	cmpl   $0x2,(%ecx)
int main(int argc, char *argv[]) {
  16:	8b 71 04             	mov    0x4(%ecx),%esi
    if (argc < 3) {
  19:	7f 13                	jg     2e <main+0x2e>
        printf(2, "Usage: dcc [input.c] [output_executable]\n");
  1b:	56                   	push   %esi
  1c:	56                   	push   %esi
  1d:	68 88 0e 00 00       	push   $0xe88
  22:	6a 02                	push   $0x2
  24:	e8 27 0a 00 00       	call   a50 <printf>
        exit();
  29:	e8 c5 08 00 00       	call   8f3 <exit>
    }

    int in_fd = open(argv[1], O_RDONLY);
  2e:	53                   	push   %ebx
  2f:	53                   	push   %ebx
  30:	6a 00                	push   $0x0
  32:	ff 76 04             	push   0x4(%esi)
  35:	e8 f9 08 00 00       	call   933 <open>
    if (in_fd < 0) { printf(2, "dcc: Cannot open input file\n"); exit(); }
  3a:	83 c4 10             	add    $0x10,%esp
    int in_fd = open(argv[1], O_RDONLY);
  3d:	89 c3                	mov    %eax,%ebx
    if (in_fd < 0) { printf(2, "dcc: Cannot open input file\n"); exit(); }
  3f:	85 c0                	test   %eax,%eax
  41:	0f 88 97 00 00 00    	js     de <main+0xde>
    int n = read(in_fd, buffer, sizeof(buffer) - 1);
  47:	50                   	push   %eax
  48:	68 ff 07 00 00       	push   $0x7ff
  4d:	68 60 16 00 00       	push   $0x1660
  52:	53                   	push   %ebx
  53:	e8 b3 08 00 00       	call   90b <read>
    buffer[n] = '\0';
    close(in_fd);
  58:	89 1c 24             	mov    %ebx,(%esp)
    buffer[n] = '\0';
  5b:	c6 80 60 16 00 00 00 	movb   $0x0,0x1660(%eax)
    close(in_fd);
  62:	e8 b4 08 00 00       	call   91b <close>

    src_ptr = buffer;
  67:	c7 05 44 16 00 00 60 	movl   $0x1660,0x1644
  6e:	16 00 00 
    next_token();
  71:	e8 da 01 00 00       	call   250 <next_token>

    match(TOKEN_INT);
  76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7d:	e8 ae 05 00 00       	call   630 <match>
    if (strcmp(token_string, "main") != 0) { printf(2, "dcc: Main missing\n"); exit(); }
  82:	58                   	pop    %eax
  83:	5a                   	pop    %edx
  84:	68 aa 0d 00 00       	push   $0xdaa
  89:	68 c0 15 00 00       	push   $0x15c0
  8e:	e8 4d 06 00 00       	call   6e0 <strcmp>
  93:	83 c4 10             	add    $0x10,%esp
  96:	85 c0                	test   %eax,%eax
  98:	75 59                	jne    f3 <main+0xf3>
    next_token();
  9a:	e8 b1 01 00 00       	call   250 <next_token>
    match(TOKEN_LPAREN);
  9f:	83 ec 0c             	sub    $0xc,%esp
  a2:	6a 07                	push   $0x7
  a4:	e8 87 05 00 00       	call   630 <match>
    match(TOKEN_RPAREN);
  a9:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  b0:	e8 7b 05 00 00       	call   630 <match>
    match(TOKEN_LBRACE);
  b5:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  bc:	e8 6f 05 00 00       	call   630 <match>

    // Compile variables and loop instructions down into raw bytes
    while (current_token != TOKEN_RBRACE && current_token != TOKEN_EOF) {
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	a1 40 16 00 00       	mov    0x1640,%eax
  c9:	83 f8 06             	cmp    $0x6,%eax
  cc:	74 38                	je     106 <main+0x106>
  ce:	85 c0                	test   %eax,%eax
  d0:	74 34                	je     106 <main+0x106>
    if (current_token == TOKEN_NAME) {
  d2:	83 f8 02             	cmp    $0x2,%eax
  d5:	75 1a                	jne    f1 <main+0xf1>
  d7:	e8 14 04 00 00       	call   4f0 <compile_statement.part.0>
  dc:	eb e6                	jmp    c4 <main+0xc4>
    if (in_fd < 0) { printf(2, "dcc: Cannot open input file\n"); exit(); }
  de:	51                   	push   %ecx
  df:	51                   	push   %ecx
  e0:	68 8d 0d 00 00       	push   $0xd8d
  e5:	6a 02                	push   $0x2
  e7:	e8 64 09 00 00       	call   a50 <printf>
  ec:	e8 02 08 00 00       	call   8f3 <exit>
    while (current_token != TOKEN_RBRACE && current_token != TOKEN_EOF) {
  f1:	eb fe                	jmp    f1 <main+0xf1>
    if (strcmp(token_string, "main") != 0) { printf(2, "dcc: Main missing\n"); exit(); }
  f3:	51                   	push   %ecx
  f4:	51                   	push   %ecx
  f5:	68 af 0d 00 00       	push   $0xdaf
  fa:	6a 02                	push   $0x2
  fc:	e8 4f 09 00 00       	call   a50 <printf>
 101:	e8 ed 07 00 00       	call   8f3 <exit>
        compile_statement();
    }
    match(TOKEN_RBRACE);
 106:	83 ec 0c             	sub    $0xc,%esp
 109:	6a 06                	push   $0x6
 10b:	e8 20 05 00 00       	call   630 <match>
    code_buf[code_idx++] = b;
 110:	a1 80 13 00 00       	mov    0x1380,%eax

    // Append an exit() system call byte block to the end automatically 
    // so compiled apps don't crash when they finish running
    emit(0xB8); emit_int(2); // movl $2, %eax
 115:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    code_buf[code_idx++] = b;
 11c:	8d 50 01             	lea    0x1(%eax),%edx
 11f:	c6 80 a0 13 00 00 b8 	movb   $0xb8,0x13a0(%eax)
 126:	89 15 80 13 00 00    	mov    %edx,0x1380
    emit(0xB8); emit_int(2); // movl $2, %eax
 12c:	e8 df 00 00 00       	call   210 <emit_int>
    code_buf[code_idx++] = b;
 131:	a1 80 13 00 00       	mov    0x1380,%eax
 136:	66 c7 80 a0 13 00 00 	movw   $0x40cd,0x13a0(%eax)
 13d:	cd 40 
 13f:	8d 50 02             	lea    0x2(%eax),%edx
    emit(0xCD); emit(0x40); // int $64

    // Open and write out the completely standalone binary executable file
    out_fd = open(argv[2], O_CREATE | O_WRONLY);
 142:	58                   	pop    %eax
    code_buf[code_idx++] = b;
 143:	89 15 80 13 00 00    	mov    %edx,0x1380
    out_fd = open(argv[2], O_CREATE | O_WRONLY);
 149:	5a                   	pop    %edx
 14a:	68 01 02 00 00       	push   $0x201
 14f:	ff 76 08             	push   0x8(%esi)
 152:	e8 dc 07 00 00       	call   933 <open>
    if (out_fd < 0) { printf(2, "dcc: Cannot create executable\n"); exit(); }
 157:	83 c4 10             	add    $0x10,%esp
    out_fd = open(argv[2], O_CREATE | O_WRONLY);
 15a:	a3 a0 15 00 00       	mov    %eax,0x15a0
    if (out_fd < 0) { printf(2, "dcc: Cannot create executable\n"); exit(); }
 15f:	85 c0                	test   %eax,%eax
 161:	78 4d                	js     1b0 <main+0x1b0>

    write_elf_header(out_fd, code_idx);
 163:	52                   	push   %edx
 164:	52                   	push   %edx
 165:	ff 35 80 13 00 00    	push   0x1380
 16b:	50                   	push   %eax
 16c:	e8 ff 04 00 00       	call   670 <write_elf_header>
    write(out_fd, code_buf, code_idx);
 171:	83 c4 0c             	add    $0xc,%esp
 174:	ff 35 80 13 00 00    	push   0x1380
 17a:	68 a0 13 00 00       	push   $0x13a0
 17f:	ff 35 a0 15 00 00    	push   0x15a0
 185:	e8 89 07 00 00       	call   913 <write>
    close(out_fd);
 18a:	59                   	pop    %ecx
 18b:	ff 35 a0 15 00 00    	push   0x15a0
 191:	e8 85 07 00 00       	call   91b <close>

    printf(1, "SUCCESS! '%s' compiled directly into executable binary '%s'\n", argv[1], argv[2]);
 196:	ff 76 08             	push   0x8(%esi)
 199:	ff 76 04             	push   0x4(%esi)
 19c:	68 d4 0e 00 00       	push   $0xed4
 1a1:	6a 01                	push   $0x1
 1a3:	e8 a8 08 00 00       	call   a50 <printf>
    exit();
 1a8:	83 c4 20             	add    $0x20,%esp
 1ab:	e8 43 07 00 00       	call   8f3 <exit>
    if (out_fd < 0) { printf(2, "dcc: Cannot create executable\n"); exit(); }
 1b0:	53                   	push   %ebx
 1b1:	53                   	push   %ebx
 1b2:	68 b4 0e 00 00       	push   $0xeb4
 1b7:	6a 02                	push   $0x2
 1b9:	e8 92 08 00 00       	call   a50 <printf>
 1be:	e8 30 07 00 00       	call   8f3 <exit>
 1c3:	66 90                	xchg   %ax,%ax
 1c5:	66 90                	xchg   %ax,%ax
 1c7:	66 90                	xchg   %ax,%ax
 1c9:	66 90                	xchg   %ax,%ax
 1cb:	66 90                	xchg   %ax,%ax
 1cd:	66 90                	xchg   %ax,%ax
 1cf:	90                   	nop

000001d0 <match.part.0>:
void match(enum token_type expected) {
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 10             	sub    $0x10,%esp
    else { printf(2, "dcc: Syntax Error\n"); exit(); }
 1d6:	68 58 0d 00 00       	push   $0xd58
 1db:	6a 02                	push   $0x2
 1dd:	e8 6e 08 00 00       	call   a50 <printf>
 1e2:	e8 0c 07 00 00       	call   8f3 <exit>
 1e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ee:	00 
 1ef:	90                   	nop

000001f0 <emit>:
void emit(uchar b) {
 1f0:	55                   	push   %ebp
    code_buf[code_idx++] = b;
 1f1:	a1 80 13 00 00       	mov    0x1380,%eax
 1f6:	8d 50 01             	lea    0x1(%eax),%edx
void emit(uchar b) {
 1f9:	89 e5                	mov    %esp,%ebp
    code_buf[code_idx++] = b;
 1fb:	89 15 80 13 00 00    	mov    %edx,0x1380
 201:	8b 55 08             	mov    0x8(%ebp),%edx
}
 204:	5d                   	pop    %ebp
    code_buf[code_idx++] = b;
 205:	88 90 a0 13 00 00    	mov    %dl,0x13a0(%eax)
}
 20b:	c3                   	ret
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <emit_int>:
void emit_int(uint i) {
 210:	55                   	push   %ebp
    code_buf[code_idx++] = i & 0xFF;
 211:	8b 15 80 13 00 00    	mov    0x1380,%edx
void emit_int(uint i) {
 217:	89 e5                	mov    %esp,%ebp
 219:	8b 45 08             	mov    0x8(%ebp),%eax
}
 21c:	5d                   	pop    %ebp
    code_buf[code_idx++] = (i >> 16) & 0xFF;
 21d:	89 c1                	mov    %eax,%ecx
    code_buf[code_idx++] = i & 0xFF;
 21f:	88 82 a0 13 00 00    	mov    %al,0x13a0(%edx)
    code_buf[code_idx++] = (i >> 16) & 0xFF;
 225:	c1 e9 10             	shr    $0x10,%ecx
    code_buf[code_idx++] = (i >> 8) & 0xFF;
 228:	88 a2 a1 13 00 00    	mov    %ah,0x13a1(%edx)
    code_buf[code_idx++] = (i >> 24) & 0xFF;
 22e:	c1 e8 18             	shr    $0x18,%eax
    code_buf[code_idx++] = (i >> 16) & 0xFF;
 231:	88 8a a2 13 00 00    	mov    %cl,0x13a2(%edx)
    code_buf[code_idx++] = (i >> 24) & 0xFF;
 237:	8d 4a 04             	lea    0x4(%edx),%ecx
 23a:	89 0d 80 13 00 00    	mov    %ecx,0x1380
 240:	88 82 a3 13 00 00    	mov    %al,0x13a3(%edx)
}
 246:	c3                   	ret
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop

00000250 <next_token>:
void next_token() {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	be 13 00 80 00       	mov    $0x800013,%esi
 259:	53                   	push   %ebx
    while (*src_ptr == ' ' || *src_ptr == '\t' || *src_ptr == '\n' || *src_ptr == '\r') {
 25a:	a1 44 16 00 00       	mov    0x1644,%eax
 25f:	eb 0f                	jmp    270 <next_token+0x20>
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        src_ptr++;
 268:	83 c0 01             	add    $0x1,%eax
 26b:	a3 44 16 00 00       	mov    %eax,0x1644
    while (*src_ptr == ' ' || *src_ptr == '\t' || *src_ptr == '\n' || *src_ptr == '\r') {
 270:	0f b6 10             	movzbl (%eax),%edx
 273:	8d 4a f7             	lea    -0x9(%edx),%ecx
 276:	89 d3                	mov    %edx,%ebx
 278:	80 f9 17             	cmp    $0x17,%cl
 27b:	77 1b                	ja     298 <next_token+0x48>
 27d:	0f a3 ce             	bt     %ecx,%esi
 280:	72 e6                	jb     268 <next_token+0x18>
    printf(2, "dcc: Lexer error\n");
 282:	50                   	push   %eax
 283:	50                   	push   %eax
 284:	68 6f 0d 00 00       	push   $0xd6f
 289:	6a 02                	push   $0x2
 28b:	e8 c0 07 00 00       	call   a50 <printf>
    exit();
 290:	e8 5e 06 00 00       	call   8f3 <exit>
 295:	8d 76 00             	lea    0x0(%esi),%esi
    if (*src_ptr == '\0') { current_token = TOKEN_EOF; return; }
 298:	80 fa 3b             	cmp    $0x3b,%dl
 29b:	7f 23                	jg     2c0 <next_token+0x70>
 29d:	80 fa 21             	cmp    $0x21,%dl
 2a0:	0f 8e 8a 01 00 00    	jle    430 <next_token+0x1e0>
 2a6:	8d 4a de             	lea    -0x22(%edx),%ecx
 2a9:	80 f9 19             	cmp    $0x19,%cl
 2ac:	77 42                	ja     2f0 <next_token+0xa0>
 2ae:	0f b6 c9             	movzbl %cl,%ecx
 2b1:	ff 24 8d cc 0d 00 00 	jmp    *0xdcc(,%ecx,4)
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 
 2c0:	80 fa 7b             	cmp    $0x7b,%dl
 2c3:	0f 84 87 00 00 00    	je     350 <next_token+0x100>
 2c9:	80 fa 7d             	cmp    $0x7d,%dl
 2cc:	0f 85 97 01 00 00    	jne    469 <next_token+0x219>
    if (*src_ptr == '}')  { current_token = TOKEN_RBRACE; src_ptr++; return; }
 2d2:	c7 05 40 16 00 00 06 	movl   $0x6,0x1640
 2d9:	00 00 00 
 2dc:	83 c0 01             	add    $0x1,%eax
 2df:	a3 44 16 00 00       	mov    %eax,0x1644
}
 2e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e7:	5b                   	pop    %ebx
 2e8:	5e                   	pop    %esi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret
 2eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if (*src_ptr >= '0' && *src_ptr <= '9') {
 2f0:	83 ea 30             	sub    $0x30,%edx
 2f3:	80 fa 09             	cmp    $0x9,%dl
 2f6:	77 8a                	ja     282 <next_token+0x32>
        token_value = 0;
 2f8:	c7 05 a4 15 00 00 00 	movl   $0x0,0x15a4
 2ff:	00 00 00 
        while (*src_ptr >= '0' && *src_ptr <= '9') {
 302:	0f b6 10             	movzbl (%eax),%edx
 305:	31 c9                	xor    %ecx,%ecx
 307:	83 c0 01             	add    $0x1,%eax
 30a:	8d 5a d0             	lea    -0x30(%edx),%ebx
 30d:	80 fb 09             	cmp    $0x9,%bl
 310:	77 2c                	ja     33e <next_token+0xee>
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            token_value = token_value * 10 + (*src_ptr - '0');
 318:	83 ea 30             	sub    $0x30,%edx
 31b:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
            src_ptr++;
 31e:	a3 44 16 00 00       	mov    %eax,0x1644
        while (*src_ptr >= '0' && *src_ptr <= '9') {
 323:	83 c0 01             	add    $0x1,%eax
            token_value = token_value * 10 + (*src_ptr - '0');
 326:	0f be d2             	movsbl %dl,%edx
 329:	8d 0c 4a             	lea    (%edx,%ecx,2),%ecx
 32c:	89 0d a4 15 00 00    	mov    %ecx,0x15a4
        while (*src_ptr >= '0' && *src_ptr <= '9') {
 332:	0f b6 50 ff          	movzbl -0x1(%eax),%edx
 336:	8d 5a d0             	lea    -0x30(%edx),%ebx
 339:	80 fb 09             	cmp    $0x9,%bl
 33c:	76 da                	jbe    318 <next_token+0xc8>
        current_token = TOKEN_NUM;
 33e:	c7 05 40 16 00 00 03 	movl   $0x3,0x1640
 345:	00 00 00 
        return;
 348:	eb 9a                	jmp    2e4 <next_token+0x94>
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (*src_ptr == '{')  { current_token = TOKEN_LBRACE; src_ptr++; return; }
 350:	c7 05 40 16 00 00 05 	movl   $0x5,0x1640
 357:	00 00 00 
 35a:	83 c0 01             	add    $0x1,%eax
 35d:	a3 44 16 00 00       	mov    %eax,0x1644
}
 362:	8d 65 f8             	lea    -0x8(%ebp),%esp
 365:	5b                   	pop    %ebx
 366:	5e                   	pop    %esi
 367:	5d                   	pop    %ebp
 368:	c3                   	ret
    if (*src_ptr == ';')  { current_token = TOKEN_SEMICOLON; src_ptr++; return; }
 369:	c7 05 40 16 00 00 09 	movl   $0x9,0x1640
 370:	00 00 00 
 373:	83 c0 01             	add    $0x1,%eax
 376:	a3 44 16 00 00       	mov    %eax,0x1644
}
 37b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 37e:	5b                   	pop    %ebx
 37f:	5e                   	pop    %esi
 380:	5d                   	pop    %ebp
 381:	c3                   	ret
    if (*src_ptr == ',')  { current_token = TOKEN_COMMA; src_ptr++; return; }
 382:	c7 05 40 16 00 00 0a 	movl   $0xa,0x1640
 389:	00 00 00 
 38c:	83 c0 01             	add    $0x1,%eax
 38f:	a3 44 16 00 00       	mov    %eax,0x1644
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret
    if (*src_ptr == ')')  { current_token = TOKEN_RPAREN; src_ptr++; return; }
 39b:	c7 05 40 16 00 00 08 	movl   $0x8,0x1640
 3a2:	00 00 00 
 3a5:	83 c0 01             	add    $0x1,%eax
 3a8:	a3 44 16 00 00       	mov    %eax,0x1644
}
 3ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3b0:	5b                   	pop    %ebx
 3b1:	5e                   	pop    %esi
 3b2:	5d                   	pop    %ebp
 3b3:	c3                   	ret
    if (*src_ptr == '(')  { current_token = TOKEN_LPAREN; src_ptr++; return; }
 3b4:	c7 05 40 16 00 00 07 	movl   $0x7,0x1640
 3bb:	00 00 00 
 3be:	83 c0 01             	add    $0x1,%eax
 3c1:	a3 44 16 00 00       	mov    %eax,0x1644
}
 3c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3c9:	5b                   	pop    %ebx
 3ca:	5e                   	pop    %esi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret
        src_ptr++;
 3cd:	8d 50 01             	lea    0x1(%eax),%edx
        int i = 0;
 3d0:	31 c9                	xor    %ecx,%ecx
        src_ptr++;
 3d2:	89 15 44 16 00 00    	mov    %edx,0x1644
        while (*src_ptr != '"' && *src_ptr != '\0') {
 3d8:	0f b6 40 01          	movzbl 0x1(%eax),%eax
 3dc:	3c 22                	cmp    $0x22,%al
 3de:	75 26                	jne    406 <next_token+0x1b6>
 3e0:	eb 67                	jmp    449 <next_token+0x1f9>
 3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                token_string[i++] = *src_ptr++;
 3e8:	8d 42 01             	lea    0x1(%edx),%eax
 3eb:	a3 44 16 00 00       	mov    %eax,0x1644
 3f0:	0f b6 12             	movzbl (%edx),%edx
 3f3:	88 91 bf 15 00 00    	mov    %dl,0x15bf(%ecx)
 3f9:	89 c2                	mov    %eax,%edx
        while (*src_ptr != '"' && *src_ptr != '\0') {
 3fb:	0f b6 02             	movzbl (%edx),%eax
 3fe:	3c 22                	cmp    $0x22,%al
 400:	0f 84 d9 00 00 00    	je     4df <next_token+0x28f>
 406:	84 c0                	test   %al,%al
 408:	74 3f                	je     449 <next_token+0x1f9>
                token_string[i++] = '\n';
 40a:	83 c1 01             	add    $0x1,%ecx
            if (*src_ptr == '\\' && *(src_ptr + 1) == 'n') {
 40d:	3c 5c                	cmp    $0x5c,%al
 40f:	75 d7                	jne    3e8 <next_token+0x198>
 411:	80 7a 01 6e          	cmpb   $0x6e,0x1(%edx)
 415:	75 d1                	jne    3e8 <next_token+0x198>
                src_ptr += 2;
 417:	83 c2 02             	add    $0x2,%edx
                token_string[i++] = '\n';
 41a:	c6 81 bf 15 00 00 0a 	movb   $0xa,0x15bf(%ecx)
                src_ptr += 2;
 421:	89 15 44 16 00 00    	mov    %edx,0x1644
 427:	eb d2                	jmp    3fb <next_token+0x1ab>
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 430:	84 d2                	test   %dl,%dl
 432:	0f 85 4a fe ff ff    	jne    282 <next_token+0x32>
    if (*src_ptr == '\0') { current_token = TOKEN_EOF; return; }
 438:	c7 05 40 16 00 00 00 	movl   $0x0,0x1640
 43f:	00 00 00 
}
 442:	8d 65 f8             	lea    -0x8(%ebp),%esp
 445:	5b                   	pop    %ebx
 446:	5e                   	pop    %esi
 447:	5d                   	pop    %ebp
 448:	c3                   	ret
        if (*src_ptr == '"') src_ptr++;
 449:	3c 22                	cmp    $0x22,%al
 44b:	0f 84 8e 00 00 00    	je     4df <next_token+0x28f>
        token_string[i] = '\0';
 451:	c6 81 c0 15 00 00 00 	movb   $0x0,0x15c0(%ecx)
        current_token = TOKEN_STRING;
 458:	c7 05 40 16 00 00 04 	movl   $0x4,0x1640
 45f:	00 00 00 
}
 462:	8d 65 f8             	lea    -0x8(%ebp),%esp
 465:	5b                   	pop    %ebx
 466:	5e                   	pop    %esi
 467:	5d                   	pop    %ebp
 468:	c3                   	ret
    if ((*src_ptr >= 'a' && *src_ptr <= 'z') || (*src_ptr >= 'A' && *src_ptr <= 'Z')) {
 469:	83 e2 df             	and    $0xffffffdf,%edx
 46c:	83 ea 41             	sub    $0x41,%edx
 46f:	80 fa 19             	cmp    $0x19,%dl
 472:	0f 87 0a fe ff ff    	ja     282 <next_token+0x32>
 478:	83 c0 01             	add    $0x1,%eax
        int i = 0;
 47b:	31 c9                	xor    %ecx,%ecx
 47d:	eb 1a                	jmp    499 <next_token+0x249>
 47f:	90                   	nop
            token_string[i++] = *src_ptr++;
 480:	a3 44 16 00 00       	mov    %eax,0x1644
 485:	0f b6 50 ff          	movzbl -0x1(%eax),%edx
 489:	83 c1 01             	add    $0x1,%ecx
 48c:	83 c0 01             	add    $0x1,%eax
 48f:	88 91 bf 15 00 00    	mov    %dl,0x15bf(%ecx)
        while ((*src_ptr >= 'a' && *src_ptr <= 'z') || (*src_ptr >= 'A' && *src_ptr <= 'Z') || (*src_ptr >= '0' && *src_ptr <= '9')) {
 495:	0f b6 58 ff          	movzbl -0x1(%eax),%ebx
 499:	89 da                	mov    %ebx,%edx
 49b:	83 e2 df             	and    $0xffffffdf,%edx
 49e:	83 ea 41             	sub    $0x41,%edx
 4a1:	80 fa 19             	cmp    $0x19,%dl
 4a4:	76 da                	jbe    480 <next_token+0x230>
 4a6:	83 eb 30             	sub    $0x30,%ebx
 4a9:	80 fb 09             	cmp    $0x9,%bl
 4ac:	76 d2                	jbe    480 <next_token+0x230>
        if (strcmp(token_string, "int") == 0) current_token = TOKEN_INT;
 4ae:	83 ec 08             	sub    $0x8,%esp
        token_string[i] = '\0';
 4b1:	c6 81 c0 15 00 00 00 	movb   $0x0,0x15c0(%ecx)
        if (strcmp(token_string, "int") == 0) current_token = TOKEN_INT;
 4b8:	68 6b 0d 00 00       	push   $0xd6b
 4bd:	68 c0 15 00 00       	push   $0x15c0
 4c2:	e8 19 02 00 00       	call   6e0 <strcmp>
 4c7:	83 c4 10             	add    $0x10,%esp
 4ca:	83 f8 01             	cmp    $0x1,%eax
 4cd:	b8 01 00 00 00       	mov    $0x1,%eax
 4d2:	83 d8 ff             	sbb    $0xffffffff,%eax
 4d5:	a3 40 16 00 00       	mov    %eax,0x1640
 4da:	e9 05 fe ff ff       	jmp    2e4 <next_token+0x94>
        if (*src_ptr == '"') src_ptr++;
 4df:	83 c2 01             	add    $0x1,%edx
 4e2:	89 15 44 16 00 00    	mov    %edx,0x1644
 4e8:	e9 64 ff ff ff       	jmp    451 <next_token+0x201>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi

000004f0 <compile_statement.part.0>:
void compile_statement() {
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	53                   	push   %ebx
        strcpy(name, token_string);
 4f4:	8d 5d b8             	lea    -0x48(%ebp),%ebx
void compile_statement() {
 4f7:	83 ec 4c             	sub    $0x4c,%esp
        strcpy(name, token_string);
 4fa:	68 c0 15 00 00       	push   $0x15c0
 4ff:	53                   	push   %ebx
 500:	e8 ab 01 00 00       	call   6b0 <strcpy>
        next_token();
 505:	e8 46 fd ff ff       	call   250 <next_token>
    if (current_token == expected) next_token();
 50a:	83 c4 10             	add    $0x10,%esp
 50d:	83 3d 40 16 00 00 07 	cmpl   $0x7,0x1640
 514:	0f 85 08 01 00 00    	jne    622 <compile_statement.part.0+0x132>
 51a:	e8 31 fd ff ff       	call   250 <next_token>
        if (strcmp(name, "reboot") == 0) {
 51f:	83 ec 08             	sub    $0x8,%esp
 522:	68 81 0d 00 00       	push   $0xd81
 527:	53                   	push   %ebx
 528:	e8 b3 01 00 00       	call   6e0 <strcmp>
 52d:	83 c4 10             	add    $0x10,%esp
 530:	85 c0                	test   %eax,%eax
 532:	74 4c                	je     580 <compile_statement.part.0+0x90>
        else if (strcmp(name, "exit") == 0) {
 534:	83 ec 08             	sub    $0x8,%esp
 537:	68 88 0d 00 00       	push   $0xd88
 53c:	53                   	push   %ebx
 53d:	e8 9e 01 00 00       	call   6e0 <strcmp>
 542:	83 c4 10             	add    $0x10,%esp
 545:	85 c0                	test   %eax,%eax
 547:	0f 84 93 00 00 00    	je     5e0 <compile_statement.part.0+0xf0>
    if (current_token == expected) next_token();
 54d:	83 3d 40 16 00 00 08 	cmpl   $0x8,0x1640
 554:	0f 85 c8 00 00 00    	jne    622 <compile_statement.part.0+0x132>
 55a:	e8 f1 fc ff ff       	call   250 <next_token>
 55f:	83 3d 40 16 00 00 09 	cmpl   $0x9,0x1640
 566:	0f 85 b6 00 00 00    	jne    622 <compile_statement.part.0+0x132>
 56c:	e8 df fc ff ff       	call   250 <next_token>
}
 571:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 574:	c9                   	leave
 575:	c3                   	ret
 576:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57d:	00 
 57e:	66 90                	xchg   %ax,%ax
            int arg = token_value;
 580:	8b 1d a4 15 00 00    	mov    0x15a4,%ebx
            next_token();
 586:	e8 c5 fc ff ff       	call   250 <next_token>
    code_buf[code_idx++] = b;
 58b:	a1 80 13 00 00       	mov    0x1380,%eax
 590:	8d 50 09             	lea    0x9(%eax),%edx
 593:	c6 80 a0 13 00 00 6a 	movb   $0x6a,0x13a0(%eax)
            emit(arg);
 59a:	88 98 a1 13 00 00    	mov    %bl,0x13a1(%eax)
    code_buf[code_idx++] = b;
 5a0:	c6 80 a2 13 00 00 b8 	movb   $0xb8,0x13a2(%eax)
    code_buf[code_idx++] = i & 0xFF;
 5a7:	c6 80 a3 13 00 00 17 	movb   $0x17,0x13a3(%eax)
    code_buf[code_idx++] = (i >> 8) & 0xFF;
 5ae:	c6 80 a4 13 00 00 00 	movb   $0x0,0x13a4(%eax)
    code_buf[code_idx++] = (i >> 16) & 0xFF;
 5b5:	c6 80 a5 13 00 00 00 	movb   $0x0,0x13a5(%eax)
    code_buf[code_idx++] = (i >> 24) & 0xFF;
 5bc:	c6 80 a6 13 00 00 00 	movb   $0x0,0x13a6(%eax)
    code_buf[code_idx++] = b;
 5c3:	c6 80 a7 13 00 00 cd 	movb   $0xcd,0x13a7(%eax)
 5ca:	89 15 80 13 00 00    	mov    %edx,0x1380
 5d0:	c6 80 a8 13 00 00 40 	movb   $0x40,0x13a8(%eax)
}
 5d7:	e9 71 ff ff ff       	jmp    54d <compile_statement.part.0+0x5d>
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    code_buf[code_idx++] = b;
 5e0:	a1 80 13 00 00       	mov    0x1380,%eax
    code_buf[code_idx++] = (i >> 24) & 0xFF;
 5e5:	ba 00 cd ff ff       	mov    $0xffffcd00,%edx
 5ea:	66 89 90 a4 13 00 00 	mov    %dx,0x13a4(%eax)
    code_buf[code_idx++] = b;
 5f1:	8d 50 07             	lea    0x7(%eax),%edx
 5f4:	c6 80 a0 13 00 00 b8 	movb   $0xb8,0x13a0(%eax)
    code_buf[code_idx++] = i & 0xFF;
 5fb:	c6 80 a1 13 00 00 02 	movb   $0x2,0x13a1(%eax)
    code_buf[code_idx++] = (i >> 8) & 0xFF;
 602:	c6 80 a2 13 00 00 00 	movb   $0x0,0x13a2(%eax)
    code_buf[code_idx++] = (i >> 16) & 0xFF;
 609:	c6 80 a3 13 00 00 00 	movb   $0x0,0x13a3(%eax)
    code_buf[code_idx++] = b;
 610:	89 15 80 13 00 00    	mov    %edx,0x1380
 616:	c6 80 a6 13 00 00 40 	movb   $0x40,0x13a6(%eax)
}
 61d:	e9 2b ff ff ff       	jmp    54d <compile_statement.part.0+0x5d>
 622:	e8 a9 fb ff ff       	call   1d0 <match.part.0>
 627:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 62e:	00 
 62f:	90                   	nop

00000630 <match>:
void match(enum token_type expected) {
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	83 ec 08             	sub    $0x8,%esp
    if (current_token == expected) next_token();
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	39 05 40 16 00 00    	cmp    %eax,0x1640
 63f:	75 06                	jne    647 <match+0x17>
}
 641:	c9                   	leave
    if (current_token == expected) next_token();
 642:	e9 09 fc ff ff       	jmp    250 <next_token>
 647:	e8 84 fb ff ff       	call   1d0 <match.part.0>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000650 <compile_statement>:
    if (current_token == TOKEN_NAME) {
 650:	83 3d 40 16 00 00 02 	cmpl   $0x2,0x1640
 657:	74 07                	je     660 <compile_statement+0x10>
}
 659:	c3                   	ret
 65a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 660:	e9 8b fe ff ff       	jmp    4f0 <compile_statement.part.0>
 665:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 66c:	00 
 66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <write_elf_header>:
void write_elf_header(int fd, int code_size) {
 670:	55                   	push   %ebp
    uchar elfhdr[84] = {
 671:	b9 15 00 00 00       	mov    $0x15,%ecx
void write_elf_header(int fd, int code_size) {
 676:	89 e5                	mov    %esp,%ebp
 678:	57                   	push   %edi
 679:	56                   	push   %esi
    uchar elfhdr[84] = {
 67a:	8d 7d a4             	lea    -0x5c(%ebp),%edi
 67d:	be 34 0e 00 00       	mov    $0xe34,%esi
void write_elf_header(int fd, int code_size) {
 682:	83 ec 64             	sub    $0x64,%esp
    uint total_size = 84 + code_size;
 685:	8b 45 0c             	mov    0xc(%ebp),%eax
    uchar elfhdr[84] = {
 688:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    uint total_size = 84 + code_size;
 68a:	83 c0 54             	add    $0x54,%eax
    elfhdr[68] = total_size & 0xFF;        // Update p_filesz
 68d:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
    elfhdr[72] = total_size & 0xFF;        // Update p_memsz
 691:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    write(fd, elfhdr, 84);
 695:	8d 45 a4             	lea    -0x5c(%ebp),%eax
 698:	6a 54                	push   $0x54
 69a:	50                   	push   %eax
 69b:	ff 75 08             	push   0x8(%ebp)
 69e:	e8 70 02 00 00       	call   913 <write>
}
 6a3:	83 c4 10             	add    $0x10,%esp
 6a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6a9:	5e                   	pop    %esi
 6aa:	5f                   	pop    %edi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret
 6ad:	66 90                	xchg   %ax,%ax
 6af:	90                   	nop

000006b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 6b0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6b1:	31 c0                	xor    %eax,%eax
{
 6b3:	89 e5                	mov    %esp,%ebp
 6b5:	53                   	push   %ebx
 6b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 6c0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 6c4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 6c7:	83 c0 01             	add    $0x1,%eax
 6ca:	84 d2                	test   %dl,%dl
 6cc:	75 f2                	jne    6c0 <strcpy+0x10>
    ;
  return os;
}
 6ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6d1:	89 c8                	mov    %ecx,%eax
 6d3:	c9                   	leave
 6d4:	c3                   	ret
 6d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6dc:	00 
 6dd:	8d 76 00             	lea    0x0(%esi),%esi

000006e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 55 08             	mov    0x8(%ebp),%edx
 6e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 6ea:	0f b6 02             	movzbl (%edx),%eax
 6ed:	84 c0                	test   %al,%al
 6ef:	75 17                	jne    708 <strcmp+0x28>
 6f1:	eb 3a                	jmp    72d <strcmp+0x4d>
 6f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 6f8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 6fc:	83 c2 01             	add    $0x1,%edx
 6ff:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 702:	84 c0                	test   %al,%al
 704:	74 1a                	je     720 <strcmp+0x40>
 706:	89 d9                	mov    %ebx,%ecx
 708:	0f b6 19             	movzbl (%ecx),%ebx
 70b:	38 c3                	cmp    %al,%bl
 70d:	74 e9                	je     6f8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 70f:	29 d8                	sub    %ebx,%eax
}
 711:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 714:	c9                   	leave
 715:	c3                   	ret
 716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71d:	00 
 71e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 720:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 724:	31 c0                	xor    %eax,%eax
 726:	29 d8                	sub    %ebx,%eax
}
 728:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 72b:	c9                   	leave
 72c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 72d:	0f b6 19             	movzbl (%ecx),%ebx
 730:	31 c0                	xor    %eax,%eax
 732:	eb db                	jmp    70f <strcmp+0x2f>
 734:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73b:	00 
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <strlen>:

uint
strlen(const char *s)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 746:	80 3a 00             	cmpb   $0x0,(%edx)
 749:	74 15                	je     760 <strlen+0x20>
 74b:	31 c0                	xor    %eax,%eax
 74d:	8d 76 00             	lea    0x0(%esi),%esi
 750:	83 c0 01             	add    $0x1,%eax
 753:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 757:	89 c1                	mov    %eax,%ecx
 759:	75 f5                	jne    750 <strlen+0x10>
    ;
  return n;
}
 75b:	89 c8                	mov    %ecx,%eax
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret
 75f:	90                   	nop
  for(n = 0; s[n]; n++)
 760:	31 c9                	xor    %ecx,%ecx
}
 762:	5d                   	pop    %ebp
 763:	89 c8                	mov    %ecx,%eax
 765:	c3                   	ret
 766:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76d:	00 
 76e:	66 90                	xchg   %ax,%ax

00000770 <memset>:

void*
memset(void *dst, int c, uint n)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 777:	8b 4d 10             	mov    0x10(%ebp),%ecx
 77a:	8b 45 0c             	mov    0xc(%ebp),%eax
 77d:	89 d7                	mov    %edx,%edi
 77f:	fc                   	cld
 780:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 782:	8b 7d fc             	mov    -0x4(%ebp),%edi
 785:	89 d0                	mov    %edx,%eax
 787:	c9                   	leave
 788:	c3                   	ret
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <strchr>:

char*
strchr(const char *s, char c)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	8b 45 08             	mov    0x8(%ebp),%eax
 796:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 79a:	0f b6 10             	movzbl (%eax),%edx
 79d:	84 d2                	test   %dl,%dl
 79f:	75 12                	jne    7b3 <strchr+0x23>
 7a1:	eb 1d                	jmp    7c0 <strchr+0x30>
 7a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 7a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 7ac:	83 c0 01             	add    $0x1,%eax
 7af:	84 d2                	test   %dl,%dl
 7b1:	74 0d                	je     7c0 <strchr+0x30>
    if(*s == c)
 7b3:	38 d1                	cmp    %dl,%cl
 7b5:	75 f1                	jne    7a8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 7b7:	5d                   	pop    %ebp
 7b8:	c3                   	ret
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 7c0:	31 c0                	xor    %eax,%eax
}
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret
 7c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7cb:	00 
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007d0 <gets>:

char*
gets(char *buf, int max)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 7d5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 7d8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 7d9:	31 db                	xor    %ebx,%ebx
{
 7db:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 7de:	eb 27                	jmp    807 <gets+0x37>
    cc = read(0, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
 7e3:	6a 01                	push   $0x1
 7e5:	56                   	push   %esi
 7e6:	6a 00                	push   $0x0
 7e8:	e8 1e 01 00 00       	call   90b <read>
    if(cc < 1)
 7ed:	83 c4 10             	add    $0x10,%esp
 7f0:	85 c0                	test   %eax,%eax
 7f2:	7e 1d                	jle    811 <gets+0x41>
      break;
    buf[i++] = c;
 7f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7f8:	8b 55 08             	mov    0x8(%ebp),%edx
 7fb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 7ff:	3c 0a                	cmp    $0xa,%al
 801:	74 10                	je     813 <gets+0x43>
 803:	3c 0d                	cmp    $0xd,%al
 805:	74 0c                	je     813 <gets+0x43>
  for(i=0; i+1 < max; ){
 807:	89 df                	mov    %ebx,%edi
 809:	83 c3 01             	add    $0x1,%ebx
 80c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 80f:	7c cf                	jl     7e0 <gets+0x10>
 811:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 813:	8b 45 08             	mov    0x8(%ebp),%eax
 816:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 81a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81d:	5b                   	pop    %ebx
 81e:	5e                   	pop    %esi
 81f:	5f                   	pop    %edi
 820:	5d                   	pop    %ebp
 821:	c3                   	ret
 822:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 829:	00 
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000830 <stat>:

int
stat(const char *n, struct stat *st)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	56                   	push   %esi
 834:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 835:	83 ec 08             	sub    $0x8,%esp
 838:	6a 00                	push   $0x0
 83a:	ff 75 08             	push   0x8(%ebp)
 83d:	e8 f1 00 00 00       	call   933 <open>
  if(fd < 0)
 842:	83 c4 10             	add    $0x10,%esp
 845:	85 c0                	test   %eax,%eax
 847:	78 27                	js     870 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 849:	83 ec 08             	sub    $0x8,%esp
 84c:	ff 75 0c             	push   0xc(%ebp)
 84f:	89 c3                	mov    %eax,%ebx
 851:	50                   	push   %eax
 852:	e8 f4 00 00 00       	call   94b <fstat>
  close(fd);
 857:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 85a:	89 c6                	mov    %eax,%esi
  close(fd);
 85c:	e8 ba 00 00 00       	call   91b <close>
  return r;
 861:	83 c4 10             	add    $0x10,%esp
}
 864:	8d 65 f8             	lea    -0x8(%ebp),%esp
 867:	89 f0                	mov    %esi,%eax
 869:	5b                   	pop    %ebx
 86a:	5e                   	pop    %esi
 86b:	5d                   	pop    %ebp
 86c:	c3                   	ret
 86d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 870:	be ff ff ff ff       	mov    $0xffffffff,%esi
 875:	eb ed                	jmp    864 <stat+0x34>
 877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 87e:	00 
 87f:	90                   	nop

00000880 <atoi>:

int
atoi(const char *s)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	53                   	push   %ebx
 884:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 887:	0f be 02             	movsbl (%edx),%eax
 88a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 88d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 890:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 895:	77 1e                	ja     8b5 <atoi+0x35>
 897:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89e:	00 
 89f:	90                   	nop
    n = n*10 + *s++ - '0';
 8a0:	83 c2 01             	add    $0x1,%edx
 8a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 8a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 8aa:	0f be 02             	movsbl (%edx),%eax
 8ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 8b0:	80 fb 09             	cmp    $0x9,%bl
 8b3:	76 eb                	jbe    8a0 <atoi+0x20>
  return n;
}
 8b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8b8:	89 c8                	mov    %ecx,%eax
 8ba:	c9                   	leave
 8bb:	c3                   	ret
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	8b 45 10             	mov    0x10(%ebp),%eax
 8c7:	8b 55 08             	mov    0x8(%ebp),%edx
 8ca:	56                   	push   %esi
 8cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 8ce:	85 c0                	test   %eax,%eax
 8d0:	7e 13                	jle    8e5 <memmove+0x25>
 8d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 8d4:	89 d7                	mov    %edx,%edi
 8d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8dd:	00 
 8de:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 8e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 8e1:	39 f8                	cmp    %edi,%eax
 8e3:	75 fb                	jne    8e0 <memmove+0x20>
  return vdst;
}
 8e5:	5e                   	pop    %esi
 8e6:	89 d0                	mov    %edx,%eax
 8e8:	5f                   	pop    %edi
 8e9:	5d                   	pop    %ebp
 8ea:	c3                   	ret

000008eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 8eb:	b8 01 00 00 00       	mov    $0x1,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret

000008f3 <exit>:
SYSCALL(exit)
 8f3:	b8 02 00 00 00       	mov    $0x2,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret

000008fb <wait>:
SYSCALL(wait)
 8fb:	b8 03 00 00 00       	mov    $0x3,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret

00000903 <pipe>:
SYSCALL(pipe)
 903:	b8 04 00 00 00       	mov    $0x4,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret

0000090b <read>:
SYSCALL(read)
 90b:	b8 05 00 00 00       	mov    $0x5,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret

00000913 <write>:
SYSCALL(write)
 913:	b8 10 00 00 00       	mov    $0x10,%eax
 918:	cd 40                	int    $0x40
 91a:	c3                   	ret

0000091b <close>:
SYSCALL(close)
 91b:	b8 15 00 00 00       	mov    $0x15,%eax
 920:	cd 40                	int    $0x40
 922:	c3                   	ret

00000923 <kill>:
SYSCALL(kill)
 923:	b8 06 00 00 00       	mov    $0x6,%eax
 928:	cd 40                	int    $0x40
 92a:	c3                   	ret

0000092b <exec>:
SYSCALL(exec)
 92b:	b8 07 00 00 00       	mov    $0x7,%eax
 930:	cd 40                	int    $0x40
 932:	c3                   	ret

00000933 <open>:
SYSCALL(open)
 933:	b8 0f 00 00 00       	mov    $0xf,%eax
 938:	cd 40                	int    $0x40
 93a:	c3                   	ret

0000093b <mknod>:
SYSCALL(mknod)
 93b:	b8 11 00 00 00       	mov    $0x11,%eax
 940:	cd 40                	int    $0x40
 942:	c3                   	ret

00000943 <unlink>:
SYSCALL(unlink)
 943:	b8 12 00 00 00       	mov    $0x12,%eax
 948:	cd 40                	int    $0x40
 94a:	c3                   	ret

0000094b <fstat>:
SYSCALL(fstat)
 94b:	b8 08 00 00 00       	mov    $0x8,%eax
 950:	cd 40                	int    $0x40
 952:	c3                   	ret

00000953 <link>:
SYSCALL(link)
 953:	b8 13 00 00 00       	mov    $0x13,%eax
 958:	cd 40                	int    $0x40
 95a:	c3                   	ret

0000095b <mkdir>:
SYSCALL(mkdir)
 95b:	b8 14 00 00 00       	mov    $0x14,%eax
 960:	cd 40                	int    $0x40
 962:	c3                   	ret

00000963 <chdir>:
SYSCALL(chdir)
 963:	b8 09 00 00 00       	mov    $0x9,%eax
 968:	cd 40                	int    $0x40
 96a:	c3                   	ret

0000096b <dup>:
SYSCALL(dup)
 96b:	b8 0a 00 00 00       	mov    $0xa,%eax
 970:	cd 40                	int    $0x40
 972:	c3                   	ret

00000973 <getpid>:
SYSCALL(getpid)
 973:	b8 0b 00 00 00       	mov    $0xb,%eax
 978:	cd 40                	int    $0x40
 97a:	c3                   	ret

0000097b <sbrk>:
SYSCALL(sbrk)
 97b:	b8 0c 00 00 00       	mov    $0xc,%eax
 980:	cd 40                	int    $0x40
 982:	c3                   	ret

00000983 <sleep>:
SYSCALL(sleep)
 983:	b8 0d 00 00 00       	mov    $0xd,%eax
 988:	cd 40                	int    $0x40
 98a:	c3                   	ret

0000098b <uptime>:
SYSCALL(uptime)
 98b:	b8 0e 00 00 00       	mov    $0xe,%eax
 990:	cd 40                	int    $0x40
 992:	c3                   	ret

00000993 <getproccount>:
SYSCALL(getproccount)
 993:	b8 16 00 00 00       	mov    $0x16,%eax
 998:	cd 40                	int    $0x40
 99a:	c3                   	ret

0000099b <reboot>:
SYSCALL(reboot)
 99b:	b8 17 00 00 00       	mov    $0x17,%eax
 9a0:	cd 40                	int    $0x40
 9a2:	c3                   	ret
 9a3:	66 90                	xchg   %ax,%ax
 9a5:	66 90                	xchg   %ax,%ax
 9a7:	66 90                	xchg   %ax,%ax
 9a9:	66 90                	xchg   %ax,%ax
 9ab:	66 90                	xchg   %ax,%ax
 9ad:	66 90                	xchg   %ax,%ax
 9af:	90                   	nop

000009b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 9b8:	89 d1                	mov    %edx,%ecx
{
 9ba:	83 ec 3c             	sub    $0x3c,%esp
 9bd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 9c0:	85 d2                	test   %edx,%edx
 9c2:	0f 89 80 00 00 00    	jns    a48 <printint+0x98>
 9c8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 9cc:	74 7a                	je     a48 <printint+0x98>
    x = -xx;
 9ce:	f7 d9                	neg    %ecx
    neg = 1;
 9d0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 9d5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 9d8:	31 f6                	xor    %esi,%esi
 9da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 9e0:	89 c8                	mov    %ecx,%eax
 9e2:	31 d2                	xor    %edx,%edx
 9e4:	89 f7                	mov    %esi,%edi
 9e6:	f7 f3                	div    %ebx
 9e8:	8d 76 01             	lea    0x1(%esi),%esi
 9eb:	0f b6 92 6c 0f 00 00 	movzbl 0xf6c(%edx),%edx
 9f2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 9f6:	89 ca                	mov    %ecx,%edx
 9f8:	89 c1                	mov    %eax,%ecx
 9fa:	39 da                	cmp    %ebx,%edx
 9fc:	73 e2                	jae    9e0 <printint+0x30>
  if(neg)
 9fe:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 a01:	85 c0                	test   %eax,%eax
 a03:	74 07                	je     a0c <printint+0x5c>
    buf[i++] = '-';
 a05:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 a0a:	89 f7                	mov    %esi,%edi
 a0c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 a0f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 a12:	01 df                	add    %ebx,%edi
 a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 a18:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 a1b:	83 ec 04             	sub    $0x4,%esp
 a1e:	88 45 d7             	mov    %al,-0x29(%ebp)
 a21:	8d 45 d7             	lea    -0x29(%ebp),%eax
 a24:	6a 01                	push   $0x1
 a26:	50                   	push   %eax
 a27:	56                   	push   %esi
 a28:	e8 e6 fe ff ff       	call   913 <write>
  while(--i >= 0)
 a2d:	89 f8                	mov    %edi,%eax
 a2f:	83 c4 10             	add    $0x10,%esp
 a32:	83 ef 01             	sub    $0x1,%edi
 a35:	39 c3                	cmp    %eax,%ebx
 a37:	75 df                	jne    a18 <printint+0x68>
}
 a39:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a3c:	5b                   	pop    %ebx
 a3d:	5e                   	pop    %esi
 a3e:	5f                   	pop    %edi
 a3f:	5d                   	pop    %ebp
 a40:	c3                   	ret
 a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 a48:	31 c0                	xor    %eax,%eax
 a4a:	eb 89                	jmp    9d5 <printint+0x25>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a59:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 a5c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 a5f:	0f b6 1e             	movzbl (%esi),%ebx
 a62:	83 c6 01             	add    $0x1,%esi
 a65:	84 db                	test   %bl,%bl
 a67:	74 67                	je     ad0 <printf+0x80>
 a69:	8d 4d 10             	lea    0x10(%ebp),%ecx
 a6c:	31 d2                	xor    %edx,%edx
 a6e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 a71:	eb 34                	jmp    aa7 <printf+0x57>
 a73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 a78:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a7b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 a80:	83 f8 25             	cmp    $0x25,%eax
 a83:	74 18                	je     a9d <printf+0x4d>
  write(fd, &c, 1);
 a85:	83 ec 04             	sub    $0x4,%esp
 a88:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a8b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 a8e:	6a 01                	push   $0x1
 a90:	50                   	push   %eax
 a91:	57                   	push   %edi
 a92:	e8 7c fe ff ff       	call   913 <write>
 a97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 a9a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a9d:	0f b6 1e             	movzbl (%esi),%ebx
 aa0:	83 c6 01             	add    $0x1,%esi
 aa3:	84 db                	test   %bl,%bl
 aa5:	74 29                	je     ad0 <printf+0x80>
    c = fmt[i] & 0xff;
 aa7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 aaa:	85 d2                	test   %edx,%edx
 aac:	74 ca                	je     a78 <printf+0x28>
      }
    } else if(state == '%'){
 aae:	83 fa 25             	cmp    $0x25,%edx
 ab1:	75 ea                	jne    a9d <printf+0x4d>
      if(c == 'd'){
 ab3:	83 f8 25             	cmp    $0x25,%eax
 ab6:	0f 84 04 01 00 00    	je     bc0 <printf+0x170>
 abc:	83 e8 63             	sub    $0x63,%eax
 abf:	83 f8 15             	cmp    $0x15,%eax
 ac2:	77 1c                	ja     ae0 <printf+0x90>
 ac4:	ff 24 85 14 0f 00 00 	jmp    *0xf14(,%eax,4)
 acb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ad3:	5b                   	pop    %ebx
 ad4:	5e                   	pop    %esi
 ad5:	5f                   	pop    %edi
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret
 ad8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 adf:	00 
  write(fd, &c, 1);
 ae0:	83 ec 04             	sub    $0x4,%esp
 ae3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 ae6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 aea:	6a 01                	push   $0x1
 aec:	52                   	push   %edx
 aed:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 af0:	57                   	push   %edi
 af1:	e8 1d fe ff ff       	call   913 <write>
 af6:	83 c4 0c             	add    $0xc,%esp
 af9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 afc:	6a 01                	push   $0x1
 afe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 b01:	52                   	push   %edx
 b02:	57                   	push   %edi
 b03:	e8 0b fe ff ff       	call   913 <write>
        putc(fd, c);
 b08:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b0b:	31 d2                	xor    %edx,%edx
 b0d:	eb 8e                	jmp    a9d <printf+0x4d>
 b0f:	90                   	nop
        printint(fd, *ap, 16, 0);
 b10:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 b13:	83 ec 0c             	sub    $0xc,%esp
 b16:	b9 10 00 00 00       	mov    $0x10,%ecx
 b1b:	8b 13                	mov    (%ebx),%edx
 b1d:	6a 00                	push   $0x0
 b1f:	89 f8                	mov    %edi,%eax
        ap++;
 b21:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 b24:	e8 87 fe ff ff       	call   9b0 <printint>
        ap++;
 b29:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 b2c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b2f:	31 d2                	xor    %edx,%edx
 b31:	e9 67 ff ff ff       	jmp    a9d <printf+0x4d>
        s = (char*)*ap;
 b36:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b39:	8b 18                	mov    (%eax),%ebx
        ap++;
 b3b:	83 c0 04             	add    $0x4,%eax
 b3e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 b41:	85 db                	test   %ebx,%ebx
 b43:	0f 84 87 00 00 00    	je     bd0 <printf+0x180>
        while(*s != 0){
 b49:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 b4c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 b4e:	84 c0                	test   %al,%al
 b50:	0f 84 47 ff ff ff    	je     a9d <printf+0x4d>
 b56:	8d 55 e7             	lea    -0x19(%ebp),%edx
 b59:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 b5c:	89 de                	mov    %ebx,%esi
 b5e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 b60:	83 ec 04             	sub    $0x4,%esp
 b63:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 b66:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 b69:	6a 01                	push   $0x1
 b6b:	53                   	push   %ebx
 b6c:	57                   	push   %edi
 b6d:	e8 a1 fd ff ff       	call   913 <write>
        while(*s != 0){
 b72:	0f b6 06             	movzbl (%esi),%eax
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	84 c0                	test   %al,%al
 b7a:	75 e4                	jne    b60 <printf+0x110>
      state = 0;
 b7c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 b7f:	31 d2                	xor    %edx,%edx
 b81:	e9 17 ff ff ff       	jmp    a9d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 b86:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 b89:	83 ec 0c             	sub    $0xc,%esp
 b8c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b91:	8b 13                	mov    (%ebx),%edx
 b93:	6a 01                	push   $0x1
 b95:	eb 88                	jmp    b1f <printf+0xcf>
        putc(fd, *ap);
 b97:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 b9a:	83 ec 04             	sub    $0x4,%esp
 b9d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 ba0:	8b 03                	mov    (%ebx),%eax
        ap++;
 ba2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 ba5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ba8:	6a 01                	push   $0x1
 baa:	52                   	push   %edx
 bab:	57                   	push   %edi
 bac:	e8 62 fd ff ff       	call   913 <write>
        ap++;
 bb1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 bb4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bb7:	31 d2                	xor    %edx,%edx
 bb9:	e9 df fe ff ff       	jmp    a9d <printf+0x4d>
 bbe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 bc0:	83 ec 04             	sub    $0x4,%esp
 bc3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 bc6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 bc9:	6a 01                	push   $0x1
 bcb:	e9 31 ff ff ff       	jmp    b01 <printf+0xb1>
 bd0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 bd5:	bb c2 0d 00 00       	mov    $0xdc2,%ebx
 bda:	e9 77 ff ff ff       	jmp    b56 <printf+0x106>
 bdf:	90                   	nop

00000be0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be1:	a1 60 1e 00 00       	mov    0x1e60,%eax
{
 be6:	89 e5                	mov    %esp,%ebp
 be8:	57                   	push   %edi
 be9:	56                   	push   %esi
 bea:	53                   	push   %ebx
 beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 bee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bf8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bfa:	39 c8                	cmp    %ecx,%eax
 bfc:	73 32                	jae    c30 <free+0x50>
 bfe:	39 d1                	cmp    %edx,%ecx
 c00:	72 04                	jb     c06 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c02:	39 d0                	cmp    %edx,%eax
 c04:	72 32                	jb     c38 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c06:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c09:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c0c:	39 fa                	cmp    %edi,%edx
 c0e:	74 30                	je     c40 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 c10:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 c13:	8b 50 04             	mov    0x4(%eax),%edx
 c16:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c19:	39 f1                	cmp    %esi,%ecx
 c1b:	74 3a                	je     c57 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 c1d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 c1f:	5b                   	pop    %ebx
  freep = p;
 c20:	a3 60 1e 00 00       	mov    %eax,0x1e60
}
 c25:	5e                   	pop    %esi
 c26:	5f                   	pop    %edi
 c27:	5d                   	pop    %ebp
 c28:	c3                   	ret
 c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c30:	39 d0                	cmp    %edx,%eax
 c32:	72 04                	jb     c38 <free+0x58>
 c34:	39 d1                	cmp    %edx,%ecx
 c36:	72 ce                	jb     c06 <free+0x26>
{
 c38:	89 d0                	mov    %edx,%eax
 c3a:	eb bc                	jmp    bf8 <free+0x18>
 c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 c40:	03 72 04             	add    0x4(%edx),%esi
 c43:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c46:	8b 10                	mov    (%eax),%edx
 c48:	8b 12                	mov    (%edx),%edx
 c4a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 c4d:	8b 50 04             	mov    0x4(%eax),%edx
 c50:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c53:	39 f1                	cmp    %esi,%ecx
 c55:	75 c6                	jne    c1d <free+0x3d>
    p->s.size += bp->s.size;
 c57:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 c5a:	a3 60 1e 00 00       	mov    %eax,0x1e60
    p->s.size += bp->s.size;
 c5f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 c62:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c65:	89 08                	mov    %ecx,(%eax)
}
 c67:	5b                   	pop    %ebx
 c68:	5e                   	pop    %esi
 c69:	5f                   	pop    %edi
 c6a:	5d                   	pop    %ebp
 c6b:	c3                   	ret
 c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c70:	55                   	push   %ebp
 c71:	89 e5                	mov    %esp,%ebp
 c73:	57                   	push   %edi
 c74:	56                   	push   %esi
 c75:	53                   	push   %ebx
 c76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c7c:	8b 15 60 1e 00 00    	mov    0x1e60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c82:	8d 78 07             	lea    0x7(%eax),%edi
 c85:	c1 ef 03             	shr    $0x3,%edi
 c88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 c8b:	85 d2                	test   %edx,%edx
 c8d:	0f 84 8d 00 00 00    	je     d20 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c93:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c95:	8b 48 04             	mov    0x4(%eax),%ecx
 c98:	39 f9                	cmp    %edi,%ecx
 c9a:	73 64                	jae    d00 <malloc+0x90>
  if(nu < 4096)
 c9c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ca1:	39 df                	cmp    %ebx,%edi
 ca3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 ca6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 cad:	eb 0a                	jmp    cb9 <malloc+0x49>
 caf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cb2:	8b 48 04             	mov    0x4(%eax),%ecx
 cb5:	39 f9                	cmp    %edi,%ecx
 cb7:	73 47                	jae    d00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cb9:	89 c2                	mov    %eax,%edx
 cbb:	3b 05 60 1e 00 00    	cmp    0x1e60,%eax
 cc1:	75 ed                	jne    cb0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 cc3:	83 ec 0c             	sub    $0xc,%esp
 cc6:	56                   	push   %esi
 cc7:	e8 af fc ff ff       	call   97b <sbrk>
  if(p == (char*)-1)
 ccc:	83 c4 10             	add    $0x10,%esp
 ccf:	83 f8 ff             	cmp    $0xffffffff,%eax
 cd2:	74 1c                	je     cf0 <malloc+0x80>
  hp->s.size = nu;
 cd4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 cd7:	83 ec 0c             	sub    $0xc,%esp
 cda:	83 c0 08             	add    $0x8,%eax
 cdd:	50                   	push   %eax
 cde:	e8 fd fe ff ff       	call   be0 <free>
  return freep;
 ce3:	8b 15 60 1e 00 00    	mov    0x1e60,%edx
      if((p = morecore(nunits)) == 0)
 ce9:	83 c4 10             	add    $0x10,%esp
 cec:	85 d2                	test   %edx,%edx
 cee:	75 c0                	jne    cb0 <malloc+0x40>
        return 0;
  }
}
 cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 cf3:	31 c0                	xor    %eax,%eax
}
 cf5:	5b                   	pop    %ebx
 cf6:	5e                   	pop    %esi
 cf7:	5f                   	pop    %edi
 cf8:	5d                   	pop    %ebp
 cf9:	c3                   	ret
 cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d00:	39 cf                	cmp    %ecx,%edi
 d02:	74 4c                	je     d50 <malloc+0xe0>
        p->s.size -= nunits;
 d04:	29 f9                	sub    %edi,%ecx
 d06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d0c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 d0f:	89 15 60 1e 00 00    	mov    %edx,0x1e60
}
 d15:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 d18:	83 c0 08             	add    $0x8,%eax
}
 d1b:	5b                   	pop    %ebx
 d1c:	5e                   	pop    %esi
 d1d:	5f                   	pop    %edi
 d1e:	5d                   	pop    %ebp
 d1f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 d20:	c7 05 60 1e 00 00 64 	movl   $0x1e64,0x1e60
 d27:	1e 00 00 
    base.s.size = 0;
 d2a:	b8 64 1e 00 00       	mov    $0x1e64,%eax
    base.s.ptr = freep = prevp = &base;
 d2f:	c7 05 64 1e 00 00 64 	movl   $0x1e64,0x1e64
 d36:	1e 00 00 
    base.s.size = 0;
 d39:	c7 05 68 1e 00 00 00 	movl   $0x0,0x1e68
 d40:	00 00 00 
    if(p->s.size >= nunits){
 d43:	e9 54 ff ff ff       	jmp    c9c <malloc+0x2c>
 d48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 d4f:	00 
        prevp->s.ptr = p->s.ptr;
 d50:	8b 08                	mov    (%eax),%ecx
 d52:	89 0a                	mov    %ecx,(%edx)
 d54:	eb b9                	jmp    d0f <malloc+0x9f>
