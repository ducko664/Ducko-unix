
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc f0 70 11 80       	mov    $0x801170f0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 50 30 10 80       	mov    $0x80103050,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 72 10 80       	push   $0x80107240
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 c5 43 00 00       	call   80104420 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
8010006a:	ec 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
80100074:	ec 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 72 10 80       	push   $0x80107247
80100097:	50                   	push   %eax
80100098:	e8 53 42 00 00       	call   801042f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 a5 10 80       	push   $0x8010a520
801000e4:	e8 27 45 00 00       	call   80104610 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100126:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 a5 10 80       	push   $0x8010a520
80100162:	e8 49 44 00 00       	call   801045b0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 41 00 00       	call   80104330 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 2f 21 00 00       	call   801022c0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 4e 72 10 80       	push   $0x8010724e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 0d 42 00 00       	call   801043d0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 e7 20 00 00       	jmp    801022c0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 72 10 80       	push   $0x8010725f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 41 00 00       	call   801043d0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 7c 41 00 00       	call   80104390 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 f0 43 00 00       	call   80104610 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 42 43 00 00       	jmp    801045b0 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 66 72 10 80       	push   $0x80107266
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 d7 15 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002a0:	e8 6b 43 00 00       	call   80104610 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002b5:	39 05 04 ef 10 80    	cmp    %eax,0x8010ef04
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ef 10 80       	push   $0x8010ef20
801002c8:	68 00 ef 10 80       	push   $0x8010ef00
801002cd:	e8 6e 3d 00 00       	call   80104040 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 99 36 00 00       	call   80103980 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ef 10 80       	push   $0x8010ef20
801002f6:	e8 b5 42 00 00       	call   801045b0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 8c 14 00 00       	call   80101790 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ef 10 80       	push   $0x8010ef20
8010034c:	e8 5f 42 00 00       	call   801045b0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 36 14 00 00       	call   80101790 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 22 25 00 00       	call   801028c0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 6d 72 10 80       	push   $0x8010726d
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 0b 77 10 80 	movl   $0x8010770b,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 73 40 00 00       	call   80104440 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 81 72 10 80       	push   $0x80107281
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 6c 59 00 00       	call   80105d90 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004c8:	0f b6 db             	movzbl %bl,%ebx
801004cb:	8d 70 01             	lea    0x1(%eax),%esi
801004ce:	80 cf 07             	or     $0x7,%bh
801004d1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004d8:	80 
801004d9:	eb 8a                	jmp    80100465 <consputc.part.0+0x65>
801004db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 a1 58 00 00       	call   80105d90 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 95 58 00 00       	call   80105d90 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 89 58 00 00       	call   80105d90 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 3a 42 00 00       	call   801047a0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 95 41 00 00       	call   80104710 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058d:	00 
8010058e:	66 90                	xchg   %ax,%ax
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 85 72 10 80       	push   $0x80107285
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 ac 12 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801005cb:	e8 40 40 00 00       	call   80104610 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 fb                	cmp    %edi,%ebx
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 ef 10 80       	push   $0x8010ef20
80100604:	e8 a7 3f 00 00       	call   801045b0 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 7e 11 00 00       	call   80101790 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	89 d3                	mov    %edx,%ebx
80100628:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062b:	85 c0                	test   %eax,%eax
8010062d:	79 05                	jns    80100634 <printint+0x14>
8010062f:	83 e1 01             	and    $0x1,%ecx
80100632:	75 64                	jne    80100698 <printint+0x78>
    x = xx;
80100634:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010063b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010063d:	31 f6                	xor    %esi,%esi
8010063f:	90                   	nop
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 5c 77 10 80 	movzbl -0x7fef88a4(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80100661:	85 c9                	test   %ecx,%ecx
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 11                	je     801006a5 <printint+0x85>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
    x = -xx;
80100698:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010069a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006a1:	89 c1                	mov    %eax,%ecx
801006a3:	eb 98                	jmp    8010063d <printint+0x1d>
}
801006a5:	83 c4 2c             	add    $0x2c,%esp
801006a8:	5b                   	pop    %ebx
801006a9:	5e                   	pop    %esi
801006aa:	5f                   	pop    %edi
801006ab:	5d                   	pop    %ebp
801006ac:	c3                   	ret
801006ad:	8d 76 00             	lea    0x0(%esi),%esi

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 ef 10 80    	mov    0x8010ef54,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 06 01 00 00    	jne    801007d0 <cprintf+0x120>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 b7 01 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 5f                	je     80100738 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	75 58                	jne    80100740 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006e8:	83 c3 01             	add    $0x1,%ebx
801006eb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006ef:	85 c9                	test   %ecx,%ecx
801006f1:	74 3a                	je     8010072d <cprintf+0x7d>
    switch(c){
801006f3:	83 f9 70             	cmp    $0x70,%ecx
801006f6:	0f 84 b4 00 00 00    	je     801007b0 <cprintf+0x100>
801006fc:	7f 72                	jg     80100770 <cprintf+0xc0>
801006fe:	83 f9 25             	cmp    $0x25,%ecx
80100701:	74 4d                	je     80100750 <cprintf+0xa0>
80100703:	83 f9 64             	cmp    $0x64,%ecx
80100706:	75 76                	jne    8010077e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100708:	8d 47 04             	lea    0x4(%edi),%eax
8010070b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100710:	ba 0a 00 00 00       	mov    $0xa,%edx
80100715:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100718:	8b 07                	mov    (%edi),%eax
8010071a:	e8 01 ff ff ff       	call   80100620 <printint>
8010071f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100722:	83 c3 01             	add    $0x1,%ebx
80100725:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 b6                	jne    801006e3 <cprintf+0x33>
8010072d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100730:	85 ff                	test   %edi,%edi
80100732:	0f 85 bb 00 00 00    	jne    801007f3 <cprintf+0x143>
}
80100738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073b:	5b                   	pop    %ebx
8010073c:	5e                   	pop    %esi
8010073d:	5f                   	pop    %edi
8010073e:	5d                   	pop    %ebp
8010073f:	c3                   	ret
  if(panicked){
80100740:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100746:	85 c9                	test   %ecx,%ecx
80100748:	74 19                	je     80100763 <cprintf+0xb3>
8010074a:	fa                   	cli
    for(;;)
8010074b:	eb fe                	jmp    8010074b <cprintf+0x9b>
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100750:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100756:	85 c9                	test   %ecx,%ecx
80100758:	0f 85 f2 00 00 00    	jne    80100850 <cprintf+0x1a0>
8010075e:	b8 25 00 00 00       	mov    $0x25,%eax
80100763:	e8 98 fc ff ff       	call   80100400 <consputc.part.0>
      break;
80100768:	eb b8                	jmp    80100722 <cprintf+0x72>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100770:	83 f9 73             	cmp    $0x73,%ecx
80100773:	0f 84 8f 00 00 00    	je     80100808 <cprintf+0x158>
80100779:	83 f9 78             	cmp    $0x78,%ecx
8010077c:	74 32                	je     801007b0 <cprintf+0x100>
  if(panicked){
8010077e:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100784:	85 d2                	test   %edx,%edx
80100786:	0f 85 b8 00 00 00    	jne    80100844 <cprintf+0x194>
8010078c:	b8 25 00 00 00       	mov    $0x25,%eax
80100791:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100794:	e8 67 fc ff ff       	call   80100400 <consputc.part.0>
80100799:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
8010079e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 84 cd 00 00 00    	je     80100876 <cprintf+0x1c6>
801007a9:	fa                   	cli
    for(;;)
801007aa:	eb fe                	jmp    801007aa <cprintf+0xfa>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007b0:	8d 47 04             	lea    0x4(%edi),%eax
801007b3:	31 c9                	xor    %ecx,%ecx
801007b5:	ba 10 00 00 00       	mov    $0x10,%edx
801007ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007bd:	8b 07                	mov    (%edi),%eax
801007bf:	e8 5c fe ff ff       	call   80100620 <printint>
801007c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007c7:	e9 56 ff ff ff       	jmp    80100722 <cprintf+0x72>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ef 10 80       	push   $0x8010ef20
801007d8:	e8 33 3e 00 00       	call   80104610 <acquire>
  if (fmt == 0)
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	85 f6                	test   %esi,%esi
801007e2:	0f 84 a1 00 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e8:	0f b6 06             	movzbl (%esi),%eax
801007eb:	85 c0                	test   %eax,%eax
801007ed:	0f 85 e6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 20 ef 10 80       	push   $0x8010ef20
801007fb:	e8 b0 3d 00 00       	call   801045b0 <release>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	e9 30 ff ff ff       	jmp    80100738 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100808:	8b 17                	mov    (%edi),%edx
8010080a:	8d 47 04             	lea    0x4(%edi),%eax
8010080d:	85 d2                	test   %edx,%edx
8010080f:	74 27                	je     80100838 <cprintf+0x188>
      for(; *s; s++)
80100811:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100814:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100816:	84 c9                	test   %cl,%cl
80100818:	74 68                	je     80100882 <cprintf+0x1d2>
8010081a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010081d:	89 fb                	mov    %edi,%ebx
8010081f:	89 f7                	mov    %esi,%edi
80100821:	89 c6                	mov    %eax,%esi
80100823:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100826:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010082c:	85 d2                	test   %edx,%edx
8010082e:	74 28                	je     80100858 <cprintf+0x1a8>
80100830:	fa                   	cli
    for(;;)
80100831:	eb fe                	jmp    80100831 <cprintf+0x181>
80100833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100838:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010083d:	bf 98 72 10 80       	mov    $0x80107298,%edi
80100842:	eb d6                	jmp    8010081a <cprintf+0x16a>
80100844:	fa                   	cli
    for(;;)
80100845:	eb fe                	jmp    80100845 <cprintf+0x195>
80100847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010084e:	00 
8010084f:	90                   	nop
80100850:	fa                   	cli
80100851:	eb fe                	jmp    80100851 <cprintf+0x1a1>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	e8 a3 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
8010085d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100861:	83 c3 01             	add    $0x1,%ebx
80100864:	84 c0                	test   %al,%al
80100866:	75 be                	jne    80100826 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100868:	89 f0                	mov    %esi,%eax
8010086a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010086d:	89 fe                	mov    %edi,%esi
8010086f:	89 c7                	mov    %eax,%edi
80100871:	e9 ac fe ff ff       	jmp    80100722 <cprintf+0x72>
80100876:	89 c8                	mov    %ecx,%eax
80100878:	e8 83 fb ff ff       	call   80100400 <consputc.part.0>
      break;
8010087d:	e9 a0 fe ff ff       	jmp    80100722 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
80100882:	89 c7                	mov    %eax,%edi
80100884:	e9 99 fe ff ff       	jmp    80100722 <cprintf+0x72>
    panic("null fmt");
80100889:	83 ec 0c             	sub    $0xc,%esp
8010088c:	68 9f 72 10 80       	push   $0x8010729f
80100891:	e8 ea fa ff ff       	call   80100380 <panic>
80100896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089d:	00 
8010089e:	66 90                	xchg   %ax,%ax

801008a0 <consoleintr>:
{
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	57                   	push   %edi
  int c, doprocdump = 0;
801008a4:	31 ff                	xor    %edi,%edi
{
801008a6:	56                   	push   %esi
801008a7:	53                   	push   %ebx
801008a8:	83 ec 18             	sub    $0x18,%esp
801008ab:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ae:	68 20 ef 10 80       	push   $0x8010ef20
801008b3:	e8 58 3d 00 00       	call   80104610 <acquire>
  while((c = getc()) >= 0){
801008b8:	83 c4 10             	add    $0x10,%esp
801008bb:	ff d6                	call   *%esi
801008bd:	89 c3                	mov    %eax,%ebx
801008bf:	85 c0                	test   %eax,%eax
801008c1:	78 22                	js     801008e5 <consoleintr+0x45>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 47                	je     8010090f <consoleintr+0x6f>
801008c8:	7f 76                	jg     80100940 <consoleintr+0xa0>
801008ca:	83 fb 08             	cmp    $0x8,%ebx
801008cd:	74 76                	je     80100945 <consoleintr+0xa5>
801008cf:	83 fb 10             	cmp    $0x10,%ebx
801008d2:	0f 85 f8 00 00 00    	jne    801009d0 <consoleintr+0x130>
  while((c = getc()) >= 0){
801008d8:	ff d6                	call   *%esi
    switch(c){
801008da:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008df:	89 c3                	mov    %eax,%ebx
801008e1:	85 c0                	test   %eax,%eax
801008e3:	79 de                	jns    801008c3 <consoleintr+0x23>
  release(&cons.lock);
801008e5:	83 ec 0c             	sub    $0xc,%esp
801008e8:	68 20 ef 10 80       	push   $0x8010ef20
801008ed:	e8 be 3c 00 00       	call   801045b0 <release>
  if(doprocdump) {
801008f2:	83 c4 10             	add    $0x10,%esp
801008f5:	85 ff                	test   %edi,%edi
801008f7:	0f 85 4b 01 00 00    	jne    80100a48 <consoleintr+0x1a8>
}
801008fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100900:	5b                   	pop    %ebx
80100901:	5e                   	pop    %esi
80100902:	5f                   	pop    %edi
80100903:	5d                   	pop    %ebp
80100904:	c3                   	ret
80100905:	b8 00 01 00 00       	mov    $0x100,%eax
8010090a:	e8 f1 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010090f:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100914:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
8010091a:	74 9f                	je     801008bb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010091c:	83 e8 01             	sub    $0x1,%eax
8010091f:	89 c2                	mov    %eax,%edx
80100921:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100924:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
8010092b:	74 8e                	je     801008bb <consoleintr+0x1b>
  if(panicked){
8010092d:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.e--;
80100933:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100938:	85 d2                	test   %edx,%edx
8010093a:	74 c9                	je     80100905 <consoleintr+0x65>
8010093c:	fa                   	cli
    for(;;)
8010093d:	eb fe                	jmp    8010093d <consoleintr+0x9d>
8010093f:	90                   	nop
    switch(c){
80100940:	83 fb 7f             	cmp    $0x7f,%ebx
80100943:	75 2b                	jne    80100970 <consoleintr+0xd0>
      if(input.e != input.w){
80100945:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010094a:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100950:	0f 84 65 ff ff ff    	je     801008bb <consoleintr+0x1b>
        input.e--;
80100956:	83 e8 01             	sub    $0x1,%eax
80100959:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
8010095e:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100963:	85 c0                	test   %eax,%eax
80100965:	0f 84 ce 00 00 00    	je     80100a39 <consoleintr+0x199>
8010096b:	fa                   	cli
    for(;;)
8010096c:	eb fe                	jmp    8010096c <consoleintr+0xcc>
8010096e:	66 90                	xchg   %ax,%ax
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100970:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100975:	89 c2                	mov    %eax,%edx
80100977:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
8010097d:	83 fa 7f             	cmp    $0x7f,%edx
80100980:	0f 87 35 ff ff ff    	ja     801008bb <consoleintr+0x1b>
  if(panicked){
80100986:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010098c:	8d 50 01             	lea    0x1(%eax),%edx
8010098f:	83 e0 7f             	and    $0x7f,%eax
80100992:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
80100998:	88 98 80 ee 10 80    	mov    %bl,-0x7fef1180(%eax)
  if(panicked){
8010099e:	85 c9                	test   %ecx,%ecx
801009a0:	0f 85 ae 00 00 00    	jne    80100a54 <consoleintr+0x1b4>
801009a6:	89 d8                	mov    %ebx,%eax
801009a8:	e8 53 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009ad:	83 fb 0a             	cmp    $0xa,%ebx
801009b0:	74 68                	je     80100a1a <consoleintr+0x17a>
801009b2:	83 fb 04             	cmp    $0x4,%ebx
801009b5:	74 63                	je     80100a1a <consoleintr+0x17a>
801009b7:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801009bc:	83 e8 80             	sub    $0xffffff80,%eax
801009bf:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
801009c5:	0f 85 f0 fe ff ff    	jne    801008bb <consoleintr+0x1b>
801009cb:	eb 52                	jmp    80100a1f <consoleintr+0x17f>
801009cd:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009d0:	85 db                	test   %ebx,%ebx
801009d2:	0f 84 e3 fe ff ff    	je     801008bb <consoleintr+0x1b>
801009d8:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801009dd:	89 c2                	mov    %eax,%edx
801009df:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
801009e5:	83 fa 7f             	cmp    $0x7f,%edx
801009e8:	0f 87 cd fe ff ff    	ja     801008bb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ee:	8d 50 01             	lea    0x1(%eax),%edx
  if(panicked){
801009f1:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
801009f7:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801009fa:	83 fb 0d             	cmp    $0xd,%ebx
801009fd:	75 93                	jne    80100992 <consoleintr+0xf2>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ff:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
80100a05:	c6 80 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%eax)
  if(panicked){
80100a0c:	85 c9                	test   %ecx,%ecx
80100a0e:	75 44                	jne    80100a54 <consoleintr+0x1b4>
80100a10:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a15:	e8 e6 f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a1a:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
          wakeup(&input.r);
80100a1f:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a22:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
          wakeup(&input.r);
80100a27:	68 00 ef 10 80       	push   $0x8010ef00
80100a2c:	e8 cf 36 00 00       	call   80104100 <wakeup>
80100a31:	83 c4 10             	add    $0x10,%esp
80100a34:	e9 82 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
80100a39:	b8 00 01 00 00       	mov    $0x100,%eax
80100a3e:	e8 bd f9 ff ff       	call   80100400 <consputc.part.0>
80100a43:	e9 73 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
}
80100a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4b:	5b                   	pop    %ebx
80100a4c:	5e                   	pop    %esi
80100a4d:	5f                   	pop    %edi
80100a4e:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a4f:	e9 8c 37 00 00       	jmp    801041e0 <procdump>
80100a54:	fa                   	cli
    for(;;)
80100a55:	eb fe                	jmp    80100a55 <consoleintr+0x1b5>
80100a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a5e:	00 
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 a8 72 10 80       	push   $0x801072a8
80100a6b:	68 20 ef 10 80       	push   $0x8010ef20
80100a70:	e8 ab 39 00 00       	call   80104420 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c f9 10 80 b0 	movl   $0x801005b0,0x8010f90c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 f9 10 80 80 	movl   $0x80100280,0x8010f908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 b2 19 00 00       	call   80102450 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave
80100aa2:	c3                   	ret
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 bf 2e 00 00       	call   80103980 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 64 22 00 00       	call   80102d30 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 99 15 00 00       	call   80102070 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 30 03 00 00    	je     80100e12 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c7                	mov    %eax,%edi
80100ae7:	50                   	push   %eax
80100ae8:	e8 a3 0c 00 00       	call   80101790 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	57                   	push   %edi
80100af9:	e8 a2 0f 00 00       	call   80101aa0 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	0f 85 01 01 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b0a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b11:	45 4c 46 
80100b14:	0f 85 f1 00 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b1a:	e8 e1 63 00 00       	call   80106f00 <setupkvm>
80100b1f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b25:	85 c0                	test   %eax,%eax
80100b27:	0f 84 de 00 00 00    	je     80100c0b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b34:	00 
80100b35:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b3b:	0f 84 a1 02 00 00    	je     80100de2 <exec+0x332>
  sz = 0;
80100b41:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b48:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b4b:	31 db                	xor    %ebx,%ebx
80100b4d:	e9 8c 00 00 00       	jmp    80100bde <exec+0x12e>
80100b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b58:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b5f:	75 6c                	jne    80100bcd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100b61:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b67:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b6d:	0f 82 87 00 00 00    	jb     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b73:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b79:	72 7f                	jb     80100bfa <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b7b:	83 ec 04             	sub    $0x4,%esp
80100b7e:	50                   	push   %eax
80100b7f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b85:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100b8b:	e8 a0 61 00 00       	call   80106d30 <allocuvm>
80100b90:	83 c4 10             	add    $0x10,%esp
80100b93:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b99:	85 c0                	test   %eax,%eax
80100b9b:	74 5d                	je     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b9d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ba3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ba8:	75 50                	jne    80100bfa <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100baa:	83 ec 0c             	sub    $0xc,%esp
80100bad:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bb3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bb9:	57                   	push   %edi
80100bba:	50                   	push   %eax
80100bbb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bc1:	e8 9a 60 00 00       	call   80106c60 <loaduvm>
80100bc6:	83 c4 20             	add    $0x20,%esp
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	78 2d                	js     80100bfa <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bcd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bd4:	83 c3 01             	add    $0x1,%ebx
80100bd7:	83 c6 20             	add    $0x20,%esi
80100bda:	39 d8                	cmp    %ebx,%eax
80100bdc:	7e 52                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bde:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100be4:	6a 20                	push   $0x20
80100be6:	56                   	push   %esi
80100be7:	50                   	push   %eax
80100be8:	57                   	push   %edi
80100be9:	e8 b2 0e 00 00       	call   80101aa0 <readi>
80100bee:	83 c4 10             	add    $0x10,%esp
80100bf1:	83 f8 20             	cmp    $0x20,%eax
80100bf4:	0f 84 5e ff ff ff    	je     80100b58 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100bfa:	83 ec 0c             	sub    $0xc,%esp
80100bfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c03:	e8 78 62 00 00       	call   80106e80 <freevm>
  if(ip){
80100c08:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c0b:	83 ec 0c             	sub    $0xc,%esp
80100c0e:	57                   	push   %edi
80100c0f:	e8 0c 0e 00 00       	call   80101a20 <iunlockput>
    end_op();
80100c14:	e8 87 21 00 00       	call   80102da0 <end_op>
80100c19:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c24:	5b                   	pop    %ebx
80100c25:	5e                   	pop    %esi
80100c26:	5f                   	pop    %edi
80100c27:	5d                   	pop    %ebp
80100c28:	c3                   	ret
80100c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c30:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c36:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c3c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	57                   	push   %edi
80100c4c:	e8 cf 0d 00 00       	call   80101a20 <iunlockput>
  end_op();
80100c51:	e8 4a 21 00 00       	call   80102da0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	53                   	push   %ebx
80100c5a:	56                   	push   %esi
80100c5b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c61:	56                   	push   %esi
80100c62:	e8 c9 60 00 00       	call   80106d30 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c7                	mov    %eax,%edi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 86 00 00 00    	je     80100cfa <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100c7d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 18 63 00 00       	call   80106fa0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8b 10                	mov    (%eax),%edx
80100c90:	85 d2                	test   %edx,%edx
80100c92:	0f 84 56 01 00 00    	je     80100dee <exec+0x33e>
80100c98:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100c9e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100ca1:	eb 23                	jmp    80100cc6 <exec+0x216>
80100ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ca8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100cab:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100cb2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100cbb:	85 d2                	test   %edx,%edx
80100cbd:	74 51                	je     80100d10 <exec+0x260>
    if(argc >= MAXARG)
80100cbf:	83 f8 20             	cmp    $0x20,%eax
80100cc2:	74 36                	je     80100cfa <exec+0x24a>
80100cc4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cc6:	83 ec 0c             	sub    $0xc,%esp
80100cc9:	52                   	push   %edx
80100cca:	e8 31 3c 00 00       	call   80104900 <strlen>
80100ccf:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cd1:	58                   	pop    %eax
80100cd2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cd5:	83 eb 01             	sub    $0x1,%ebx
80100cd8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cdb:	e8 20 3c 00 00       	call   80104900 <strlen>
80100ce0:	83 c0 01             	add    $0x1,%eax
80100ce3:	50                   	push   %eax
80100ce4:	ff 34 b7             	push   (%edi,%esi,4)
80100ce7:	53                   	push   %ebx
80100ce8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cee:	e8 7d 64 00 00       	call   80107170 <copyout>
80100cf3:	83 c4 20             	add    $0x20,%esp
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	79 ae                	jns    80100ca8 <exec+0x1f8>
    freevm(pgdir);
80100cfa:	83 ec 0c             	sub    $0xc,%esp
80100cfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d03:	e8 78 61 00 00       	call   80106e80 <freevm>
80100d08:	83 c4 10             	add    $0x10,%esp
80100d0b:	e9 0c ff ff ff       	jmp    80100c1c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d10:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d17:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d1d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d23:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d26:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d29:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d30:	00 00 00 00 
  ustack[1] = argc;
80100d34:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d3a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d41:	ff ff ff 
  ustack[1] = argc;
80100d44:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d4c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4e:	29 d0                	sub    %edx,%eax
80100d50:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d56:	56                   	push   %esi
80100d57:	51                   	push   %ecx
80100d58:	53                   	push   %ebx
80100d59:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d5f:	e8 0c 64 00 00       	call   80107170 <copyout>
80100d64:	83 c4 10             	add    $0x10,%esp
80100d67:	85 c0                	test   %eax,%eax
80100d69:	78 8f                	js     80100cfa <exec+0x24a>
  for(last=s=path; *s; s++)
80100d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80100d6e:	8b 55 08             	mov    0x8(%ebp),%edx
80100d71:	0f b6 00             	movzbl (%eax),%eax
80100d74:	84 c0                	test   %al,%al
80100d76:	74 17                	je     80100d8f <exec+0x2df>
80100d78:	89 d1                	mov    %edx,%ecx
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	83 ec 04             	sub    $0x4,%esp
80100d92:	6a 10                	push   $0x10
80100d94:	52                   	push   %edx
80100d95:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100d9b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100d9e:	50                   	push   %eax
80100d9f:	e8 1c 3b 00 00       	call   801048c0 <safestrcpy>
  curproc->pgdir = pgdir;
80100da4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100daa:	89 f0                	mov    %esi,%eax
80100dac:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100daf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100db1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db4:	89 c1                	mov    %eax,%ecx
80100db6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbc:	8b 40 18             	mov    0x18(%eax),%eax
80100dbf:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc2:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dc8:	89 0c 24             	mov    %ecx,(%esp)
80100dcb:	e8 00 5d 00 00       	call   80106ad0 <switchuvm>
  freevm(oldpgdir);
80100dd0:	89 34 24             	mov    %esi,(%esp)
80100dd3:	e8 a8 60 00 00       	call   80106e80 <freevm>
  return 0;
80100dd8:	83 c4 10             	add    $0x10,%esp
80100ddb:	31 c0                	xor    %eax,%eax
80100ddd:	e9 3f fe ff ff       	jmp    80100c21 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100de2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100de7:	31 f6                	xor    %esi,%esi
80100de9:	e9 5a fe ff ff       	jmp    80100c48 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100dee:	be 10 00 00 00       	mov    $0x10,%esi
80100df3:	ba 04 00 00 00       	mov    $0x4,%edx
80100df8:	b8 03 00 00 00       	mov    $0x3,%eax
80100dfd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e04:	00 00 00 
80100e07:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e0d:	e9 17 ff ff ff       	jmp    80100d29 <exec+0x279>
    end_op();
80100e12:	e8 89 1f 00 00       	call   80102da0 <end_op>
    cprintf("exec: fail\n");
80100e17:	83 ec 0c             	sub    $0xc,%esp
80100e1a:	68 b0 72 10 80       	push   $0x801072b0
80100e1f:	e8 8c f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e24:	83 c4 10             	add    $0x10,%esp
80100e27:	e9 f0 fd ff ff       	jmp    80100c1c <exec+0x16c>
80100e2c:	66 90                	xchg   %ax,%ax
80100e2e:	66 90                	xchg   %ax,%ax

80100e30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e36:	68 bc 72 10 80       	push   $0x801072bc
80100e3b:	68 60 ef 10 80       	push   $0x8010ef60
80100e40:	e8 db 35 00 00       	call   80104420 <initlock>
}
80100e45:	83 c4 10             	add    $0x10,%esp
80100e48:	c9                   	leave
80100e49:	c3                   	ret
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e54:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80100e59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e5c:	68 60 ef 10 80       	push   $0x8010ef60
80100e61:	e8 aa 37 00 00       	call   80104610 <acquire>
80100e66:	83 c4 10             	add    $0x10,%esp
80100e69:	eb 10                	jmp    80100e7b <filealloc+0x2b>
80100e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e70:	83 c3 18             	add    $0x18,%ebx
80100e73:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100e79:	74 25                	je     80100ea0 <filealloc+0x50>
    if(f->ref == 0){
80100e7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	75 ee                	jne    80100e70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e82:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e8c:	68 60 ef 10 80       	push   $0x8010ef60
80100e91:	e8 1a 37 00 00       	call   801045b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e96:	89 d8                	mov    %ebx,%eax
      return f;
80100e98:	83 c4 10             	add    $0x10,%esp
}
80100e9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e9e:	c9                   	leave
80100e9f:	c3                   	ret
  release(&ftable.lock);
80100ea0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ea3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ea5:	68 60 ef 10 80       	push   $0x8010ef60
80100eaa:	e8 01 37 00 00       	call   801045b0 <release>
}
80100eaf:	89 d8                	mov    %ebx,%eax
  return 0;
80100eb1:	83 c4 10             	add    $0x10,%esp
}
80100eb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eb7:	c9                   	leave
80100eb8:	c3                   	ret
80100eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ec0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
80100ec4:	83 ec 10             	sub    $0x10,%esp
80100ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eca:	68 60 ef 10 80       	push   $0x8010ef60
80100ecf:	e8 3c 37 00 00       	call   80104610 <acquire>
  if(f->ref < 1)
80100ed4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed7:	83 c4 10             	add    $0x10,%esp
80100eda:	85 c0                	test   %eax,%eax
80100edc:	7e 1a                	jle    80100ef8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ede:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ee1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ee4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ee7:	68 60 ef 10 80       	push   $0x8010ef60
80100eec:	e8 bf 36 00 00       	call   801045b0 <release>
  return f;
}
80100ef1:	89 d8                	mov    %ebx,%eax
80100ef3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ef6:	c9                   	leave
80100ef7:	c3                   	ret
    panic("filedup");
80100ef8:	83 ec 0c             	sub    $0xc,%esp
80100efb:	68 c3 72 10 80       	push   $0x801072c3
80100f00:	e8 7b f4 ff ff       	call   80100380 <panic>
80100f05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f0c:	00 
80100f0d:	8d 76 00             	lea    0x0(%esi),%esi

80100f10 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	57                   	push   %edi
80100f14:	56                   	push   %esi
80100f15:	53                   	push   %ebx
80100f16:	83 ec 28             	sub    $0x28,%esp
80100f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f1c:	68 60 ef 10 80       	push   $0x8010ef60
80100f21:	e8 ea 36 00 00       	call   80104610 <acquire>
  if(f->ref < 1)
80100f26:	8b 53 04             	mov    0x4(%ebx),%edx
80100f29:	83 c4 10             	add    $0x10,%esp
80100f2c:	85 d2                	test   %edx,%edx
80100f2e:	0f 8e a5 00 00 00    	jle    80100fd9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f34:	83 ea 01             	sub    $0x1,%edx
80100f37:	89 53 04             	mov    %edx,0x4(%ebx)
80100f3a:	75 44                	jne    80100f80 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f3c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f40:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f43:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f45:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f4b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f4e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f51:	8b 43 10             	mov    0x10(%ebx),%eax
80100f54:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f57:	68 60 ef 10 80       	push   $0x8010ef60
80100f5c:	e8 4f 36 00 00       	call   801045b0 <release>

  if(ff.type == FD_PIPE)
80100f61:	83 c4 10             	add    $0x10,%esp
80100f64:	83 ff 01             	cmp    $0x1,%edi
80100f67:	74 57                	je     80100fc0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f69:	83 ff 02             	cmp    $0x2,%edi
80100f6c:	74 2a                	je     80100f98 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f71:	5b                   	pop    %ebx
80100f72:	5e                   	pop    %esi
80100f73:	5f                   	pop    %edi
80100f74:	5d                   	pop    %ebp
80100f75:	c3                   	ret
80100f76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f7d:	00 
80100f7e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80100f80:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80100f87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8a:	5b                   	pop    %ebx
80100f8b:	5e                   	pop    %esi
80100f8c:	5f                   	pop    %edi
80100f8d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f8e:	e9 1d 36 00 00       	jmp    801045b0 <release>
80100f93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80100f98:	e8 93 1d 00 00       	call   80102d30 <begin_op>
    iput(ff.ip);
80100f9d:	83 ec 0c             	sub    $0xc,%esp
80100fa0:	ff 75 e0             	push   -0x20(%ebp)
80100fa3:	e8 18 09 00 00       	call   801018c0 <iput>
    end_op();
80100fa8:	83 c4 10             	add    $0x10,%esp
}
80100fab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fae:	5b                   	pop    %ebx
80100faf:	5e                   	pop    %esi
80100fb0:	5f                   	pop    %edi
80100fb1:	5d                   	pop    %ebp
    end_op();
80100fb2:	e9 e9 1d 00 00       	jmp    80102da0 <end_op>
80100fb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fbe:	00 
80100fbf:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100fc0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fc4:	83 ec 08             	sub    $0x8,%esp
80100fc7:	53                   	push   %ebx
80100fc8:	56                   	push   %esi
80100fc9:	e8 52 25 00 00       	call   80103520 <pipeclose>
80100fce:	83 c4 10             	add    $0x10,%esp
}
80100fd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd4:	5b                   	pop    %ebx
80100fd5:	5e                   	pop    %esi
80100fd6:	5f                   	pop    %edi
80100fd7:	5d                   	pop    %ebp
80100fd8:	c3                   	ret
    panic("fileclose");
80100fd9:	83 ec 0c             	sub    $0xc,%esp
80100fdc:	68 cb 72 10 80       	push   $0x801072cb
80100fe1:	e8 9a f3 ff ff       	call   80100380 <panic>
80100fe6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fed:	00 
80100fee:	66 90                	xchg   %ax,%ax

80100ff0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	53                   	push   %ebx
80100ff4:	83 ec 04             	sub    $0x4,%esp
80100ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100ffa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100ffd:	75 31                	jne    80101030 <filestat+0x40>
    ilock(f->ip);
80100fff:	83 ec 0c             	sub    $0xc,%esp
80101002:	ff 73 10             	push   0x10(%ebx)
80101005:	e8 86 07 00 00       	call   80101790 <ilock>
    stati(f->ip, st);
8010100a:	58                   	pop    %eax
8010100b:	5a                   	pop    %edx
8010100c:	ff 75 0c             	push   0xc(%ebp)
8010100f:	ff 73 10             	push   0x10(%ebx)
80101012:	e8 59 0a 00 00       	call   80101a70 <stati>
    iunlock(f->ip);
80101017:	59                   	pop    %ecx
80101018:	ff 73 10             	push   0x10(%ebx)
8010101b:	e8 50 08 00 00       	call   80101870 <iunlock>
    return 0;
  }
  return -1;
}
80101020:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101023:	83 c4 10             	add    $0x10,%esp
80101026:	31 c0                	xor    %eax,%eax
}
80101028:	c9                   	leave
80101029:	c3                   	ret
8010102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101033:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101038:	c9                   	leave
80101039:	c3                   	ret
8010103a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101040 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	57                   	push   %edi
80101044:	56                   	push   %esi
80101045:	53                   	push   %ebx
80101046:	83 ec 0c             	sub    $0xc,%esp
80101049:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010104c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010104f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101052:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101056:	74 60                	je     801010b8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101058:	8b 03                	mov    (%ebx),%eax
8010105a:	83 f8 01             	cmp    $0x1,%eax
8010105d:	74 41                	je     801010a0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010105f:	83 f8 02             	cmp    $0x2,%eax
80101062:	75 5b                	jne    801010bf <fileread+0x7f>
    ilock(f->ip);
80101064:	83 ec 0c             	sub    $0xc,%esp
80101067:	ff 73 10             	push   0x10(%ebx)
8010106a:	e8 21 07 00 00       	call   80101790 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010106f:	57                   	push   %edi
80101070:	ff 73 14             	push   0x14(%ebx)
80101073:	56                   	push   %esi
80101074:	ff 73 10             	push   0x10(%ebx)
80101077:	e8 24 0a 00 00       	call   80101aa0 <readi>
8010107c:	83 c4 20             	add    $0x20,%esp
8010107f:	89 c6                	mov    %eax,%esi
80101081:	85 c0                	test   %eax,%eax
80101083:	7e 03                	jle    80101088 <fileread+0x48>
      f->off += r;
80101085:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101088:	83 ec 0c             	sub    $0xc,%esp
8010108b:	ff 73 10             	push   0x10(%ebx)
8010108e:	e8 dd 07 00 00       	call   80101870 <iunlock>
    return r;
80101093:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101099:	89 f0                	mov    %esi,%eax
8010109b:	5b                   	pop    %ebx
8010109c:	5e                   	pop    %esi
8010109d:	5f                   	pop    %edi
8010109e:	5d                   	pop    %ebp
8010109f:	c3                   	ret
    return piperead(f->pipe, addr, n);
801010a0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010a3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a9:	5b                   	pop    %ebx
801010aa:	5e                   	pop    %esi
801010ab:	5f                   	pop    %edi
801010ac:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010ad:	e9 2e 26 00 00       	jmp    801036e0 <piperead>
801010b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010b8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010bd:	eb d7                	jmp    80101096 <fileread+0x56>
  panic("fileread");
801010bf:	83 ec 0c             	sub    $0xc,%esp
801010c2:	68 d5 72 10 80       	push   $0x801072d5
801010c7:	e8 b4 f2 ff ff       	call   80100380 <panic>
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010d0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010d0:	55                   	push   %ebp
801010d1:	89 e5                	mov    %esp,%ebp
801010d3:	57                   	push   %edi
801010d4:	56                   	push   %esi
801010d5:	53                   	push   %ebx
801010d6:	83 ec 1c             	sub    $0x1c,%esp
801010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010df:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010e2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010e5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010ec:	0f 84 bb 00 00 00    	je     801011ad <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801010f2:	8b 03                	mov    (%ebx),%eax
801010f4:	83 f8 01             	cmp    $0x1,%eax
801010f7:	0f 84 bf 00 00 00    	je     801011bc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010fd:	83 f8 02             	cmp    $0x2,%eax
80101100:	0f 85 c8 00 00 00    	jne    801011ce <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101106:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101109:	31 f6                	xor    %esi,%esi
    while(i < n){
8010110b:	85 c0                	test   %eax,%eax
8010110d:	7f 30                	jg     8010113f <filewrite+0x6f>
8010110f:	e9 94 00 00 00       	jmp    801011a8 <filewrite+0xd8>
80101114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101118:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010111b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010111e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101121:	ff 73 10             	push   0x10(%ebx)
80101124:	e8 47 07 00 00       	call   80101870 <iunlock>
      end_op();
80101129:	e8 72 1c 00 00       	call   80102da0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010112e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101131:	83 c4 10             	add    $0x10,%esp
80101134:	39 c7                	cmp    %eax,%edi
80101136:	75 5c                	jne    80101194 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101138:	01 fe                	add    %edi,%esi
    while(i < n){
8010113a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010113d:	7e 69                	jle    801011a8 <filewrite+0xd8>
      int n1 = n - i;
8010113f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101142:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101147:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101149:	39 c7                	cmp    %eax,%edi
8010114b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010114e:	e8 dd 1b 00 00       	call   80102d30 <begin_op>
      ilock(f->ip);
80101153:	83 ec 0c             	sub    $0xc,%esp
80101156:	ff 73 10             	push   0x10(%ebx)
80101159:	e8 32 06 00 00       	call   80101790 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010115e:	57                   	push   %edi
8010115f:	ff 73 14             	push   0x14(%ebx)
80101162:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101165:	01 f0                	add    %esi,%eax
80101167:	50                   	push   %eax
80101168:	ff 73 10             	push   0x10(%ebx)
8010116b:	e8 30 0a 00 00       	call   80101ba0 <writei>
80101170:	83 c4 20             	add    $0x20,%esp
80101173:	85 c0                	test   %eax,%eax
80101175:	7f a1                	jg     80101118 <filewrite+0x48>
80101177:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010117a:	83 ec 0c             	sub    $0xc,%esp
8010117d:	ff 73 10             	push   0x10(%ebx)
80101180:	e8 eb 06 00 00       	call   80101870 <iunlock>
      end_op();
80101185:	e8 16 1c 00 00       	call   80102da0 <end_op>
      if(r < 0)
8010118a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010118d:	83 c4 10             	add    $0x10,%esp
80101190:	85 c0                	test   %eax,%eax
80101192:	75 14                	jne    801011a8 <filewrite+0xd8>
        panic("short filewrite");
80101194:	83 ec 0c             	sub    $0xc,%esp
80101197:	68 de 72 10 80       	push   $0x801072de
8010119c:	e8 df f1 ff ff       	call   80100380 <panic>
801011a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801011a8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011ab:	74 05                	je     801011b2 <filewrite+0xe2>
801011ad:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801011b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b5:	89 f0                	mov    %esi,%eax
801011b7:	5b                   	pop    %ebx
801011b8:	5e                   	pop    %esi
801011b9:	5f                   	pop    %edi
801011ba:	5d                   	pop    %ebp
801011bb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801011bc:	8b 43 0c             	mov    0xc(%ebx),%eax
801011bf:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c5:	5b                   	pop    %ebx
801011c6:	5e                   	pop    %esi
801011c7:	5f                   	pop    %edi
801011c8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011c9:	e9 f2 23 00 00       	jmp    801035c0 <pipewrite>
  panic("filewrite");
801011ce:	83 ec 0c             	sub    $0xc,%esp
801011d1:	68 e4 72 10 80       	push   $0x801072e4
801011d6:	e8 a5 f1 ff ff       	call   80100380 <panic>
801011db:	66 90                	xchg   %ax,%ax
801011dd:	66 90                	xchg   %ax,%ax
801011df:	90                   	nop

801011e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011e9:	8b 0d d4 31 11 80    	mov    0x801131d4,%ecx
{
801011ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011f2:	85 c9                	test   %ecx,%ecx
801011f4:	0f 84 8c 00 00 00    	je     80101286 <balloc+0xa6>
801011fa:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801011fc:	89 f8                	mov    %edi,%eax
801011fe:	83 ec 08             	sub    $0x8,%esp
80101201:	89 fe                	mov    %edi,%esi
80101203:	c1 f8 0c             	sar    $0xc,%eax
80101206:	03 05 ec 31 11 80    	add    0x801131ec,%eax
8010120c:	50                   	push   %eax
8010120d:	ff 75 dc             	push   -0x24(%ebp)
80101210:	e8 bb ee ff ff       	call   801000d0 <bread>
80101215:	83 c4 10             	add    $0x10,%esp
80101218:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010121b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010121e:	a1 d4 31 11 80       	mov    0x801131d4,%eax
80101223:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101226:	31 c0                	xor    %eax,%eax
80101228:	eb 32                	jmp    8010125c <balloc+0x7c>
8010122a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101230:	89 c1                	mov    %eax,%ecx
80101232:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101237:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010123a:	83 e1 07             	and    $0x7,%ecx
8010123d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010123f:	89 c1                	mov    %eax,%ecx
80101241:	c1 f9 03             	sar    $0x3,%ecx
80101244:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101249:	89 fa                	mov    %edi,%edx
8010124b:	85 df                	test   %ebx,%edi
8010124d:	74 49                	je     80101298 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010124f:	83 c0 01             	add    $0x1,%eax
80101252:	83 c6 01             	add    $0x1,%esi
80101255:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010125a:	74 07                	je     80101263 <balloc+0x83>
8010125c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010125f:	39 d6                	cmp    %edx,%esi
80101261:	72 cd                	jb     80101230 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101263:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101266:	83 ec 0c             	sub    $0xc,%esp
80101269:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010126c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101272:	e8 79 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101277:	83 c4 10             	add    $0x10,%esp
8010127a:	3b 3d d4 31 11 80    	cmp    0x801131d4,%edi
80101280:	0f 82 76 ff ff ff    	jb     801011fc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101286:	83 ec 0c             	sub    $0xc,%esp
80101289:	68 ee 72 10 80       	push   $0x801072ee
8010128e:	e8 ed f0 ff ff       	call   80100380 <panic>
80101293:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101298:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010129b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010129e:	09 da                	or     %ebx,%edx
801012a0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012a4:	57                   	push   %edi
801012a5:	e8 66 1c 00 00       	call   80102f10 <log_write>
        brelse(bp);
801012aa:	89 3c 24             	mov    %edi,(%esp)
801012ad:	e8 3e ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801012b2:	58                   	pop    %eax
801012b3:	5a                   	pop    %edx
801012b4:	56                   	push   %esi
801012b5:	ff 75 dc             	push   -0x24(%ebp)
801012b8:	e8 13 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012bd:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801012c0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012c2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012c5:	68 00 02 00 00       	push   $0x200
801012ca:	6a 00                	push   $0x0
801012cc:	50                   	push   %eax
801012cd:	e8 3e 34 00 00       	call   80104710 <memset>
  log_write(bp);
801012d2:	89 1c 24             	mov    %ebx,(%esp)
801012d5:	e8 36 1c 00 00       	call   80102f10 <log_write>
  brelse(bp);
801012da:	89 1c 24             	mov    %ebx,(%esp)
801012dd:	e8 0e ef ff ff       	call   801001f0 <brelse>
}
801012e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e5:	89 f0                	mov    %esi,%eax
801012e7:	5b                   	pop    %ebx
801012e8:	5e                   	pop    %esi
801012e9:	5f                   	pop    %edi
801012ea:	5d                   	pop    %ebp
801012eb:	c3                   	ret
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012f4:	31 ff                	xor    %edi,%edi
{
801012f6:	56                   	push   %esi
801012f7:	89 c6                	mov    %eax,%esi
801012f9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fa:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
801012ff:	83 ec 28             	sub    $0x28,%esp
80101302:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101305:	68 60 f9 10 80       	push   $0x8010f960
8010130a:	e8 01 33 00 00       	call   80104610 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101312:	83 c4 10             	add    $0x10,%esp
80101315:	eb 1b                	jmp    80101332 <iget+0x42>
80101317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010131e:	00 
8010131f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101320:	39 33                	cmp    %esi,(%ebx)
80101322:	74 64                	je     80101388 <iget+0x98>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101324:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010132a:	81 fb d4 31 11 80    	cmp    $0x801131d4,%ebx
80101330:	74 1f                	je     80101351 <iget+0x61>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101332:	8b 43 08             	mov    0x8(%ebx),%eax
80101335:	85 c0                	test   %eax,%eax
80101337:	7f e7                	jg     80101320 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101339:	85 ff                	test   %edi,%edi
8010133b:	75 e7                	jne    80101324 <iget+0x34>
8010133d:	85 c0                	test   %eax,%eax
8010133f:	75 6c                	jne    801013ad <iget+0xbd>
      empty = ip;
80101341:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101343:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101349:	81 fb d4 31 11 80    	cmp    $0x801131d4,%ebx
8010134f:	75 e1                	jne    80101332 <iget+0x42>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101351:	85 ff                	test   %edi,%edi
80101353:	74 76                	je     801013cb <iget+0xdb>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101355:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101358:	89 37                	mov    %esi,(%edi)

  return ip;
8010135a:	89 fb                	mov    %edi,%ebx
  ip->inum = inum;
8010135c:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
8010135f:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
80101366:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
8010136d:	68 60 f9 10 80       	push   $0x8010f960
80101372:	e8 39 32 00 00       	call   801045b0 <release>
  return ip;
80101377:	83 c4 10             	add    $0x10,%esp
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	89 d8                	mov    %ebx,%eax
8010137f:	5b                   	pop    %ebx
80101380:	5e                   	pop    %esi
80101381:	5f                   	pop    %edi
80101382:	5d                   	pop    %ebp
80101383:	c3                   	ret
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101388:	39 53 04             	cmp    %edx,0x4(%ebx)
8010138b:	75 97                	jne    80101324 <iget+0x34>
      ip->ref++;
8010138d:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101390:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101393:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101396:	68 60 f9 10 80       	push   $0x8010f960
8010139b:	e8 10 32 00 00       	call   801045b0 <release>
      return ip;
801013a0:	83 c4 10             	add    $0x10,%esp
}
801013a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a6:	89 d8                	mov    %ebx,%eax
801013a8:	5b                   	pop    %ebx
801013a9:	5e                   	pop    %esi
801013aa:	5f                   	pop    %edi
801013ab:	5d                   	pop    %ebp
801013ac:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ad:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013b3:	81 fb d4 31 11 80    	cmp    $0x801131d4,%ebx
801013b9:	74 10                	je     801013cb <iget+0xdb>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013bb:	8b 43 08             	mov    0x8(%ebx),%eax
801013be:	85 c0                	test   %eax,%eax
801013c0:	0f 8f 5a ff ff ff    	jg     80101320 <iget+0x30>
801013c6:	e9 72 ff ff ff       	jmp    8010133d <iget+0x4d>
    panic("iget: no inodes");
801013cb:	83 ec 0c             	sub    $0xc,%esp
801013ce:	68 04 73 10 80       	push   $0x80107304
801013d3:	e8 a8 ef ff ff       	call   80100380 <panic>
801013d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013df:	00 

801013e0 <bfree>:
{
801013e0:	55                   	push   %ebp
801013e1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801013e3:	89 d0                	mov    %edx,%eax
801013e5:	c1 e8 0c             	shr    $0xc,%eax
{
801013e8:	89 e5                	mov    %esp,%ebp
801013ea:	56                   	push   %esi
801013eb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801013ec:	03 05 ec 31 11 80    	add    0x801131ec,%eax
{
801013f2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801013f4:	83 ec 08             	sub    $0x8,%esp
801013f7:	50                   	push   %eax
801013f8:	51                   	push   %ecx
801013f9:	e8 d2 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801013fe:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101400:	c1 fb 03             	sar    $0x3,%ebx
80101403:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101406:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101408:	83 e1 07             	and    $0x7,%ecx
8010140b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101410:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101416:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101418:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010141d:	85 c1                	test   %eax,%ecx
8010141f:	74 23                	je     80101444 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101421:	f7 d0                	not    %eax
  log_write(bp);
80101423:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101426:	21 c8                	and    %ecx,%eax
80101428:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010142c:	56                   	push   %esi
8010142d:	e8 de 1a 00 00       	call   80102f10 <log_write>
  brelse(bp);
80101432:	89 34 24             	mov    %esi,(%esp)
80101435:	e8 b6 ed ff ff       	call   801001f0 <brelse>
}
8010143a:	83 c4 10             	add    $0x10,%esp
8010143d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101440:	5b                   	pop    %ebx
80101441:	5e                   	pop    %esi
80101442:	5d                   	pop    %ebp
80101443:	c3                   	ret
    panic("freeing free block");
80101444:	83 ec 0c             	sub    $0xc,%esp
80101447:	68 14 73 10 80       	push   $0x80107314
8010144c:	e8 2f ef ff ff       	call   80100380 <panic>
80101451:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101458:	00 
80101459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101460 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	57                   	push   %edi
80101464:	56                   	push   %esi
80101465:	89 c6                	mov    %eax,%esi
80101467:	53                   	push   %ebx
80101468:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010146b:	83 fa 0b             	cmp    $0xb,%edx
8010146e:	0f 86 8c 00 00 00    	jbe    80101500 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101474:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101477:	83 fb 7f             	cmp    $0x7f,%ebx
8010147a:	0f 87 a2 00 00 00    	ja     80101522 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101480:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101486:	85 c0                	test   %eax,%eax
80101488:	74 5e                	je     801014e8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010148a:	83 ec 08             	sub    $0x8,%esp
8010148d:	50                   	push   %eax
8010148e:	ff 36                	push   (%esi)
80101490:	e8 3b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101495:	83 c4 10             	add    $0x10,%esp
80101498:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010149c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010149e:	8b 3b                	mov    (%ebx),%edi
801014a0:	85 ff                	test   %edi,%edi
801014a2:	74 1c                	je     801014c0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801014a4:	83 ec 0c             	sub    $0xc,%esp
801014a7:	52                   	push   %edx
801014a8:	e8 43 ed ff ff       	call   801001f0 <brelse>
801014ad:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014b3:	89 f8                	mov    %edi,%eax
801014b5:	5b                   	pop    %ebx
801014b6:	5e                   	pop    %esi
801014b7:	5f                   	pop    %edi
801014b8:	5d                   	pop    %ebp
801014b9:	c3                   	ret
801014ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014c3:	8b 06                	mov    (%esi),%eax
801014c5:	e8 16 fd ff ff       	call   801011e0 <balloc>
      log_write(bp);
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014d0:	89 03                	mov    %eax,(%ebx)
801014d2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014d4:	52                   	push   %edx
801014d5:	e8 36 1a 00 00       	call   80102f10 <log_write>
801014da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014dd:	83 c4 10             	add    $0x10,%esp
801014e0:	eb c2                	jmp    801014a4 <bmap+0x44>
801014e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014e8:	8b 06                	mov    (%esi),%eax
801014ea:	e8 f1 fc ff ff       	call   801011e0 <balloc>
801014ef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014f5:	eb 93                	jmp    8010148a <bmap+0x2a>
801014f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014fe:	00 
801014ff:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101500:	8d 5a 14             	lea    0x14(%edx),%ebx
80101503:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101507:	85 ff                	test   %edi,%edi
80101509:	75 a5                	jne    801014b0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010150b:	8b 00                	mov    (%eax),%eax
8010150d:	e8 ce fc ff ff       	call   801011e0 <balloc>
80101512:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101516:	89 c7                	mov    %eax,%edi
}
80101518:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010151b:	5b                   	pop    %ebx
8010151c:	89 f8                	mov    %edi,%eax
8010151e:	5e                   	pop    %esi
8010151f:	5f                   	pop    %edi
80101520:	5d                   	pop    %ebp
80101521:	c3                   	ret
  panic("bmap: out of range");
80101522:	83 ec 0c             	sub    $0xc,%esp
80101525:	68 27 73 10 80       	push   $0x80107327
8010152a:	e8 51 ee ff ff       	call   80100380 <panic>
8010152f:	90                   	nop

80101530 <readsb>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	56                   	push   %esi
80101534:	53                   	push   %ebx
80101535:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101538:	83 ec 08             	sub    $0x8,%esp
8010153b:	6a 01                	push   $0x1
8010153d:	ff 75 08             	push   0x8(%ebp)
80101540:	e8 8b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101545:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101548:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010154a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010154d:	6a 1c                	push   $0x1c
8010154f:	50                   	push   %eax
80101550:	56                   	push   %esi
80101551:	e8 4a 32 00 00       	call   801047a0 <memmove>
  brelse(bp);
80101556:	83 c4 10             	add    $0x10,%esp
80101559:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010155c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010155f:	5b                   	pop    %ebx
80101560:	5e                   	pop    %esi
80101561:	5d                   	pop    %ebp
  brelse(bp);
80101562:	e9 89 ec ff ff       	jmp    801001f0 <brelse>
80101567:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010156e:	00 
8010156f:	90                   	nop

80101570 <iinit>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	53                   	push   %ebx
80101574:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
80101579:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010157c:	68 3a 73 10 80       	push   $0x8010733a
80101581:	68 60 f9 10 80       	push   $0x8010f960
80101586:	e8 95 2e 00 00       	call   80104420 <initlock>
  for(i = 0; i < NINODE; i++) {
8010158b:	83 c4 10             	add    $0x10,%esp
8010158e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101590:	83 ec 08             	sub    $0x8,%esp
80101593:	68 41 73 10 80       	push   $0x80107341
80101598:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101599:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010159f:	e8 4c 2d 00 00       	call   801042f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015a4:	83 c4 10             	add    $0x10,%esp
801015a7:	81 fb e0 31 11 80    	cmp    $0x801131e0,%ebx
801015ad:	75 e1                	jne    80101590 <iinit+0x20>
  bp = bread(dev, 1);
801015af:	83 ec 08             	sub    $0x8,%esp
801015b2:	6a 01                	push   $0x1
801015b4:	ff 75 08             	push   0x8(%ebp)
801015b7:	e8 14 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015bc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015bf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015c1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015c4:	6a 1c                	push   $0x1c
801015c6:	50                   	push   %eax
801015c7:	68 d4 31 11 80       	push   $0x801131d4
801015cc:	e8 cf 31 00 00       	call   801047a0 <memmove>
  brelse(bp);
801015d1:	89 1c 24             	mov    %ebx,(%esp)
801015d4:	e8 17 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015d9:	ff 35 ec 31 11 80    	push   0x801131ec
801015df:	ff 35 e8 31 11 80    	push   0x801131e8
801015e5:	ff 35 e4 31 11 80    	push   0x801131e4
801015eb:	ff 35 e0 31 11 80    	push   0x801131e0
801015f1:	ff 35 dc 31 11 80    	push   0x801131dc
801015f7:	ff 35 d8 31 11 80    	push   0x801131d8
801015fd:	ff 35 d4 31 11 80    	push   0x801131d4
80101603:	68 70 77 10 80       	push   $0x80107770
80101608:	e8 a3 f0 ff ff       	call   801006b0 <cprintf>
}
8010160d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101610:	83 c4 30             	add    $0x30,%esp
80101613:	c9                   	leave
80101614:	c3                   	ret
80101615:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010161c:	00 
8010161d:	8d 76 00             	lea    0x0(%esi),%esi

80101620 <ialloc>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	57                   	push   %edi
80101624:	56                   	push   %esi
80101625:	53                   	push   %ebx
80101626:	83 ec 1c             	sub    $0x1c,%esp
80101629:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010162c:	83 3d dc 31 11 80 01 	cmpl   $0x1,0x801131dc
{
80101633:	8b 75 08             	mov    0x8(%ebp),%esi
80101636:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101639:	0f 86 91 00 00 00    	jbe    801016d0 <ialloc+0xb0>
8010163f:	bf 01 00 00 00       	mov    $0x1,%edi
80101644:	eb 21                	jmp    80101667 <ialloc+0x47>
80101646:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010164d:	00 
8010164e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101650:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101653:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101656:	53                   	push   %ebx
80101657:	e8 94 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010165c:	83 c4 10             	add    $0x10,%esp
8010165f:	3b 3d dc 31 11 80    	cmp    0x801131dc,%edi
80101665:	73 69                	jae    801016d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101667:	89 f8                	mov    %edi,%eax
80101669:	83 ec 08             	sub    $0x8,%esp
8010166c:	c1 e8 03             	shr    $0x3,%eax
8010166f:	03 05 e8 31 11 80    	add    0x801131e8,%eax
80101675:	50                   	push   %eax
80101676:	56                   	push   %esi
80101677:	e8 54 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010167c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010167f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101681:	89 f8                	mov    %edi,%eax
80101683:	83 e0 07             	and    $0x7,%eax
80101686:	c1 e0 06             	shl    $0x6,%eax
80101689:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010168d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101691:	75 bd                	jne    80101650 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101693:	83 ec 04             	sub    $0x4,%esp
80101696:	6a 40                	push   $0x40
80101698:	6a 00                	push   $0x0
8010169a:	51                   	push   %ecx
8010169b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010169e:	e8 6d 30 00 00       	call   80104710 <memset>
      dip->type = type;
801016a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016ad:	89 1c 24             	mov    %ebx,(%esp)
801016b0:	e8 5b 18 00 00       	call   80102f10 <log_write>
      brelse(bp);
801016b5:	89 1c 24             	mov    %ebx,(%esp)
801016b8:	e8 33 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016bd:	83 c4 10             	add    $0x10,%esp
}
801016c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016c3:	89 fa                	mov    %edi,%edx
}
801016c5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016c6:	89 f0                	mov    %esi,%eax
}
801016c8:	5e                   	pop    %esi
801016c9:	5f                   	pop    %edi
801016ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801016cb:	e9 20 fc ff ff       	jmp    801012f0 <iget>
  panic("ialloc: no inodes");
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	68 47 73 10 80       	push   $0x80107347
801016d8:	e8 a3 ec ff ff       	call   80100380 <panic>
801016dd:	8d 76 00             	lea    0x0(%esi),%esi

801016e0 <iupdate>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016eb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016ee:	83 ec 08             	sub    $0x8,%esp
801016f1:	c1 e8 03             	shr    $0x3,%eax
801016f4:	03 05 e8 31 11 80    	add    0x801131e8,%eax
801016fa:	50                   	push   %eax
801016fb:	ff 73 a4             	push   -0x5c(%ebx)
801016fe:	e8 cd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101703:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101707:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010170c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010170f:	83 e0 07             	and    $0x7,%eax
80101712:	c1 e0 06             	shl    $0x6,%eax
80101715:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101719:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010171c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101720:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101723:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101727:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010172b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010172f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101733:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101737:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010173a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173d:	6a 34                	push   $0x34
8010173f:	53                   	push   %ebx
80101740:	50                   	push   %eax
80101741:	e8 5a 30 00 00       	call   801047a0 <memmove>
  log_write(bp);
80101746:	89 34 24             	mov    %esi,(%esp)
80101749:	e8 c2 17 00 00       	call   80102f10 <log_write>
  brelse(bp);
8010174e:	83 c4 10             	add    $0x10,%esp
80101751:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101754:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101757:	5b                   	pop    %ebx
80101758:	5e                   	pop    %esi
80101759:	5d                   	pop    %ebp
  brelse(bp);
8010175a:	e9 91 ea ff ff       	jmp    801001f0 <brelse>
8010175f:	90                   	nop

80101760 <idup>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	53                   	push   %ebx
80101764:	83 ec 10             	sub    $0x10,%esp
80101767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010176a:	68 60 f9 10 80       	push   $0x8010f960
8010176f:	e8 9c 2e 00 00       	call   80104610 <acquire>
  ip->ref++;
80101774:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101778:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
8010177f:	e8 2c 2e 00 00       	call   801045b0 <release>
}
80101784:	89 d8                	mov    %ebx,%eax
80101786:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101789:	c9                   	leave
8010178a:	c3                   	ret
8010178b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101790 <ilock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101798:	85 db                	test   %ebx,%ebx
8010179a:	0f 84 b7 00 00 00    	je     80101857 <ilock+0xc7>
801017a0:	8b 53 08             	mov    0x8(%ebx),%edx
801017a3:	85 d2                	test   %edx,%edx
801017a5:	0f 8e ac 00 00 00    	jle    80101857 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	8d 43 0c             	lea    0xc(%ebx),%eax
801017b1:	50                   	push   %eax
801017b2:	e8 79 2b 00 00       	call   80104330 <acquiresleep>
  if(ip->valid == 0){
801017b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ba:	83 c4 10             	add    $0x10,%esp
801017bd:	85 c0                	test   %eax,%eax
801017bf:	74 0f                	je     801017d0 <ilock+0x40>
}
801017c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017c4:	5b                   	pop    %ebx
801017c5:	5e                   	pop    %esi
801017c6:	5d                   	pop    %ebp
801017c7:	c3                   	ret
801017c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017cf:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017d0:	8b 43 04             	mov    0x4(%ebx),%eax
801017d3:	83 ec 08             	sub    $0x8,%esp
801017d6:	c1 e8 03             	shr    $0x3,%eax
801017d9:	03 05 e8 31 11 80    	add    0x801131e8,%eax
801017df:	50                   	push   %eax
801017e0:	ff 33                	push   (%ebx)
801017e2:	e8 e9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ea:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ec:	8b 43 04             	mov    0x4(%ebx),%eax
801017ef:	83 e0 07             	and    $0x7,%eax
801017f2:	c1 e0 06             	shl    $0x6,%eax
801017f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101803:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101807:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010180b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010180f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101813:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101817:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010181b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010181e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101821:	6a 34                	push   $0x34
80101823:	50                   	push   %eax
80101824:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101827:	50                   	push   %eax
80101828:	e8 73 2f 00 00       	call   801047a0 <memmove>
    brelse(bp);
8010182d:	89 34 24             	mov    %esi,(%esp)
80101830:	e8 bb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101835:	83 c4 10             	add    $0x10,%esp
80101838:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010183d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101844:	0f 85 77 ff ff ff    	jne    801017c1 <ilock+0x31>
      panic("ilock: no type");
8010184a:	83 ec 0c             	sub    $0xc,%esp
8010184d:	68 5f 73 10 80       	push   $0x8010735f
80101852:	e8 29 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101857:	83 ec 0c             	sub    $0xc,%esp
8010185a:	68 59 73 10 80       	push   $0x80107359
8010185f:	e8 1c eb ff ff       	call   80100380 <panic>
80101864:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010186b:	00 
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101870 <iunlock>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101878:	85 db                	test   %ebx,%ebx
8010187a:	74 28                	je     801018a4 <iunlock+0x34>
8010187c:	83 ec 0c             	sub    $0xc,%esp
8010187f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101882:	56                   	push   %esi
80101883:	e8 48 2b 00 00       	call   801043d0 <holdingsleep>
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	85 c0                	test   %eax,%eax
8010188d:	74 15                	je     801018a4 <iunlock+0x34>
8010188f:	8b 43 08             	mov    0x8(%ebx),%eax
80101892:	85 c0                	test   %eax,%eax
80101894:	7e 0e                	jle    801018a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101896:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101899:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010189f:	e9 ec 2a 00 00       	jmp    80104390 <releasesleep>
    panic("iunlock");
801018a4:	83 ec 0c             	sub    $0xc,%esp
801018a7:	68 6e 73 10 80       	push   $0x8010736e
801018ac:	e8 cf ea ff ff       	call   80100380 <panic>
801018b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018b8:	00 
801018b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801018c0 <iput>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 28             	sub    $0x28,%esp
801018c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018cf:	57                   	push   %edi
801018d0:	e8 5b 2a 00 00       	call   80104330 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	85 d2                	test   %edx,%edx
801018dd:	74 07                	je     801018e6 <iput+0x26>
801018df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018e4:	74 32                	je     80101918 <iput+0x58>
  releasesleep(&ip->lock);
801018e6:	83 ec 0c             	sub    $0xc,%esp
801018e9:	57                   	push   %edi
801018ea:	e8 a1 2a 00 00       	call   80104390 <releasesleep>
  acquire(&icache.lock);
801018ef:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801018f6:	e8 15 2d 00 00       	call   80104610 <acquire>
  ip->ref--;
801018fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ff:	83 c4 10             	add    $0x10,%esp
80101902:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101909:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010190c:	5b                   	pop    %ebx
8010190d:	5e                   	pop    %esi
8010190e:	5f                   	pop    %edi
8010190f:	5d                   	pop    %ebp
  release(&icache.lock);
80101910:	e9 9b 2c 00 00       	jmp    801045b0 <release>
80101915:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101918:	83 ec 0c             	sub    $0xc,%esp
8010191b:	68 60 f9 10 80       	push   $0x8010f960
80101920:	e8 eb 2c 00 00       	call   80104610 <acquire>
    int r = ip->ref;
80101925:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101928:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
8010192f:	e8 7c 2c 00 00       	call   801045b0 <release>
    if(r == 1){
80101934:	83 c4 10             	add    $0x10,%esp
80101937:	83 fe 01             	cmp    $0x1,%esi
8010193a:	75 aa                	jne    801018e6 <iput+0x26>
8010193c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101942:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101945:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101948:	89 df                	mov    %ebx,%edi
8010194a:	89 cb                	mov    %ecx,%ebx
8010194c:	eb 09                	jmp    80101957 <iput+0x97>
8010194e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101950:	83 c6 04             	add    $0x4,%esi
80101953:	39 de                	cmp    %ebx,%esi
80101955:	74 19                	je     80101970 <iput+0xb0>
    if(ip->addrs[i]){
80101957:	8b 16                	mov    (%esi),%edx
80101959:	85 d2                	test   %edx,%edx
8010195b:	74 f3                	je     80101950 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010195d:	8b 07                	mov    (%edi),%eax
8010195f:	e8 7c fa ff ff       	call   801013e0 <bfree>
      ip->addrs[i] = 0;
80101964:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010196a:	eb e4                	jmp    80101950 <iput+0x90>
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101970:	89 fb                	mov    %edi,%ebx
80101972:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101975:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010197b:	85 c0                	test   %eax,%eax
8010197d:	75 2d                	jne    801019ac <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010197f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101982:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101989:	53                   	push   %ebx
8010198a:	e8 51 fd ff ff       	call   801016e0 <iupdate>
      ip->type = 0;
8010198f:	31 c0                	xor    %eax,%eax
80101991:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101995:	89 1c 24             	mov    %ebx,(%esp)
80101998:	e8 43 fd ff ff       	call   801016e0 <iupdate>
      ip->valid = 0;
8010199d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019a4:	83 c4 10             	add    $0x10,%esp
801019a7:	e9 3a ff ff ff       	jmp    801018e6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019ac:	83 ec 08             	sub    $0x8,%esp
801019af:	50                   	push   %eax
801019b0:	ff 33                	push   (%ebx)
801019b2:	e8 19 e7 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801019b7:	83 c4 10             	add    $0x10,%esp
801019ba:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019bd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019c6:	8d 70 5c             	lea    0x5c(%eax),%esi
801019c9:	89 cf                	mov    %ecx,%edi
801019cb:	eb 0a                	jmp    801019d7 <iput+0x117>
801019cd:	8d 76 00             	lea    0x0(%esi),%esi
801019d0:	83 c6 04             	add    $0x4,%esi
801019d3:	39 fe                	cmp    %edi,%esi
801019d5:	74 0f                	je     801019e6 <iput+0x126>
      if(a[j])
801019d7:	8b 16                	mov    (%esi),%edx
801019d9:	85 d2                	test   %edx,%edx
801019db:	74 f3                	je     801019d0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019dd:	8b 03                	mov    (%ebx),%eax
801019df:	e8 fc f9 ff ff       	call   801013e0 <bfree>
801019e4:	eb ea                	jmp    801019d0 <iput+0x110>
    brelse(bp);
801019e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019e9:	83 ec 0c             	sub    $0xc,%esp
801019ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019ef:	50                   	push   %eax
801019f0:	e8 fb e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019f5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019fb:	8b 03                	mov    (%ebx),%eax
801019fd:	e8 de f9 ff ff       	call   801013e0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a02:	83 c4 10             	add    $0x10,%esp
80101a05:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a0c:	00 00 00 
80101a0f:	e9 6b ff ff ff       	jmp    8010197f <iput+0xbf>
80101a14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a1b:	00 
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a20 <iunlockput>:
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	56                   	push   %esi
80101a24:	53                   	push   %ebx
80101a25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a28:	85 db                	test   %ebx,%ebx
80101a2a:	74 34                	je     80101a60 <iunlockput+0x40>
80101a2c:	83 ec 0c             	sub    $0xc,%esp
80101a2f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a32:	56                   	push   %esi
80101a33:	e8 98 29 00 00       	call   801043d0 <holdingsleep>
80101a38:	83 c4 10             	add    $0x10,%esp
80101a3b:	85 c0                	test   %eax,%eax
80101a3d:	74 21                	je     80101a60 <iunlockput+0x40>
80101a3f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a42:	85 c0                	test   %eax,%eax
80101a44:	7e 1a                	jle    80101a60 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a46:	83 ec 0c             	sub    $0xc,%esp
80101a49:	56                   	push   %esi
80101a4a:	e8 41 29 00 00       	call   80104390 <releasesleep>
  iput(ip);
80101a4f:	83 c4 10             	add    $0x10,%esp
80101a52:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101a55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a58:	5b                   	pop    %ebx
80101a59:	5e                   	pop    %esi
80101a5a:	5d                   	pop    %ebp
  iput(ip);
80101a5b:	e9 60 fe ff ff       	jmp    801018c0 <iput>
    panic("iunlock");
80101a60:	83 ec 0c             	sub    $0xc,%esp
80101a63:	68 6e 73 10 80       	push   $0x8010736e
80101a68:	e8 13 e9 ff ff       	call   80100380 <panic>
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi

80101a70 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	8b 55 08             	mov    0x8(%ebp),%edx
80101a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a79:	8b 0a                	mov    (%edx),%ecx
80101a7b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a7e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a81:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a84:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a88:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a8b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a8f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a93:	8b 52 58             	mov    0x58(%edx),%edx
80101a96:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a99:	5d                   	pop    %ebp
80101a9a:	c3                   	ret
80101a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101aa0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 75 08             	mov    0x8(%ebp),%esi
80101aac:	8b 45 0c             	mov    0xc(%ebp),%eax
80101aaf:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101ab7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101aba:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101abd:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101ac0:	0f 84 aa 00 00 00    	je     80101b70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ac6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101ac9:	8b 56 58             	mov    0x58(%esi),%edx
80101acc:	39 fa                	cmp    %edi,%edx
80101ace:	0f 82 bd 00 00 00    	jb     80101b91 <readi+0xf1>
80101ad4:	89 f9                	mov    %edi,%ecx
80101ad6:	31 db                	xor    %ebx,%ebx
80101ad8:	01 c1                	add    %eax,%ecx
80101ada:	0f 92 c3             	setb   %bl
80101add:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101ae0:	0f 82 ab 00 00 00    	jb     80101b91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ae6:	89 d3                	mov    %edx,%ebx
80101ae8:	29 fb                	sub    %edi,%ebx
80101aea:	39 ca                	cmp    %ecx,%edx
80101aec:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aef:	85 c0                	test   %eax,%eax
80101af1:	74 73                	je     80101b66 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101af3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101af6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b03:	89 fa                	mov    %edi,%edx
80101b05:	c1 ea 09             	shr    $0x9,%edx
80101b08:	89 d8                	mov    %ebx,%eax
80101b0a:	e8 51 f9 ff ff       	call   80101460 <bmap>
80101b0f:	83 ec 08             	sub    $0x8,%esp
80101b12:	50                   	push   %eax
80101b13:	ff 33                	push   (%ebx)
80101b15:	e8 b6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b1d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b22:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b24:	89 f8                	mov    %edi,%eax
80101b26:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b2b:	29 f3                	sub    %esi,%ebx
80101b2d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b33:	39 d9                	cmp    %ebx,%ecx
80101b35:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b38:	83 c4 0c             	add    $0xc,%esp
80101b3b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b3c:	01 de                	add    %ebx,%esi
80101b3e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b40:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b43:	50                   	push   %eax
80101b44:	ff 75 e0             	push   -0x20(%ebp)
80101b47:	e8 54 2c 00 00       	call   801047a0 <memmove>
    brelse(bp);
80101b4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b4f:	89 14 24             	mov    %edx,(%esp)
80101b52:	e8 99 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b5a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b5d:	83 c4 10             	add    $0x10,%esp
80101b60:	39 de                	cmp    %ebx,%esi
80101b62:	72 9c                	jb     80101b00 <readi+0x60>
80101b64:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101b66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b69:	5b                   	pop    %ebx
80101b6a:	5e                   	pop    %esi
80101b6b:	5f                   	pop    %edi
80101b6c:	5d                   	pop    %ebp
80101b6d:	c3                   	ret
80101b6e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b70:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101b74:	66 83 fa 09          	cmp    $0x9,%dx
80101b78:	77 17                	ja     80101b91 <readi+0xf1>
80101b7a:	8b 14 d5 00 f9 10 80 	mov    -0x7fef0700(,%edx,8),%edx
80101b81:	85 d2                	test   %edx,%edx
80101b83:	74 0c                	je     80101b91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b85:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b8f:	ff e2                	jmp    *%edx
      return -1;
80101b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b96:	eb ce                	jmp    80101b66 <readi+0xc6>
80101b98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b9f:	00 

80101ba0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bac:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101baf:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bb2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bb7:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101bba:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101bbd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101bc0:	0f 84 ba 00 00 00    	je     80101c80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bc6:	39 78 58             	cmp    %edi,0x58(%eax)
80101bc9:	0f 82 ea 00 00 00    	jb     80101cb9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bcf:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101bd2:	89 f2                	mov    %esi,%edx
80101bd4:	01 fa                	add    %edi,%edx
80101bd6:	0f 82 dd 00 00 00    	jb     80101cb9 <writei+0x119>
80101bdc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101be2:	0f 87 d1 00 00 00    	ja     80101cb9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be8:	85 f6                	test   %esi,%esi
80101bea:	0f 84 85 00 00 00    	je     80101c75 <writei+0xd5>
80101bf0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101bf7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c00:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c03:	89 fa                	mov    %edi,%edx
80101c05:	c1 ea 09             	shr    $0x9,%edx
80101c08:	89 f0                	mov    %esi,%eax
80101c0a:	e8 51 f8 ff ff       	call   80101460 <bmap>
80101c0f:	83 ec 08             	sub    $0x8,%esp
80101c12:	50                   	push   %eax
80101c13:	ff 36                	push   (%esi)
80101c15:	e8 b6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c1d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c20:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c25:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c27:	89 f8                	mov    %edi,%eax
80101c29:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c2e:	29 d3                	sub    %edx,%ebx
80101c30:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c32:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c36:	39 d9                	cmp    %ebx,%ecx
80101c38:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c3b:	83 c4 0c             	add    $0xc,%esp
80101c3e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c3f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101c41:	ff 75 dc             	push   -0x24(%ebp)
80101c44:	50                   	push   %eax
80101c45:	e8 56 2b 00 00       	call   801047a0 <memmove>
    log_write(bp);
80101c4a:	89 34 24             	mov    %esi,(%esp)
80101c4d:	e8 be 12 00 00       	call   80102f10 <log_write>
    brelse(bp);
80101c52:	89 34 24             	mov    %esi,(%esp)
80101c55:	e8 96 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c5a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c60:	83 c4 10             	add    $0x10,%esp
80101c63:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c66:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c69:	39 d8                	cmp    %ebx,%eax
80101c6b:	72 93                	jb     80101c00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c70:	39 78 58             	cmp    %edi,0x58(%eax)
80101c73:	72 33                	jb     80101ca8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c75:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7b:	5b                   	pop    %ebx
80101c7c:	5e                   	pop    %esi
80101c7d:	5f                   	pop    %edi
80101c7e:	5d                   	pop    %ebp
80101c7f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c84:	66 83 f8 09          	cmp    $0x9,%ax
80101c88:	77 2f                	ja     80101cb9 <writei+0x119>
80101c8a:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 24                	je     80101cb9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101c95:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c9f:	ff e0                	jmp    *%eax
80101ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101ca8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cab:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101cae:	50                   	push   %eax
80101caf:	e8 2c fa ff ff       	call   801016e0 <iupdate>
80101cb4:	83 c4 10             	add    $0x10,%esp
80101cb7:	eb bc                	jmp    80101c75 <writei+0xd5>
      return -1;
80101cb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cbe:	eb b8                	jmp    80101c78 <writei+0xd8>

80101cc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cc6:	6a 0e                	push   $0xe
80101cc8:	ff 75 0c             	push   0xc(%ebp)
80101ccb:	ff 75 08             	push   0x8(%ebp)
80101cce:	e8 3d 2b 00 00       	call   80104810 <strncmp>
}
80101cd3:	c9                   	leave
80101cd4:	c3                   	ret
80101cd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cdc:	00 
80101cdd:	8d 76 00             	lea    0x0(%esi),%esi

80101ce0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cf1:	0f 85 85 00 00 00    	jne    80101d7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cfa:	31 ff                	xor    %edi,%edi
80101cfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cff:	85 d2                	test   %edx,%edx
80101d01:	74 3e                	je     80101d41 <dirlookup+0x61>
80101d03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d08:	6a 10                	push   $0x10
80101d0a:	57                   	push   %edi
80101d0b:	56                   	push   %esi
80101d0c:	53                   	push   %ebx
80101d0d:	e8 8e fd ff ff       	call   80101aa0 <readi>
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	83 f8 10             	cmp    $0x10,%eax
80101d18:	75 55                	jne    80101d6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d1f:	74 18                	je     80101d39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d21:	83 ec 04             	sub    $0x4,%esp
80101d24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d27:	6a 0e                	push   $0xe
80101d29:	50                   	push   %eax
80101d2a:	ff 75 0c             	push   0xc(%ebp)
80101d2d:	e8 de 2a 00 00       	call   80104810 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	85 c0                	test   %eax,%eax
80101d37:	74 17                	je     80101d50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d39:	83 c7 10             	add    $0x10,%edi
80101d3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d3f:	72 c7                	jb     80101d08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d44:	31 c0                	xor    %eax,%eax
}
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret
80101d4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101d50:	8b 45 10             	mov    0x10(%ebp),%eax
80101d53:	85 c0                	test   %eax,%eax
80101d55:	74 05                	je     80101d5c <dirlookup+0x7c>
        *poff = off;
80101d57:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d60:	8b 03                	mov    (%ebx),%eax
80101d62:	e8 89 f5 ff ff       	call   801012f0 <iget>
}
80101d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6a:	5b                   	pop    %ebx
80101d6b:	5e                   	pop    %esi
80101d6c:	5f                   	pop    %edi
80101d6d:	5d                   	pop    %ebp
80101d6e:	c3                   	ret
      panic("dirlookup read");
80101d6f:	83 ec 0c             	sub    $0xc,%esp
80101d72:	68 88 73 10 80       	push   $0x80107388
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 76 73 10 80       	push   $0x80107376
80101d84:	e8 f7 e5 ff ff       	call   80100380 <panic>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101da4:	0f 84 9e 01 00 00    	je     80101f48 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101daa:	e8 d1 1b 00 00       	call   80103980 <myproc>
  acquire(&icache.lock);
80101daf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101db2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101db5:	68 60 f9 10 80       	push   $0x8010f960
80101dba:	e8 51 28 00 00       	call   80104610 <acquire>
  ip->ref++;
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc3:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101dca:	e8 e1 27 00 00       	call   801045b0 <release>
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	eb 07                	jmp    80101ddb <namex+0x4b>
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ddb:	0f b6 03             	movzbl (%ebx),%eax
80101dde:	3c 2f                	cmp    $0x2f,%al
80101de0:	74 f6                	je     80101dd8 <namex+0x48>
  if(*path == 0)
80101de2:	84 c0                	test   %al,%al
80101de4:	0f 84 06 01 00 00    	je     80101ef0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dea:	0f b6 03             	movzbl (%ebx),%eax
80101ded:	84 c0                	test   %al,%al
80101def:	0f 84 10 01 00 00    	je     80101f05 <namex+0x175>
80101df5:	89 df                	mov    %ebx,%edi
80101df7:	3c 2f                	cmp    $0x2f,%al
80101df9:	0f 84 06 01 00 00    	je     80101f05 <namex+0x175>
80101dff:	90                   	nop
80101e00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	74 04                	je     80101e0f <namex+0x7f>
80101e0b:	84 c0                	test   %al,%al
80101e0d:	75 f1                	jne    80101e00 <namex+0x70>
  len = path - s;
80101e0f:	89 f8                	mov    %edi,%eax
80101e11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e13:	83 f8 0d             	cmp    $0xd,%eax
80101e16:	0f 8e ac 00 00 00    	jle    80101ec8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e1c:	83 ec 04             	sub    $0x4,%esp
80101e1f:	6a 0e                	push   $0xe
80101e21:	53                   	push   %ebx
80101e22:	89 fb                	mov    %edi,%ebx
80101e24:	ff 75 e4             	push   -0x1c(%ebp)
80101e27:	e8 74 29 00 00       	call   801047a0 <memmove>
80101e2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e32:	75 0c                	jne    80101e40 <namex+0xb0>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e3e:	74 f8                	je     80101e38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 47 f9 ff ff       	call   80101790 <ilock>
    if(ip->type != T_DIR){
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e51:	0f 85 b7 00 00 00    	jne    80101f0e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 09                	je     80101e67 <namex+0xd7>
80101e5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e61:	0f 84 f7 00 00 00    	je     80101f5e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e67:	83 ec 04             	sub    $0x4,%esp
80101e6a:	6a 00                	push   $0x0
80101e6c:	ff 75 e4             	push   -0x1c(%ebp)
80101e6f:	56                   	push   %esi
80101e70:	e8 6b fe ff ff       	call   80101ce0 <dirlookup>
80101e75:	83 c4 10             	add    $0x10,%esp
80101e78:	89 c7                	mov    %eax,%edi
80101e7a:	85 c0                	test   %eax,%eax
80101e7c:	0f 84 8c 00 00 00    	je     80101f0e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e82:	83 ec 0c             	sub    $0xc,%esp
80101e85:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101e88:	51                   	push   %ecx
80101e89:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101e8c:	e8 3f 25 00 00       	call   801043d0 <holdingsleep>
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	85 c0                	test   %eax,%eax
80101e96:	0f 84 02 01 00 00    	je     80101f9e <namex+0x20e>
80101e9c:	8b 56 08             	mov    0x8(%esi),%edx
80101e9f:	85 d2                	test   %edx,%edx
80101ea1:	0f 8e f7 00 00 00    	jle    80101f9e <namex+0x20e>
  releasesleep(&ip->lock);
80101ea7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	51                   	push   %ecx
80101eae:	e8 dd 24 00 00       	call   80104390 <releasesleep>
  iput(ip);
80101eb3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101eb6:	89 fe                	mov    %edi,%esi
  iput(ip);
80101eb8:	e8 03 fa ff ff       	call   801018c0 <iput>
80101ebd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101ec0:	e9 16 ff ff ff       	jmp    80101ddb <namex+0x4b>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ec8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ecb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101ed4:	50                   	push   %eax
80101ed5:	53                   	push   %ebx
    name[len] = 0;
80101ed6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ed8:	ff 75 e4             	push   -0x1c(%ebp)
80101edb:	e8 c0 28 00 00       	call   801047a0 <memmove>
    name[len] = 0;
80101ee0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 01 00             	movb   $0x0,(%ecx)
80101ee9:	e9 41 ff ff ff       	jmp    80101e2f <namex+0x9f>
80101eee:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101ef0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ef3:	85 c0                	test   %eax,%eax
80101ef5:	0f 85 93 00 00 00    	jne    80101f8e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80101efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efe:	89 f0                	mov    %esi,%eax
80101f00:	5b                   	pop    %ebx
80101f01:	5e                   	pop    %esi
80101f02:	5f                   	pop    %edi
80101f03:	5d                   	pop    %ebp
80101f04:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f05:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f08:	89 df                	mov    %ebx,%edi
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb c0                	jmp    80101ece <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f0e:	83 ec 0c             	sub    $0xc,%esp
80101f11:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f14:	53                   	push   %ebx
80101f15:	e8 b6 24 00 00       	call   801043d0 <holdingsleep>
80101f1a:	83 c4 10             	add    $0x10,%esp
80101f1d:	85 c0                	test   %eax,%eax
80101f1f:	74 7d                	je     80101f9e <namex+0x20e>
80101f21:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f24:	85 c9                	test   %ecx,%ecx
80101f26:	7e 76                	jle    80101f9e <namex+0x20e>
  releasesleep(&ip->lock);
80101f28:	83 ec 0c             	sub    $0xc,%esp
80101f2b:	53                   	push   %ebx
80101f2c:	e8 5f 24 00 00       	call   80104390 <releasesleep>
  iput(ip);
80101f31:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f34:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f36:	e8 85 f9 ff ff       	call   801018c0 <iput>
      return 0;
80101f3b:	83 c4 10             	add    $0x10,%esp
}
80101f3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f41:	89 f0                	mov    %esi,%eax
80101f43:	5b                   	pop    %ebx
80101f44:	5e                   	pop    %esi
80101f45:	5f                   	pop    %edi
80101f46:	5d                   	pop    %ebp
80101f47:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80101f48:	ba 01 00 00 00       	mov    $0x1,%edx
80101f4d:	b8 01 00 00 00       	mov    $0x1,%eax
80101f52:	e8 99 f3 ff ff       	call   801012f0 <iget>
80101f57:	89 c6                	mov    %eax,%esi
80101f59:	e9 7d fe ff ff       	jmp    80101ddb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f5e:	83 ec 0c             	sub    $0xc,%esp
80101f61:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f64:	53                   	push   %ebx
80101f65:	e8 66 24 00 00       	call   801043d0 <holdingsleep>
80101f6a:	83 c4 10             	add    $0x10,%esp
80101f6d:	85 c0                	test   %eax,%eax
80101f6f:	74 2d                	je     80101f9e <namex+0x20e>
80101f71:	8b 7e 08             	mov    0x8(%esi),%edi
80101f74:	85 ff                	test   %edi,%edi
80101f76:	7e 26                	jle    80101f9e <namex+0x20e>
  releasesleep(&ip->lock);
80101f78:	83 ec 0c             	sub    $0xc,%esp
80101f7b:	53                   	push   %ebx
80101f7c:	e8 0f 24 00 00       	call   80104390 <releasesleep>
}
80101f81:	83 c4 10             	add    $0x10,%esp
}
80101f84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f87:	89 f0                	mov    %esi,%eax
80101f89:	5b                   	pop    %ebx
80101f8a:	5e                   	pop    %esi
80101f8b:	5f                   	pop    %edi
80101f8c:	5d                   	pop    %ebp
80101f8d:	c3                   	ret
    iput(ip);
80101f8e:	83 ec 0c             	sub    $0xc,%esp
80101f91:	56                   	push   %esi
      return 0;
80101f92:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f94:	e8 27 f9 ff ff       	call   801018c0 <iput>
    return 0;
80101f99:	83 c4 10             	add    $0x10,%esp
80101f9c:	eb a0                	jmp    80101f3e <namex+0x1ae>
    panic("iunlock");
80101f9e:	83 ec 0c             	sub    $0xc,%esp
80101fa1:	68 6e 73 10 80       	push   $0x8010736e
80101fa6:	e8 d5 e3 ff ff       	call   80100380 <panic>
80101fab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101fb0 <dirlink>:
{
80101fb0:	55                   	push   %ebp
80101fb1:	89 e5                	mov    %esp,%ebp
80101fb3:	57                   	push   %edi
80101fb4:	56                   	push   %esi
80101fb5:	53                   	push   %ebx
80101fb6:	83 ec 20             	sub    $0x20,%esp
80101fb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fbc:	6a 00                	push   $0x0
80101fbe:	ff 75 0c             	push   0xc(%ebp)
80101fc1:	53                   	push   %ebx
80101fc2:	e8 19 fd ff ff       	call   80101ce0 <dirlookup>
80101fc7:	83 c4 10             	add    $0x10,%esp
80101fca:	85 c0                	test   %eax,%eax
80101fcc:	75 67                	jne    80102035 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fce:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fd1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fd4:	85 ff                	test   %edi,%edi
80101fd6:	74 29                	je     80102001 <dirlink+0x51>
80101fd8:	31 ff                	xor    %edi,%edi
80101fda:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fdd:	eb 09                	jmp    80101fe8 <dirlink+0x38>
80101fdf:	90                   	nop
80101fe0:	83 c7 10             	add    $0x10,%edi
80101fe3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fe6:	73 19                	jae    80102001 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fe8:	6a 10                	push   $0x10
80101fea:	57                   	push   %edi
80101feb:	56                   	push   %esi
80101fec:	53                   	push   %ebx
80101fed:	e8 ae fa ff ff       	call   80101aa0 <readi>
80101ff2:	83 c4 10             	add    $0x10,%esp
80101ff5:	83 f8 10             	cmp    $0x10,%eax
80101ff8:	75 4e                	jne    80102048 <dirlink+0x98>
    if(de.inum == 0)
80101ffa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fff:	75 df                	jne    80101fe0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102001:	83 ec 04             	sub    $0x4,%esp
80102004:	8d 45 da             	lea    -0x26(%ebp),%eax
80102007:	6a 0e                	push   $0xe
80102009:	ff 75 0c             	push   0xc(%ebp)
8010200c:	50                   	push   %eax
8010200d:	e8 4e 28 00 00       	call   80104860 <strncpy>
  de.inum = inum;
80102012:	8b 45 10             	mov    0x10(%ebp),%eax
80102015:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102019:	6a 10                	push   $0x10
8010201b:	57                   	push   %edi
8010201c:	56                   	push   %esi
8010201d:	53                   	push   %ebx
8010201e:	e8 7d fb ff ff       	call   80101ba0 <writei>
80102023:	83 c4 20             	add    $0x20,%esp
80102026:	83 f8 10             	cmp    $0x10,%eax
80102029:	75 2a                	jne    80102055 <dirlink+0xa5>
  return 0;
8010202b:	31 c0                	xor    %eax,%eax
}
8010202d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102030:	5b                   	pop    %ebx
80102031:	5e                   	pop    %esi
80102032:	5f                   	pop    %edi
80102033:	5d                   	pop    %ebp
80102034:	c3                   	ret
    iput(ip);
80102035:	83 ec 0c             	sub    $0xc,%esp
80102038:	50                   	push   %eax
80102039:	e8 82 f8 ff ff       	call   801018c0 <iput>
    return -1;
8010203e:	83 c4 10             	add    $0x10,%esp
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	eb e5                	jmp    8010202d <dirlink+0x7d>
      panic("dirlink read");
80102048:	83 ec 0c             	sub    $0xc,%esp
8010204b:	68 97 73 10 80       	push   $0x80107397
80102050:	e8 2b e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102055:	83 ec 0c             	sub    $0xc,%esp
80102058:	68 0f 76 10 80       	push   $0x8010760f
8010205d:	e8 1e e3 ff ff       	call   80100380 <panic>
80102062:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102069:	00 
8010206a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102070 <namei>:

struct inode*
namei(char *path)
{
80102070:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102071:	31 d2                	xor    %edx,%edx
{
80102073:	89 e5                	mov    %esp,%ebp
80102075:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102078:	8b 45 08             	mov    0x8(%ebp),%eax
8010207b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010207e:	e8 0d fd ff ff       	call   80101d90 <namex>
}
80102083:	c9                   	leave
80102084:	c3                   	ret
80102085:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010208c:	00 
8010208d:	8d 76 00             	lea    0x0(%esi),%esi

80102090 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102090:	55                   	push   %ebp
  return namex(path, 1, name);
80102091:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102096:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102098:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010209b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010209e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010209f:	e9 ec fc ff ff       	jmp    80101d90 <namex>
801020a4:	66 90                	xchg   %ax,%ax
801020a6:	66 90                	xchg   %ax,%ax
801020a8:	66 90                	xchg   %ax,%ax
801020aa:	66 90                	xchg   %ax,%ax
801020ac:	66 90                	xchg   %ax,%ax
801020ae:	66 90                	xchg   %ax,%ax

801020b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020b9:	85 c0                	test   %eax,%eax
801020bb:	0f 84 b4 00 00 00    	je     80102175 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020c1:	8b 70 08             	mov    0x8(%eax),%esi
801020c4:	89 c3                	mov    %eax,%ebx
801020c6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020cc:	0f 87 96 00 00 00    	ja     80102168 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020de:	00 
801020df:	90                   	nop
801020e0:	89 ca                	mov    %ecx,%edx
801020e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e3:	83 e0 c0             	and    $0xffffffc0,%eax
801020e6:	3c 40                	cmp    $0x40,%al
801020e8:	75 f6                	jne    801020e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ea:	31 ff                	xor    %edi,%edi
801020ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020f1:	89 f8                	mov    %edi,%eax
801020f3:	ee                   	out    %al,(%dx)
801020f4:	b8 01 00 00 00       	mov    $0x1,%eax
801020f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020fe:	ee                   	out    %al,(%dx)
801020ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102104:	89 f0                	mov    %esi,%eax
80102106:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102107:	89 f0                	mov    %esi,%eax
80102109:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010210e:	c1 f8 08             	sar    $0x8,%eax
80102111:	ee                   	out    %al,(%dx)
80102112:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102117:	89 f8                	mov    %edi,%eax
80102119:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010211a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010211e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102123:	c1 e0 04             	shl    $0x4,%eax
80102126:	83 e0 10             	and    $0x10,%eax
80102129:	83 c8 e0             	or     $0xffffffe0,%eax
8010212c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010212d:	f6 03 04             	testb  $0x4,(%ebx)
80102130:	75 16                	jne    80102148 <idestart+0x98>
80102132:	b8 20 00 00 00       	mov    $0x20,%eax
80102137:	89 ca                	mov    %ecx,%edx
80102139:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010213a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213d:	5b                   	pop    %ebx
8010213e:	5e                   	pop    %esi
8010213f:	5f                   	pop    %edi
80102140:	5d                   	pop    %ebp
80102141:	c3                   	ret
80102142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102148:	b8 30 00 00 00       	mov    $0x30,%eax
8010214d:	89 ca                	mov    %ecx,%edx
8010214f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102150:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102155:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102158:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010215d:	fc                   	cld
8010215e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102160:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102163:	5b                   	pop    %ebx
80102164:	5e                   	pop    %esi
80102165:	5f                   	pop    %edi
80102166:	5d                   	pop    %ebp
80102167:	c3                   	ret
    panic("incorrect blockno");
80102168:	83 ec 0c             	sub    $0xc,%esp
8010216b:	68 ad 73 10 80       	push   $0x801073ad
80102170:	e8 0b e2 ff ff       	call   80100380 <panic>
    panic("idestart");
80102175:	83 ec 0c             	sub    $0xc,%esp
80102178:	68 a4 73 10 80       	push   $0x801073a4
8010217d:	e8 fe e1 ff ff       	call   80100380 <panic>
80102182:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102189:	00 
8010218a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102190 <ideinit>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102196:	68 bf 73 10 80       	push   $0x801073bf
8010219b:	68 20 32 11 80       	push   $0x80113220
801021a0:	e8 7b 22 00 00       	call   80104420 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021a5:	58                   	pop    %eax
801021a6:	a1 a4 33 11 80       	mov    0x801133a4,%eax
801021ab:	5a                   	pop    %edx
801021ac:	83 e8 01             	sub    $0x1,%eax
801021af:	50                   	push   %eax
801021b0:	6a 0e                	push   $0xe
801021b2:	e8 99 02 00 00       	call   80102450 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ba:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801021bf:	90                   	nop
801021c0:	89 ca                	mov    %ecx,%edx
801021c2:	ec                   	in     (%dx),%al
801021c3:	83 e0 c0             	and    $0xffffffc0,%eax
801021c6:	3c 40                	cmp    $0x40,%al
801021c8:	75 f6                	jne    801021c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021ca:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021cf:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021d4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021d5:	89 ca                	mov    %ecx,%edx
801021d7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021d8:	84 c0                	test   %al,%al
801021da:	75 1e                	jne    801021fa <ideinit+0x6a>
801021dc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
801021e1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021ed:	00 
801021ee:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801021f0:	83 e9 01             	sub    $0x1,%ecx
801021f3:	74 0f                	je     80102204 <ideinit+0x74>
801021f5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021f6:	84 c0                	test   %al,%al
801021f8:	74 f6                	je     801021f0 <ideinit+0x60>
      havedisk1 = 1;
801021fa:	c7 05 00 32 11 80 01 	movl   $0x1,0x80113200
80102201:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102204:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102209:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010220e:	ee                   	out    %al,(%dx)
}
8010220f:	c9                   	leave
80102210:	c3                   	ret
80102211:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102218:	00 
80102219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102220 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	57                   	push   %edi
80102224:	56                   	push   %esi
80102225:	53                   	push   %ebx
80102226:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102229:	68 20 32 11 80       	push   $0x80113220
8010222e:	e8 dd 23 00 00       	call   80104610 <acquire>

  if((b = idequeue) == 0){
80102233:	8b 1d 04 32 11 80    	mov    0x80113204,%ebx
80102239:	83 c4 10             	add    $0x10,%esp
8010223c:	85 db                	test   %ebx,%ebx
8010223e:	74 63                	je     801022a3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102240:	8b 43 58             	mov    0x58(%ebx),%eax
80102243:	a3 04 32 11 80       	mov    %eax,0x80113204

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102248:	8b 33                	mov    (%ebx),%esi
8010224a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102250:	75 2f                	jne    80102281 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102252:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010225e:	00 
8010225f:	90                   	nop
80102260:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102261:	89 c1                	mov    %eax,%ecx
80102263:	83 e1 c0             	and    $0xffffffc0,%ecx
80102266:	80 f9 40             	cmp    $0x40,%cl
80102269:	75 f5                	jne    80102260 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010226b:	a8 21                	test   $0x21,%al
8010226d:	75 12                	jne    80102281 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010226f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102272:	b9 80 00 00 00       	mov    $0x80,%ecx
80102277:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010227c:	fc                   	cld
8010227d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010227f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102281:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102284:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102287:	83 ce 02             	or     $0x2,%esi
8010228a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010228c:	53                   	push   %ebx
8010228d:	e8 6e 1e 00 00       	call   80104100 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102292:	a1 04 32 11 80       	mov    0x80113204,%eax
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	85 c0                	test   %eax,%eax
8010229c:	74 05                	je     801022a3 <ideintr+0x83>
    idestart(idequeue);
8010229e:	e8 0d fe ff ff       	call   801020b0 <idestart>
    release(&idelock);
801022a3:	83 ec 0c             	sub    $0xc,%esp
801022a6:	68 20 32 11 80       	push   $0x80113220
801022ab:	e8 00 23 00 00       	call   801045b0 <release>

  release(&idelock);
}
801022b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b3:	5b                   	pop    %ebx
801022b4:	5e                   	pop    %esi
801022b5:	5f                   	pop    %edi
801022b6:	5d                   	pop    %ebp
801022b7:	c3                   	ret
801022b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022bf:	00 

801022c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	53                   	push   %ebx
801022c4:	83 ec 10             	sub    $0x10,%esp
801022c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801022cd:	50                   	push   %eax
801022ce:	e8 fd 20 00 00       	call   801043d0 <holdingsleep>
801022d3:	83 c4 10             	add    $0x10,%esp
801022d6:	85 c0                	test   %eax,%eax
801022d8:	0f 84 c3 00 00 00    	je     801023a1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022de:	8b 03                	mov    (%ebx),%eax
801022e0:	83 e0 06             	and    $0x6,%eax
801022e3:	83 f8 02             	cmp    $0x2,%eax
801022e6:	0f 84 a8 00 00 00    	je     80102394 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022ec:	8b 53 04             	mov    0x4(%ebx),%edx
801022ef:	85 d2                	test   %edx,%edx
801022f1:	74 0d                	je     80102300 <iderw+0x40>
801022f3:	a1 00 32 11 80       	mov    0x80113200,%eax
801022f8:	85 c0                	test   %eax,%eax
801022fa:	0f 84 87 00 00 00    	je     80102387 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	68 20 32 11 80       	push   $0x80113220
80102308:	e8 03 23 00 00       	call   80104610 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010230d:	a1 04 32 11 80       	mov    0x80113204,%eax
  b->qnext = 0;
80102312:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102319:	83 c4 10             	add    $0x10,%esp
8010231c:	85 c0                	test   %eax,%eax
8010231e:	74 60                	je     80102380 <iderw+0xc0>
80102320:	89 c2                	mov    %eax,%edx
80102322:	8b 40 58             	mov    0x58(%eax),%eax
80102325:	85 c0                	test   %eax,%eax
80102327:	75 f7                	jne    80102320 <iderw+0x60>
80102329:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010232c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010232e:	39 1d 04 32 11 80    	cmp    %ebx,0x80113204
80102334:	74 3a                	je     80102370 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102336:	8b 03                	mov    (%ebx),%eax
80102338:	83 e0 06             	and    $0x6,%eax
8010233b:	83 f8 02             	cmp    $0x2,%eax
8010233e:	74 1b                	je     8010235b <iderw+0x9b>
    sleep(b, &idelock);
80102340:	83 ec 08             	sub    $0x8,%esp
80102343:	68 20 32 11 80       	push   $0x80113220
80102348:	53                   	push   %ebx
80102349:	e8 f2 1c 00 00       	call   80104040 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010234e:	8b 03                	mov    (%ebx),%eax
80102350:	83 c4 10             	add    $0x10,%esp
80102353:	83 e0 06             	and    $0x6,%eax
80102356:	83 f8 02             	cmp    $0x2,%eax
80102359:	75 e5                	jne    80102340 <iderw+0x80>
  }


  release(&idelock);
8010235b:	c7 45 08 20 32 11 80 	movl   $0x80113220,0x8(%ebp)
}
80102362:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102365:	c9                   	leave
  release(&idelock);
80102366:	e9 45 22 00 00       	jmp    801045b0 <release>
8010236b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102370:	89 d8                	mov    %ebx,%eax
80102372:	e8 39 fd ff ff       	call   801020b0 <idestart>
80102377:	eb bd                	jmp    80102336 <iderw+0x76>
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102380:	ba 04 32 11 80       	mov    $0x80113204,%edx
80102385:	eb a5                	jmp    8010232c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102387:	83 ec 0c             	sub    $0xc,%esp
8010238a:	68 ee 73 10 80       	push   $0x801073ee
8010238f:	e8 ec df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 d9 73 10 80       	push   $0x801073d9
8010239c:	e8 df df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023a1:	83 ec 0c             	sub    $0xc,%esp
801023a4:	68 c3 73 10 80       	push   $0x801073c3
801023a9:	e8 d2 df ff ff       	call   80100380 <panic>
801023ae:	66 90                	xchg   %ax,%ax

801023b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023b5:	c7 05 54 32 11 80 00 	movl   $0xfec00000,0x80113254
801023bc:	00 c0 fe 
  ioapic->reg = reg;
801023bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023c6:	00 00 00 
  return ioapic->data;
801023c9:	8b 15 54 32 11 80    	mov    0x80113254,%edx
801023cf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023d8:	8b 1d 54 32 11 80    	mov    0x80113254,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023de:	0f b6 15 a0 33 11 80 	movzbl 0x801133a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023e5:	c1 ee 10             	shr    $0x10,%esi
801023e8:	89 f0                	mov    %esi,%eax
801023ea:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801023ed:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801023f0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023f3:	39 c2                	cmp    %eax,%edx
801023f5:	74 16                	je     8010240d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	68 c4 77 10 80       	push   $0x801077c4
801023ff:	e8 ac e2 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
80102404:	8b 1d 54 32 11 80    	mov    0x80113254,%ebx
8010240a:	83 c4 10             	add    $0x10,%esp
{
8010240d:	ba 10 00 00 00       	mov    $0x10,%edx
80102412:	31 c0                	xor    %eax,%eax
80102414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102418:	89 13                	mov    %edx,(%ebx)
8010241a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010241d:	8b 1d 54 32 11 80    	mov    0x80113254,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102423:	83 c0 01             	add    $0x1,%eax
80102426:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010242c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010242f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102432:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102435:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102437:	8b 1d 54 32 11 80    	mov    0x80113254,%ebx
8010243d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102444:	39 c6                	cmp    %eax,%esi
80102446:	7d d0                	jge    80102418 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102448:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010244b:	5b                   	pop    %ebx
8010244c:	5e                   	pop    %esi
8010244d:	5d                   	pop    %ebp
8010244e:	c3                   	ret
8010244f:	90                   	nop

80102450 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102450:	55                   	push   %ebp
  ioapic->reg = reg;
80102451:	8b 0d 54 32 11 80    	mov    0x80113254,%ecx
{
80102457:	89 e5                	mov    %esp,%ebp
80102459:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010245c:	8d 50 20             	lea    0x20(%eax),%edx
8010245f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102463:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102465:	8b 0d 54 32 11 80    	mov    0x80113254,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010246b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010246e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102471:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102474:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102476:	a1 54 32 11 80       	mov    0x80113254,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010247b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010247e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret
80102483:	66 90                	xchg   %ax,%ax
80102485:	66 90                	xchg   %ax,%ax
80102487:	66 90                	xchg   %ax,%ax
80102489:	66 90                	xchg   %ax,%ax
8010248b:	66 90                	xchg   %ax,%ax
8010248d:	66 90                	xchg   %ax,%ax
8010248f:	90                   	nop

80102490 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 04             	sub    $0x4,%esp
80102497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010249a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024a0:	75 76                	jne    80102518 <kfree+0x88>
801024a2:	81 fb f0 70 11 80    	cmp    $0x801170f0,%ebx
801024a8:	72 6e                	jb     80102518 <kfree+0x88>
801024aa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024b0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024b5:	77 61                	ja     80102518 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024b7:	83 ec 04             	sub    $0x4,%esp
801024ba:	68 00 10 00 00       	push   $0x1000
801024bf:	6a 01                	push   $0x1
801024c1:	53                   	push   %ebx
801024c2:	e8 49 22 00 00       	call   80104710 <memset>

  if(kmem.use_lock)
801024c7:	8b 15 94 32 11 80    	mov    0x80113294,%edx
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	85 d2                	test   %edx,%edx
801024d2:	75 1c                	jne    801024f0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024d4:	a1 98 32 11 80       	mov    0x80113298,%eax
801024d9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024db:	a1 94 32 11 80       	mov    0x80113294,%eax
  kmem.freelist = r;
801024e0:	89 1d 98 32 11 80    	mov    %ebx,0x80113298
  if(kmem.use_lock)
801024e6:	85 c0                	test   %eax,%eax
801024e8:	75 1e                	jne    80102508 <kfree+0x78>
    release(&kmem.lock);
}
801024ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024ed:	c9                   	leave
801024ee:	c3                   	ret
801024ef:	90                   	nop
    acquire(&kmem.lock);
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 60 32 11 80       	push   $0x80113260
801024f8:	e8 13 21 00 00       	call   80104610 <acquire>
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	eb d2                	jmp    801024d4 <kfree+0x44>
80102502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102508:	c7 45 08 60 32 11 80 	movl   $0x80113260,0x8(%ebp)
}
8010250f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102512:	c9                   	leave
    release(&kmem.lock);
80102513:	e9 98 20 00 00       	jmp    801045b0 <release>
    panic("kfree");
80102518:	83 ec 0c             	sub    $0xc,%esp
8010251b:	68 0c 74 10 80       	push   $0x8010740c
80102520:	e8 5b de ff ff       	call   80100380 <panic>
80102525:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010252c:	00 
8010252d:	8d 76 00             	lea    0x0(%esi),%esi

80102530 <freerange>:
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	56                   	push   %esi
80102534:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102535:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102538:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010253b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102541:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102547:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010254d:	39 de                	cmp    %ebx,%esi
8010254f:	72 23                	jb     80102574 <freerange+0x44>
80102551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102558:	83 ec 0c             	sub    $0xc,%esp
8010255b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 23 ff ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 de                	cmp    %ebx,%esi
80102572:	73 e4                	jae    80102558 <freerange+0x28>
}
80102574:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102577:	5b                   	pop    %ebx
80102578:	5e                   	pop    %esi
80102579:	5d                   	pop    %ebp
8010257a:	c3                   	ret
8010257b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102580 <kinit2>:
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	56                   	push   %esi
80102584:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102585:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102588:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010258b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102591:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102597:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010259d:	39 de                	cmp    %ebx,%esi
8010259f:	72 23                	jb     801025c4 <kinit2+0x44>
801025a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025a8:	83 ec 0c             	sub    $0xc,%esp
801025ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025b7:	50                   	push   %eax
801025b8:	e8 d3 fe ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025bd:	83 c4 10             	add    $0x10,%esp
801025c0:	39 de                	cmp    %ebx,%esi
801025c2:	73 e4                	jae    801025a8 <kinit2+0x28>
  kmem.use_lock = 1;
801025c4:	c7 05 94 32 11 80 01 	movl   $0x1,0x80113294
801025cb:	00 00 00 
}
801025ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025d1:	5b                   	pop    %ebx
801025d2:	5e                   	pop    %esi
801025d3:	5d                   	pop    %ebp
801025d4:	c3                   	ret
801025d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025dc:	00 
801025dd:	8d 76 00             	lea    0x0(%esi),%esi

801025e0 <kinit1>:
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	56                   	push   %esi
801025e4:	53                   	push   %ebx
801025e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801025e8:	83 ec 08             	sub    $0x8,%esp
801025eb:	68 12 74 10 80       	push   $0x80107412
801025f0:	68 60 32 11 80       	push   $0x80113260
801025f5:	e8 26 1e 00 00       	call   80104420 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801025fa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025fd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102600:	c7 05 94 32 11 80 00 	movl   $0x0,0x80113294
80102607:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010260a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102610:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102616:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010261c:	39 de                	cmp    %ebx,%esi
8010261e:	72 1c                	jb     8010263c <kinit1+0x5c>
    kfree(p);
80102620:	83 ec 0c             	sub    $0xc,%esp
80102623:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102629:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010262f:	50                   	push   %eax
80102630:	e8 5b fe ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102635:	83 c4 10             	add    $0x10,%esp
80102638:	39 de                	cmp    %ebx,%esi
8010263a:	73 e4                	jae    80102620 <kinit1+0x40>
}
8010263c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010263f:	5b                   	pop    %ebx
80102640:	5e                   	pop    %esi
80102641:	5d                   	pop    %ebp
80102642:	c3                   	ret
80102643:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010264a:	00 
8010264b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102650 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	53                   	push   %ebx
80102654:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102657:	a1 94 32 11 80       	mov    0x80113294,%eax
8010265c:	85 c0                	test   %eax,%eax
8010265e:	75 20                	jne    80102680 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102660:	8b 1d 98 32 11 80    	mov    0x80113298,%ebx
  if(r)
80102666:	85 db                	test   %ebx,%ebx
80102668:	74 07                	je     80102671 <kalloc+0x21>
    kmem.freelist = r->next;
8010266a:	8b 03                	mov    (%ebx),%eax
8010266c:	a3 98 32 11 80       	mov    %eax,0x80113298
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102671:	89 d8                	mov    %ebx,%eax
80102673:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102676:	c9                   	leave
80102677:	c3                   	ret
80102678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010267f:	00 
    acquire(&kmem.lock);
80102680:	83 ec 0c             	sub    $0xc,%esp
80102683:	68 60 32 11 80       	push   $0x80113260
80102688:	e8 83 1f 00 00       	call   80104610 <acquire>
  r = kmem.freelist;
8010268d:	8b 1d 98 32 11 80    	mov    0x80113298,%ebx
  if(kmem.use_lock)
80102693:	a1 94 32 11 80       	mov    0x80113294,%eax
  if(r)
80102698:	83 c4 10             	add    $0x10,%esp
8010269b:	85 db                	test   %ebx,%ebx
8010269d:	74 08                	je     801026a7 <kalloc+0x57>
    kmem.freelist = r->next;
8010269f:	8b 13                	mov    (%ebx),%edx
801026a1:	89 15 98 32 11 80    	mov    %edx,0x80113298
  if(kmem.use_lock)
801026a7:	85 c0                	test   %eax,%eax
801026a9:	74 c6                	je     80102671 <kalloc+0x21>
    release(&kmem.lock);
801026ab:	83 ec 0c             	sub    $0xc,%esp
801026ae:	68 60 32 11 80       	push   $0x80113260
801026b3:	e8 f8 1e 00 00       	call   801045b0 <release>
}
801026b8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801026ba:	83 c4 10             	add    $0x10,%esp
}
801026bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026c0:	c9                   	leave
801026c1:	c3                   	ret
801026c2:	66 90                	xchg   %ax,%ax
801026c4:	66 90                	xchg   %ax,%ax
801026c6:	66 90                	xchg   %ax,%ax
801026c8:	66 90                	xchg   %ax,%ax
801026ca:	66 90                	xchg   %ax,%ax
801026cc:	66 90                	xchg   %ax,%ax
801026ce:	66 90                	xchg   %ax,%ax

801026d0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026d0:	ba 64 00 00 00       	mov    $0x64,%edx
801026d5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026d6:	a8 01                	test   $0x1,%al
801026d8:	0f 84 c2 00 00 00    	je     801027a0 <kbdgetc+0xd0>
{
801026de:	55                   	push   %ebp
801026df:	ba 60 00 00 00       	mov    $0x60,%edx
801026e4:	89 e5                	mov    %esp,%ebp
801026e6:	53                   	push   %ebx
801026e7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801026e8:	8b 1d 9c 32 11 80    	mov    0x8011329c,%ebx
  data = inb(KBDATAP);
801026ee:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801026f1:	3c e0                	cmp    $0xe0,%al
801026f3:	74 5b                	je     80102750 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026f5:	89 da                	mov    %ebx,%edx
801026f7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801026fa:	84 c0                	test   %al,%al
801026fc:	78 62                	js     80102760 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026fe:	85 d2                	test   %edx,%edx
80102700:	74 09                	je     8010270b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102702:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102705:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102708:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010270b:	0f b6 91 a0 7a 10 80 	movzbl -0x7fef8560(%ecx),%edx
  shift ^= togglecode[data];
80102712:	0f b6 81 a0 79 10 80 	movzbl -0x7fef8660(%ecx),%eax
  shift |= shiftcode[data];
80102719:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010271b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010271d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010271f:	89 15 9c 32 11 80    	mov    %edx,0x8011329c
  c = charcode[shift & (CTL | SHIFT)][data];
80102725:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102728:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010272b:	8b 04 85 80 79 10 80 	mov    -0x7fef8680(,%eax,4),%eax
80102732:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102736:	74 0b                	je     80102743 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102738:	8d 50 9f             	lea    -0x61(%eax),%edx
8010273b:	83 fa 19             	cmp    $0x19,%edx
8010273e:	77 48                	ja     80102788 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102740:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102743:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102746:	c9                   	leave
80102747:	c3                   	ret
80102748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010274f:	00 
    shift |= E0ESC;
80102750:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102753:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102755:	89 1d 9c 32 11 80    	mov    %ebx,0x8011329c
}
8010275b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010275e:	c9                   	leave
8010275f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102760:	83 e0 7f             	and    $0x7f,%eax
80102763:	85 d2                	test   %edx,%edx
80102765:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102768:	0f b6 81 a0 7a 10 80 	movzbl -0x7fef8560(%ecx),%eax
8010276f:	83 c8 40             	or     $0x40,%eax
80102772:	0f b6 c0             	movzbl %al,%eax
80102775:	f7 d0                	not    %eax
80102777:	21 d8                	and    %ebx,%eax
80102779:	a3 9c 32 11 80       	mov    %eax,0x8011329c
    return 0;
8010277e:	31 c0                	xor    %eax,%eax
80102780:	eb d9                	jmp    8010275b <kbdgetc+0x8b>
80102782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102788:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010278b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010278e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102791:	c9                   	leave
      c += 'a' - 'A';
80102792:	83 f9 1a             	cmp    $0x1a,%ecx
80102795:	0f 42 c2             	cmovb  %edx,%eax
}
80102798:	c3                   	ret
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027a5:	c3                   	ret
801027a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027ad:	00 
801027ae:	66 90                	xchg   %ax,%ax

801027b0 <kbdintr>:

void
kbdintr(void)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027b6:	68 d0 26 10 80       	push   $0x801026d0
801027bb:	e8 e0 e0 ff ff       	call   801008a0 <consoleintr>
}
801027c0:	83 c4 10             	add    $0x10,%esp
801027c3:	c9                   	leave
801027c4:	c3                   	ret
801027c5:	66 90                	xchg   %ax,%ax
801027c7:	66 90                	xchg   %ax,%ax
801027c9:	66 90                	xchg   %ax,%ax
801027cb:	66 90                	xchg   %ax,%ax
801027cd:	66 90                	xchg   %ax,%ax
801027cf:	90                   	nop

801027d0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027d0:	a1 a0 32 11 80       	mov    0x801132a0,%eax
801027d5:	85 c0                	test   %eax,%eax
801027d7:	0f 84 c3 00 00 00    	je     801028a0 <lapicinit+0xd0>
  lapic[index] = value;
801027dd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027e4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ea:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027f1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027fe:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102801:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102804:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010280b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102818:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010281e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102825:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102828:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010282b:	8b 50 30             	mov    0x30(%eax),%edx
8010282e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102834:	75 72                	jne    801028a8 <lapicinit+0xd8>
  lapic[index] = value;
80102836:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010283d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102840:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102843:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010284a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102850:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102857:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102864:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102867:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010286a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102871:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102874:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102877:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010287e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102881:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102888:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010288e:	80 e6 10             	and    $0x10,%dh
80102891:	75 f5                	jne    80102888 <lapicinit+0xb8>
  lapic[index] = value;
80102893:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010289a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010289d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028a0:	c3                   	ret
801028a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028a8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028af:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028b2:	8b 50 20             	mov    0x20(%eax),%edx
}
801028b5:	e9 7c ff ff ff       	jmp    80102836 <lapicinit+0x66>
801028ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028c0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028c0:	a1 a0 32 11 80       	mov    0x801132a0,%eax
801028c5:	85 c0                	test   %eax,%eax
801028c7:	74 07                	je     801028d0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028c9:	8b 40 20             	mov    0x20(%eax),%eax
801028cc:	c1 e8 18             	shr    $0x18,%eax
801028cf:	c3                   	ret
    return 0;
801028d0:	31 c0                	xor    %eax,%eax
}
801028d2:	c3                   	ret
801028d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028da:	00 
801028db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801028e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028e0:	a1 a0 32 11 80       	mov    0x801132a0,%eax
801028e5:	85 c0                	test   %eax,%eax
801028e7:	74 0d                	je     801028f6 <lapiceoi+0x16>
  lapic[index] = value;
801028e9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028f0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028f6:	c3                   	ret
801028f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028fe:	00 
801028ff:	90                   	nop

80102900 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102900:	c3                   	ret
80102901:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102908:	00 
80102909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102910 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102910:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102911:	b8 0f 00 00 00       	mov    $0xf,%eax
80102916:	ba 70 00 00 00       	mov    $0x70,%edx
8010291b:	89 e5                	mov    %esp,%ebp
8010291d:	53                   	push   %ebx
8010291e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102921:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102924:	ee                   	out    %al,(%dx)
80102925:	b8 0a 00 00 00       	mov    $0xa,%eax
8010292a:	ba 71 00 00 00       	mov    $0x71,%edx
8010292f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102930:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102932:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102935:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010293b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010293d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102940:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102942:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102945:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102948:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010294e:	a1 a0 32 11 80       	mov    0x801132a0,%eax
80102953:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102959:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010295c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102963:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102966:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102969:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102970:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102973:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102976:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010297c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010297f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102985:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102988:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010298e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102991:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102997:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010299a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010299d:	c9                   	leave
8010299e:	c3                   	ret
8010299f:	90                   	nop

801029a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029a0:	55                   	push   %ebp
801029a1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029a6:	ba 70 00 00 00       	mov    $0x70,%edx
801029ab:	89 e5                	mov    %esp,%ebp
801029ad:	57                   	push   %edi
801029ae:	56                   	push   %esi
801029af:	53                   	push   %ebx
801029b0:	83 ec 4c             	sub    $0x4c,%esp
801029b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b4:	ba 71 00 00 00       	mov    $0x71,%edx
801029b9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029bd:	bf 70 00 00 00       	mov    $0x70,%edi
801029c2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029c5:	8d 76 00             	lea    0x0(%esi),%esi
801029c8:	31 c0                	xor    %eax,%eax
801029ca:	89 fa                	mov    %edi,%edx
801029cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cd:	b9 71 00 00 00       	mov    $0x71,%ecx
801029d2:	89 ca                	mov    %ecx,%edx
801029d4:	ec                   	in     (%dx),%al
801029d5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d8:	89 fa                	mov    %edi,%edx
801029da:	b8 02 00 00 00       	mov    $0x2,%eax
801029df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e0:	89 ca                	mov    %ecx,%edx
801029e2:	ec                   	in     (%dx),%al
801029e3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e6:	89 fa                	mov    %edi,%edx
801029e8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ee:	89 ca                	mov    %ecx,%edx
801029f0:	ec                   	in     (%dx),%al
801029f1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f4:	89 fa                	mov    %edi,%edx
801029f6:	b8 07 00 00 00       	mov    $0x7,%eax
801029fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fc:	89 ca                	mov    %ecx,%edx
801029fe:	ec                   	in     (%dx),%al
801029ff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a02:	89 fa                	mov    %edi,%edx
80102a04:	b8 08 00 00 00       	mov    $0x8,%eax
80102a09:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0a:	89 ca                	mov    %ecx,%edx
80102a0c:	ec                   	in     (%dx),%al
80102a0d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a0f:	89 fa                	mov    %edi,%edx
80102a11:	b8 09 00 00 00       	mov    $0x9,%eax
80102a16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a17:	89 ca                	mov    %ecx,%edx
80102a19:	ec                   	in     (%dx),%al
80102a1a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a1d:	89 fa                	mov    %edi,%edx
80102a1f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a24:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a25:	89 ca                	mov    %ecx,%edx
80102a27:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a28:	84 c0                	test   %al,%al
80102a2a:	78 9c                	js     801029c8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a2c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a30:	89 f2                	mov    %esi,%edx
80102a32:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102a35:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a38:	89 fa                	mov    %edi,%edx
80102a3a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a3d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a41:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102a44:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a47:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a4b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a4e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a52:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a55:	31 c0                	xor    %eax,%eax
80102a57:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a58:	89 ca                	mov    %ecx,%edx
80102a5a:	ec                   	in     (%dx),%al
80102a5b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a5e:	89 fa                	mov    %edi,%edx
80102a60:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a63:	b8 02 00 00 00       	mov    $0x2,%eax
80102a68:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a69:	89 ca                	mov    %ecx,%edx
80102a6b:	ec                   	in     (%dx),%al
80102a6c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a6f:	89 fa                	mov    %edi,%edx
80102a71:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a74:	b8 04 00 00 00       	mov    $0x4,%eax
80102a79:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7a:	89 ca                	mov    %ecx,%edx
80102a7c:	ec                   	in     (%dx),%al
80102a7d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a80:	89 fa                	mov    %edi,%edx
80102a82:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a85:	b8 07 00 00 00       	mov    $0x7,%eax
80102a8a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8b:	89 ca                	mov    %ecx,%edx
80102a8d:	ec                   	in     (%dx),%al
80102a8e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a91:	89 fa                	mov    %edi,%edx
80102a93:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a96:	b8 08 00 00 00       	mov    $0x8,%eax
80102a9b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9c:	89 ca                	mov    %ecx,%edx
80102a9e:	ec                   	in     (%dx),%al
80102a9f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa2:	89 fa                	mov    %edi,%edx
80102aa4:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102aa7:	b8 09 00 00 00       	mov    $0x9,%eax
80102aac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aad:	89 ca                	mov    %ecx,%edx
80102aaf:	ec                   	in     (%dx),%al
80102ab0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ab3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ab6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ab9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102abc:	6a 18                	push   $0x18
80102abe:	50                   	push   %eax
80102abf:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ac2:	50                   	push   %eax
80102ac3:	e8 88 1c 00 00       	call   80104750 <memcmp>
80102ac8:	83 c4 10             	add    $0x10,%esp
80102acb:	85 c0                	test   %eax,%eax
80102acd:	0f 85 f5 fe ff ff    	jne    801029c8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ad3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ada:	89 f0                	mov    %esi,%eax
80102adc:	84 c0                	test   %al,%al
80102ade:	75 78                	jne    80102b58 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ae0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ae3:	89 c2                	mov    %eax,%edx
80102ae5:	83 e0 0f             	and    $0xf,%eax
80102ae8:	c1 ea 04             	shr    $0x4,%edx
80102aeb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aee:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102af4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102af7:	89 c2                	mov    %eax,%edx
80102af9:	83 e0 0f             	and    $0xf,%eax
80102afc:	c1 ea 04             	shr    $0x4,%edx
80102aff:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b02:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b05:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b08:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b0b:	89 c2                	mov    %eax,%edx
80102b0d:	83 e0 0f             	and    $0xf,%eax
80102b10:	c1 ea 04             	shr    $0x4,%edx
80102b13:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b16:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b19:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b1c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b1f:	89 c2                	mov    %eax,%edx
80102b21:	83 e0 0f             	and    $0xf,%eax
80102b24:	c1 ea 04             	shr    $0x4,%edx
80102b27:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b30:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b33:	89 c2                	mov    %eax,%edx
80102b35:	83 e0 0f             	and    $0xf,%eax
80102b38:	c1 ea 04             	shr    $0x4,%edx
80102b3b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b3e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b41:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b44:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b47:	89 c2                	mov    %eax,%edx
80102b49:	83 e0 0f             	and    $0xf,%eax
80102b4c:	c1 ea 04             	shr    $0x4,%edx
80102b4f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b52:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b55:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b58:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b5b:	89 03                	mov    %eax,(%ebx)
80102b5d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b60:	89 43 04             	mov    %eax,0x4(%ebx)
80102b63:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b66:	89 43 08             	mov    %eax,0x8(%ebx)
80102b69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b6c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102b6f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b72:	89 43 10             	mov    %eax,0x10(%ebx)
80102b75:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b78:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102b7b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b85:	5b                   	pop    %ebx
80102b86:	5e                   	pop    %esi
80102b87:	5f                   	pop    %edi
80102b88:	5d                   	pop    %ebp
80102b89:	c3                   	ret
80102b8a:	66 90                	xchg   %ax,%ax
80102b8c:	66 90                	xchg   %ax,%ax
80102b8e:	66 90                	xchg   %ax,%ax

80102b90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b90:	8b 0d 08 33 11 80    	mov    0x80113308,%ecx
80102b96:	85 c9                	test   %ecx,%ecx
80102b98:	0f 8e 8a 00 00 00    	jle    80102c28 <install_trans+0x98>
{
80102b9e:	55                   	push   %ebp
80102b9f:	89 e5                	mov    %esp,%ebp
80102ba1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102ba2:	31 ff                	xor    %edi,%edi
{
80102ba4:	56                   	push   %esi
80102ba5:	53                   	push   %ebx
80102ba6:	83 ec 0c             	sub    $0xc,%esp
80102ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bb0:	a1 f4 32 11 80       	mov    0x801132f4,%eax
80102bb5:	83 ec 08             	sub    $0x8,%esp
80102bb8:	01 f8                	add    %edi,%eax
80102bba:	83 c0 01             	add    $0x1,%eax
80102bbd:	50                   	push   %eax
80102bbe:	ff 35 04 33 11 80    	push   0x80113304
80102bc4:	e8 07 d5 ff ff       	call   801000d0 <bread>
80102bc9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bcb:	58                   	pop    %eax
80102bcc:	5a                   	pop    %edx
80102bcd:	ff 34 bd 0c 33 11 80 	push   -0x7feeccf4(,%edi,4)
80102bd4:	ff 35 04 33 11 80    	push   0x80113304
  for (tail = 0; tail < log.lh.n; tail++) {
80102bda:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bdd:	e8 ee d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102be2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102be5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102be7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bea:	68 00 02 00 00       	push   $0x200
80102bef:	50                   	push   %eax
80102bf0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102bf3:	50                   	push   %eax
80102bf4:	e8 a7 1b 00 00       	call   801047a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bf9:	89 1c 24             	mov    %ebx,(%esp)
80102bfc:	e8 af d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c01:	89 34 24             	mov    %esi,(%esp)
80102c04:	e8 e7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c09:	89 1c 24             	mov    %ebx,(%esp)
80102c0c:	e8 df d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c11:	83 c4 10             	add    $0x10,%esp
80102c14:	39 3d 08 33 11 80    	cmp    %edi,0x80113308
80102c1a:	7f 94                	jg     80102bb0 <install_trans+0x20>
  }
}
80102c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c1f:	5b                   	pop    %ebx
80102c20:	5e                   	pop    %esi
80102c21:	5f                   	pop    %edi
80102c22:	5d                   	pop    %ebp
80102c23:	c3                   	ret
80102c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c28:	c3                   	ret
80102c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	53                   	push   %ebx
80102c34:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c37:	ff 35 f4 32 11 80    	push   0x801132f4
80102c3d:	ff 35 04 33 11 80    	push   0x80113304
80102c43:	e8 88 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c48:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c4b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c4d:	a1 08 33 11 80       	mov    0x80113308,%eax
80102c52:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c55:	85 c0                	test   %eax,%eax
80102c57:	7e 19                	jle    80102c72 <write_head+0x42>
80102c59:	31 d2                	xor    %edx,%edx
80102c5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c60:	8b 0c 95 0c 33 11 80 	mov    -0x7feeccf4(,%edx,4),%ecx
80102c67:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c6b:	83 c2 01             	add    $0x1,%edx
80102c6e:	39 d0                	cmp    %edx,%eax
80102c70:	75 ee                	jne    80102c60 <write_head+0x30>
  }
  bwrite(buf);
80102c72:	83 ec 0c             	sub    $0xc,%esp
80102c75:	53                   	push   %ebx
80102c76:	e8 35 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c7b:	89 1c 24             	mov    %ebx,(%esp)
80102c7e:	e8 6d d5 ff ff       	call   801001f0 <brelse>
}
80102c83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c86:	83 c4 10             	add    $0x10,%esp
80102c89:	c9                   	leave
80102c8a:	c3                   	ret
80102c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102c90 <initlog>:
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	53                   	push   %ebx
80102c94:	83 ec 2c             	sub    $0x2c,%esp
80102c97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c9a:	68 17 74 10 80       	push   $0x80107417
80102c9f:	68 c0 32 11 80       	push   $0x801132c0
80102ca4:	e8 77 17 00 00       	call   80104420 <initlock>
  readsb(dev, &sb);
80102ca9:	58                   	pop    %eax
80102caa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 7b e8 ff ff       	call   80101530 <readsb>
  log.start = sb.logstart;
80102cb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cb8:	59                   	pop    %ecx
  log.dev = dev;
80102cb9:	89 1d 04 33 11 80    	mov    %ebx,0x80113304
  log.size = sb.nlog;
80102cbf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cc2:	a3 f4 32 11 80       	mov    %eax,0x801132f4
  log.size = sb.nlog;
80102cc7:	89 15 f8 32 11 80    	mov    %edx,0x801132f8
  struct buf *buf = bread(log.dev, log.start);
80102ccd:	5a                   	pop    %edx
80102cce:	50                   	push   %eax
80102ccf:	53                   	push   %ebx
80102cd0:	e8 fb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102cd5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102cd8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102cdb:	89 1d 08 33 11 80    	mov    %ebx,0x80113308
  for (i = 0; i < log.lh.n; i++) {
80102ce1:	85 db                	test   %ebx,%ebx
80102ce3:	7e 1d                	jle    80102d02 <initlog+0x72>
80102ce5:	31 d2                	xor    %edx,%edx
80102ce7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102cee:	00 
80102cef:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102cf0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102cf4:	89 0c 95 0c 33 11 80 	mov    %ecx,-0x7feeccf4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102cfb:	83 c2 01             	add    $0x1,%edx
80102cfe:	39 d3                	cmp    %edx,%ebx
80102d00:	75 ee                	jne    80102cf0 <initlog+0x60>
  brelse(buf);
80102d02:	83 ec 0c             	sub    $0xc,%esp
80102d05:	50                   	push   %eax
80102d06:	e8 e5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d0b:	e8 80 fe ff ff       	call   80102b90 <install_trans>
  log.lh.n = 0;
80102d10:	c7 05 08 33 11 80 00 	movl   $0x0,0x80113308
80102d17:	00 00 00 
  write_head(); // clear the log
80102d1a:	e8 11 ff ff ff       	call   80102c30 <write_head>
}
80102d1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d22:	83 c4 10             	add    $0x10,%esp
80102d25:	c9                   	leave
80102d26:	c3                   	ret
80102d27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d2e:	00 
80102d2f:	90                   	nop

80102d30 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d30:	55                   	push   %ebp
80102d31:	89 e5                	mov    %esp,%ebp
80102d33:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d36:	68 c0 32 11 80       	push   $0x801132c0
80102d3b:	e8 d0 18 00 00       	call   80104610 <acquire>
80102d40:	83 c4 10             	add    $0x10,%esp
80102d43:	eb 18                	jmp    80102d5d <begin_op+0x2d>
80102d45:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d48:	83 ec 08             	sub    $0x8,%esp
80102d4b:	68 c0 32 11 80       	push   $0x801132c0
80102d50:	68 c0 32 11 80       	push   $0x801132c0
80102d55:	e8 e6 12 00 00       	call   80104040 <sleep>
80102d5a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d5d:	a1 00 33 11 80       	mov    0x80113300,%eax
80102d62:	85 c0                	test   %eax,%eax
80102d64:	75 e2                	jne    80102d48 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d66:	a1 fc 32 11 80       	mov    0x801132fc,%eax
80102d6b:	8b 15 08 33 11 80    	mov    0x80113308,%edx
80102d71:	83 c0 01             	add    $0x1,%eax
80102d74:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d77:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d7a:	83 fa 1e             	cmp    $0x1e,%edx
80102d7d:	7f c9                	jg     80102d48 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d7f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d82:	a3 fc 32 11 80       	mov    %eax,0x801132fc
      release(&log.lock);
80102d87:	68 c0 32 11 80       	push   $0x801132c0
80102d8c:	e8 1f 18 00 00       	call   801045b0 <release>
      break;
    }
  }
}
80102d91:	83 c4 10             	add    $0x10,%esp
80102d94:	c9                   	leave
80102d95:	c3                   	ret
80102d96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9d:	00 
80102d9e:	66 90                	xchg   %ax,%ax

80102da0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	57                   	push   %edi
80102da4:	56                   	push   %esi
80102da5:	53                   	push   %ebx
80102da6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102da9:	68 c0 32 11 80       	push   $0x801132c0
80102dae:	e8 5d 18 00 00       	call   80104610 <acquire>
  log.outstanding -= 1;
80102db3:	a1 fc 32 11 80       	mov    0x801132fc,%eax
  if(log.committing)
80102db8:	8b 35 00 33 11 80    	mov    0x80113300,%esi
80102dbe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102dc1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102dc4:	89 1d fc 32 11 80    	mov    %ebx,0x801132fc
  if(log.committing)
80102dca:	85 f6                	test   %esi,%esi
80102dcc:	0f 85 22 01 00 00    	jne    80102ef4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102dd2:	85 db                	test   %ebx,%ebx
80102dd4:	0f 85 f6 00 00 00    	jne    80102ed0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dda:	c7 05 00 33 11 80 01 	movl   $0x1,0x80113300
80102de1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102de4:	83 ec 0c             	sub    $0xc,%esp
80102de7:	68 c0 32 11 80       	push   $0x801132c0
80102dec:	e8 bf 17 00 00       	call   801045b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102df1:	8b 0d 08 33 11 80    	mov    0x80113308,%ecx
80102df7:	83 c4 10             	add    $0x10,%esp
80102dfa:	85 c9                	test   %ecx,%ecx
80102dfc:	7f 42                	jg     80102e40 <end_op+0xa0>
    acquire(&log.lock);
80102dfe:	83 ec 0c             	sub    $0xc,%esp
80102e01:	68 c0 32 11 80       	push   $0x801132c0
80102e06:	e8 05 18 00 00       	call   80104610 <acquire>
    log.committing = 0;
80102e0b:	c7 05 00 33 11 80 00 	movl   $0x0,0x80113300
80102e12:	00 00 00 
    wakeup(&log);
80102e15:	c7 04 24 c0 32 11 80 	movl   $0x801132c0,(%esp)
80102e1c:	e8 df 12 00 00       	call   80104100 <wakeup>
    release(&log.lock);
80102e21:	c7 04 24 c0 32 11 80 	movl   $0x801132c0,(%esp)
80102e28:	e8 83 17 00 00       	call   801045b0 <release>
80102e2d:	83 c4 10             	add    $0x10,%esp
}
80102e30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e33:	5b                   	pop    %ebx
80102e34:	5e                   	pop    %esi
80102e35:	5f                   	pop    %edi
80102e36:	5d                   	pop    %ebp
80102e37:	c3                   	ret
80102e38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e3f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e40:	a1 f4 32 11 80       	mov    0x801132f4,%eax
80102e45:	83 ec 08             	sub    $0x8,%esp
80102e48:	01 d8                	add    %ebx,%eax
80102e4a:	83 c0 01             	add    $0x1,%eax
80102e4d:	50                   	push   %eax
80102e4e:	ff 35 04 33 11 80    	push   0x80113304
80102e54:	e8 77 d2 ff ff       	call   801000d0 <bread>
80102e59:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e5b:	58                   	pop    %eax
80102e5c:	5a                   	pop    %edx
80102e5d:	ff 34 9d 0c 33 11 80 	push   -0x7feeccf4(,%ebx,4)
80102e64:	ff 35 04 33 11 80    	push   0x80113304
  for (tail = 0; tail < log.lh.n; tail++) {
80102e6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e6d:	e8 5e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e72:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e75:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e77:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e7a:	68 00 02 00 00       	push   $0x200
80102e7f:	50                   	push   %eax
80102e80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e83:	50                   	push   %eax
80102e84:	e8 17 19 00 00       	call   801047a0 <memmove>
    bwrite(to);  // write the log
80102e89:	89 34 24             	mov    %esi,(%esp)
80102e8c:	e8 1f d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102e91:	89 3c 24             	mov    %edi,(%esp)
80102e94:	e8 57 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102e99:	89 34 24             	mov    %esi,(%esp)
80102e9c:	e8 4f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ea1:	83 c4 10             	add    $0x10,%esp
80102ea4:	3b 1d 08 33 11 80    	cmp    0x80113308,%ebx
80102eaa:	7c 94                	jl     80102e40 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102eac:	e8 7f fd ff ff       	call   80102c30 <write_head>
    install_trans(); // Now install writes to home locations
80102eb1:	e8 da fc ff ff       	call   80102b90 <install_trans>
    log.lh.n = 0;
80102eb6:	c7 05 08 33 11 80 00 	movl   $0x0,0x80113308
80102ebd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ec0:	e8 6b fd ff ff       	call   80102c30 <write_head>
80102ec5:	e9 34 ff ff ff       	jmp    80102dfe <end_op+0x5e>
80102eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ed0:	83 ec 0c             	sub    $0xc,%esp
80102ed3:	68 c0 32 11 80       	push   $0x801132c0
80102ed8:	e8 23 12 00 00       	call   80104100 <wakeup>
  release(&log.lock);
80102edd:	c7 04 24 c0 32 11 80 	movl   $0x801132c0,(%esp)
80102ee4:	e8 c7 16 00 00       	call   801045b0 <release>
80102ee9:	83 c4 10             	add    $0x10,%esp
}
80102eec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eef:	5b                   	pop    %ebx
80102ef0:	5e                   	pop    %esi
80102ef1:	5f                   	pop    %edi
80102ef2:	5d                   	pop    %ebp
80102ef3:	c3                   	ret
    panic("log.committing");
80102ef4:	83 ec 0c             	sub    $0xc,%esp
80102ef7:	68 1b 74 10 80       	push   $0x8010741b
80102efc:	e8 7f d4 ff ff       	call   80100380 <panic>
80102f01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f08:	00 
80102f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f17:	8b 15 08 33 11 80    	mov    0x80113308,%edx
{
80102f1d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f20:	83 fa 1d             	cmp    $0x1d,%edx
80102f23:	7f 7d                	jg     80102fa2 <log_write+0x92>
80102f25:	a1 f8 32 11 80       	mov    0x801132f8,%eax
80102f2a:	83 e8 01             	sub    $0x1,%eax
80102f2d:	39 c2                	cmp    %eax,%edx
80102f2f:	7d 71                	jge    80102fa2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f31:	a1 fc 32 11 80       	mov    0x801132fc,%eax
80102f36:	85 c0                	test   %eax,%eax
80102f38:	7e 75                	jle    80102faf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f3a:	83 ec 0c             	sub    $0xc,%esp
80102f3d:	68 c0 32 11 80       	push   $0x801132c0
80102f42:	e8 c9 16 00 00       	call   80104610 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f47:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f4a:	83 c4 10             	add    $0x10,%esp
80102f4d:	31 c0                	xor    %eax,%eax
80102f4f:	8b 15 08 33 11 80    	mov    0x80113308,%edx
80102f55:	85 d2                	test   %edx,%edx
80102f57:	7f 0e                	jg     80102f67 <log_write+0x57>
80102f59:	eb 15                	jmp    80102f70 <log_write+0x60>
80102f5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f60:	83 c0 01             	add    $0x1,%eax
80102f63:	39 c2                	cmp    %eax,%edx
80102f65:	74 29                	je     80102f90 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f67:	39 0c 85 0c 33 11 80 	cmp    %ecx,-0x7feeccf4(,%eax,4)
80102f6e:	75 f0                	jne    80102f60 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f70:	89 0c 85 0c 33 11 80 	mov    %ecx,-0x7feeccf4(,%eax,4)
  if (i == log.lh.n)
80102f77:	39 c2                	cmp    %eax,%edx
80102f79:	74 1c                	je     80102f97 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102f7b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f81:	c7 45 08 c0 32 11 80 	movl   $0x801132c0,0x8(%ebp)
}
80102f88:	c9                   	leave
  release(&log.lock);
80102f89:	e9 22 16 00 00       	jmp    801045b0 <release>
80102f8e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80102f90:	89 0c 95 0c 33 11 80 	mov    %ecx,-0x7feeccf4(,%edx,4)
    log.lh.n++;
80102f97:	83 c2 01             	add    $0x1,%edx
80102f9a:	89 15 08 33 11 80    	mov    %edx,0x80113308
80102fa0:	eb d9                	jmp    80102f7b <log_write+0x6b>
    panic("too big a transaction");
80102fa2:	83 ec 0c             	sub    $0xc,%esp
80102fa5:	68 2a 74 10 80       	push   $0x8010742a
80102faa:	e8 d1 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102faf:	83 ec 0c             	sub    $0xc,%esp
80102fb2:	68 40 74 10 80       	push   $0x80107440
80102fb7:	e8 c4 d3 ff ff       	call   80100380 <panic>
80102fbc:	66 90                	xchg   %ax,%ax
80102fbe:	66 90                	xchg   %ax,%ax

80102fc0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	53                   	push   %ebx
80102fc4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fc7:	e8 94 09 00 00       	call   80103960 <cpuid>
80102fcc:	89 c3                	mov    %eax,%ebx
80102fce:	e8 8d 09 00 00       	call   80103960 <cpuid>
80102fd3:	83 ec 04             	sub    $0x4,%esp
80102fd6:	53                   	push   %ebx
80102fd7:	50                   	push   %eax
80102fd8:	68 5b 74 10 80       	push   $0x8010745b
80102fdd:	e8 ce d6 ff ff       	call   801006b0 <cprintf>
  cprintf("\n====================================\n");
80102fe2:	c7 04 24 f8 77 10 80 	movl   $0x801077f8,(%esp)
80102fe9:	e8 c2 d6 ff ff       	call   801006b0 <cprintf>
  cprintf("Welcome to DUCKO.UNIX v3.5\n");
80102fee:	c7 04 24 6f 74 10 80 	movl   $0x8010746f,(%esp)
80102ff5:	e8 b6 d6 ff ff       	call   801006b0 <cprintf>
  cprintf("Thanks for using my Unix DISTRO!!!\n");
80102ffa:	c7 04 24 24 78 10 80 	movl   $0x80107824,(%esp)
80103001:	e8 aa d6 ff ff       	call   801006b0 <cprintf>
  cprintf("====================================\n");
80103006:	c7 04 24 48 78 10 80 	movl   $0x80107848,(%esp)
8010300d:	e8 9e d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103012:	e8 a9 29 00 00       	call   801059c0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103017:	e8 e4 08 00 00       	call   80103900 <mycpu>
8010301c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010301e:	b8 01 00 00 00       	mov    $0x1,%eax
80103023:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010302a:	e8 01 0c 00 00       	call   80103c30 <scheduler>
8010302f:	90                   	nop

80103030 <mpenter>:
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103036:	e8 85 3a 00 00       	call   80106ac0 <switchkvm>
  seginit();
8010303b:	e8 f0 39 00 00       	call   80106a30 <seginit>
  lapicinit();
80103040:	e8 8b f7 ff ff       	call   801027d0 <lapicinit>
  mpmain();
80103045:	e8 76 ff ff ff       	call   80102fc0 <mpmain>
8010304a:	66 90                	xchg   %ax,%ax
8010304c:	66 90                	xchg   %ax,%ax
8010304e:	66 90                	xchg   %ax,%ax

80103050 <main>:
{
80103050:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103054:	83 e4 f0             	and    $0xfffffff0,%esp
80103057:	ff 71 fc             	push   -0x4(%ecx)
8010305a:	55                   	push   %ebp
8010305b:	89 e5                	mov    %esp,%ebp
8010305d:	53                   	push   %ebx
8010305e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010305f:	83 ec 08             	sub    $0x8,%esp
80103062:	68 00 00 40 80       	push   $0x80400000
80103067:	68 f0 70 11 80       	push   $0x801170f0
8010306c:	e8 6f f5 ff ff       	call   801025e0 <kinit1>
  kvmalloc();      // kernel page table
80103071:	e8 0a 3f 00 00       	call   80106f80 <kvmalloc>
  mpinit();        // detect other processors
80103076:	e8 85 01 00 00       	call   80103200 <mpinit>
  lapicinit();     // interrupt controller
8010307b:	e8 50 f7 ff ff       	call   801027d0 <lapicinit>
  seginit();       // segment descriptors
80103080:	e8 ab 39 00 00       	call   80106a30 <seginit>
  picinit();       // disable pic
80103085:	e8 86 03 00 00       	call   80103410 <picinit>
  ioapicinit();    // another interrupt controller
8010308a:	e8 21 f3 ff ff       	call   801023b0 <ioapicinit>
  consoleinit();   // console hardware
8010308f:	e8 cc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
80103094:	e8 07 2c 00 00       	call   80105ca0 <uartinit>
  pinit();         // process table
80103099:	e8 42 08 00 00       	call   801038e0 <pinit>
  tvinit();        // trap vectors
8010309e:	e8 9d 28 00 00       	call   80105940 <tvinit>
  binit();         // buffer cache
801030a3:	e8 98 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030a8:	e8 83 dd ff ff       	call   80100e30 <fileinit>
  ideinit();       // disk 
801030ad:	e8 de f0 ff ff       	call   80102190 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030b2:	83 c4 0c             	add    $0xc,%esp
801030b5:	68 8a 00 00 00       	push   $0x8a
801030ba:	68 8c a4 10 80       	push   $0x8010a48c
801030bf:	68 00 70 00 80       	push   $0x80007000
801030c4:	e8 d7 16 00 00       	call   801047a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030c9:	83 c4 10             	add    $0x10,%esp
801030cc:	69 05 a4 33 11 80 b0 	imul   $0xb0,0x801133a4,%eax
801030d3:	00 00 00 
801030d6:	05 c0 33 11 80       	add    $0x801133c0,%eax
801030db:	3d c0 33 11 80       	cmp    $0x801133c0,%eax
801030e0:	76 7e                	jbe    80103160 <main+0x110>
801030e2:	bb c0 33 11 80       	mov    $0x801133c0,%ebx
801030e7:	eb 20                	jmp    80103109 <main+0xb9>
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	69 05 a4 33 11 80 b0 	imul   $0xb0,0x801133a4,%eax
801030f7:	00 00 00 
801030fa:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103100:	05 c0 33 11 80       	add    $0x801133c0,%eax
80103105:	39 c3                	cmp    %eax,%ebx
80103107:	73 57                	jae    80103160 <main+0x110>
    if(c == mycpu())  // We've started already.
80103109:	e8 f2 07 00 00       	call   80103900 <mycpu>
8010310e:	39 c3                	cmp    %eax,%ebx
80103110:	74 de                	je     801030f0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103112:	e8 39 f5 ff ff       	call   80102650 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103117:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010311a:	c7 05 f8 6f 00 80 30 	movl   $0x80103030,0x80006ff8
80103121:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103124:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010312b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010312e:	05 00 10 00 00       	add    $0x1000,%eax
80103133:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103138:	0f b6 03             	movzbl (%ebx),%eax
8010313b:	68 00 70 00 00       	push   $0x7000
80103140:	50                   	push   %eax
80103141:	e8 ca f7 ff ff       	call   80102910 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103146:	83 c4 10             	add    $0x10,%esp
80103149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103150:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103156:	85 c0                	test   %eax,%eax
80103158:	74 f6                	je     80103150 <main+0x100>
8010315a:	eb 94                	jmp    801030f0 <main+0xa0>
8010315c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103160:	83 ec 08             	sub    $0x8,%esp
80103163:	68 00 00 00 8e       	push   $0x8e000000
80103168:	68 00 00 40 80       	push   $0x80400000
8010316d:	e8 0e f4 ff ff       	call   80102580 <kinit2>
  userinit();      // first user process
80103172:	e8 39 08 00 00       	call   801039b0 <userinit>
  mpmain();        // finish this processor's setup
80103177:	e8 44 fe ff ff       	call   80102fc0 <mpmain>
8010317c:	66 90                	xchg   %ax,%ax
8010317e:	66 90                	xchg   %ax,%ax

80103180 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	57                   	push   %edi
80103184:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103185:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010318b:	53                   	push   %ebx
  e = addr+len;
8010318c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010318f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103192:	39 de                	cmp    %ebx,%esi
80103194:	72 10                	jb     801031a6 <mpsearch1+0x26>
80103196:	eb 50                	jmp    801031e8 <mpsearch1+0x68>
80103198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010319f:	00 
801031a0:	89 fe                	mov    %edi,%esi
801031a2:	39 df                	cmp    %ebx,%edi
801031a4:	73 42                	jae    801031e8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031a6:	83 ec 04             	sub    $0x4,%esp
801031a9:	8d 7e 10             	lea    0x10(%esi),%edi
801031ac:	6a 04                	push   $0x4
801031ae:	68 8b 74 10 80       	push   $0x8010748b
801031b3:	56                   	push   %esi
801031b4:	e8 97 15 00 00       	call   80104750 <memcmp>
801031b9:	83 c4 10             	add    $0x10,%esp
801031bc:	85 c0                	test   %eax,%eax
801031be:	75 e0                	jne    801031a0 <mpsearch1+0x20>
801031c0:	89 f2                	mov    %esi,%edx
801031c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031c8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031cb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031ce:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031d0:	39 fa                	cmp    %edi,%edx
801031d2:	75 f4                	jne    801031c8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031d4:	84 c0                	test   %al,%al
801031d6:	75 c8                	jne    801031a0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031db:	89 f0                	mov    %esi,%eax
801031dd:	5b                   	pop    %ebx
801031de:	5e                   	pop    %esi
801031df:	5f                   	pop    %edi
801031e0:	5d                   	pop    %ebp
801031e1:	c3                   	ret
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031eb:	31 f6                	xor    %esi,%esi
}
801031ed:	5b                   	pop    %ebx
801031ee:	89 f0                	mov    %esi,%eax
801031f0:	5e                   	pop    %esi
801031f1:	5f                   	pop    %edi
801031f2:	5d                   	pop    %ebp
801031f3:	c3                   	ret
801031f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031fb:	00 
801031fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103200 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	57                   	push   %edi
80103204:	56                   	push   %esi
80103205:	53                   	push   %ebx
80103206:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103209:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103210:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103217:	c1 e0 08             	shl    $0x8,%eax
8010321a:	09 d0                	or     %edx,%eax
8010321c:	c1 e0 04             	shl    $0x4,%eax
8010321f:	75 1b                	jne    8010323c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103221:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103228:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010322f:	c1 e0 08             	shl    $0x8,%eax
80103232:	09 d0                	or     %edx,%eax
80103234:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103237:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010323c:	ba 00 04 00 00       	mov    $0x400,%edx
80103241:	e8 3a ff ff ff       	call   80103180 <mpsearch1>
80103246:	89 c3                	mov    %eax,%ebx
80103248:	85 c0                	test   %eax,%eax
8010324a:	0f 84 58 01 00 00    	je     801033a8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103250:	8b 73 04             	mov    0x4(%ebx),%esi
80103253:	85 f6                	test   %esi,%esi
80103255:	0f 84 3d 01 00 00    	je     80103398 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010325b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010325e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103264:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103267:	6a 04                	push   $0x4
80103269:	68 90 74 10 80       	push   $0x80107490
8010326e:	50                   	push   %eax
8010326f:	e8 dc 14 00 00       	call   80104750 <memcmp>
80103274:	83 c4 10             	add    $0x10,%esp
80103277:	85 c0                	test   %eax,%eax
80103279:	0f 85 19 01 00 00    	jne    80103398 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010327f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103286:	3c 01                	cmp    $0x1,%al
80103288:	74 08                	je     80103292 <mpinit+0x92>
8010328a:	3c 04                	cmp    $0x4,%al
8010328c:	0f 85 06 01 00 00    	jne    80103398 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103292:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103299:	66 85 d2             	test   %dx,%dx
8010329c:	74 22                	je     801032c0 <mpinit+0xc0>
8010329e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032a1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032a3:	31 d2                	xor    %edx,%edx
801032a5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032a8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032af:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032b2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032b4:	39 f8                	cmp    %edi,%eax
801032b6:	75 f0                	jne    801032a8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032b8:	84 d2                	test   %dl,%dl
801032ba:	0f 85 d8 00 00 00    	jne    80103398 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032c0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801032c9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
801032cc:	a3 a0 32 11 80       	mov    %eax,0x801132a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032d1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032d8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801032de:	01 d7                	add    %edx,%edi
801032e0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801032e2:	bf 01 00 00 00       	mov    $0x1,%edi
801032e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032ee:	00 
801032ef:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032f0:	39 d0                	cmp    %edx,%eax
801032f2:	73 19                	jae    8010330d <mpinit+0x10d>
    switch(*p){
801032f4:	0f b6 08             	movzbl (%eax),%ecx
801032f7:	80 f9 02             	cmp    $0x2,%cl
801032fa:	0f 84 80 00 00 00    	je     80103380 <mpinit+0x180>
80103300:	77 6e                	ja     80103370 <mpinit+0x170>
80103302:	84 c9                	test   %cl,%cl
80103304:	74 3a                	je     80103340 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103306:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103309:	39 d0                	cmp    %edx,%eax
8010330b:	72 e7                	jb     801032f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010330d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103310:	85 ff                	test   %edi,%edi
80103312:	0f 84 dd 00 00 00    	je     801033f5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103318:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010331c:	74 15                	je     80103333 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010331e:	b8 70 00 00 00       	mov    $0x70,%eax
80103323:	ba 22 00 00 00       	mov    $0x22,%edx
80103328:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103329:	ba 23 00 00 00       	mov    $0x23,%edx
8010332e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010332f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103332:	ee                   	out    %al,(%dx)
  }
}
80103333:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103336:	5b                   	pop    %ebx
80103337:	5e                   	pop    %esi
80103338:	5f                   	pop    %edi
80103339:	5d                   	pop    %ebp
8010333a:	c3                   	ret
8010333b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103340:	8b 0d a4 33 11 80    	mov    0x801133a4,%ecx
80103346:	83 f9 07             	cmp    $0x7,%ecx
80103349:	7f 19                	jg     80103364 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010334b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103351:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103355:	83 c1 01             	add    $0x1,%ecx
80103358:	89 0d a4 33 11 80    	mov    %ecx,0x801133a4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010335e:	88 9e c0 33 11 80    	mov    %bl,-0x7feecc40(%esi)
      p += sizeof(struct mpproc);
80103364:	83 c0 14             	add    $0x14,%eax
      continue;
80103367:	eb 87                	jmp    801032f0 <mpinit+0xf0>
80103369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103370:	83 e9 03             	sub    $0x3,%ecx
80103373:	80 f9 01             	cmp    $0x1,%cl
80103376:	76 8e                	jbe    80103306 <mpinit+0x106>
80103378:	31 ff                	xor    %edi,%edi
8010337a:	e9 71 ff ff ff       	jmp    801032f0 <mpinit+0xf0>
8010337f:	90                   	nop
      ioapicid = ioapic->apicno;
80103380:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103384:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103387:	88 0d a0 33 11 80    	mov    %cl,0x801133a0
      continue;
8010338d:	e9 5e ff ff ff       	jmp    801032f0 <mpinit+0xf0>
80103392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103398:	83 ec 0c             	sub    $0xc,%esp
8010339b:	68 95 74 10 80       	push   $0x80107495
801033a0:	e8 db cf ff ff       	call   80100380 <panic>
801033a5:	8d 76 00             	lea    0x0(%esi),%esi
{
801033a8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033ad:	eb 0b                	jmp    801033ba <mpinit+0x1ba>
801033af:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
801033b0:	89 f3                	mov    %esi,%ebx
801033b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033b8:	74 de                	je     80103398 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ba:	83 ec 04             	sub    $0x4,%esp
801033bd:	8d 73 10             	lea    0x10(%ebx),%esi
801033c0:	6a 04                	push   $0x4
801033c2:	68 8b 74 10 80       	push   $0x8010748b
801033c7:	53                   	push   %ebx
801033c8:	e8 83 13 00 00       	call   80104750 <memcmp>
801033cd:	83 c4 10             	add    $0x10,%esp
801033d0:	85 c0                	test   %eax,%eax
801033d2:	75 dc                	jne    801033b0 <mpinit+0x1b0>
801033d4:	89 da                	mov    %ebx,%edx
801033d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033dd:	00 
801033de:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801033e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033e8:	39 d6                	cmp    %edx,%esi
801033ea:	75 f4                	jne    801033e0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ec:	84 c0                	test   %al,%al
801033ee:	75 c0                	jne    801033b0 <mpinit+0x1b0>
801033f0:	e9 5b fe ff ff       	jmp    80103250 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	68 70 78 10 80       	push   $0x80107870
801033fd:	e8 7e cf ff ff       	call   80100380 <panic>
80103402:	66 90                	xchg   %ax,%ax
80103404:	66 90                	xchg   %ax,%ax
80103406:	66 90                	xchg   %ax,%ax
80103408:	66 90                	xchg   %ax,%ax
8010340a:	66 90                	xchg   %ax,%ax
8010340c:	66 90                	xchg   %ax,%ax
8010340e:	66 90                	xchg   %ax,%ax

80103410 <picinit>:
80103410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103415:	ba 21 00 00 00       	mov    $0x21,%edx
8010341a:	ee                   	out    %al,(%dx)
8010341b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103420:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103421:	c3                   	ret
80103422:	66 90                	xchg   %ax,%ax
80103424:	66 90                	xchg   %ax,%ax
80103426:	66 90                	xchg   %ax,%ax
80103428:	66 90                	xchg   %ax,%ax
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	8b 75 08             	mov    0x8(%ebp),%esi
8010343c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010343f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103445:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010344b:	e8 00 da ff ff       	call   80100e50 <filealloc>
80103450:	89 06                	mov    %eax,(%esi)
80103452:	85 c0                	test   %eax,%eax
80103454:	0f 84 a5 00 00 00    	je     801034ff <pipealloc+0xcf>
8010345a:	e8 f1 d9 ff ff       	call   80100e50 <filealloc>
8010345f:	89 07                	mov    %eax,(%edi)
80103461:	85 c0                	test   %eax,%eax
80103463:	0f 84 84 00 00 00    	je     801034ed <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103469:	e8 e2 f1 ff ff       	call   80102650 <kalloc>
8010346e:	89 c3                	mov    %eax,%ebx
80103470:	85 c0                	test   %eax,%eax
80103472:	0f 84 a0 00 00 00    	je     80103518 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103478:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010347f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103482:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103485:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010348c:	00 00 00 
  p->nwrite = 0;
8010348f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103496:	00 00 00 
  p->nread = 0;
80103499:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034a0:	00 00 00 
  initlock(&p->lock, "pipe");
801034a3:	68 ad 74 10 80       	push   $0x801074ad
801034a8:	50                   	push   %eax
801034a9:	e8 72 0f 00 00       	call   80104420 <initlock>
  (*f0)->type = FD_PIPE;
801034ae:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034b9:	8b 06                	mov    (%esi),%eax
801034bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034bf:	8b 06                	mov    (%esi),%eax
801034c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034c5:	8b 06                	mov    (%esi),%eax
801034c7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034ca:	8b 07                	mov    (%edi),%eax
801034cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034d2:	8b 07                	mov    (%edi),%eax
801034d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034d8:	8b 07                	mov    (%edi),%eax
801034da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034de:	8b 07                	mov    (%edi),%eax
801034e0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801034e3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034e8:	5b                   	pop    %ebx
801034e9:	5e                   	pop    %esi
801034ea:	5f                   	pop    %edi
801034eb:	5d                   	pop    %ebp
801034ec:	c3                   	ret
  if(*f0)
801034ed:	8b 06                	mov    (%esi),%eax
801034ef:	85 c0                	test   %eax,%eax
801034f1:	74 1e                	je     80103511 <pipealloc+0xe1>
    fileclose(*f0);
801034f3:	83 ec 0c             	sub    $0xc,%esp
801034f6:	50                   	push   %eax
801034f7:	e8 14 da ff ff       	call   80100f10 <fileclose>
801034fc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034ff:	8b 07                	mov    (%edi),%eax
80103501:	85 c0                	test   %eax,%eax
80103503:	74 0c                	je     80103511 <pipealloc+0xe1>
    fileclose(*f1);
80103505:	83 ec 0c             	sub    $0xc,%esp
80103508:	50                   	push   %eax
80103509:	e8 02 da ff ff       	call   80100f10 <fileclose>
8010350e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103511:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103516:	eb cd                	jmp    801034e5 <pipealloc+0xb5>
  if(*f0)
80103518:	8b 06                	mov    (%esi),%eax
8010351a:	85 c0                	test   %eax,%eax
8010351c:	75 d5                	jne    801034f3 <pipealloc+0xc3>
8010351e:	eb df                	jmp    801034ff <pipealloc+0xcf>

80103520 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	56                   	push   %esi
80103524:	53                   	push   %ebx
80103525:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103528:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010352b:	83 ec 0c             	sub    $0xc,%esp
8010352e:	53                   	push   %ebx
8010352f:	e8 dc 10 00 00       	call   80104610 <acquire>
  if(writable){
80103534:	83 c4 10             	add    $0x10,%esp
80103537:	85 f6                	test   %esi,%esi
80103539:	74 65                	je     801035a0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010353b:	83 ec 0c             	sub    $0xc,%esp
8010353e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103544:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010354b:	00 00 00 
    wakeup(&p->nread);
8010354e:	50                   	push   %eax
8010354f:	e8 ac 0b 00 00       	call   80104100 <wakeup>
80103554:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103557:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010355d:	85 d2                	test   %edx,%edx
8010355f:	75 0a                	jne    8010356b <pipeclose+0x4b>
80103561:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103567:	85 c0                	test   %eax,%eax
80103569:	74 15                	je     80103580 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010356b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010356e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103571:	5b                   	pop    %ebx
80103572:	5e                   	pop    %esi
80103573:	5d                   	pop    %ebp
    release(&p->lock);
80103574:	e9 37 10 00 00       	jmp    801045b0 <release>
80103579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103580:	83 ec 0c             	sub    $0xc,%esp
80103583:	53                   	push   %ebx
80103584:	e8 27 10 00 00       	call   801045b0 <release>
    kfree((char*)p);
80103589:	83 c4 10             	add    $0x10,%esp
8010358c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010358f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103592:	5b                   	pop    %ebx
80103593:	5e                   	pop    %esi
80103594:	5d                   	pop    %ebp
    kfree((char*)p);
80103595:	e9 f6 ee ff ff       	jmp    80102490 <kfree>
8010359a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035b0:	00 00 00 
    wakeup(&p->nwrite);
801035b3:	50                   	push   %eax
801035b4:	e8 47 0b 00 00       	call   80104100 <wakeup>
801035b9:	83 c4 10             	add    $0x10,%esp
801035bc:	eb 99                	jmp    80103557 <pipeclose+0x37>
801035be:	66 90                	xchg   %ax,%ax

801035c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	57                   	push   %edi
801035c4:	56                   	push   %esi
801035c5:	53                   	push   %ebx
801035c6:	83 ec 28             	sub    $0x28,%esp
801035c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801035cf:	53                   	push   %ebx
801035d0:	e8 3b 10 00 00       	call   80104610 <acquire>
  for(i = 0; i < n; i++){
801035d5:	83 c4 10             	add    $0x10,%esp
801035d8:	85 ff                	test   %edi,%edi
801035da:	0f 8e ce 00 00 00    	jle    801036ae <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035e0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801035e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035e9:	89 7d 10             	mov    %edi,0x10(%ebp)
801035ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035ef:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801035f2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035f5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035fb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103601:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103607:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010360d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103610:	0f 85 b6 00 00 00    	jne    801036cc <pipewrite+0x10c>
80103616:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103619:	eb 3b                	jmp    80103656 <pipewrite+0x96>
8010361b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103620:	e8 5b 03 00 00       	call   80103980 <myproc>
80103625:	8b 48 24             	mov    0x24(%eax),%ecx
80103628:	85 c9                	test   %ecx,%ecx
8010362a:	75 34                	jne    80103660 <pipewrite+0xa0>
      wakeup(&p->nread);
8010362c:	83 ec 0c             	sub    $0xc,%esp
8010362f:	56                   	push   %esi
80103630:	e8 cb 0a 00 00       	call   80104100 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103635:	58                   	pop    %eax
80103636:	5a                   	pop    %edx
80103637:	53                   	push   %ebx
80103638:	57                   	push   %edi
80103639:	e8 02 0a 00 00       	call   80104040 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010363e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103644:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010364a:	83 c4 10             	add    $0x10,%esp
8010364d:	05 00 02 00 00       	add    $0x200,%eax
80103652:	39 c2                	cmp    %eax,%edx
80103654:	75 2a                	jne    80103680 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103656:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010365c:	85 c0                	test   %eax,%eax
8010365e:	75 c0                	jne    80103620 <pipewrite+0x60>
        release(&p->lock);
80103660:	83 ec 0c             	sub    $0xc,%esp
80103663:	53                   	push   %ebx
80103664:	e8 47 0f 00 00       	call   801045b0 <release>
        return -1;
80103669:	83 c4 10             	add    $0x10,%esp
8010366c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103671:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103674:	5b                   	pop    %ebx
80103675:	5e                   	pop    %esi
80103676:	5f                   	pop    %edi
80103677:	5d                   	pop    %ebp
80103678:	c3                   	ret
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103680:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103683:	8d 42 01             	lea    0x1(%edx),%eax
80103686:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010368c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010368f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103695:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103698:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010369c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801036a3:	39 c1                	cmp    %eax,%ecx
801036a5:	0f 85 50 ff ff ff    	jne    801035fb <pipewrite+0x3b>
801036ab:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036ae:	83 ec 0c             	sub    $0xc,%esp
801036b1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036b7:	50                   	push   %eax
801036b8:	e8 43 0a 00 00       	call   80104100 <wakeup>
  release(&p->lock);
801036bd:	89 1c 24             	mov    %ebx,(%esp)
801036c0:	e8 eb 0e 00 00       	call   801045b0 <release>
  return n;
801036c5:	83 c4 10             	add    $0x10,%esp
801036c8:	89 f8                	mov    %edi,%eax
801036ca:	eb a5                	jmp    80103671 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801036cf:	eb b2                	jmp    80103683 <pipewrite+0xc3>
801036d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801036d8:	00 
801036d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801036e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	57                   	push   %edi
801036e4:	56                   	push   %esi
801036e5:	53                   	push   %ebx
801036e6:	83 ec 18             	sub    $0x18,%esp
801036e9:	8b 75 08             	mov    0x8(%ebp),%esi
801036ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036ef:	56                   	push   %esi
801036f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036f6:	e8 15 0f 00 00       	call   80104610 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103701:	83 c4 10             	add    $0x10,%esp
80103704:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010370a:	74 2f                	je     8010373b <piperead+0x5b>
8010370c:	eb 37                	jmp    80103745 <piperead+0x65>
8010370e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103710:	e8 6b 02 00 00       	call   80103980 <myproc>
80103715:	8b 40 24             	mov    0x24(%eax),%eax
80103718:	85 c0                	test   %eax,%eax
8010371a:	0f 85 80 00 00 00    	jne    801037a0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103720:	83 ec 08             	sub    $0x8,%esp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx
80103725:	e8 16 09 00 00       	call   80104040 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010372a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103730:	83 c4 10             	add    $0x10,%esp
80103733:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103739:	75 0a                	jne    80103745 <piperead+0x65>
8010373b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103741:	85 d2                	test   %edx,%edx
80103743:	75 cb                	jne    80103710 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103745:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103748:	31 db                	xor    %ebx,%ebx
8010374a:	85 c9                	test   %ecx,%ecx
8010374c:	7f 26                	jg     80103774 <piperead+0x94>
8010374e:	eb 2c                	jmp    8010377c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103750:	8d 48 01             	lea    0x1(%eax),%ecx
80103753:	25 ff 01 00 00       	and    $0x1ff,%eax
80103758:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010375e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103763:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103766:	83 c3 01             	add    $0x1,%ebx
80103769:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010376c:	74 0e                	je     8010377c <piperead+0x9c>
8010376e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103774:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010377a:	75 d4                	jne    80103750 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010377c:	83 ec 0c             	sub    $0xc,%esp
8010377f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103785:	50                   	push   %eax
80103786:	e8 75 09 00 00       	call   80104100 <wakeup>
  release(&p->lock);
8010378b:	89 34 24             	mov    %esi,(%esp)
8010378e:	e8 1d 0e 00 00       	call   801045b0 <release>
  return i;
80103793:	83 c4 10             	add    $0x10,%esp
}
80103796:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103799:	89 d8                	mov    %ebx,%eax
8010379b:	5b                   	pop    %ebx
8010379c:	5e                   	pop    %esi
8010379d:	5f                   	pop    %edi
8010379e:	5d                   	pop    %ebp
8010379f:	c3                   	ret
      release(&p->lock);
801037a0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037a8:	56                   	push   %esi
801037a9:	e8 02 0e 00 00       	call   801045b0 <release>
      return -1;
801037ae:	83 c4 10             	add    $0x10,%esp
}
801037b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037b4:	89 d8                	mov    %ebx,%eax
801037b6:	5b                   	pop    %ebx
801037b7:	5e                   	pop    %esi
801037b8:	5f                   	pop    %edi
801037b9:	5d                   	pop    %ebp
801037ba:	c3                   	ret
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c4:	bb 74 39 11 80       	mov    $0x80113974,%ebx
{
801037c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037cc:	68 40 39 11 80       	push   $0x80113940
801037d1:	e8 3a 0e 00 00       	call   80104610 <acquire>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	eb 10                	jmp    801037eb <allocproc+0x2b>
801037db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e0:	83 c3 7c             	add    $0x7c,%ebx
801037e3:	81 fb 74 58 11 80    	cmp    $0x80115874,%ebx
801037e9:	74 75                	je     80103860 <allocproc+0xa0>
    if(p->state == UNUSED)
801037eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801037ee:	85 c0                	test   %eax,%eax
801037f0:	75 ee                	jne    801037e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037f2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801037f7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103801:	89 43 10             	mov    %eax,0x10(%ebx)
80103804:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103807:	68 40 39 11 80       	push   $0x80113940
  p->pid = nextpid++;
8010380c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103812:	e8 99 0d 00 00       	call   801045b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103817:	e8 34 ee ff ff       	call   80102650 <kalloc>
8010381c:	83 c4 10             	add    $0x10,%esp
8010381f:	89 43 08             	mov    %eax,0x8(%ebx)
80103822:	85 c0                	test   %eax,%eax
80103824:	74 53                	je     80103879 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103826:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010382c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010382f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103834:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103837:	c7 40 14 30 59 10 80 	movl   $0x80105930,0x14(%eax)
  p->context = (struct context*)sp;
8010383e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103841:	6a 14                	push   $0x14
80103843:	6a 00                	push   $0x0
80103845:	50                   	push   %eax
80103846:	e8 c5 0e 00 00       	call   80104710 <memset>
  p->context->eip = (uint)forkret;
8010384b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010384e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103851:	c7 40 10 90 38 10 80 	movl   $0x80103890,0x10(%eax)
}
80103858:	89 d8                	mov    %ebx,%eax
8010385a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010385d:	c9                   	leave
8010385e:	c3                   	ret
8010385f:	90                   	nop
  release(&ptable.lock);
80103860:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103863:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103865:	68 40 39 11 80       	push   $0x80113940
8010386a:	e8 41 0d 00 00       	call   801045b0 <release>
  return 0;
8010386f:	83 c4 10             	add    $0x10,%esp
}
80103872:	89 d8                	mov    %ebx,%eax
80103874:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103877:	c9                   	leave
80103878:	c3                   	ret
    p->state = UNUSED;
80103879:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103880:	31 db                	xor    %ebx,%ebx
80103882:	eb ee                	jmp    80103872 <allocproc+0xb2>
80103884:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010388b:	00 
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103890 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103896:	68 40 39 11 80       	push   $0x80113940
8010389b:	e8 10 0d 00 00       	call   801045b0 <release>

  if (first) {
801038a0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801038a5:	83 c4 10             	add    $0x10,%esp
801038a8:	85 c0                	test   %eax,%eax
801038aa:	75 04                	jne    801038b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038ac:	c9                   	leave
801038ad:	c3                   	ret
801038ae:	66 90                	xchg   %ax,%ax
    first = 0;
801038b0:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801038b7:	00 00 00 
    iinit(ROOTDEV);
801038ba:	83 ec 0c             	sub    $0xc,%esp
801038bd:	6a 01                	push   $0x1
801038bf:	e8 ac dc ff ff       	call   80101570 <iinit>
    initlog(ROOTDEV);
801038c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038cb:	e8 c0 f3 ff ff       	call   80102c90 <initlog>
}
801038d0:	83 c4 10             	add    $0x10,%esp
801038d3:	c9                   	leave
801038d4:	c3                   	ret
801038d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801038dc:	00 
801038dd:	8d 76 00             	lea    0x0(%esi),%esi

801038e0 <pinit>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038e6:	68 b2 74 10 80       	push   $0x801074b2
801038eb:	68 40 39 11 80       	push   $0x80113940
801038f0:	e8 2b 0b 00 00       	call   80104420 <initlock>
}
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	c9                   	leave
801038f9:	c3                   	ret
801038fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103900 <mycpu>:
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103905:	9c                   	pushf
80103906:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103907:	f6 c4 02             	test   $0x2,%ah
8010390a:	75 46                	jne    80103952 <mycpu+0x52>
  apicid = lapicid();
8010390c:	e8 af ef ff ff       	call   801028c0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103911:	8b 35 a4 33 11 80    	mov    0x801133a4,%esi
80103917:	85 f6                	test   %esi,%esi
80103919:	7e 2a                	jle    80103945 <mycpu+0x45>
8010391b:	31 d2                	xor    %edx,%edx
8010391d:	eb 08                	jmp    80103927 <mycpu+0x27>
8010391f:	90                   	nop
80103920:	83 c2 01             	add    $0x1,%edx
80103923:	39 f2                	cmp    %esi,%edx
80103925:	74 1e                	je     80103945 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103927:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010392d:	0f b6 99 c0 33 11 80 	movzbl -0x7feecc40(%ecx),%ebx
80103934:	39 c3                	cmp    %eax,%ebx
80103936:	75 e8                	jne    80103920 <mycpu+0x20>
}
80103938:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010393b:	8d 81 c0 33 11 80    	lea    -0x7feecc40(%ecx),%eax
}
80103941:	5b                   	pop    %ebx
80103942:	5e                   	pop    %esi
80103943:	5d                   	pop    %ebp
80103944:	c3                   	ret
  panic("unknown apicid\n");
80103945:	83 ec 0c             	sub    $0xc,%esp
80103948:	68 b9 74 10 80       	push   $0x801074b9
8010394d:	e8 2e ca ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103952:	83 ec 0c             	sub    $0xc,%esp
80103955:	68 90 78 10 80       	push   $0x80107890
8010395a:	e8 21 ca ff ff       	call   80100380 <panic>
8010395f:	90                   	nop

80103960 <cpuid>:
cpuid() {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103966:	e8 95 ff ff ff       	call   80103900 <mycpu>
}
8010396b:	c9                   	leave
  return mycpu()-cpus;
8010396c:	2d c0 33 11 80       	sub    $0x801133c0,%eax
80103971:	c1 f8 04             	sar    $0x4,%eax
80103974:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010397a:	c3                   	ret
8010397b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103980 <myproc>:
myproc(void) {
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103987:	e8 34 0b 00 00       	call   801044c0 <pushcli>
  c = mycpu();
8010398c:	e8 6f ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103991:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103997:	e8 74 0b 00 00       	call   80104510 <popcli>
}
8010399c:	89 d8                	mov    %ebx,%eax
8010399e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039a1:	c9                   	leave
801039a2:	c3                   	ret
801039a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039aa:	00 
801039ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039b0 <userinit>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	53                   	push   %ebx
801039b4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039b7:	e8 04 fe ff ff       	call   801037c0 <allocproc>
801039bc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039be:	a3 74 58 11 80       	mov    %eax,0x80115874
  if((p->pgdir = setupkvm()) == 0)
801039c3:	e8 38 35 00 00       	call   80106f00 <setupkvm>
801039c8:	89 43 04             	mov    %eax,0x4(%ebx)
801039cb:	85 c0                	test   %eax,%eax
801039cd:	0f 84 bd 00 00 00    	je     80103a90 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039d3:	83 ec 04             	sub    $0x4,%esp
801039d6:	68 2c 00 00 00       	push   $0x2c
801039db:	68 60 a4 10 80       	push   $0x8010a460
801039e0:	50                   	push   %eax
801039e1:	e8 fa 31 00 00       	call   80106be0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039e6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039e9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039ef:	6a 4c                	push   $0x4c
801039f1:	6a 00                	push   $0x0
801039f3:	ff 73 18             	push   0x18(%ebx)
801039f6:	e8 15 0d 00 00       	call   80104710 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039fb:	8b 43 18             	mov    0x18(%ebx),%eax
801039fe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a03:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a06:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a16:	8b 43 18             	mov    0x18(%ebx),%eax
80103a19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a21:	8b 43 18             	mov    0x18(%ebx),%eax
80103a24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a36:	8b 43 18             	mov    0x18(%ebx),%eax
80103a39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a40:	8b 43 18             	mov    0x18(%ebx),%eax
80103a43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a4d:	6a 10                	push   $0x10
80103a4f:	68 e2 74 10 80       	push   $0x801074e2
80103a54:	50                   	push   %eax
80103a55:	e8 66 0e 00 00       	call   801048c0 <safestrcpy>
  p->cwd = namei("/");
80103a5a:	c7 04 24 eb 74 10 80 	movl   $0x801074eb,(%esp)
80103a61:	e8 0a e6 ff ff       	call   80102070 <namei>
80103a66:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a69:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103a70:	e8 9b 0b 00 00       	call   80104610 <acquire>
  p->state = RUNNABLE;
80103a75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a7c:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103a83:	e8 28 0b 00 00       	call   801045b0 <release>
}
80103a88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a8b:	83 c4 10             	add    $0x10,%esp
80103a8e:	c9                   	leave
80103a8f:	c3                   	ret
    panic("userinit: out of memory?");
80103a90:	83 ec 0c             	sub    $0xc,%esp
80103a93:	68 c9 74 10 80       	push   $0x801074c9
80103a98:	e8 e3 c8 ff ff       	call   80100380 <panic>
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi

80103aa0 <growproc>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
80103aa4:	53                   	push   %ebx
80103aa5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103aa8:	e8 13 0a 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80103aad:	e8 4e fe ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103ab2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ab8:	e8 53 0a 00 00       	call   80104510 <popcli>
  sz = curproc->sz;
80103abd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103abf:	85 f6                	test   %esi,%esi
80103ac1:	7f 1d                	jg     80103ae0 <growproc+0x40>
  } else if(n < 0){
80103ac3:	75 3b                	jne    80103b00 <growproc+0x60>
  switchuvm(curproc);
80103ac5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ac8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103aca:	53                   	push   %ebx
80103acb:	e8 00 30 00 00       	call   80106ad0 <switchuvm>
  return 0;
80103ad0:	83 c4 10             	add    $0x10,%esp
80103ad3:	31 c0                	xor    %eax,%eax
}
80103ad5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ad8:	5b                   	pop    %ebx
80103ad9:	5e                   	pop    %esi
80103ada:	5d                   	pop    %ebp
80103adb:	c3                   	ret
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ae0:	83 ec 04             	sub    $0x4,%esp
80103ae3:	01 c6                	add    %eax,%esi
80103ae5:	56                   	push   %esi
80103ae6:	50                   	push   %eax
80103ae7:	ff 73 04             	push   0x4(%ebx)
80103aea:	e8 41 32 00 00       	call   80106d30 <allocuvm>
80103aef:	83 c4 10             	add    $0x10,%esp
80103af2:	85 c0                	test   %eax,%eax
80103af4:	75 cf                	jne    80103ac5 <growproc+0x25>
      return -1;
80103af6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103afb:	eb d8                	jmp    80103ad5 <growproc+0x35>
80103afd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b00:	83 ec 04             	sub    $0x4,%esp
80103b03:	01 c6                	add    %eax,%esi
80103b05:	56                   	push   %esi
80103b06:	50                   	push   %eax
80103b07:	ff 73 04             	push   0x4(%ebx)
80103b0a:	e8 41 33 00 00       	call   80106e50 <deallocuvm>
80103b0f:	83 c4 10             	add    $0x10,%esp
80103b12:	85 c0                	test   %eax,%eax
80103b14:	75 af                	jne    80103ac5 <growproc+0x25>
80103b16:	eb de                	jmp    80103af6 <growproc+0x56>
80103b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b1f:	00 

80103b20 <fork>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	57                   	push   %edi
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b29:	e8 92 09 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80103b2e:	e8 cd fd ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103b33:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b39:	e8 d2 09 00 00       	call   80104510 <popcli>
  if((np = allocproc()) == 0){
80103b3e:	e8 7d fc ff ff       	call   801037c0 <allocproc>
80103b43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b46:	85 c0                	test   %eax,%eax
80103b48:	0f 84 d6 00 00 00    	je     80103c24 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b4e:	83 ec 08             	sub    $0x8,%esp
80103b51:	ff 33                	push   (%ebx)
80103b53:	89 c7                	mov    %eax,%edi
80103b55:	ff 73 04             	push   0x4(%ebx)
80103b58:	e8 93 34 00 00       	call   80106ff0 <copyuvm>
80103b5d:	83 c4 10             	add    $0x10,%esp
80103b60:	89 47 04             	mov    %eax,0x4(%edi)
80103b63:	85 c0                	test   %eax,%eax
80103b65:	0f 84 9a 00 00 00    	je     80103c05 <fork+0xe5>
  np->sz = curproc->sz;
80103b6b:	8b 03                	mov    (%ebx),%eax
80103b6d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b70:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103b72:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103b75:	89 c8                	mov    %ecx,%eax
80103b77:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b7a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b7f:	8b 73 18             	mov    0x18(%ebx),%esi
80103b82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b84:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b86:	8b 40 18             	mov    0x18(%eax),%eax
80103b89:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b90:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b94:	85 c0                	test   %eax,%eax
80103b96:	74 13                	je     80103bab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b98:	83 ec 0c             	sub    $0xc,%esp
80103b9b:	50                   	push   %eax
80103b9c:	e8 1f d3 ff ff       	call   80100ec0 <filedup>
80103ba1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ba4:	83 c4 10             	add    $0x10,%esp
80103ba7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103bab:	83 c6 01             	add    $0x1,%esi
80103bae:	83 fe 10             	cmp    $0x10,%esi
80103bb1:	75 dd                	jne    80103b90 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103bb3:	83 ec 0c             	sub    $0xc,%esp
80103bb6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bb9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103bbc:	e8 9f db ff ff       	call   80101760 <idup>
80103bc1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bc4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103bc7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bca:	8d 47 6c             	lea    0x6c(%edi),%eax
80103bcd:	6a 10                	push   $0x10
80103bcf:	53                   	push   %ebx
80103bd0:	50                   	push   %eax
80103bd1:	e8 ea 0c 00 00       	call   801048c0 <safestrcpy>
  pid = np->pid;
80103bd6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103bd9:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103be0:	e8 2b 0a 00 00       	call   80104610 <acquire>
  np->state = RUNNABLE;
80103be5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103bec:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103bf3:	e8 b8 09 00 00       	call   801045b0 <release>
  return pid;
80103bf8:	83 c4 10             	add    $0x10,%esp
}
80103bfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bfe:	89 d8                	mov    %ebx,%eax
80103c00:	5b                   	pop    %ebx
80103c01:	5e                   	pop    %esi
80103c02:	5f                   	pop    %edi
80103c03:	5d                   	pop    %ebp
80103c04:	c3                   	ret
    kfree(np->kstack);
80103c05:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103c08:	83 ec 0c             	sub    $0xc,%esp
80103c0b:	ff 73 08             	push   0x8(%ebx)
80103c0e:	e8 7d e8 ff ff       	call   80102490 <kfree>
    np->kstack = 0;
80103c13:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103c1a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103c1d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c24:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c29:	eb d0                	jmp    80103bfb <fork+0xdb>
80103c2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103c30 <scheduler>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
80103c36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103c39:	e8 c2 fc ff ff       	call   80103900 <mycpu>
  c->proc = 0;
80103c3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c45:	00 00 00 
  struct cpu *c = mycpu();
80103c48:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103c4a:	8d 78 04             	lea    0x4(%eax),%edi
80103c4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c50:	fb                   	sti
    acquire(&ptable.lock);
80103c51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c54:	bb 74 39 11 80       	mov    $0x80113974,%ebx
    acquire(&ptable.lock);
80103c59:	68 40 39 11 80       	push   $0x80113940
80103c5e:	e8 ad 09 00 00       	call   80104610 <acquire>
80103c63:	83 c4 10             	add    $0x10,%esp
80103c66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c6d:	00 
80103c6e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103c70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c74:	75 33                	jne    80103ca9 <scheduler+0x79>
      switchuvm(p);
80103c76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c7f:	53                   	push   %ebx
80103c80:	e8 4b 2e 00 00       	call   80106ad0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c85:	58                   	pop    %eax
80103c86:	5a                   	pop    %edx
80103c87:	ff 73 1c             	push   0x1c(%ebx)
80103c8a:	57                   	push   %edi
      p->state = RUNNING;
80103c8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103c92:	e8 84 0c 00 00       	call   8010491b <swtch>
      switchkvm();
80103c97:	e8 24 2e 00 00       	call   80106ac0 <switchkvm>
      c->proc = 0;
80103c9c:	83 c4 10             	add    $0x10,%esp
80103c9f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ca6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ca9:	83 c3 7c             	add    $0x7c,%ebx
80103cac:	81 fb 74 58 11 80    	cmp    $0x80115874,%ebx
80103cb2:	75 bc                	jne    80103c70 <scheduler+0x40>
    release(&ptable.lock);
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 40 39 11 80       	push   $0x80113940
80103cbc:	e8 ef 08 00 00       	call   801045b0 <release>
    sti();
80103cc1:	83 c4 10             	add    $0x10,%esp
80103cc4:	eb 8a                	jmp    80103c50 <scheduler+0x20>
80103cc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ccd:	00 
80103cce:	66 90                	xchg   %ax,%ax

80103cd0 <sched>:
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	56                   	push   %esi
80103cd4:	53                   	push   %ebx
  pushcli();
80103cd5:	e8 e6 07 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80103cda:	e8 21 fc ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103cdf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ce5:	e8 26 08 00 00       	call   80104510 <popcli>
  if(!holding(&ptable.lock))
80103cea:	83 ec 0c             	sub    $0xc,%esp
80103ced:	68 40 39 11 80       	push   $0x80113940
80103cf2:	e8 79 08 00 00       	call   80104570 <holding>
80103cf7:	83 c4 10             	add    $0x10,%esp
80103cfa:	85 c0                	test   %eax,%eax
80103cfc:	74 4f                	je     80103d4d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cfe:	e8 fd fb ff ff       	call   80103900 <mycpu>
80103d03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103d0a:	75 68                	jne    80103d74 <sched+0xa4>
  if(p->state == RUNNING)
80103d0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d10:	74 55                	je     80103d67 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d12:	9c                   	pushf
80103d13:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d14:	f6 c4 02             	test   $0x2,%ah
80103d17:	75 41                	jne    80103d5a <sched+0x8a>
  intena = mycpu()->intena;
80103d19:	e8 e2 fb ff ff       	call   80103900 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d1e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d27:	e8 d4 fb ff ff       	call   80103900 <mycpu>
80103d2c:	83 ec 08             	sub    $0x8,%esp
80103d2f:	ff 70 04             	push   0x4(%eax)
80103d32:	53                   	push   %ebx
80103d33:	e8 e3 0b 00 00       	call   8010491b <swtch>
  mycpu()->intena = intena;
80103d38:	e8 c3 fb ff ff       	call   80103900 <mycpu>
}
80103d3d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d49:	5b                   	pop    %ebx
80103d4a:	5e                   	pop    %esi
80103d4b:	5d                   	pop    %ebp
80103d4c:	c3                   	ret
    panic("sched ptable.lock");
80103d4d:	83 ec 0c             	sub    $0xc,%esp
80103d50:	68 ed 74 10 80       	push   $0x801074ed
80103d55:	e8 26 c6 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103d5a:	83 ec 0c             	sub    $0xc,%esp
80103d5d:	68 19 75 10 80       	push   $0x80107519
80103d62:	e8 19 c6 ff ff       	call   80100380 <panic>
    panic("sched running");
80103d67:	83 ec 0c             	sub    $0xc,%esp
80103d6a:	68 0b 75 10 80       	push   $0x8010750b
80103d6f:	e8 0c c6 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103d74:	83 ec 0c             	sub    $0xc,%esp
80103d77:	68 ff 74 10 80       	push   $0x801074ff
80103d7c:	e8 ff c5 ff ff       	call   80100380 <panic>
80103d81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d88:	00 
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d90 <exit>:
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	57                   	push   %edi
80103d94:	56                   	push   %esi
80103d95:	53                   	push   %ebx
80103d96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103d99:	e8 e2 fb ff ff       	call   80103980 <myproc>
  if(curproc == initproc)
80103d9e:	39 05 74 58 11 80    	cmp    %eax,0x80115874
80103da4:	0f 84 fd 00 00 00    	je     80103ea7 <exit+0x117>
80103daa:	89 c3                	mov    %eax,%ebx
80103dac:	8d 70 28             	lea    0x28(%eax),%esi
80103daf:	8d 78 68             	lea    0x68(%eax),%edi
80103db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103db8:	8b 06                	mov    (%esi),%eax
80103dba:	85 c0                	test   %eax,%eax
80103dbc:	74 12                	je     80103dd0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103dbe:	83 ec 0c             	sub    $0xc,%esp
80103dc1:	50                   	push   %eax
80103dc2:	e8 49 d1 ff ff       	call   80100f10 <fileclose>
      curproc->ofile[fd] = 0;
80103dc7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103dcd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103dd0:	83 c6 04             	add    $0x4,%esi
80103dd3:	39 f7                	cmp    %esi,%edi
80103dd5:	75 e1                	jne    80103db8 <exit+0x28>
  begin_op();
80103dd7:	e8 54 ef ff ff       	call   80102d30 <begin_op>
  iput(curproc->cwd);
80103ddc:	83 ec 0c             	sub    $0xc,%esp
80103ddf:	ff 73 68             	push   0x68(%ebx)
80103de2:	e8 d9 da ff ff       	call   801018c0 <iput>
  end_op();
80103de7:	e8 b4 ef ff ff       	call   80102da0 <end_op>
  curproc->cwd = 0;
80103dec:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103df3:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103dfa:	e8 11 08 00 00       	call   80104610 <acquire>
  wakeup1(curproc->parent);
80103dff:	8b 53 14             	mov    0x14(%ebx),%edx
80103e02:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e05:	b8 74 39 11 80       	mov    $0x80113974,%eax
80103e0a:	eb 0e                	jmp    80103e1a <exit+0x8a>
80103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e10:	83 c0 7c             	add    $0x7c,%eax
80103e13:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80103e18:	74 1c                	je     80103e36 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103e1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e1e:	75 f0                	jne    80103e10 <exit+0x80>
80103e20:	3b 50 20             	cmp    0x20(%eax),%edx
80103e23:	75 eb                	jne    80103e10 <exit+0x80>
      p->state = RUNNABLE;
80103e25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e2c:	83 c0 7c             	add    $0x7c,%eax
80103e2f:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80103e34:	75 e4                	jne    80103e1a <exit+0x8a>
      p->parent = initproc;
80103e36:	8b 0d 74 58 11 80    	mov    0x80115874,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3c:	ba 74 39 11 80       	mov    $0x80113974,%edx
80103e41:	eb 10                	jmp    80103e53 <exit+0xc3>
80103e43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e48:	83 c2 7c             	add    $0x7c,%edx
80103e4b:	81 fa 74 58 11 80    	cmp    $0x80115874,%edx
80103e51:	74 3b                	je     80103e8e <exit+0xfe>
    if(p->parent == curproc){
80103e53:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103e56:	75 f0                	jne    80103e48 <exit+0xb8>
      if(p->state == ZOMBIE)
80103e58:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e5c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e5f:	75 e7                	jne    80103e48 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e61:	b8 74 39 11 80       	mov    $0x80113974,%eax
80103e66:	eb 12                	jmp    80103e7a <exit+0xea>
80103e68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e6f:	00 
80103e70:	83 c0 7c             	add    $0x7c,%eax
80103e73:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80103e78:	74 ce                	je     80103e48 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103e7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e7e:	75 f0                	jne    80103e70 <exit+0xe0>
80103e80:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e83:	75 eb                	jne    80103e70 <exit+0xe0>
      p->state = RUNNABLE;
80103e85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e8c:	eb e2                	jmp    80103e70 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e8e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103e95:	e8 36 fe ff ff       	call   80103cd0 <sched>
  panic("zombie exit");
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 3a 75 10 80       	push   $0x8010753a
80103ea2:	e8 d9 c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103ea7:	83 ec 0c             	sub    $0xc,%esp
80103eaa:	68 2d 75 10 80       	push   $0x8010752d
80103eaf:	e8 cc c4 ff ff       	call   80100380 <panic>
80103eb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ebb:	00 
80103ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ec0 <wait>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	56                   	push   %esi
80103ec4:	53                   	push   %ebx
  pushcli();
80103ec5:	e8 f6 05 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80103eca:	e8 31 fa ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103ecf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ed5:	e8 36 06 00 00       	call   80104510 <popcli>
  acquire(&ptable.lock);
80103eda:	83 ec 0c             	sub    $0xc,%esp
80103edd:	68 40 39 11 80       	push   $0x80113940
80103ee2:	e8 29 07 00 00       	call   80104610 <acquire>
80103ee7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eec:	bb 74 39 11 80       	mov    $0x80113974,%ebx
80103ef1:	eb 10                	jmp    80103f03 <wait+0x43>
80103ef3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ef8:	83 c3 7c             	add    $0x7c,%ebx
80103efb:	81 fb 74 58 11 80    	cmp    $0x80115874,%ebx
80103f01:	74 1b                	je     80103f1e <wait+0x5e>
      if(p->parent != curproc)
80103f03:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f06:	75 f0                	jne    80103ef8 <wait+0x38>
      if(p->state == ZOMBIE){
80103f08:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f0c:	74 62                	je     80103f70 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f0e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103f11:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f16:	81 fb 74 58 11 80    	cmp    $0x80115874,%ebx
80103f1c:	75 e5                	jne    80103f03 <wait+0x43>
    if(!havekids || curproc->killed){
80103f1e:	85 c0                	test   %eax,%eax
80103f20:	0f 84 a0 00 00 00    	je     80103fc6 <wait+0x106>
80103f26:	8b 46 24             	mov    0x24(%esi),%eax
80103f29:	85 c0                	test   %eax,%eax
80103f2b:	0f 85 95 00 00 00    	jne    80103fc6 <wait+0x106>
  pushcli();
80103f31:	e8 8a 05 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80103f36:	e8 c5 f9 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103f3b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f41:	e8 ca 05 00 00       	call   80104510 <popcli>
  if(p == 0)
80103f46:	85 db                	test   %ebx,%ebx
80103f48:	0f 84 8f 00 00 00    	je     80103fdd <wait+0x11d>
  p->chan = chan;
80103f4e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103f51:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f58:	e8 73 fd ff ff       	call   80103cd0 <sched>
  p->chan = 0;
80103f5d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f64:	eb 84                	jmp    80103eea <wait+0x2a>
80103f66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f6d:	00 
80103f6e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80103f70:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103f73:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f76:	ff 73 08             	push   0x8(%ebx)
80103f79:	e8 12 e5 ff ff       	call   80102490 <kfree>
        p->kstack = 0;
80103f7e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f85:	5a                   	pop    %edx
80103f86:	ff 73 04             	push   0x4(%ebx)
80103f89:	e8 f2 2e 00 00       	call   80106e80 <freevm>
        p->pid = 0;
80103f8e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f95:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f9c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fa0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fa7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fae:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103fb5:	e8 f6 05 00 00       	call   801045b0 <release>
        return pid;
80103fba:	83 c4 10             	add    $0x10,%esp
}
80103fbd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fc0:	89 f0                	mov    %esi,%eax
80103fc2:	5b                   	pop    %ebx
80103fc3:	5e                   	pop    %esi
80103fc4:	5d                   	pop    %ebp
80103fc5:	c3                   	ret
      release(&ptable.lock);
80103fc6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fc9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fce:	68 40 39 11 80       	push   $0x80113940
80103fd3:	e8 d8 05 00 00       	call   801045b0 <release>
      return -1;
80103fd8:	83 c4 10             	add    $0x10,%esp
80103fdb:	eb e0                	jmp    80103fbd <wait+0xfd>
    panic("sleep");
80103fdd:	83 ec 0c             	sub    $0xc,%esp
80103fe0:	68 46 75 10 80       	push   $0x80107546
80103fe5:	e8 96 c3 ff ff       	call   80100380 <panic>
80103fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ff0 <yield>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ff7:	68 40 39 11 80       	push   $0x80113940
80103ffc:	e8 0f 06 00 00       	call   80104610 <acquire>
  pushcli();
80104001:	e8 ba 04 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80104006:	e8 f5 f8 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010400b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104011:	e8 fa 04 00 00       	call   80104510 <popcli>
  myproc()->state = RUNNABLE;
80104016:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010401d:	e8 ae fc ff ff       	call   80103cd0 <sched>
  release(&ptable.lock);
80104022:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80104029:	e8 82 05 00 00       	call   801045b0 <release>
}
8010402e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104031:	83 c4 10             	add    $0x10,%esp
80104034:	c9                   	leave
80104035:	c3                   	ret
80104036:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010403d:	00 
8010403e:	66 90                	xchg   %ax,%ax

80104040 <sleep>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 0c             	sub    $0xc,%esp
80104049:	8b 7d 08             	mov    0x8(%ebp),%edi
8010404c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010404f:	e8 6c 04 00 00       	call   801044c0 <pushcli>
  c = mycpu();
80104054:	e8 a7 f8 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104059:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010405f:	e8 ac 04 00 00       	call   80104510 <popcli>
  if(p == 0)
80104064:	85 db                	test   %ebx,%ebx
80104066:	0f 84 87 00 00 00    	je     801040f3 <sleep+0xb3>
  if(lk == 0)
8010406c:	85 f6                	test   %esi,%esi
8010406e:	74 76                	je     801040e6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104070:	81 fe 40 39 11 80    	cmp    $0x80113940,%esi
80104076:	74 50                	je     801040c8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	68 40 39 11 80       	push   $0x80113940
80104080:	e8 8b 05 00 00       	call   80104610 <acquire>
    release(lk);
80104085:	89 34 24             	mov    %esi,(%esp)
80104088:	e8 23 05 00 00       	call   801045b0 <release>
  p->chan = chan;
8010408d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104090:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104097:	e8 34 fc ff ff       	call   80103cd0 <sched>
  p->chan = 0;
8010409c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801040a3:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
801040aa:	e8 01 05 00 00       	call   801045b0 <release>
    acquire(lk);
801040af:	83 c4 10             	add    $0x10,%esp
801040b2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040b8:	5b                   	pop    %ebx
801040b9:	5e                   	pop    %esi
801040ba:	5f                   	pop    %edi
801040bb:	5d                   	pop    %ebp
    acquire(lk);
801040bc:	e9 4f 05 00 00       	jmp    80104610 <acquire>
801040c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801040c8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040cb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040d2:	e8 f9 fb ff ff       	call   80103cd0 <sched>
  p->chan = 0;
801040d7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801040de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040e1:	5b                   	pop    %ebx
801040e2:	5e                   	pop    %esi
801040e3:	5f                   	pop    %edi
801040e4:	5d                   	pop    %ebp
801040e5:	c3                   	ret
    panic("sleep without lk");
801040e6:	83 ec 0c             	sub    $0xc,%esp
801040e9:	68 4c 75 10 80       	push   $0x8010754c
801040ee:	e8 8d c2 ff ff       	call   80100380 <panic>
    panic("sleep");
801040f3:	83 ec 0c             	sub    $0xc,%esp
801040f6:	68 46 75 10 80       	push   $0x80107546
801040fb:	e8 80 c2 ff ff       	call   80100380 <panic>

80104100 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 10             	sub    $0x10,%esp
80104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010410a:	68 40 39 11 80       	push   $0x80113940
8010410f:	e8 fc 04 00 00       	call   80104610 <acquire>
80104114:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104117:	b8 74 39 11 80       	mov    $0x80113974,%eax
8010411c:	eb 0c                	jmp    8010412a <wakeup+0x2a>
8010411e:	66 90                	xchg   %ax,%ax
80104120:	83 c0 7c             	add    $0x7c,%eax
80104123:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80104128:	74 1c                	je     80104146 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010412a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010412e:	75 f0                	jne    80104120 <wakeup+0x20>
80104130:	3b 58 20             	cmp    0x20(%eax),%ebx
80104133:	75 eb                	jne    80104120 <wakeup+0x20>
      p->state = RUNNABLE;
80104135:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010413c:	83 c0 7c             	add    $0x7c,%eax
8010413f:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80104144:	75 e4                	jne    8010412a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104146:	c7 45 08 40 39 11 80 	movl   $0x80113940,0x8(%ebp)
}
8010414d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104150:	c9                   	leave
  release(&ptable.lock);
80104151:	e9 5a 04 00 00       	jmp    801045b0 <release>
80104156:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010415d:	00 
8010415e:	66 90                	xchg   %ax,%ax

80104160 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	53                   	push   %ebx
80104164:	83 ec 10             	sub    $0x10,%esp
80104167:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010416a:	68 40 39 11 80       	push   $0x80113940
8010416f:	e8 9c 04 00 00       	call   80104610 <acquire>
80104174:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104177:	b8 74 39 11 80       	mov    $0x80113974,%eax
8010417c:	eb 0c                	jmp    8010418a <kill+0x2a>
8010417e:	66 90                	xchg   %ax,%ax
80104180:	83 c0 7c             	add    $0x7c,%eax
80104183:	3d 74 58 11 80       	cmp    $0x80115874,%eax
80104188:	74 36                	je     801041c0 <kill+0x60>
    if(p->pid == pid){
8010418a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010418d:	75 f1                	jne    80104180 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010418f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104193:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010419a:	75 07                	jne    801041a3 <kill+0x43>
        p->state = RUNNABLE;
8010419c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801041a3:	83 ec 0c             	sub    $0xc,%esp
801041a6:	68 40 39 11 80       	push   $0x80113940
801041ab:	e8 00 04 00 00       	call   801045b0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801041b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801041b3:	83 c4 10             	add    $0x10,%esp
801041b6:	31 c0                	xor    %eax,%eax
}
801041b8:	c9                   	leave
801041b9:	c3                   	ret
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801041c0:	83 ec 0c             	sub    $0xc,%esp
801041c3:	68 40 39 11 80       	push   $0x80113940
801041c8:	e8 e3 03 00 00       	call   801045b0 <release>
}
801041cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801041d0:	83 c4 10             	add    $0x10,%esp
801041d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041d8:	c9                   	leave
801041d9:	c3                   	ret
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801041e8:	53                   	push   %ebx
801041e9:	bb e0 39 11 80       	mov    $0x801139e0,%ebx
801041ee:	83 ec 3c             	sub    $0x3c,%esp
801041f1:	eb 24                	jmp    80104217 <procdump+0x37>
801041f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	68 0b 77 10 80       	push   $0x8010770b
80104200:	e8 ab c4 ff ff       	call   801006b0 <cprintf>
80104205:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104208:	83 c3 7c             	add    $0x7c,%ebx
8010420b:	81 fb e0 58 11 80    	cmp    $0x801158e0,%ebx
80104211:	0f 84 81 00 00 00    	je     80104298 <procdump+0xb8>
    if(p->state == UNUSED)
80104217:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010421a:	85 c0                	test   %eax,%eax
8010421c:	74 ea                	je     80104208 <procdump+0x28>
      state = "???";
8010421e:	ba 5d 75 10 80       	mov    $0x8010755d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104223:	83 f8 05             	cmp    $0x5,%eax
80104226:	77 11                	ja     80104239 <procdump+0x59>
80104228:	8b 14 85 a0 7b 10 80 	mov    -0x7fef8460(,%eax,4),%edx
      state = "???";
8010422f:	b8 5d 75 10 80       	mov    $0x8010755d,%eax
80104234:	85 d2                	test   %edx,%edx
80104236:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104239:	53                   	push   %ebx
8010423a:	52                   	push   %edx
8010423b:	ff 73 a4             	push   -0x5c(%ebx)
8010423e:	68 61 75 10 80       	push   $0x80107561
80104243:	e8 68 c4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104248:	83 c4 10             	add    $0x10,%esp
8010424b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010424f:	75 a7                	jne    801041f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104251:	83 ec 08             	sub    $0x8,%esp
80104254:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104257:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010425a:	50                   	push   %eax
8010425b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010425e:	8b 40 0c             	mov    0xc(%eax),%eax
80104261:	83 c0 08             	add    $0x8,%eax
80104264:	50                   	push   %eax
80104265:	e8 d6 01 00 00       	call   80104440 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010426a:	83 c4 10             	add    $0x10,%esp
8010426d:	8d 76 00             	lea    0x0(%esi),%esi
80104270:	8b 17                	mov    (%edi),%edx
80104272:	85 d2                	test   %edx,%edx
80104274:	74 82                	je     801041f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104276:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104279:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010427c:	52                   	push   %edx
8010427d:	68 81 72 10 80       	push   $0x80107281
80104282:	e8 29 c4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104287:	83 c4 10             	add    $0x10,%esp
8010428a:	39 f7                	cmp    %esi,%edi
8010428c:	75 e2                	jne    80104270 <procdump+0x90>
8010428e:	e9 65 ff ff ff       	jmp    801041f8 <procdump+0x18>
80104293:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104298:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010429b:	5b                   	pop    %ebx
8010429c:	5e                   	pop    %esi
8010429d:	5f                   	pop    %edi
8010429e:	5d                   	pop    %ebp
8010429f:	c3                   	ret

801042a0 <getproccount>:
// Kernel function to count active processes
int
getproccount(void)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
  struct proc *p;
  int count = 0;
801042a4:	31 db                	xor    %ebx,%ebx
{
801042a6:	83 ec 10             	sub    $0x10,%esp

  // Loop through the kernel's process table
  acquire(&ptable.lock);
801042a9:	68 40 39 11 80       	push   $0x80113940
801042ae:	e8 5d 03 00 00       	call   80104610 <acquire>
801042b3:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b6:	b8 74 39 11 80       	mov    $0x80113974,%eax
801042bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state != UNUSED){
      count++;
801042c0:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
801042c4:	83 db ff             	sbb    $0xffffffff,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042c7:	83 c0 7c             	add    $0x7c,%eax
801042ca:	3d 74 58 11 80       	cmp    $0x80115874,%eax
801042cf:	75 ef                	jne    801042c0 <getproccount+0x20>
    }
  }
  release(&ptable.lock);
801042d1:	83 ec 0c             	sub    $0xc,%esp
801042d4:	68 40 39 11 80       	push   $0x80113940
801042d9:	e8 d2 02 00 00       	call   801045b0 <release>

  return count;
}
801042de:	89 d8                	mov    %ebx,%eax
801042e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042e3:	c9                   	leave
801042e4:	c3                   	ret
801042e5:	66 90                	xchg   %ax,%ax
801042e7:	66 90                	xchg   %ax,%ax
801042e9:	66 90                	xchg   %ax,%ax
801042eb:	66 90                	xchg   %ax,%ax
801042ed:	66 90                	xchg   %ax,%ax
801042ef:	90                   	nop

801042f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042fa:	68 94 75 10 80       	push   $0x80107594
801042ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104302:	50                   	push   %eax
80104303:	e8 18 01 00 00       	call   80104420 <initlock>
  lk->name = name;
80104308:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010430b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104311:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104314:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010431b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010431e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104321:	c9                   	leave
80104322:	c3                   	ret
80104323:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010432a:	00 
8010432b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104330 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	8d 73 04             	lea    0x4(%ebx),%esi
8010433b:	83 ec 0c             	sub    $0xc,%esp
8010433e:	56                   	push   %esi
8010433f:	e8 cc 02 00 00       	call   80104610 <acquire>
  while (lk->locked) {
80104344:	8b 13                	mov    (%ebx),%edx
80104346:	83 c4 10             	add    $0x10,%esp
80104349:	85 d2                	test   %edx,%edx
8010434b:	74 16                	je     80104363 <acquiresleep+0x33>
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	56                   	push   %esi
80104354:	53                   	push   %ebx
80104355:	e8 e6 fc ff ff       	call   80104040 <sleep>
  while (lk->locked) {
8010435a:	8b 03                	mov    (%ebx),%eax
8010435c:	83 c4 10             	add    $0x10,%esp
8010435f:	85 c0                	test   %eax,%eax
80104361:	75 ed                	jne    80104350 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104363:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104369:	e8 12 f6 ff ff       	call   80103980 <myproc>
8010436e:	8b 40 10             	mov    0x10(%eax),%eax
80104371:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104374:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104377:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010437a:	5b                   	pop    %ebx
8010437b:	5e                   	pop    %esi
8010437c:	5d                   	pop    %ebp
  release(&lk->lk);
8010437d:	e9 2e 02 00 00       	jmp    801045b0 <release>
80104382:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104389:	00 
8010438a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104390 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104398:	8d 73 04             	lea    0x4(%ebx),%esi
8010439b:	83 ec 0c             	sub    $0xc,%esp
8010439e:	56                   	push   %esi
8010439f:	e8 6c 02 00 00       	call   80104610 <acquire>
  lk->locked = 0;
801043a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043b1:	89 1c 24             	mov    %ebx,(%esp)
801043b4:	e8 47 fd ff ff       	call   80104100 <wakeup>
  release(&lk->lk);
801043b9:	83 c4 10             	add    $0x10,%esp
801043bc:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043c2:	5b                   	pop    %ebx
801043c3:	5e                   	pop    %esi
801043c4:	5d                   	pop    %ebp
  release(&lk->lk);
801043c5:	e9 e6 01 00 00       	jmp    801045b0 <release>
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	31 ff                	xor    %edi,%edi
801043d6:	56                   	push   %esi
801043d7:	53                   	push   %ebx
801043d8:	83 ec 18             	sub    $0x18,%esp
801043db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801043de:	8d 73 04             	lea    0x4(%ebx),%esi
801043e1:	56                   	push   %esi
801043e2:	e8 29 02 00 00       	call   80104610 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801043e7:	8b 03                	mov    (%ebx),%eax
801043e9:	83 c4 10             	add    $0x10,%esp
801043ec:	85 c0                	test   %eax,%eax
801043ee:	75 18                	jne    80104408 <holdingsleep+0x38>
  release(&lk->lk);
801043f0:	83 ec 0c             	sub    $0xc,%esp
801043f3:	56                   	push   %esi
801043f4:	e8 b7 01 00 00       	call   801045b0 <release>
  return r;
}
801043f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043fc:	89 f8                	mov    %edi,%eax
801043fe:	5b                   	pop    %ebx
801043ff:	5e                   	pop    %esi
80104400:	5f                   	pop    %edi
80104401:	5d                   	pop    %ebp
80104402:	c3                   	ret
80104403:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104408:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010440b:	e8 70 f5 ff ff       	call   80103980 <myproc>
80104410:	39 58 10             	cmp    %ebx,0x10(%eax)
80104413:	0f 94 c0             	sete   %al
80104416:	0f b6 c0             	movzbl %al,%eax
80104419:	89 c7                	mov    %eax,%edi
8010441b:	eb d3                	jmp    801043f0 <holdingsleep+0x20>
8010441d:	66 90                	xchg   %ax,%ax
8010441f:	90                   	nop

80104420 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104426:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104429:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010442f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104432:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104439:	5d                   	pop    %ebp
8010443a:	c3                   	ret
8010443b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104440 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	53                   	push   %ebx
80104444:	8b 45 08             	mov    0x8(%ebp),%eax
80104447:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010444a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010444d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104452:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104457:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010445c:	76 10                	jbe    8010446e <getcallerpcs+0x2e>
8010445e:	eb 28                	jmp    80104488 <getcallerpcs+0x48>
80104460:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104466:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010446c:	77 1a                	ja     80104488 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010446e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104471:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104474:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104477:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104479:	83 f8 0a             	cmp    $0xa,%eax
8010447c:	75 e2                	jne    80104460 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010447e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104481:	c9                   	leave
80104482:	c3                   	ret
80104483:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104488:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010448b:	83 c1 28             	add    $0x28,%ecx
8010448e:	89 ca                	mov    %ecx,%edx
80104490:	29 c2                	sub    %eax,%edx
80104492:	83 e2 04             	and    $0x4,%edx
80104495:	74 11                	je     801044a8 <getcallerpcs+0x68>
    pcs[i] = 0;
80104497:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010449d:	83 c0 04             	add    $0x4,%eax
801044a0:	39 c1                	cmp    %eax,%ecx
801044a2:	74 da                	je     8010447e <getcallerpcs+0x3e>
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801044a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801044ae:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801044b1:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801044b8:	39 c1                	cmp    %eax,%ecx
801044ba:	75 ec                	jne    801044a8 <getcallerpcs+0x68>
801044bc:	eb c0                	jmp    8010447e <getcallerpcs+0x3e>
801044be:	66 90                	xchg   %ax,%ax

801044c0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	83 ec 04             	sub    $0x4,%esp
801044c7:	9c                   	pushf
801044c8:	5b                   	pop    %ebx
  asm volatile("cli");
801044c9:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801044ca:	e8 31 f4 ff ff       	call   80103900 <mycpu>
801044cf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044d5:	85 c0                	test   %eax,%eax
801044d7:	74 17                	je     801044f0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801044d9:	e8 22 f4 ff ff       	call   80103900 <mycpu>
801044de:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e8:	c9                   	leave
801044e9:	c3                   	ret
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801044f0:	e8 0b f4 ff ff       	call   80103900 <mycpu>
801044f5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044fb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104501:	eb d6                	jmp    801044d9 <pushcli+0x19>
80104503:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010450a:	00 
8010450b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104510 <popcli>:

void
popcli(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104516:	9c                   	pushf
80104517:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104518:	f6 c4 02             	test   $0x2,%ah
8010451b:	75 35                	jne    80104552 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010451d:	e8 de f3 ff ff       	call   80103900 <mycpu>
80104522:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104529:	78 34                	js     8010455f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010452b:	e8 d0 f3 ff ff       	call   80103900 <mycpu>
80104530:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104536:	85 d2                	test   %edx,%edx
80104538:	74 06                	je     80104540 <popcli+0x30>
    sti();
}
8010453a:	c9                   	leave
8010453b:	c3                   	ret
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104540:	e8 bb f3 ff ff       	call   80103900 <mycpu>
80104545:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010454b:	85 c0                	test   %eax,%eax
8010454d:	74 eb                	je     8010453a <popcli+0x2a>
  asm volatile("sti");
8010454f:	fb                   	sti
}
80104550:	c9                   	leave
80104551:	c3                   	ret
    panic("popcli - interruptible");
80104552:	83 ec 0c             	sub    $0xc,%esp
80104555:	68 9f 75 10 80       	push   $0x8010759f
8010455a:	e8 21 be ff ff       	call   80100380 <panic>
    panic("popcli");
8010455f:	83 ec 0c             	sub    $0xc,%esp
80104562:	68 b6 75 10 80       	push   $0x801075b6
80104567:	e8 14 be ff ff       	call   80100380 <panic>
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104570 <holding>:
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	56                   	push   %esi
80104574:	53                   	push   %ebx
80104575:	8b 75 08             	mov    0x8(%ebp),%esi
80104578:	31 db                	xor    %ebx,%ebx
  pushcli();
8010457a:	e8 41 ff ff ff       	call   801044c0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010457f:	8b 06                	mov    (%esi),%eax
80104581:	85 c0                	test   %eax,%eax
80104583:	75 0b                	jne    80104590 <holding+0x20>
  popcli();
80104585:	e8 86 ff ff ff       	call   80104510 <popcli>
}
8010458a:	89 d8                	mov    %ebx,%eax
8010458c:	5b                   	pop    %ebx
8010458d:	5e                   	pop    %esi
8010458e:	5d                   	pop    %ebp
8010458f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104590:	8b 5e 08             	mov    0x8(%esi),%ebx
80104593:	e8 68 f3 ff ff       	call   80103900 <mycpu>
80104598:	39 c3                	cmp    %eax,%ebx
8010459a:	0f 94 c3             	sete   %bl
  popcli();
8010459d:	e8 6e ff ff ff       	call   80104510 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801045a2:	0f b6 db             	movzbl %bl,%ebx
}
801045a5:	89 d8                	mov    %ebx,%eax
801045a7:	5b                   	pop    %ebx
801045a8:	5e                   	pop    %esi
801045a9:	5d                   	pop    %ebp
801045aa:	c3                   	ret
801045ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801045b0 <release>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
801045b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801045b8:	e8 03 ff ff ff       	call   801044c0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801045bd:	8b 03                	mov    (%ebx),%eax
801045bf:	85 c0                	test   %eax,%eax
801045c1:	75 15                	jne    801045d8 <release+0x28>
  popcli();
801045c3:	e8 48 ff ff ff       	call   80104510 <popcli>
    panic("release");
801045c8:	83 ec 0c             	sub    $0xc,%esp
801045cb:	68 bd 75 10 80       	push   $0x801075bd
801045d0:	e8 ab bd ff ff       	call   80100380 <panic>
801045d5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801045d8:	8b 73 08             	mov    0x8(%ebx),%esi
801045db:	e8 20 f3 ff ff       	call   80103900 <mycpu>
801045e0:	39 c6                	cmp    %eax,%esi
801045e2:	75 df                	jne    801045c3 <release+0x13>
  popcli();
801045e4:	e8 27 ff ff ff       	call   80104510 <popcli>
  lk->pcs[0] = 0;
801045e9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045f0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801045f7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045fc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104602:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104605:	5b                   	pop    %ebx
80104606:	5e                   	pop    %esi
80104607:	5d                   	pop    %ebp
  popcli();
80104608:	e9 03 ff ff ff       	jmp    80104510 <popcli>
8010460d:	8d 76 00             	lea    0x0(%esi),%esi

80104610 <acquire>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104617:	e8 a4 fe ff ff       	call   801044c0 <pushcli>
  if(holding(lk))
8010461c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010461f:	e8 9c fe ff ff       	call   801044c0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104624:	8b 03                	mov    (%ebx),%eax
80104626:	85 c0                	test   %eax,%eax
80104628:	0f 85 b2 00 00 00    	jne    801046e0 <acquire+0xd0>
  popcli();
8010462e:	e8 dd fe ff ff       	call   80104510 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104633:	b9 01 00 00 00       	mov    $0x1,%ecx
80104638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010463f:	00 
  while(xchg(&lk->locked, 1) != 0)
80104640:	8b 55 08             	mov    0x8(%ebp),%edx
80104643:	89 c8                	mov    %ecx,%eax
80104645:	f0 87 02             	lock xchg %eax,(%edx)
80104648:	85 c0                	test   %eax,%eax
8010464a:	75 f4                	jne    80104640 <acquire+0x30>
  __sync_synchronize();
8010464c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104651:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104654:	e8 a7 f2 ff ff       	call   80103900 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104659:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010465c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010465e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104661:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104667:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010466c:	77 32                	ja     801046a0 <acquire+0x90>
  ebp = (uint*)v - 2;
8010466e:	89 e8                	mov    %ebp,%eax
80104670:	eb 14                	jmp    80104686 <acquire+0x76>
80104672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104678:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010467e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104684:	77 1a                	ja     801046a0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104686:	8b 58 04             	mov    0x4(%eax),%ebx
80104689:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010468d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104690:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104692:	83 fa 0a             	cmp    $0xa,%edx
80104695:	75 e1                	jne    80104678 <acquire+0x68>
}
80104697:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010469a:	c9                   	leave
8010469b:	c3                   	ret
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801046a4:	83 c1 34             	add    $0x34,%ecx
801046a7:	89 ca                	mov    %ecx,%edx
801046a9:	29 c2                	sub    %eax,%edx
801046ab:	83 e2 04             	and    $0x4,%edx
801046ae:	74 10                	je     801046c0 <acquire+0xb0>
    pcs[i] = 0;
801046b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046b6:	83 c0 04             	add    $0x4,%eax
801046b9:	39 c1                	cmp    %eax,%ecx
801046bb:	74 da                	je     80104697 <acquire+0x87>
801046bd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801046c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046c6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801046c9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801046d0:	39 c1                	cmp    %eax,%ecx
801046d2:	75 ec                	jne    801046c0 <acquire+0xb0>
801046d4:	eb c1                	jmp    80104697 <acquire+0x87>
801046d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046dd:	00 
801046de:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801046e0:	8b 5b 08             	mov    0x8(%ebx),%ebx
801046e3:	e8 18 f2 ff ff       	call   80103900 <mycpu>
801046e8:	39 c3                	cmp    %eax,%ebx
801046ea:	0f 85 3e ff ff ff    	jne    8010462e <acquire+0x1e>
  popcli();
801046f0:	e8 1b fe ff ff       	call   80104510 <popcli>
    panic("acquire");
801046f5:	83 ec 0c             	sub    $0xc,%esp
801046f8:	68 c5 75 10 80       	push   $0x801075c5
801046fd:	e8 7e bc ff ff       	call   80100380 <panic>
80104702:	66 90                	xchg   %ax,%ax
80104704:	66 90                	xchg   %ax,%ax
80104706:	66 90                	xchg   %ax,%ax
80104708:	66 90                	xchg   %ax,%ax
8010470a:	66 90                	xchg   %ax,%ax
8010470c:	66 90                	xchg   %ax,%ax
8010470e:	66 90                	xchg   %ax,%ax

80104710 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	57                   	push   %edi
80104714:	8b 55 08             	mov    0x8(%ebp),%edx
80104717:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010471a:	89 d0                	mov    %edx,%eax
8010471c:	09 c8                	or     %ecx,%eax
8010471e:	a8 03                	test   $0x3,%al
80104720:	75 1e                	jne    80104740 <memset+0x30>
    c &= 0xFF;
80104722:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104726:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104729:	89 d7                	mov    %edx,%edi
8010472b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104731:	fc                   	cld
80104732:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104734:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104737:	89 d0                	mov    %edx,%eax
80104739:	c9                   	leave
8010473a:	c3                   	ret
8010473b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104740:	8b 45 0c             	mov    0xc(%ebp),%eax
80104743:	89 d7                	mov    %edx,%edi
80104745:	fc                   	cld
80104746:	f3 aa                	rep stos %al,%es:(%edi)
80104748:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010474b:	89 d0                	mov    %edx,%eax
8010474d:	c9                   	leave
8010474e:	c3                   	ret
8010474f:	90                   	nop

80104750 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	8b 75 10             	mov    0x10(%ebp),%esi
80104757:	8b 45 08             	mov    0x8(%ebp),%eax
8010475a:	53                   	push   %ebx
8010475b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010475e:	85 f6                	test   %esi,%esi
80104760:	74 2e                	je     80104790 <memcmp+0x40>
80104762:	01 c6                	add    %eax,%esi
80104764:	eb 14                	jmp    8010477a <memcmp+0x2a>
80104766:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010476d:	00 
8010476e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104770:	83 c0 01             	add    $0x1,%eax
80104773:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104776:	39 f0                	cmp    %esi,%eax
80104778:	74 16                	je     80104790 <memcmp+0x40>
    if(*s1 != *s2)
8010477a:	0f b6 08             	movzbl (%eax),%ecx
8010477d:	0f b6 1a             	movzbl (%edx),%ebx
80104780:	38 d9                	cmp    %bl,%cl
80104782:	74 ec                	je     80104770 <memcmp+0x20>
      return *s1 - *s2;
80104784:	0f b6 c1             	movzbl %cl,%eax
80104787:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104789:	5b                   	pop    %ebx
8010478a:	5e                   	pop    %esi
8010478b:	5d                   	pop    %ebp
8010478c:	c3                   	ret
8010478d:	8d 76 00             	lea    0x0(%esi),%esi
80104790:	5b                   	pop    %ebx
  return 0;
80104791:	31 c0                	xor    %eax,%eax
}
80104793:	5e                   	pop    %esi
80104794:	5d                   	pop    %ebp
80104795:	c3                   	ret
80104796:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010479d:	00 
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	8b 55 08             	mov    0x8(%ebp),%edx
801047a7:	8b 45 10             	mov    0x10(%ebp),%eax
801047aa:	56                   	push   %esi
801047ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ae:	39 d6                	cmp    %edx,%esi
801047b0:	73 26                	jae    801047d8 <memmove+0x38>
801047b2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801047b5:	39 ca                	cmp    %ecx,%edx
801047b7:	73 1f                	jae    801047d8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801047b9:	85 c0                	test   %eax,%eax
801047bb:	74 0f                	je     801047cc <memmove+0x2c>
801047bd:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
801047c0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801047c4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801047c7:	83 e8 01             	sub    $0x1,%eax
801047ca:	73 f4                	jae    801047c0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047cc:	5e                   	pop    %esi
801047cd:	89 d0                	mov    %edx,%eax
801047cf:	5f                   	pop    %edi
801047d0:	5d                   	pop    %ebp
801047d1:	c3                   	ret
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801047d8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801047db:	89 d7                	mov    %edx,%edi
801047dd:	85 c0                	test   %eax,%eax
801047df:	74 eb                	je     801047cc <memmove+0x2c>
801047e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801047e8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801047e9:	39 ce                	cmp    %ecx,%esi
801047eb:	75 fb                	jne    801047e8 <memmove+0x48>
}
801047ed:	5e                   	pop    %esi
801047ee:	89 d0                	mov    %edx,%eax
801047f0:	5f                   	pop    %edi
801047f1:	5d                   	pop    %ebp
801047f2:	c3                   	ret
801047f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047fa:	00 
801047fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104800 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104800:	eb 9e                	jmp    801047a0 <memmove>
80104802:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104809:	00 
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104810 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
80104814:	8b 55 10             	mov    0x10(%ebp),%edx
80104817:	8b 45 08             	mov    0x8(%ebp),%eax
8010481a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010481d:	85 d2                	test   %edx,%edx
8010481f:	75 16                	jne    80104837 <strncmp+0x27>
80104821:	eb 2d                	jmp    80104850 <strncmp+0x40>
80104823:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104828:	3a 19                	cmp    (%ecx),%bl
8010482a:	75 12                	jne    8010483e <strncmp+0x2e>
    n--, p++, q++;
8010482c:	83 c0 01             	add    $0x1,%eax
8010482f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104832:	83 ea 01             	sub    $0x1,%edx
80104835:	74 19                	je     80104850 <strncmp+0x40>
80104837:	0f b6 18             	movzbl (%eax),%ebx
8010483a:	84 db                	test   %bl,%bl
8010483c:	75 ea                	jne    80104828 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010483e:	0f b6 00             	movzbl (%eax),%eax
80104841:	0f b6 11             	movzbl (%ecx),%edx
}
80104844:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104847:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104848:	29 d0                	sub    %edx,%eax
}
8010484a:	c3                   	ret
8010484b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104850:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	c9                   	leave
80104856:	c3                   	ret
80104857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010485e:	00 
8010485f:	90                   	nop

80104860 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	57                   	push   %edi
80104864:	56                   	push   %esi
80104865:	8b 75 08             	mov    0x8(%ebp),%esi
80104868:	53                   	push   %ebx
80104869:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010486c:	89 f0                	mov    %esi,%eax
8010486e:	eb 15                	jmp    80104885 <strncpy+0x25>
80104870:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104874:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104877:	83 c0 01             	add    $0x1,%eax
8010487a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010487e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104881:	84 c9                	test   %cl,%cl
80104883:	74 13                	je     80104898 <strncpy+0x38>
80104885:	89 d3                	mov    %edx,%ebx
80104887:	83 ea 01             	sub    $0x1,%edx
8010488a:	85 db                	test   %ebx,%ebx
8010488c:	7f e2                	jg     80104870 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010488e:	5b                   	pop    %ebx
8010488f:	89 f0                	mov    %esi,%eax
80104891:	5e                   	pop    %esi
80104892:	5f                   	pop    %edi
80104893:	5d                   	pop    %ebp
80104894:	c3                   	ret
80104895:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104898:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010489b:	83 e9 01             	sub    $0x1,%ecx
8010489e:	85 d2                	test   %edx,%edx
801048a0:	74 ec                	je     8010488e <strncpy+0x2e>
801048a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
801048a8:	83 c0 01             	add    $0x1,%eax
801048ab:	89 ca                	mov    %ecx,%edx
801048ad:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
801048b1:	29 c2                	sub    %eax,%edx
801048b3:	85 d2                	test   %edx,%edx
801048b5:	7f f1                	jg     801048a8 <strncpy+0x48>
}
801048b7:	5b                   	pop    %ebx
801048b8:	89 f0                	mov    %esi,%eax
801048ba:	5e                   	pop    %esi
801048bb:	5f                   	pop    %edi
801048bc:	5d                   	pop    %ebp
801048bd:	c3                   	ret
801048be:	66 90                	xchg   %ax,%ax

801048c0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	8b 55 10             	mov    0x10(%ebp),%edx
801048c7:	8b 75 08             	mov    0x8(%ebp),%esi
801048ca:	53                   	push   %ebx
801048cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
801048ce:	85 d2                	test   %edx,%edx
801048d0:	7e 25                	jle    801048f7 <safestrcpy+0x37>
801048d2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801048d6:	89 f2                	mov    %esi,%edx
801048d8:	eb 16                	jmp    801048f0 <safestrcpy+0x30>
801048da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048e0:	0f b6 08             	movzbl (%eax),%ecx
801048e3:	83 c0 01             	add    $0x1,%eax
801048e6:	83 c2 01             	add    $0x1,%edx
801048e9:	88 4a ff             	mov    %cl,-0x1(%edx)
801048ec:	84 c9                	test   %cl,%cl
801048ee:	74 04                	je     801048f4 <safestrcpy+0x34>
801048f0:	39 d8                	cmp    %ebx,%eax
801048f2:	75 ec                	jne    801048e0 <safestrcpy+0x20>
    ;
  *s = 0;
801048f4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801048f7:	89 f0                	mov    %esi,%eax
801048f9:	5b                   	pop    %ebx
801048fa:	5e                   	pop    %esi
801048fb:	5d                   	pop    %ebp
801048fc:	c3                   	ret
801048fd:	8d 76 00             	lea    0x0(%esi),%esi

80104900 <strlen>:

int
strlen(const char *s)
{
80104900:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104901:	31 c0                	xor    %eax,%eax
{
80104903:	89 e5                	mov    %esp,%ebp
80104905:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104908:	80 3a 00             	cmpb   $0x0,(%edx)
8010490b:	74 0c                	je     80104919 <strlen+0x19>
8010490d:	8d 76 00             	lea    0x0(%esi),%esi
80104910:	83 c0 01             	add    $0x1,%eax
80104913:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104917:	75 f7                	jne    80104910 <strlen+0x10>
    ;
  return n;
}
80104919:	5d                   	pop    %ebp
8010491a:	c3                   	ret

8010491b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010491b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010491f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104923:	55                   	push   %ebp
  pushl %ebx
80104924:	53                   	push   %ebx
  pushl %esi
80104925:	56                   	push   %esi
  pushl %edi
80104926:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104927:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104929:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010492b:	5f                   	pop    %edi
  popl %esi
8010492c:	5e                   	pop    %esi
  popl %ebx
8010492d:	5b                   	pop    %ebx
  popl %ebp
8010492e:	5d                   	pop    %ebp
  ret
8010492f:	c3                   	ret

80104930 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 04             	sub    $0x4,%esp
80104937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010493a:	e8 41 f0 ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010493f:	8b 00                	mov    (%eax),%eax
80104941:	39 c3                	cmp    %eax,%ebx
80104943:	73 1b                	jae    80104960 <fetchint+0x30>
80104945:	8d 53 04             	lea    0x4(%ebx),%edx
80104948:	39 d0                	cmp    %edx,%eax
8010494a:	72 14                	jb     80104960 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010494c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010494f:	8b 13                	mov    (%ebx),%edx
80104951:	89 10                	mov    %edx,(%eax)
  return 0;
80104953:	31 c0                	xor    %eax,%eax
}
80104955:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104958:	c9                   	leave
80104959:	c3                   	ret
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104965:	eb ee                	jmp    80104955 <fetchint+0x25>
80104967:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010496e:	00 
8010496f:	90                   	nop

80104970 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	83 ec 04             	sub    $0x4,%esp
80104977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010497a:	e8 01 f0 ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz)
8010497f:	3b 18                	cmp    (%eax),%ebx
80104981:	73 2d                	jae    801049b0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104983:	8b 55 0c             	mov    0xc(%ebp),%edx
80104986:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104988:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010498a:	39 d3                	cmp    %edx,%ebx
8010498c:	73 22                	jae    801049b0 <fetchstr+0x40>
8010498e:	89 d8                	mov    %ebx,%eax
80104990:	eb 0d                	jmp    8010499f <fetchstr+0x2f>
80104992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104998:	83 c0 01             	add    $0x1,%eax
8010499b:	39 d0                	cmp    %edx,%eax
8010499d:	73 11                	jae    801049b0 <fetchstr+0x40>
    if(*s == 0)
8010499f:	80 38 00             	cmpb   $0x0,(%eax)
801049a2:	75 f4                	jne    80104998 <fetchstr+0x28>
      return s - *pp;
801049a4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801049a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049a9:	c9                   	leave
801049aa:	c3                   	ret
801049ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801049b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801049b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049b8:	c9                   	leave
801049b9:	c3                   	ret
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049c5:	e8 b6 ef ff ff       	call   80103980 <myproc>
801049ca:	8b 55 08             	mov    0x8(%ebp),%edx
801049cd:	8b 40 18             	mov    0x18(%eax),%eax
801049d0:	8b 40 44             	mov    0x44(%eax),%eax
801049d3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801049d6:	e8 a5 ef ff ff       	call   80103980 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049db:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049de:	8b 00                	mov    (%eax),%eax
801049e0:	39 c6                	cmp    %eax,%esi
801049e2:	73 1c                	jae    80104a00 <argint+0x40>
801049e4:	8d 53 08             	lea    0x8(%ebx),%edx
801049e7:	39 d0                	cmp    %edx,%eax
801049e9:	72 15                	jb     80104a00 <argint+0x40>
  *ip = *(int*)(addr);
801049eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ee:	8b 53 04             	mov    0x4(%ebx),%edx
801049f1:	89 10                	mov    %edx,(%eax)
  return 0;
801049f3:	31 c0                	xor    %eax,%eax
}
801049f5:	5b                   	pop    %ebx
801049f6:	5e                   	pop    %esi
801049f7:	5d                   	pop    %ebp
801049f8:	c3                   	ret
801049f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a05:	eb ee                	jmp    801049f5 <argint+0x35>
80104a07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a0e:	00 
80104a0f:	90                   	nop

80104a10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	56                   	push   %esi
80104a15:	53                   	push   %ebx
80104a16:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104a19:	e8 62 ef ff ff       	call   80103980 <myproc>
80104a1e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a20:	e8 5b ef ff ff       	call   80103980 <myproc>
80104a25:	8b 55 08             	mov    0x8(%ebp),%edx
80104a28:	8b 40 18             	mov    0x18(%eax),%eax
80104a2b:	8b 40 44             	mov    0x44(%eax),%eax
80104a2e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a31:	e8 4a ef ff ff       	call   80103980 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a36:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a39:	8b 00                	mov    (%eax),%eax
80104a3b:	39 c7                	cmp    %eax,%edi
80104a3d:	73 31                	jae    80104a70 <argptr+0x60>
80104a3f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104a42:	39 c8                	cmp    %ecx,%eax
80104a44:	72 2a                	jb     80104a70 <argptr+0x60>
 
	  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a46:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104a49:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a4c:	85 d2                	test   %edx,%edx
80104a4e:	78 20                	js     80104a70 <argptr+0x60>
80104a50:	8b 16                	mov    (%esi),%edx
80104a52:	39 d0                	cmp    %edx,%eax
80104a54:	73 1a                	jae    80104a70 <argptr+0x60>
80104a56:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a59:	01 c3                	add    %eax,%ebx
80104a5b:	39 da                	cmp    %ebx,%edx
80104a5d:	72 11                	jb     80104a70 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104a5f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a62:	89 02                	mov    %eax,(%edx)
  return 0;
80104a64:	31 c0                	xor    %eax,%eax
}
80104a66:	83 c4 0c             	add    $0xc,%esp
80104a69:	5b                   	pop    %ebx
80104a6a:	5e                   	pop    %esi
80104a6b:	5f                   	pop    %edi
80104a6c:	5d                   	pop    %ebp
80104a6d:	c3                   	ret
80104a6e:	66 90                	xchg   %ax,%ax
    return -1;
80104a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a75:	eb ef                	jmp    80104a66 <argptr+0x56>
80104a77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a7e:	00 
80104a7f:	90                   	nop

80104a80 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	56                   	push   %esi
80104a84:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a85:	e8 f6 ee ff ff       	call   80103980 <myproc>
80104a8a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a8d:	8b 40 18             	mov    0x18(%eax),%eax
80104a90:	8b 40 44             	mov    0x44(%eax),%eax
80104a93:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a96:	e8 e5 ee ff ff       	call   80103980 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a9b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a9e:	8b 00                	mov    (%eax),%eax
80104aa0:	39 c6                	cmp    %eax,%esi
80104aa2:	73 44                	jae    80104ae8 <argstr+0x68>
80104aa4:	8d 53 08             	lea    0x8(%ebx),%edx
80104aa7:	39 d0                	cmp    %edx,%eax
80104aa9:	72 3d                	jb     80104ae8 <argstr+0x68>
  *ip = *(int*)(addr);
80104aab:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104aae:	e8 cd ee ff ff       	call   80103980 <myproc>
  if(addr >= curproc->sz)
80104ab3:	3b 18                	cmp    (%eax),%ebx
80104ab5:	73 31                	jae    80104ae8 <argstr+0x68>
  *pp = (char*)addr;
80104ab7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104aba:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104abc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104abe:	39 d3                	cmp    %edx,%ebx
80104ac0:	73 26                	jae    80104ae8 <argstr+0x68>
80104ac2:	89 d8                	mov    %ebx,%eax
80104ac4:	eb 11                	jmp    80104ad7 <argstr+0x57>
80104ac6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104acd:	00 
80104ace:	66 90                	xchg   %ax,%ax
80104ad0:	83 c0 01             	add    $0x1,%eax
80104ad3:	39 d0                	cmp    %edx,%eax
80104ad5:	73 11                	jae    80104ae8 <argstr+0x68>
    if(*s == 0)
80104ad7:	80 38 00             	cmpb   $0x0,(%eax)
80104ada:	75 f4                	jne    80104ad0 <argstr+0x50>
      return s - *pp;
80104adc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104ade:	5b                   	pop    %ebx
80104adf:	5e                   	pop    %esi
80104ae0:	5d                   	pop    %ebp
80104ae1:	c3                   	ret
80104ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ae8:	5b                   	pop    %ebx
    return -1;
80104ae9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104aee:	5e                   	pop    %esi
80104aef:	5d                   	pop    %ebp
80104af0:	c3                   	ret
80104af1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104af8:	00 
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b00 <syscall>:
[SYS_reboot]   sys_reboot,
};

void
syscall(void)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104b07:	e8 74 ee ff ff       	call   80103980 <myproc>
80104b0c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b0e:	8b 40 18             	mov    0x18(%eax),%eax
80104b11:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b14:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b17:	83 fa 16             	cmp    $0x16,%edx
80104b1a:	77 24                	ja     80104b40 <syscall+0x40>
80104b1c:	8b 14 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%edx
80104b23:	85 d2                	test   %edx,%edx
80104b25:	74 19                	je     80104b40 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104b27:	ff d2                	call   *%edx
80104b29:	89 c2                	mov    %eax,%edx
80104b2b:	8b 43 18             	mov    0x18(%ebx),%eax
80104b2e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b34:	c9                   	leave
80104b35:	c3                   	ret
80104b36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b3d:	00 
80104b3e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104b40:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b41:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b44:	50                   	push   %eax
80104b45:	ff 73 10             	push   0x10(%ebx)
80104b48:	68 cd 75 10 80       	push   $0x801075cd
80104b4d:	e8 5e bb ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104b52:	8b 43 18             	mov    0x18(%ebx),%eax
80104b55:	83 c4 10             	add    $0x10,%esp
80104b58:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b62:	c9                   	leave
80104b63:	c3                   	ret
80104b64:	66 90                	xchg   %ax,%ax
80104b66:	66 90                	xchg   %ax,%ax
80104b68:	66 90                	xchg   %ax,%ax
80104b6a:	66 90                	xchg   %ax,%ax
80104b6c:	66 90                	xchg   %ax,%ax
80104b6e:	66 90                	xchg   %ax,%ax

80104b70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b75:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104b78:	53                   	push   %ebx
80104b79:	83 ec 34             	sub    $0x34,%esp
80104b7c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104b7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b82:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104b85:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b88:	57                   	push   %edi
80104b89:	50                   	push   %eax
80104b8a:	e8 01 d5 ff ff       	call   80102090 <nameiparent>
80104b8f:	83 c4 10             	add    $0x10,%esp
80104b92:	85 c0                	test   %eax,%eax
80104b94:	74 5e                	je     80104bf4 <create+0x84>
    return 0;
  ilock(dp);
80104b96:	83 ec 0c             	sub    $0xc,%esp
80104b99:	89 c3                	mov    %eax,%ebx
80104b9b:	50                   	push   %eax
80104b9c:	e8 ef cb ff ff       	call   80101790 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104ba1:	83 c4 0c             	add    $0xc,%esp
80104ba4:	6a 00                	push   $0x0
80104ba6:	57                   	push   %edi
80104ba7:	53                   	push   %ebx
80104ba8:	e8 33 d1 ff ff       	call   80101ce0 <dirlookup>
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	89 c6                	mov    %eax,%esi
80104bb2:	85 c0                	test   %eax,%eax
80104bb4:	74 4a                	je     80104c00 <create+0x90>
    iunlockput(dp);
80104bb6:	83 ec 0c             	sub    $0xc,%esp
80104bb9:	53                   	push   %ebx
80104bba:	e8 61 ce ff ff       	call   80101a20 <iunlockput>
    ilock(ip);
80104bbf:	89 34 24             	mov    %esi,(%esp)
80104bc2:	e8 c9 cb ff ff       	call   80101790 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104bcf:	75 17                	jne    80104be8 <create+0x78>
80104bd1:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104bd6:	75 10                	jne    80104be8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bdb:	89 f0                	mov    %esi,%eax
80104bdd:	5b                   	pop    %ebx
80104bde:	5e                   	pop    %esi
80104bdf:	5f                   	pop    %edi
80104be0:	5d                   	pop    %ebp
80104be1:	c3                   	ret
80104be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104be8:	83 ec 0c             	sub    $0xc,%esp
80104beb:	56                   	push   %esi
80104bec:	e8 2f ce ff ff       	call   80101a20 <iunlockput>
    return 0;
80104bf1:	83 c4 10             	add    $0x10,%esp
}
80104bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104bf7:	31 f6                	xor    %esi,%esi
}
80104bf9:	5b                   	pop    %ebx
80104bfa:	89 f0                	mov    %esi,%eax
80104bfc:	5e                   	pop    %esi
80104bfd:	5f                   	pop    %edi
80104bfe:	5d                   	pop    %ebp
80104bff:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104c00:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104c04:	83 ec 08             	sub    $0x8,%esp
80104c07:	50                   	push   %eax
80104c08:	ff 33                	push   (%ebx)
80104c0a:	e8 11 ca ff ff       	call   80101620 <ialloc>
80104c0f:	83 c4 10             	add    $0x10,%esp
80104c12:	89 c6                	mov    %eax,%esi
80104c14:	85 c0                	test   %eax,%eax
80104c16:	0f 84 bc 00 00 00    	je     80104cd8 <create+0x168>
  ilock(ip);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	50                   	push   %eax
80104c20:	e8 6b cb ff ff       	call   80101790 <ilock>
  ip->major = major;
80104c25:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104c29:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104c2d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104c31:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104c35:	b8 01 00 00 00       	mov    $0x1,%eax
80104c3a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104c3e:	89 34 24             	mov    %esi,(%esp)
80104c41:	e8 9a ca ff ff       	call   801016e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c46:	83 c4 10             	add    $0x10,%esp
80104c49:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104c4e:	74 30                	je     80104c80 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104c50:	83 ec 04             	sub    $0x4,%esp
80104c53:	ff 76 04             	push   0x4(%esi)
80104c56:	57                   	push   %edi
80104c57:	53                   	push   %ebx
80104c58:	e8 53 d3 ff ff       	call   80101fb0 <dirlink>
80104c5d:	83 c4 10             	add    $0x10,%esp
80104c60:	85 c0                	test   %eax,%eax
80104c62:	78 67                	js     80104ccb <create+0x15b>
  iunlockput(dp);
80104c64:	83 ec 0c             	sub    $0xc,%esp
80104c67:	53                   	push   %ebx
80104c68:	e8 b3 cd ff ff       	call   80101a20 <iunlockput>
  return ip;
80104c6d:	83 c4 10             	add    $0x10,%esp
}
80104c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c73:	89 f0                	mov    %esi,%eax
80104c75:	5b                   	pop    %ebx
80104c76:	5e                   	pop    %esi
80104c77:	5f                   	pop    %edi
80104c78:	5d                   	pop    %ebp
80104c79:	c3                   	ret
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104c80:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104c83:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104c88:	53                   	push   %ebx
80104c89:	e8 52 ca ff ff       	call   801016e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c8e:	83 c4 0c             	add    $0xc,%esp
80104c91:	ff 76 04             	push   0x4(%esi)
80104c94:	68 05 76 10 80       	push   $0x80107605
80104c99:	56                   	push   %esi
80104c9a:	e8 11 d3 ff ff       	call   80101fb0 <dirlink>
80104c9f:	83 c4 10             	add    $0x10,%esp
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	78 18                	js     80104cbe <create+0x14e>
80104ca6:	83 ec 04             	sub    $0x4,%esp
80104ca9:	ff 73 04             	push   0x4(%ebx)
80104cac:	68 04 76 10 80       	push   $0x80107604
80104cb1:	56                   	push   %esi
80104cb2:	e8 f9 d2 ff ff       	call   80101fb0 <dirlink>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	79 92                	jns    80104c50 <create+0xe0>
      panic("create dots");
80104cbe:	83 ec 0c             	sub    $0xc,%esp
80104cc1:	68 f8 75 10 80       	push   $0x801075f8
80104cc6:	e8 b5 b6 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104ccb:	83 ec 0c             	sub    $0xc,%esp
80104cce:	68 07 76 10 80       	push   $0x80107607
80104cd3:	e8 a8 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	68 e9 75 10 80       	push   $0x801075e9
80104ce0:	e8 9b b6 ff ff       	call   80100380 <panic>
80104ce5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cec:	00 
80104ced:	8d 76 00             	lea    0x0(%esi),%esi

80104cf0 <sys_dup>:
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104cf5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104cf8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104cfb:	50                   	push   %eax
80104cfc:	6a 00                	push   $0x0
80104cfe:	e8 bd fc ff ff       	call   801049c0 <argint>
80104d03:	83 c4 10             	add    $0x10,%esp
80104d06:	85 c0                	test   %eax,%eax
80104d08:	78 36                	js     80104d40 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d0e:	77 30                	ja     80104d40 <sys_dup+0x50>
80104d10:	e8 6b ec ff ff       	call   80103980 <myproc>
80104d15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d18:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d1c:	85 f6                	test   %esi,%esi
80104d1e:	74 20                	je     80104d40 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104d20:	e8 5b ec ff ff       	call   80103980 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104d25:	31 db                	xor    %ebx,%ebx
80104d27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d2e:	00 
80104d2f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104d30:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d34:	85 d2                	test   %edx,%edx
80104d36:	74 18                	je     80104d50 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104d38:	83 c3 01             	add    $0x1,%ebx
80104d3b:	83 fb 10             	cmp    $0x10,%ebx
80104d3e:	75 f0                	jne    80104d30 <sys_dup+0x40>
}
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d43:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d48:	89 d8                	mov    %ebx,%eax
80104d4a:	5b                   	pop    %ebx
80104d4b:	5e                   	pop    %esi
80104d4c:	5d                   	pop    %ebp
80104d4d:	c3                   	ret
80104d4e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104d50:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104d53:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d57:	56                   	push   %esi
80104d58:	e8 63 c1 ff ff       	call   80100ec0 <filedup>
  return fd;
80104d5d:	83 c4 10             	add    $0x10,%esp
}
80104d60:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d63:	89 d8                	mov    %ebx,%eax
80104d65:	5b                   	pop    %ebx
80104d66:	5e                   	pop    %esi
80104d67:	5d                   	pop    %ebp
80104d68:	c3                   	ret
80104d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d70 <sys_read>:
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104d75:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104d78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d7b:	53                   	push   %ebx
80104d7c:	6a 00                	push   $0x0
80104d7e:	e8 3d fc ff ff       	call   801049c0 <argint>
80104d83:	83 c4 10             	add    $0x10,%esp
80104d86:	85 c0                	test   %eax,%eax
80104d88:	78 5e                	js     80104de8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d8e:	77 58                	ja     80104de8 <sys_read+0x78>
80104d90:	e8 eb eb ff ff       	call   80103980 <myproc>
80104d95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d9c:	85 f6                	test   %esi,%esi
80104d9e:	74 48                	je     80104de8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104da0:	83 ec 08             	sub    $0x8,%esp
80104da3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da6:	50                   	push   %eax
80104da7:	6a 02                	push   $0x2
80104da9:	e8 12 fc ff ff       	call   801049c0 <argint>
80104dae:	83 c4 10             	add    $0x10,%esp
80104db1:	85 c0                	test   %eax,%eax
80104db3:	78 33                	js     80104de8 <sys_read+0x78>
80104db5:	83 ec 04             	sub    $0x4,%esp
80104db8:	ff 75 f0             	push   -0x10(%ebp)
80104dbb:	53                   	push   %ebx
80104dbc:	6a 01                	push   $0x1
80104dbe:	e8 4d fc ff ff       	call   80104a10 <argptr>
80104dc3:	83 c4 10             	add    $0x10,%esp
80104dc6:	85 c0                	test   %eax,%eax
80104dc8:	78 1e                	js     80104de8 <sys_read+0x78>
  return fileread(f, p, n);
80104dca:	83 ec 04             	sub    $0x4,%esp
80104dcd:	ff 75 f0             	push   -0x10(%ebp)
80104dd0:	ff 75 f4             	push   -0xc(%ebp)
80104dd3:	56                   	push   %esi
80104dd4:	e8 67 c2 ff ff       	call   80101040 <fileread>
80104dd9:	83 c4 10             	add    $0x10,%esp
}
80104ddc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ddf:	5b                   	pop    %ebx
80104de0:	5e                   	pop    %esi
80104de1:	5d                   	pop    %ebp
80104de2:	c3                   	ret
80104de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104de8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ded:	eb ed                	jmp    80104ddc <sys_read+0x6c>
80104def:	90                   	nop

80104df0 <sys_write>:
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104df5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104df8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104dfb:	53                   	push   %ebx
80104dfc:	6a 00                	push   $0x0
80104dfe:	e8 bd fb ff ff       	call   801049c0 <argint>
80104e03:	83 c4 10             	add    $0x10,%esp
80104e06:	85 c0                	test   %eax,%eax
80104e08:	78 5e                	js     80104e68 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e0e:	77 58                	ja     80104e68 <sys_write+0x78>
80104e10:	e8 6b eb ff ff       	call   80103980 <myproc>
80104e15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e18:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e1c:	85 f6                	test   %esi,%esi
80104e1e:	74 48                	je     80104e68 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e20:	83 ec 08             	sub    $0x8,%esp
80104e23:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e26:	50                   	push   %eax
80104e27:	6a 02                	push   $0x2
80104e29:	e8 92 fb ff ff       	call   801049c0 <argint>
80104e2e:	83 c4 10             	add    $0x10,%esp
80104e31:	85 c0                	test   %eax,%eax
80104e33:	78 33                	js     80104e68 <sys_write+0x78>
80104e35:	83 ec 04             	sub    $0x4,%esp
80104e38:	ff 75 f0             	push   -0x10(%ebp)
80104e3b:	53                   	push   %ebx
80104e3c:	6a 01                	push   $0x1
80104e3e:	e8 cd fb ff ff       	call   80104a10 <argptr>
80104e43:	83 c4 10             	add    $0x10,%esp
80104e46:	85 c0                	test   %eax,%eax
80104e48:	78 1e                	js     80104e68 <sys_write+0x78>
  return filewrite(f, p, n);
80104e4a:	83 ec 04             	sub    $0x4,%esp
80104e4d:	ff 75 f0             	push   -0x10(%ebp)
80104e50:	ff 75 f4             	push   -0xc(%ebp)
80104e53:	56                   	push   %esi
80104e54:	e8 77 c2 ff ff       	call   801010d0 <filewrite>
80104e59:	83 c4 10             	add    $0x10,%esp
}
80104e5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e5f:	5b                   	pop    %ebx
80104e60:	5e                   	pop    %esi
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret
80104e63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104e68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e6d:	eb ed                	jmp    80104e5c <sys_write+0x6c>
80104e6f:	90                   	nop

80104e70 <sys_close>:
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e75:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104e78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e7b:	50                   	push   %eax
80104e7c:	6a 00                	push   $0x0
80104e7e:	e8 3d fb ff ff       	call   801049c0 <argint>
80104e83:	83 c4 10             	add    $0x10,%esp
80104e86:	85 c0                	test   %eax,%eax
80104e88:	78 3e                	js     80104ec8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e8e:	77 38                	ja     80104ec8 <sys_close+0x58>
80104e90:	e8 eb ea ff ff       	call   80103980 <myproc>
80104e95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e98:	8d 5a 08             	lea    0x8(%edx),%ebx
80104e9b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104e9f:	85 f6                	test   %esi,%esi
80104ea1:	74 25                	je     80104ec8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104ea3:	e8 d8 ea ff ff       	call   80103980 <myproc>
  fileclose(f);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104eab:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104eb2:	00 
  fileclose(f);
80104eb3:	56                   	push   %esi
80104eb4:	e8 57 c0 ff ff       	call   80100f10 <fileclose>
  return 0;
80104eb9:	83 c4 10             	add    $0x10,%esp
80104ebc:	31 c0                	xor    %eax,%eax
}
80104ebe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ec1:	5b                   	pop    %ebx
80104ec2:	5e                   	pop    %esi
80104ec3:	5d                   	pop    %ebp
80104ec4:	c3                   	ret
80104ec5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ecd:	eb ef                	jmp    80104ebe <sys_close+0x4e>
80104ecf:	90                   	nop

80104ed0 <sys_fstat>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ed5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104ed8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104edb:	53                   	push   %ebx
80104edc:	6a 00                	push   $0x0
80104ede:	e8 dd fa ff ff       	call   801049c0 <argint>
80104ee3:	83 c4 10             	add    $0x10,%esp
80104ee6:	85 c0                	test   %eax,%eax
80104ee8:	78 46                	js     80104f30 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eee:	77 40                	ja     80104f30 <sys_fstat+0x60>
80104ef0:	e8 8b ea ff ff       	call   80103980 <myproc>
80104ef5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ef8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104efc:	85 f6                	test   %esi,%esi
80104efe:	74 30                	je     80104f30 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f00:	83 ec 04             	sub    $0x4,%esp
80104f03:	6a 14                	push   $0x14
80104f05:	53                   	push   %ebx
80104f06:	6a 01                	push   $0x1
80104f08:	e8 03 fb ff ff       	call   80104a10 <argptr>
80104f0d:	83 c4 10             	add    $0x10,%esp
80104f10:	85 c0                	test   %eax,%eax
80104f12:	78 1c                	js     80104f30 <sys_fstat+0x60>
  return filestat(f, st);
80104f14:	83 ec 08             	sub    $0x8,%esp
80104f17:	ff 75 f4             	push   -0xc(%ebp)
80104f1a:	56                   	push   %esi
80104f1b:	e8 d0 c0 ff ff       	call   80100ff0 <filestat>
80104f20:	83 c4 10             	add    $0x10,%esp
}
80104f23:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f26:	5b                   	pop    %ebx
80104f27:	5e                   	pop    %esi
80104f28:	5d                   	pop    %ebp
80104f29:	c3                   	ret
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f35:	eb ec                	jmp    80104f23 <sys_fstat+0x53>
80104f37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f3e:	00 
80104f3f:	90                   	nop

80104f40 <sys_link>:
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f45:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f48:	53                   	push   %ebx
80104f49:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 2c fb ff ff       	call   80104a80 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 fb 00 00 00    	js     8010505a <sys_link+0x11a>
80104f5f:	83 ec 08             	sub    $0x8,%esp
80104f62:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f65:	50                   	push   %eax
80104f66:	6a 01                	push   $0x1
80104f68:	e8 13 fb ff ff       	call   80104a80 <argstr>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	0f 88 e2 00 00 00    	js     8010505a <sys_link+0x11a>
  begin_op();
80104f78:	e8 b3 dd ff ff       	call   80102d30 <begin_op>
  if((ip = namei(old)) == 0){
80104f7d:	83 ec 0c             	sub    $0xc,%esp
80104f80:	ff 75 d4             	push   -0x2c(%ebp)
80104f83:	e8 e8 d0 ff ff       	call   80102070 <namei>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	89 c3                	mov    %eax,%ebx
80104f8d:	85 c0                	test   %eax,%eax
80104f8f:	0f 84 df 00 00 00    	je     80105074 <sys_link+0x134>
  ilock(ip);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	50                   	push   %eax
80104f99:	e8 f2 c7 ff ff       	call   80101790 <ilock>
  if(ip->type == T_DIR){
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa6:	0f 84 b5 00 00 00    	je     80105061 <sys_link+0x121>
  iupdate(ip);
80104fac:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104faf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104fb4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104fb7:	53                   	push   %ebx
80104fb8:	e8 23 c7 ff ff       	call   801016e0 <iupdate>
  iunlock(ip);
80104fbd:	89 1c 24             	mov    %ebx,(%esp)
80104fc0:	e8 ab c8 ff ff       	call   80101870 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104fc5:	58                   	pop    %eax
80104fc6:	5a                   	pop    %edx
80104fc7:	57                   	push   %edi
80104fc8:	ff 75 d0             	push   -0x30(%ebp)
80104fcb:	e8 c0 d0 ff ff       	call   80102090 <nameiparent>
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	89 c6                	mov    %eax,%esi
80104fd5:	85 c0                	test   %eax,%eax
80104fd7:	74 5b                	je     80105034 <sys_link+0xf4>
  ilock(dp);
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 ae c7 ff ff       	call   80101790 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fe2:	8b 03                	mov    (%ebx),%eax
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	39 06                	cmp    %eax,(%esi)
80104fe9:	75 3d                	jne    80105028 <sys_link+0xe8>
80104feb:	83 ec 04             	sub    $0x4,%esp
80104fee:	ff 73 04             	push   0x4(%ebx)
80104ff1:	57                   	push   %edi
80104ff2:	56                   	push   %esi
80104ff3:	e8 b8 cf ff ff       	call   80101fb0 <dirlink>
80104ff8:	83 c4 10             	add    $0x10,%esp
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	78 29                	js     80105028 <sys_link+0xe8>
  iunlockput(dp);
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	56                   	push   %esi
80105003:	e8 18 ca ff ff       	call   80101a20 <iunlockput>
  iput(ip);
80105008:	89 1c 24             	mov    %ebx,(%esp)
8010500b:	e8 b0 c8 ff ff       	call   801018c0 <iput>
  end_op();
80105010:	e8 8b dd ff ff       	call   80102da0 <end_op>
  return 0;
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	31 c0                	xor    %eax,%eax
}
8010501a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5f                   	pop    %edi
80105020:	5d                   	pop    %ebp
80105021:	c3                   	ret
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105028:	83 ec 0c             	sub    $0xc,%esp
8010502b:	56                   	push   %esi
8010502c:	e8 ef c9 ff ff       	call   80101a20 <iunlockput>
    goto bad;
80105031:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105034:	83 ec 0c             	sub    $0xc,%esp
80105037:	53                   	push   %ebx
80105038:	e8 53 c7 ff ff       	call   80101790 <ilock>
  ip->nlink--;
8010503d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105042:	89 1c 24             	mov    %ebx,(%esp)
80105045:	e8 96 c6 ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
8010504a:	89 1c 24             	mov    %ebx,(%esp)
8010504d:	e8 ce c9 ff ff       	call   80101a20 <iunlockput>
  end_op();
80105052:	e8 49 dd ff ff       	call   80102da0 <end_op>
  return -1;
80105057:	83 c4 10             	add    $0x10,%esp
    return -1;
8010505a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010505f:	eb b9                	jmp    8010501a <sys_link+0xda>
    iunlockput(ip);
80105061:	83 ec 0c             	sub    $0xc,%esp
80105064:	53                   	push   %ebx
80105065:	e8 b6 c9 ff ff       	call   80101a20 <iunlockput>
    end_op();
8010506a:	e8 31 dd ff ff       	call   80102da0 <end_op>
    return -1;
8010506f:	83 c4 10             	add    $0x10,%esp
80105072:	eb e6                	jmp    8010505a <sys_link+0x11a>
    end_op();
80105074:	e8 27 dd ff ff       	call   80102da0 <end_op>
    return -1;
80105079:	eb df                	jmp    8010505a <sys_link+0x11a>
8010507b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105080 <sys_unlink>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	57                   	push   %edi
80105084:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105085:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105088:	53                   	push   %ebx
80105089:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010508c:	50                   	push   %eax
8010508d:	6a 00                	push   $0x0
8010508f:	e8 ec f9 ff ff       	call   80104a80 <argstr>
80105094:	83 c4 10             	add    $0x10,%esp
80105097:	85 c0                	test   %eax,%eax
80105099:	0f 88 54 01 00 00    	js     801051f3 <sys_unlink+0x173>
  begin_op();
8010509f:	e8 8c dc ff ff       	call   80102d30 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801050a4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801050a7:	83 ec 08             	sub    $0x8,%esp
801050aa:	53                   	push   %ebx
801050ab:	ff 75 c0             	push   -0x40(%ebp)
801050ae:	e8 dd cf ff ff       	call   80102090 <nameiparent>
801050b3:	83 c4 10             	add    $0x10,%esp
801050b6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050b9:	85 c0                	test   %eax,%eax
801050bb:	0f 84 58 01 00 00    	je     80105219 <sys_unlink+0x199>
  ilock(dp);
801050c1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801050c4:	83 ec 0c             	sub    $0xc,%esp
801050c7:	57                   	push   %edi
801050c8:	e8 c3 c6 ff ff       	call   80101790 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050cd:	58                   	pop    %eax
801050ce:	5a                   	pop    %edx
801050cf:	68 05 76 10 80       	push   $0x80107605
801050d4:	53                   	push   %ebx
801050d5:	e8 e6 cb ff ff       	call   80101cc0 <namecmp>
801050da:	83 c4 10             	add    $0x10,%esp
801050dd:	85 c0                	test   %eax,%eax
801050df:	0f 84 fb 00 00 00    	je     801051e0 <sys_unlink+0x160>
801050e5:	83 ec 08             	sub    $0x8,%esp
801050e8:	68 04 76 10 80       	push   $0x80107604
801050ed:	53                   	push   %ebx
801050ee:	e8 cd cb ff ff       	call   80101cc0 <namecmp>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	0f 84 e2 00 00 00    	je     801051e0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050fe:	83 ec 04             	sub    $0x4,%esp
80105101:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105104:	50                   	push   %eax
80105105:	53                   	push   %ebx
80105106:	57                   	push   %edi
80105107:	e8 d4 cb ff ff       	call   80101ce0 <dirlookup>
8010510c:	83 c4 10             	add    $0x10,%esp
8010510f:	89 c3                	mov    %eax,%ebx
80105111:	85 c0                	test   %eax,%eax
80105113:	0f 84 c7 00 00 00    	je     801051e0 <sys_unlink+0x160>
  ilock(ip);
80105119:	83 ec 0c             	sub    $0xc,%esp
8010511c:	50                   	push   %eax
8010511d:	e8 6e c6 ff ff       	call   80101790 <ilock>
  if(ip->nlink < 1)
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010512a:	0f 8e 0a 01 00 00    	jle    8010523a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105130:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105135:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105138:	74 66                	je     801051a0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010513a:	83 ec 04             	sub    $0x4,%esp
8010513d:	6a 10                	push   $0x10
8010513f:	6a 00                	push   $0x0
80105141:	57                   	push   %edi
80105142:	e8 c9 f5 ff ff       	call   80104710 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105147:	6a 10                	push   $0x10
80105149:	ff 75 c4             	push   -0x3c(%ebp)
8010514c:	57                   	push   %edi
8010514d:	ff 75 b4             	push   -0x4c(%ebp)
80105150:	e8 4b ca ff ff       	call   80101ba0 <writei>
80105155:	83 c4 20             	add    $0x20,%esp
80105158:	83 f8 10             	cmp    $0x10,%eax
8010515b:	0f 85 cc 00 00 00    	jne    8010522d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105161:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105166:	0f 84 94 00 00 00    	je     80105200 <sys_unlink+0x180>
  iunlockput(dp);
8010516c:	83 ec 0c             	sub    $0xc,%esp
8010516f:	ff 75 b4             	push   -0x4c(%ebp)
80105172:	e8 a9 c8 ff ff       	call   80101a20 <iunlockput>
  ip->nlink--;
80105177:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010517c:	89 1c 24             	mov    %ebx,(%esp)
8010517f:	e8 5c c5 ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
80105184:	89 1c 24             	mov    %ebx,(%esp)
80105187:	e8 94 c8 ff ff       	call   80101a20 <iunlockput>
  end_op();
8010518c:	e8 0f dc ff ff       	call   80102da0 <end_op>
  return 0;
80105191:	83 c4 10             	add    $0x10,%esp
80105194:	31 c0                	xor    %eax,%eax
}
80105196:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105199:	5b                   	pop    %ebx
8010519a:	5e                   	pop    %esi
8010519b:	5f                   	pop    %edi
8010519c:	5d                   	pop    %ebp
8010519d:	c3                   	ret
8010519e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051a4:	76 94                	jbe    8010513a <sys_unlink+0xba>
801051a6:	be 20 00 00 00       	mov    $0x20,%esi
801051ab:	eb 0b                	jmp    801051b8 <sys_unlink+0x138>
801051ad:	8d 76 00             	lea    0x0(%esi),%esi
801051b0:	83 c6 10             	add    $0x10,%esi
801051b3:	3b 73 58             	cmp    0x58(%ebx),%esi
801051b6:	73 82                	jae    8010513a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051b8:	6a 10                	push   $0x10
801051ba:	56                   	push   %esi
801051bb:	57                   	push   %edi
801051bc:	53                   	push   %ebx
801051bd:	e8 de c8 ff ff       	call   80101aa0 <readi>
801051c2:	83 c4 10             	add    $0x10,%esp
801051c5:	83 f8 10             	cmp    $0x10,%eax
801051c8:	75 56                	jne    80105220 <sys_unlink+0x1a0>
    if(de.inum != 0)
801051ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051cf:	74 df                	je     801051b0 <sys_unlink+0x130>
    iunlockput(ip);
801051d1:	83 ec 0c             	sub    $0xc,%esp
801051d4:	53                   	push   %ebx
801051d5:	e8 46 c8 ff ff       	call   80101a20 <iunlockput>
    goto bad;
801051da:	83 c4 10             	add    $0x10,%esp
801051dd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801051e0:	83 ec 0c             	sub    $0xc,%esp
801051e3:	ff 75 b4             	push   -0x4c(%ebp)
801051e6:	e8 35 c8 ff ff       	call   80101a20 <iunlockput>
  end_op();
801051eb:	e8 b0 db ff ff       	call   80102da0 <end_op>
  return -1;
801051f0:	83 c4 10             	add    $0x10,%esp
    return -1;
801051f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051f8:	eb 9c                	jmp    80105196 <sys_unlink+0x116>
801051fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105200:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105203:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105206:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010520b:	50                   	push   %eax
8010520c:	e8 cf c4 ff ff       	call   801016e0 <iupdate>
80105211:	83 c4 10             	add    $0x10,%esp
80105214:	e9 53 ff ff ff       	jmp    8010516c <sys_unlink+0xec>
    end_op();
80105219:	e8 82 db ff ff       	call   80102da0 <end_op>
    return -1;
8010521e:	eb d3                	jmp    801051f3 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105220:	83 ec 0c             	sub    $0xc,%esp
80105223:	68 29 76 10 80       	push   $0x80107629
80105228:	e8 53 b1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010522d:	83 ec 0c             	sub    $0xc,%esp
80105230:	68 3b 76 10 80       	push   $0x8010763b
80105235:	e8 46 b1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010523a:	83 ec 0c             	sub    $0xc,%esp
8010523d:	68 17 76 10 80       	push   $0x80107617
80105242:	e8 39 b1 ff ff       	call   80100380 <panic>
80105247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010524e:	00 
8010524f:	90                   	nop

80105250 <sys_open>:

int
sys_open(void)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	57                   	push   %edi
80105254:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105255:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105258:	53                   	push   %ebx
80105259:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010525c:	50                   	push   %eax
8010525d:	6a 00                	push   $0x0
8010525f:	e8 1c f8 ff ff       	call   80104a80 <argstr>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	0f 88 8e 00 00 00    	js     801052fd <sys_open+0xad>
8010526f:	83 ec 08             	sub    $0x8,%esp
80105272:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105275:	50                   	push   %eax
80105276:	6a 01                	push   $0x1
80105278:	e8 43 f7 ff ff       	call   801049c0 <argint>
8010527d:	83 c4 10             	add    $0x10,%esp
80105280:	85 c0                	test   %eax,%eax
80105282:	78 79                	js     801052fd <sys_open+0xad>
    return -1;

  begin_op();
80105284:	e8 a7 da ff ff       	call   80102d30 <begin_op>

  if(omode & O_CREATE){
80105289:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010528d:	75 79                	jne    80105308 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010528f:	83 ec 0c             	sub    $0xc,%esp
80105292:	ff 75 e0             	push   -0x20(%ebp)
80105295:	e8 d6 cd ff ff       	call   80102070 <namei>
8010529a:	83 c4 10             	add    $0x10,%esp
8010529d:	89 c6                	mov    %eax,%esi
8010529f:	85 c0                	test   %eax,%eax
801052a1:	0f 84 7e 00 00 00    	je     80105325 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	50                   	push   %eax
801052ab:	e8 e0 c4 ff ff       	call   80101790 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052b0:	83 c4 10             	add    $0x10,%esp
801052b3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052b8:	0f 84 ba 00 00 00    	je     80105378 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052be:	e8 8d bb ff ff       	call   80100e50 <filealloc>
801052c3:	89 c7                	mov    %eax,%edi
801052c5:	85 c0                	test   %eax,%eax
801052c7:	74 23                	je     801052ec <sys_open+0x9c>
  struct proc *curproc = myproc();
801052c9:	e8 b2 e6 ff ff       	call   80103980 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052ce:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801052d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052d4:	85 d2                	test   %edx,%edx
801052d6:	74 58                	je     80105330 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801052d8:	83 c3 01             	add    $0x1,%ebx
801052db:	83 fb 10             	cmp    $0x10,%ebx
801052de:	75 f0                	jne    801052d0 <sys_open+0x80>
    if(f)
      fileclose(f);
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	57                   	push   %edi
801052e4:	e8 27 bc ff ff       	call   80100f10 <fileclose>
801052e9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	56                   	push   %esi
801052f0:	e8 2b c7 ff ff       	call   80101a20 <iunlockput>
    end_op();
801052f5:	e8 a6 da ff ff       	call   80102da0 <end_op>
    return -1;
801052fa:	83 c4 10             	add    $0x10,%esp
    return -1;
801052fd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105302:	eb 65                	jmp    80105369 <sys_open+0x119>
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105308:	83 ec 0c             	sub    $0xc,%esp
8010530b:	31 c9                	xor    %ecx,%ecx
8010530d:	ba 02 00 00 00       	mov    $0x2,%edx
80105312:	6a 00                	push   $0x0
80105314:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105317:	e8 54 f8 ff ff       	call   80104b70 <create>
    if(ip == 0){
8010531c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010531f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105321:	85 c0                	test   %eax,%eax
80105323:	75 99                	jne    801052be <sys_open+0x6e>
      end_op();
80105325:	e8 76 da ff ff       	call   80102da0 <end_op>
      return -1;
8010532a:	eb d1                	jmp    801052fd <sys_open+0xad>
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105330:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105333:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105337:	56                   	push   %esi
80105338:	e8 33 c5 ff ff       	call   80101870 <iunlock>
  end_op();
8010533d:	e8 5e da ff ff       	call   80102da0 <end_op>

  f->type = FD_INODE;
80105342:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105348:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010534b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010534e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105351:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105353:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010535a:	f7 d0                	not    %eax
8010535c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010535f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105362:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105365:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105369:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010536c:	89 d8                	mov    %ebx,%eax
8010536e:	5b                   	pop    %ebx
8010536f:	5e                   	pop    %esi
80105370:	5f                   	pop    %edi
80105371:	5d                   	pop    %ebp
80105372:	c3                   	ret
80105373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105378:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010537b:	85 c9                	test   %ecx,%ecx
8010537d:	0f 84 3b ff ff ff    	je     801052be <sys_open+0x6e>
80105383:	e9 64 ff ff ff       	jmp    801052ec <sys_open+0x9c>
80105388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010538f:	00 

80105390 <sys_mkdir>:

int
sys_mkdir(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105396:	e8 95 d9 ff ff       	call   80102d30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010539b:	83 ec 08             	sub    $0x8,%esp
8010539e:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053a1:	50                   	push   %eax
801053a2:	6a 00                	push   $0x0
801053a4:	e8 d7 f6 ff ff       	call   80104a80 <argstr>
801053a9:	83 c4 10             	add    $0x10,%esp
801053ac:	85 c0                	test   %eax,%eax
801053ae:	78 30                	js     801053e0 <sys_mkdir+0x50>
801053b0:	83 ec 0c             	sub    $0xc,%esp
801053b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053b6:	31 c9                	xor    %ecx,%ecx
801053b8:	ba 01 00 00 00       	mov    $0x1,%edx
801053bd:	6a 00                	push   $0x0
801053bf:	e8 ac f7 ff ff       	call   80104b70 <create>
801053c4:	83 c4 10             	add    $0x10,%esp
801053c7:	85 c0                	test   %eax,%eax
801053c9:	74 15                	je     801053e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053cb:	83 ec 0c             	sub    $0xc,%esp
801053ce:	50                   	push   %eax
801053cf:	e8 4c c6 ff ff       	call   80101a20 <iunlockput>
  end_op();
801053d4:	e8 c7 d9 ff ff       	call   80102da0 <end_op>
  return 0;
801053d9:	83 c4 10             	add    $0x10,%esp
801053dc:	31 c0                	xor    %eax,%eax
}
801053de:	c9                   	leave
801053df:	c3                   	ret
    end_op();
801053e0:	e8 bb d9 ff ff       	call   80102da0 <end_op>
    return -1;
801053e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053ea:	c9                   	leave
801053eb:	c3                   	ret
801053ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053f0 <sys_mknod>:

int
sys_mknod(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053f6:	e8 35 d9 ff ff       	call   80102d30 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053fb:	83 ec 08             	sub    $0x8,%esp
801053fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105401:	50                   	push   %eax
80105402:	6a 00                	push   $0x0
80105404:	e8 77 f6 ff ff       	call   80104a80 <argstr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	78 60                	js     80105470 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105410:	83 ec 08             	sub    $0x8,%esp
80105413:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105416:	50                   	push   %eax
80105417:	6a 01                	push   $0x1
80105419:	e8 a2 f5 ff ff       	call   801049c0 <argint>
  if((argstr(0, &path)) < 0 ||
8010541e:	83 c4 10             	add    $0x10,%esp
80105421:	85 c0                	test   %eax,%eax
80105423:	78 4b                	js     80105470 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105425:	83 ec 08             	sub    $0x8,%esp
80105428:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010542b:	50                   	push   %eax
8010542c:	6a 02                	push   $0x2
8010542e:	e8 8d f5 ff ff       	call   801049c0 <argint>
     argint(1, &major) < 0 ||
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	78 36                	js     80105470 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010543a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010543e:	83 ec 0c             	sub    $0xc,%esp
80105441:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105445:	ba 03 00 00 00       	mov    $0x3,%edx
8010544a:	50                   	push   %eax
8010544b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010544e:	e8 1d f7 ff ff       	call   80104b70 <create>
     argint(2, &minor) < 0 ||
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	85 c0                	test   %eax,%eax
80105458:	74 16                	je     80105470 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010545a:	83 ec 0c             	sub    $0xc,%esp
8010545d:	50                   	push   %eax
8010545e:	e8 bd c5 ff ff       	call   80101a20 <iunlockput>
  end_op();
80105463:	e8 38 d9 ff ff       	call   80102da0 <end_op>
  return 0;
80105468:	83 c4 10             	add    $0x10,%esp
8010546b:	31 c0                	xor    %eax,%eax
}
8010546d:	c9                   	leave
8010546e:	c3                   	ret
8010546f:	90                   	nop
    end_op();
80105470:	e8 2b d9 ff ff       	call   80102da0 <end_op>
    return -1;
80105475:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010547a:	c9                   	leave
8010547b:	c3                   	ret
8010547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105480 <sys_chdir>:

int
sys_chdir(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
80105485:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105488:	e8 f3 e4 ff ff       	call   80103980 <myproc>
8010548d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010548f:	e8 9c d8 ff ff       	call   80102d30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105494:	83 ec 08             	sub    $0x8,%esp
80105497:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010549a:	50                   	push   %eax
8010549b:	6a 00                	push   $0x0
8010549d:	e8 de f5 ff ff       	call   80104a80 <argstr>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 77                	js     80105520 <sys_chdir+0xa0>
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	ff 75 f4             	push   -0xc(%ebp)
801054af:	e8 bc cb ff ff       	call   80102070 <namei>
801054b4:	83 c4 10             	add    $0x10,%esp
801054b7:	89 c3                	mov    %eax,%ebx
801054b9:	85 c0                	test   %eax,%eax
801054bb:	74 63                	je     80105520 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054bd:	83 ec 0c             	sub    $0xc,%esp
801054c0:	50                   	push   %eax
801054c1:	e8 ca c2 ff ff       	call   80101790 <ilock>
  if(ip->type != T_DIR){
801054c6:	83 c4 10             	add    $0x10,%esp
801054c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054ce:	75 30                	jne    80105500 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054d0:	83 ec 0c             	sub    $0xc,%esp
801054d3:	53                   	push   %ebx
801054d4:	e8 97 c3 ff ff       	call   80101870 <iunlock>
  iput(curproc->cwd);
801054d9:	58                   	pop    %eax
801054da:	ff 76 68             	push   0x68(%esi)
801054dd:	e8 de c3 ff ff       	call   801018c0 <iput>
  end_op();
801054e2:	e8 b9 d8 ff ff       	call   80102da0 <end_op>
  curproc->cwd = ip;
801054e7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801054ea:	83 c4 10             	add    $0x10,%esp
801054ed:	31 c0                	xor    %eax,%eax
}
801054ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054f2:	5b                   	pop    %ebx
801054f3:	5e                   	pop    %esi
801054f4:	5d                   	pop    %ebp
801054f5:	c3                   	ret
801054f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054fd:	00 
801054fe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	53                   	push   %ebx
80105504:	e8 17 c5 ff ff       	call   80101a20 <iunlockput>
    end_op();
80105509:	e8 92 d8 ff ff       	call   80102da0 <end_op>
    return -1;
8010550e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105511:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105516:	eb d7                	jmp    801054ef <sys_chdir+0x6f>
80105518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010551f:	00 
    end_op();
80105520:	e8 7b d8 ff ff       	call   80102da0 <end_op>
    return -1;
80105525:	eb ea                	jmp    80105511 <sys_chdir+0x91>
80105527:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010552e:	00 
8010552f:	90                   	nop

80105530 <sys_exec>:

int
sys_exec(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	57                   	push   %edi
80105534:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105535:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010553b:	53                   	push   %ebx
8010553c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105542:	50                   	push   %eax
80105543:	6a 00                	push   $0x0
80105545:	e8 36 f5 ff ff       	call   80104a80 <argstr>
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	85 c0                	test   %eax,%eax
8010554f:	0f 88 87 00 00 00    	js     801055dc <sys_exec+0xac>
80105555:	83 ec 08             	sub    $0x8,%esp
80105558:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010555e:	50                   	push   %eax
8010555f:	6a 01                	push   $0x1
80105561:	e8 5a f4 ff ff       	call   801049c0 <argint>
80105566:	83 c4 10             	add    $0x10,%esp
80105569:	85 c0                	test   %eax,%eax
8010556b:	78 6f                	js     801055dc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010556d:	83 ec 04             	sub    $0x4,%esp
80105570:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105576:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105578:	68 80 00 00 00       	push   $0x80
8010557d:	6a 00                	push   $0x0
8010557f:	56                   	push   %esi
80105580:	e8 8b f1 ff ff       	call   80104710 <memset>
80105585:	83 c4 10             	add    $0x10,%esp
80105588:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010558f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105590:	83 ec 08             	sub    $0x8,%esp
80105593:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105599:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801055a0:	50                   	push   %eax
801055a1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055a7:	01 f8                	add    %edi,%eax
801055a9:	50                   	push   %eax
801055aa:	e8 81 f3 ff ff       	call   80104930 <fetchint>
801055af:	83 c4 10             	add    $0x10,%esp
801055b2:	85 c0                	test   %eax,%eax
801055b4:	78 26                	js     801055dc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801055b6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055bc:	85 c0                	test   %eax,%eax
801055be:	74 30                	je     801055f0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055c0:	83 ec 08             	sub    $0x8,%esp
801055c3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801055c6:	52                   	push   %edx
801055c7:	50                   	push   %eax
801055c8:	e8 a3 f3 ff ff       	call   80104970 <fetchstr>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	78 08                	js     801055dc <sys_exec+0xac>
  for(i=0;; i++){
801055d4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801055d7:	83 fb 20             	cmp    $0x20,%ebx
801055da:	75 b4                	jne    80105590 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055e4:	5b                   	pop    %ebx
801055e5:	5e                   	pop    %esi
801055e6:	5f                   	pop    %edi
801055e7:	5d                   	pop    %ebp
801055e8:	c3                   	ret
801055e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801055f0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055f7:	00 00 00 00 
  return exec(path, argv);
801055fb:	83 ec 08             	sub    $0x8,%esp
801055fe:	56                   	push   %esi
801055ff:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105605:	e8 a6 b4 ff ff       	call   80100ab0 <exec>
8010560a:	83 c4 10             	add    $0x10,%esp
}
8010560d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105610:	5b                   	pop    %ebx
80105611:	5e                   	pop    %esi
80105612:	5f                   	pop    %edi
80105613:	5d                   	pop    %ebp
80105614:	c3                   	ret
80105615:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010561c:	00 
8010561d:	8d 76 00             	lea    0x0(%esi),%esi

80105620 <sys_pipe>:

int
sys_pipe(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105625:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105628:	53                   	push   %ebx
80105629:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010562c:	6a 08                	push   $0x8
8010562e:	50                   	push   %eax
8010562f:	6a 00                	push   $0x0
80105631:	e8 da f3 ff ff       	call   80104a10 <argptr>
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	85 c0                	test   %eax,%eax
8010563b:	0f 88 8b 00 00 00    	js     801056cc <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105641:	83 ec 08             	sub    $0x8,%esp
80105644:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105647:	50                   	push   %eax
80105648:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010564b:	50                   	push   %eax
8010564c:	e8 df dd ff ff       	call   80103430 <pipealloc>
80105651:	83 c4 10             	add    $0x10,%esp
80105654:	85 c0                	test   %eax,%eax
80105656:	78 74                	js     801056cc <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105658:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010565b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010565d:	e8 1e e3 ff ff       	call   80103980 <myproc>
    if(curproc->ofile[fd] == 0){
80105662:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105666:	85 f6                	test   %esi,%esi
80105668:	74 16                	je     80105680 <sys_pipe+0x60>
8010566a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105670:	83 c3 01             	add    $0x1,%ebx
80105673:	83 fb 10             	cmp    $0x10,%ebx
80105676:	74 3d                	je     801056b5 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105678:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010567c:	85 f6                	test   %esi,%esi
8010567e:	75 f0                	jne    80105670 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105680:	8d 73 08             	lea    0x8(%ebx),%esi
80105683:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105687:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010568a:	e8 f1 e2 ff ff       	call   80103980 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010568f:	31 d2                	xor    %edx,%edx
80105691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105698:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010569c:	85 c9                	test   %ecx,%ecx
8010569e:	74 38                	je     801056d8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
801056a0:	83 c2 01             	add    $0x1,%edx
801056a3:	83 fa 10             	cmp    $0x10,%edx
801056a6:	75 f0                	jne    80105698 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056a8:	e8 d3 e2 ff ff       	call   80103980 <myproc>
801056ad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056b4:	00 
    fileclose(rf);
801056b5:	83 ec 0c             	sub    $0xc,%esp
801056b8:	ff 75 e0             	push   -0x20(%ebp)
801056bb:	e8 50 b8 ff ff       	call   80100f10 <fileclose>
    fileclose(wf);
801056c0:	58                   	pop    %eax
801056c1:	ff 75 e4             	push   -0x1c(%ebp)
801056c4:	e8 47 b8 ff ff       	call   80100f10 <fileclose>
    return -1;
801056c9:	83 c4 10             	add    $0x10,%esp
    return -1;
801056cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d1:	eb 16                	jmp    801056e9 <sys_pipe+0xc9>
801056d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801056d8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801056dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056df:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056e4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801056e7:	31 c0                	xor    %eax,%eax
}
801056e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056ec:	5b                   	pop    %ebx
801056ed:	5e                   	pop    %esi
801056ee:	5f                   	pop    %edi
801056ef:	5d                   	pop    %ebp
801056f0:	c3                   	ret
801056f1:	66 90                	xchg   %ax,%ax
801056f3:	66 90                	xchg   %ax,%ax
801056f5:	66 90                	xchg   %ax,%ax
801056f7:	66 90                	xchg   %ax,%ax
801056f9:	66 90                	xchg   %ax,%ax
801056fb:	66 90                	xchg   %ax,%ax
801056fd:	66 90                	xchg   %ax,%ax
801056ff:	90                   	nop

80105700 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105700:	e9 1b e4 ff ff       	jmp    80103b20 <fork>
80105705:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010570c:	00 
8010570d:	8d 76 00             	lea    0x0(%esi),%esi

80105710 <sys_exit>:
}

int
sys_exit(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	83 ec 08             	sub    $0x8,%esp
  exit();
80105716:	e8 75 e6 ff ff       	call   80103d90 <exit>
  return 0;  // not reached
}
8010571b:	31 c0                	xor    %eax,%eax
8010571d:	c9                   	leave
8010571e:	c3                   	ret
8010571f:	90                   	nop

80105720 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105720:	e9 9b e7 ff ff       	jmp    80103ec0 <wait>
80105725:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010572c:	00 
8010572d:	8d 76 00             	lea    0x0(%esi),%esi

80105730 <sys_kill>:
}

int
sys_kill(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105739:	50                   	push   %eax
8010573a:	6a 00                	push   $0x0
8010573c:	e8 7f f2 ff ff       	call   801049c0 <argint>
80105741:	83 c4 10             	add    $0x10,%esp
80105744:	85 c0                	test   %eax,%eax
80105746:	78 18                	js     80105760 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105748:	83 ec 0c             	sub    $0xc,%esp
8010574b:	ff 75 f4             	push   -0xc(%ebp)
8010574e:	e8 0d ea ff ff       	call   80104160 <kill>
80105753:	83 c4 10             	add    $0x10,%esp
}
80105756:	c9                   	leave
80105757:	c3                   	ret
80105758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010575f:	00 
80105760:	c9                   	leave
    return -1;
80105761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105766:	c3                   	ret
80105767:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010576e:	00 
8010576f:	90                   	nop

80105770 <sys_getpid>:

int
sys_getpid(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105776:	e8 05 e2 ff ff       	call   80103980 <myproc>
8010577b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010577e:	c9                   	leave
8010577f:	c3                   	ret

80105780 <sys_sbrk>:

int
sys_sbrk(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105784:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105787:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010578a:	50                   	push   %eax
8010578b:	6a 00                	push   $0x0
8010578d:	e8 2e f2 ff ff       	call   801049c0 <argint>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	85 c0                	test   %eax,%eax
80105797:	78 27                	js     801057c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105799:	e8 e2 e1 ff ff       	call   80103980 <myproc>
  if(growproc(n) < 0)
8010579e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801057a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057a3:	ff 75 f4             	push   -0xc(%ebp)
801057a6:	e8 f5 e2 ff ff       	call   80103aa0 <growproc>
801057ab:	83 c4 10             	add    $0x10,%esp
801057ae:	85 c0                	test   %eax,%eax
801057b0:	78 0e                	js     801057c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057b2:	89 d8                	mov    %ebx,%eax
801057b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b7:	c9                   	leave
801057b8:	c3                   	ret
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057c5:	eb eb                	jmp    801057b2 <sys_sbrk+0x32>
801057c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ce:	00 
801057cf:	90                   	nop

801057d0 <sys_sleep>:

int
sys_sleep(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057da:	50                   	push   %eax
801057db:	6a 00                	push   $0x0
801057dd:	e8 de f1 ff ff       	call   801049c0 <argint>
801057e2:	83 c4 10             	add    $0x10,%esp
801057e5:	85 c0                	test   %eax,%eax
801057e7:	78 64                	js     8010584d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
801057e9:	83 ec 0c             	sub    $0xc,%esp
801057ec:	68 a0 58 11 80       	push   $0x801158a0
801057f1:	e8 1a ee ff ff       	call   80104610 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801057f9:	8b 1d 80 58 11 80    	mov    0x80115880,%ebx
  while(ticks - ticks0 < n){
801057ff:	83 c4 10             	add    $0x10,%esp
80105802:	85 d2                	test   %edx,%edx
80105804:	75 2b                	jne    80105831 <sys_sleep+0x61>
80105806:	eb 58                	jmp    80105860 <sys_sleep+0x90>
80105808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010580f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105810:	83 ec 08             	sub    $0x8,%esp
80105813:	68 a0 58 11 80       	push   $0x801158a0
80105818:	68 80 58 11 80       	push   $0x80115880
8010581d:	e8 1e e8 ff ff       	call   80104040 <sleep>
  while(ticks - ticks0 < n){
80105822:	a1 80 58 11 80       	mov    0x80115880,%eax
80105827:	83 c4 10             	add    $0x10,%esp
8010582a:	29 d8                	sub    %ebx,%eax
8010582c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010582f:	73 2f                	jae    80105860 <sys_sleep+0x90>
    if(myproc()->killed){
80105831:	e8 4a e1 ff ff       	call   80103980 <myproc>
80105836:	8b 40 24             	mov    0x24(%eax),%eax
80105839:	85 c0                	test   %eax,%eax
8010583b:	74 d3                	je     80105810 <sys_sleep+0x40>
      release(&tickslock);
8010583d:	83 ec 0c             	sub    $0xc,%esp
80105840:	68 a0 58 11 80       	push   $0x801158a0
80105845:	e8 66 ed ff ff       	call   801045b0 <release>
      return -1;
8010584a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
8010584d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105855:	c9                   	leave
80105856:	c3                   	ret
80105857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010585e:	00 
8010585f:	90                   	nop
  release(&tickslock);
80105860:	83 ec 0c             	sub    $0xc,%esp
80105863:	68 a0 58 11 80       	push   $0x801158a0
80105868:	e8 43 ed ff ff       	call   801045b0 <release>
}
8010586d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105870:	83 c4 10             	add    $0x10,%esp
80105873:	31 c0                	xor    %eax,%eax
}
80105875:	c9                   	leave
80105876:	c3                   	ret
80105877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587e:	00 
8010587f:	90                   	nop

80105880 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	53                   	push   %ebx
80105884:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105887:	68 a0 58 11 80       	push   $0x801158a0
8010588c:	e8 7f ed ff ff       	call   80104610 <acquire>
  xticks = ticks;
80105891:	8b 1d 80 58 11 80    	mov    0x80115880,%ebx
  release(&tickslock);
80105897:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
8010589e:	e8 0d ed ff ff       	call   801045b0 <release>
  return xticks;
}
801058a3:	89 d8                	mov    %ebx,%eax
801058a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058a8:	c9                   	leave
801058a9:	c3                   	ret
801058aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058b0 <sys_getproccount>:
extern int getproccount(void);

int
sys_getproccount(void)
{
  return getproccount();
801058b0:	e9 eb e9 ff ff       	jmp    801042a0 <getproccount>
801058b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058bc:	00 
801058bd:	8d 76 00             	lea    0x0(%esi),%esi

801058c0 <sys_reboot>:
}

int
sys_reboot(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 20             	sub    $0x20,%esp
  int type;

  // Grab the integer argument passed from user space
  if(argint(0, &type) < 0)
801058c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058c9:	50                   	push   %eax
801058ca:	6a 00                	push   $0x0
801058cc:	e8 ef f0 ff ff       	call   801049c0 <argint>
801058d1:	83 c4 10             	add    $0x10,%esp
801058d4:	85 c0                	test   %eax,%eax
801058d6:	78 39                	js     80105911 <sys_reboot+0x51>
    return -1;

  if (type == 1) {
801058d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058db:	83 f8 01             	cmp    $0x1,%eax
801058de:	74 20                	je     80105900 <sys_reboot+0x40>
  else if (type == 2) {
    // Privileged Shutdown: Write 0x2000 to QEMU's ACPI power port
    outw(0x604, 0x2000);
  }

  return 0;
801058e0:	31 c9                	xor    %ecx,%ecx
  else if (type == 2) {
801058e2:	83 f8 02             	cmp    $0x2,%eax
801058e5:	74 09                	je     801058f0 <sys_reboot+0x30>
}
801058e7:	c9                   	leave
801058e8:	89 c8                	mov    %ecx,%eax
801058ea:	c3                   	ret
801058eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058f0:	b8 00 20 00 00       	mov    $0x2000,%eax
801058f5:	ba 04 06 00 00       	mov    $0x604,%edx
801058fa:	66 ef                	out    %ax,(%dx)
801058fc:	c9                   	leave
801058fd:	89 c8                	mov    %ecx,%eax
801058ff:	c3                   	ret
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105900:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80105905:	ba 64 00 00 00       	mov    $0x64,%edx
8010590a:	ee                   	out    %al,(%dx)
8010590b:	c9                   	leave
  return 0;
8010590c:	31 c9                	xor    %ecx,%ecx
}
8010590e:	89 c8                	mov    %ecx,%eax
80105910:	c3                   	ret
    return -1;
80105911:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80105916:	eb cf                	jmp    801058e7 <sys_reboot+0x27>

80105918 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105918:	1e                   	push   %ds
  pushl %es
80105919:	06                   	push   %es
  pushl %fs
8010591a:	0f a0                	push   %fs
  pushl %gs
8010591c:	0f a8                	push   %gs
  pushal
8010591e:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010591f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105923:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105925:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105927:	54                   	push   %esp
  call trap
80105928:	e8 c3 00 00 00       	call   801059f0 <trap>
  addl $4, %esp
8010592d:	83 c4 04             	add    $0x4,%esp

80105930 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105930:	61                   	popa
  popl %gs
80105931:	0f a9                	pop    %gs
  popl %fs
80105933:	0f a1                	pop    %fs
  popl %es
80105935:	07                   	pop    %es
  popl %ds
80105936:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105937:	83 c4 08             	add    $0x8,%esp
  iret
8010593a:	cf                   	iret
8010593b:	66 90                	xchg   %ax,%ax
8010593d:	66 90                	xchg   %ax,%ax
8010593f:	90                   	nop

80105940 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105940:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105941:	31 c0                	xor    %eax,%eax
{
80105943:	89 e5                	mov    %esp,%ebp
80105945:	83 ec 08             	sub    $0x8,%esp
80105948:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010594f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105950:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105957:	c7 04 c5 e2 58 11 80 	movl   $0x8e000008,-0x7feea71e(,%eax,8)
8010595e:	08 00 00 8e 
80105962:	66 89 14 c5 e0 58 11 	mov    %dx,-0x7feea720(,%eax,8)
80105969:	80 
8010596a:	c1 ea 10             	shr    $0x10,%edx
8010596d:	66 89 14 c5 e6 58 11 	mov    %dx,-0x7feea71a(,%eax,8)
80105974:	80 
  for(i = 0; i < 256; i++)
80105975:	83 c0 01             	add    $0x1,%eax
80105978:	3d 00 01 00 00       	cmp    $0x100,%eax
8010597d:	75 d1                	jne    80105950 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010597f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105982:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105987:	c7 05 e2 5a 11 80 08 	movl   $0xef000008,0x80115ae2
8010598e:	00 00 ef 
  initlock(&tickslock, "time");
80105991:	68 4a 76 10 80       	push   $0x8010764a
80105996:	68 a0 58 11 80       	push   $0x801158a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010599b:	66 a3 e0 5a 11 80    	mov    %ax,0x80115ae0
801059a1:	c1 e8 10             	shr    $0x10,%eax
801059a4:	66 a3 e6 5a 11 80    	mov    %ax,0x80115ae6
  initlock(&tickslock, "time");
801059aa:	e8 71 ea ff ff       	call   80104420 <initlock>
}
801059af:	83 c4 10             	add    $0x10,%esp
801059b2:	c9                   	leave
801059b3:	c3                   	ret
801059b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059bb:	00 
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059c0 <idtinit>:

void
idtinit(void)
{
801059c0:	55                   	push   %ebp
  pd[0] = size-1;
801059c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059c6:	89 e5                	mov    %esp,%ebp
801059c8:	83 ec 10             	sub    $0x10,%esp
801059cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059cf:	b8 e0 58 11 80       	mov    $0x801158e0,%eax
801059d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059d8:	c1 e8 10             	shr    $0x10,%eax
801059db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801059df:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059e5:	c9                   	leave
801059e6:	c3                   	ret
801059e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ee:	00 
801059ef:	90                   	nop

801059f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	57                   	push   %edi
801059f4:	56                   	push   %esi
801059f5:	53                   	push   %ebx
801059f6:	83 ec 1c             	sub    $0x1c,%esp
801059f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801059fc:	8b 43 30             	mov    0x30(%ebx),%eax
801059ff:	83 f8 40             	cmp    $0x40,%eax
80105a02:	0f 84 58 01 00 00    	je     80105b60 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a08:	83 e8 20             	sub    $0x20,%eax
80105a0b:	83 f8 1f             	cmp    $0x1f,%eax
80105a0e:	0f 87 7c 00 00 00    	ja     80105a90 <trap+0xa0>
80105a14:	ff 24 85 20 7c 10 80 	jmp    *-0x7fef83e0(,%eax,4)
80105a1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105a20:	e8 fb c7 ff ff       	call   80102220 <ideintr>
    lapiceoi();
80105a25:	e8 b6 ce ff ff       	call   801028e0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a2a:	e8 51 df ff ff       	call   80103980 <myproc>
80105a2f:	85 c0                	test   %eax,%eax
80105a31:	74 1a                	je     80105a4d <trap+0x5d>
80105a33:	e8 48 df ff ff       	call   80103980 <myproc>
80105a38:	8b 50 24             	mov    0x24(%eax),%edx
80105a3b:	85 d2                	test   %edx,%edx
80105a3d:	74 0e                	je     80105a4d <trap+0x5d>
80105a3f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a43:	f7 d0                	not    %eax
80105a45:	a8 03                	test   $0x3,%al
80105a47:	0f 84 db 01 00 00    	je     80105c28 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a4d:	e8 2e df ff ff       	call   80103980 <myproc>
80105a52:	85 c0                	test   %eax,%eax
80105a54:	74 0f                	je     80105a65 <trap+0x75>
80105a56:	e8 25 df ff ff       	call   80103980 <myproc>
80105a5b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a5f:	0f 84 ab 00 00 00    	je     80105b10 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a65:	e8 16 df ff ff       	call   80103980 <myproc>
80105a6a:	85 c0                	test   %eax,%eax
80105a6c:	74 1a                	je     80105a88 <trap+0x98>
80105a6e:	e8 0d df ff ff       	call   80103980 <myproc>
80105a73:	8b 40 24             	mov    0x24(%eax),%eax
80105a76:	85 c0                	test   %eax,%eax
80105a78:	74 0e                	je     80105a88 <trap+0x98>
80105a7a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a7e:	f7 d0                	not    %eax
80105a80:	a8 03                	test   $0x3,%al
80105a82:	0f 84 05 01 00 00    	je     80105b8d <trap+0x19d>
    exit();
}
80105a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a8b:	5b                   	pop    %ebx
80105a8c:	5e                   	pop    %esi
80105a8d:	5f                   	pop    %edi
80105a8e:	5d                   	pop    %ebp
80105a8f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a90:	e8 eb de ff ff       	call   80103980 <myproc>
80105a95:	8b 7b 38             	mov    0x38(%ebx),%edi
80105a98:	85 c0                	test   %eax,%eax
80105a9a:	0f 84 a2 01 00 00    	je     80105c42 <trap+0x252>
80105aa0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105aa4:	0f 84 98 01 00 00    	je     80105c42 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105aaa:	0f 20 d1             	mov    %cr2,%ecx
80105aad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ab0:	e8 ab de ff ff       	call   80103960 <cpuid>
80105ab5:	8b 73 30             	mov    0x30(%ebx),%esi
80105ab8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105abb:	8b 43 34             	mov    0x34(%ebx),%eax
80105abe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105ac1:	e8 ba de ff ff       	call   80103980 <myproc>
80105ac6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ac9:	e8 b2 de ff ff       	call   80103980 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ace:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ad1:	51                   	push   %ecx
80105ad2:	57                   	push   %edi
80105ad3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ad6:	52                   	push   %edx
80105ad7:	ff 75 e4             	push   -0x1c(%ebp)
80105ada:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105adb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105ade:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ae1:	56                   	push   %esi
80105ae2:	ff 70 10             	push   0x10(%eax)
80105ae5:	68 10 79 10 80       	push   $0x80107910
80105aea:	e8 c1 ab ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105aef:	83 c4 20             	add    $0x20,%esp
80105af2:	e8 89 de ff ff       	call   80103980 <myproc>
80105af7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105afe:	e8 7d de ff ff       	call   80103980 <myproc>
80105b03:	85 c0                	test   %eax,%eax
80105b05:	0f 85 28 ff ff ff    	jne    80105a33 <trap+0x43>
80105b0b:	e9 3d ff ff ff       	jmp    80105a4d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105b10:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b14:	0f 85 4b ff ff ff    	jne    80105a65 <trap+0x75>
    yield();
80105b1a:	e8 d1 e4 ff ff       	call   80103ff0 <yield>
80105b1f:	e9 41 ff ff ff       	jmp    80105a65 <trap+0x75>
80105b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b28:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b2b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b2f:	e8 2c de ff ff       	call   80103960 <cpuid>
80105b34:	57                   	push   %edi
80105b35:	56                   	push   %esi
80105b36:	50                   	push   %eax
80105b37:	68 b8 78 10 80       	push   $0x801078b8
80105b3c:	e8 6f ab ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105b41:	e8 9a cd ff ff       	call   801028e0 <lapiceoi>
    break;
80105b46:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b49:	e8 32 de ff ff       	call   80103980 <myproc>
80105b4e:	85 c0                	test   %eax,%eax
80105b50:	0f 85 dd fe ff ff    	jne    80105a33 <trap+0x43>
80105b56:	e9 f2 fe ff ff       	jmp    80105a4d <trap+0x5d>
80105b5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105b60:	e8 1b de ff ff       	call   80103980 <myproc>
80105b65:	8b 70 24             	mov    0x24(%eax),%esi
80105b68:	85 f6                	test   %esi,%esi
80105b6a:	0f 85 c8 00 00 00    	jne    80105c38 <trap+0x248>
    myproc()->tf = tf;
80105b70:	e8 0b de ff ff       	call   80103980 <myproc>
80105b75:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105b78:	e8 83 ef ff ff       	call   80104b00 <syscall>
    if(myproc()->killed)
80105b7d:	e8 fe dd ff ff       	call   80103980 <myproc>
80105b82:	8b 48 24             	mov    0x24(%eax),%ecx
80105b85:	85 c9                	test   %ecx,%ecx
80105b87:	0f 84 fb fe ff ff    	je     80105a88 <trap+0x98>
}
80105b8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b90:	5b                   	pop    %ebx
80105b91:	5e                   	pop    %esi
80105b92:	5f                   	pop    %edi
80105b93:	5d                   	pop    %ebp
      exit();
80105b94:	e9 f7 e1 ff ff       	jmp    80103d90 <exit>
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105ba0:	e8 4b 02 00 00       	call   80105df0 <uartintr>
    lapiceoi();
80105ba5:	e8 36 cd ff ff       	call   801028e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105baa:	e8 d1 dd ff ff       	call   80103980 <myproc>
80105baf:	85 c0                	test   %eax,%eax
80105bb1:	0f 85 7c fe ff ff    	jne    80105a33 <trap+0x43>
80105bb7:	e9 91 fe ff ff       	jmp    80105a4d <trap+0x5d>
80105bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105bc0:	e8 eb cb ff ff       	call   801027b0 <kbdintr>
    lapiceoi();
80105bc5:	e8 16 cd ff ff       	call   801028e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bca:	e8 b1 dd ff ff       	call   80103980 <myproc>
80105bcf:	85 c0                	test   %eax,%eax
80105bd1:	0f 85 5c fe ff ff    	jne    80105a33 <trap+0x43>
80105bd7:	e9 71 fe ff ff       	jmp    80105a4d <trap+0x5d>
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105be0:	e8 7b dd ff ff       	call   80103960 <cpuid>
80105be5:	85 c0                	test   %eax,%eax
80105be7:	0f 85 38 fe ff ff    	jne    80105a25 <trap+0x35>
      acquire(&tickslock);
80105bed:	83 ec 0c             	sub    $0xc,%esp
80105bf0:	68 a0 58 11 80       	push   $0x801158a0
80105bf5:	e8 16 ea ff ff       	call   80104610 <acquire>
      ticks++;
80105bfa:	83 05 80 58 11 80 01 	addl   $0x1,0x80115880
      wakeup(&ticks);
80105c01:	c7 04 24 80 58 11 80 	movl   $0x80115880,(%esp)
80105c08:	e8 f3 e4 ff ff       	call   80104100 <wakeup>
      release(&tickslock);
80105c0d:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
80105c14:	e8 97 e9 ff ff       	call   801045b0 <release>
80105c19:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c1c:	e9 04 fe ff ff       	jmp    80105a25 <trap+0x35>
80105c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105c28:	e8 63 e1 ff ff       	call   80103d90 <exit>
80105c2d:	e9 1b fe ff ff       	jmp    80105a4d <trap+0x5d>
80105c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c38:	e8 53 e1 ff ff       	call   80103d90 <exit>
80105c3d:	e9 2e ff ff ff       	jmp    80105b70 <trap+0x180>
80105c42:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c45:	e8 16 dd ff ff       	call   80103960 <cpuid>
80105c4a:	83 ec 0c             	sub    $0xc,%esp
80105c4d:	56                   	push   %esi
80105c4e:	57                   	push   %edi
80105c4f:	50                   	push   %eax
80105c50:	ff 73 30             	push   0x30(%ebx)
80105c53:	68 dc 78 10 80       	push   $0x801078dc
80105c58:	e8 53 aa ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105c5d:	83 c4 14             	add    $0x14,%esp
80105c60:	68 4f 76 10 80       	push   $0x8010764f
80105c65:	e8 16 a7 ff ff       	call   80100380 <panic>
80105c6a:	66 90                	xchg   %ax,%ax
80105c6c:	66 90                	xchg   %ax,%ax
80105c6e:	66 90                	xchg   %ax,%ax

80105c70 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c70:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80105c75:	85 c0                	test   %eax,%eax
80105c77:	74 17                	je     80105c90 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c79:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c7e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c7f:	a8 01                	test   $0x1,%al
80105c81:	74 0d                	je     80105c90 <uartgetc+0x20>
80105c83:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c88:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c89:	0f b6 c0             	movzbl %al,%eax
80105c8c:	c3                   	ret
80105c8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c95:	c3                   	ret
80105c96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c9d:	00 
80105c9e:	66 90                	xchg   %ax,%ax

80105ca0 <uartinit>:
{
80105ca0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ca1:	31 c9                	xor    %ecx,%ecx
80105ca3:	89 c8                	mov    %ecx,%eax
80105ca5:	89 e5                	mov    %esp,%ebp
80105ca7:	57                   	push   %edi
80105ca8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105cad:	56                   	push   %esi
80105cae:	89 fa                	mov    %edi,%edx
80105cb0:	53                   	push   %ebx
80105cb1:	83 ec 1c             	sub    $0x1c,%esp
80105cb4:	ee                   	out    %al,(%dx)
80105cb5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105cba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105cbf:	89 f2                	mov    %esi,%edx
80105cc1:	ee                   	out    %al,(%dx)
80105cc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105cc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ccc:	ee                   	out    %al,(%dx)
80105ccd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105cd2:	89 c8                	mov    %ecx,%eax
80105cd4:	89 da                	mov    %ebx,%edx
80105cd6:	ee                   	out    %al,(%dx)
80105cd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cdc:	89 f2                	mov    %esi,%edx
80105cde:	ee                   	out    %al,(%dx)
80105cdf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ce4:	89 c8                	mov    %ecx,%eax
80105ce6:	ee                   	out    %al,(%dx)
80105ce7:	b8 01 00 00 00       	mov    $0x1,%eax
80105cec:	89 da                	mov    %ebx,%edx
80105cee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cf4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105cf5:	3c ff                	cmp    $0xff,%al
80105cf7:	0f 84 7c 00 00 00    	je     80105d79 <uartinit+0xd9>
  uart = 1;
80105cfd:	c7 05 e0 60 11 80 01 	movl   $0x1,0x801160e0
80105d04:	00 00 00 
80105d07:	89 fa                	mov    %edi,%edx
80105d09:	ec                   	in     (%dx),%al
80105d0a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d0f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d10:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d13:	bf 54 76 10 80       	mov    $0x80107654,%edi
80105d18:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105d1d:	6a 00                	push   $0x0
80105d1f:	6a 04                	push   $0x4
80105d21:	e8 2a c7 ff ff       	call   80102450 <ioapicenable>
80105d26:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d29:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105d30:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80105d35:	85 c0                	test   %eax,%eax
80105d37:	74 32                	je     80105d6b <uartinit+0xcb>
80105d39:	89 f2                	mov    %esi,%edx
80105d3b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d3c:	a8 20                	test   $0x20,%al
80105d3e:	75 21                	jne    80105d61 <uartinit+0xc1>
80105d40:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d45:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105d48:	83 ec 0c             	sub    $0xc,%esp
80105d4b:	6a 0a                	push   $0xa
80105d4d:	e8 ae cb ff ff       	call   80102900 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d52:	83 c4 10             	add    $0x10,%esp
80105d55:	83 eb 01             	sub    $0x1,%ebx
80105d58:	74 07                	je     80105d61 <uartinit+0xc1>
80105d5a:	89 f2                	mov    %esi,%edx
80105d5c:	ec                   	in     (%dx),%al
80105d5d:	a8 20                	test   $0x20,%al
80105d5f:	74 e7                	je     80105d48 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d61:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d66:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105d6a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105d6b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105d6f:	83 c7 01             	add    $0x1,%edi
80105d72:	88 45 e7             	mov    %al,-0x19(%ebp)
80105d75:	84 c0                	test   %al,%al
80105d77:	75 b7                	jne    80105d30 <uartinit+0x90>
}
80105d79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d7c:	5b                   	pop    %ebx
80105d7d:	5e                   	pop    %esi
80105d7e:	5f                   	pop    %edi
80105d7f:	5d                   	pop    %ebp
80105d80:	c3                   	ret
80105d81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d88:	00 
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d90 <uartputc>:
  if(!uart)
80105d90:	a1 e0 60 11 80       	mov    0x801160e0,%eax
80105d95:	85 c0                	test   %eax,%eax
80105d97:	74 4f                	je     80105de8 <uartputc+0x58>
{
80105d99:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d9a:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d9f:	89 e5                	mov    %esp,%ebp
80105da1:	56                   	push   %esi
80105da2:	53                   	push   %ebx
80105da3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105da4:	a8 20                	test   $0x20,%al
80105da6:	75 29                	jne    80105dd1 <uartputc+0x41>
80105da8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105dad:	be fd 03 00 00       	mov    $0x3fd,%esi
80105db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105db8:	83 ec 0c             	sub    $0xc,%esp
80105dbb:	6a 0a                	push   $0xa
80105dbd:	e8 3e cb ff ff       	call   80102900 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dc2:	83 c4 10             	add    $0x10,%esp
80105dc5:	83 eb 01             	sub    $0x1,%ebx
80105dc8:	74 07                	je     80105dd1 <uartputc+0x41>
80105dca:	89 f2                	mov    %esi,%edx
80105dcc:	ec                   	in     (%dx),%al
80105dcd:	a8 20                	test   $0x20,%al
80105dcf:	74 e7                	je     80105db8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80105dd4:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dd9:	ee                   	out    %al,(%dx)
}
80105dda:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ddd:	5b                   	pop    %ebx
80105dde:	5e                   	pop    %esi
80105ddf:	5d                   	pop    %ebp
80105de0:	c3                   	ret
80105de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105de8:	c3                   	ret
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105df0 <uartintr>:

void
uartintr(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105df6:	68 70 5c 10 80       	push   $0x80105c70
80105dfb:	e8 a0 aa ff ff       	call   801008a0 <consoleintr>
}
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	c9                   	leave
80105e04:	c3                   	ret

80105e05 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e05:	6a 00                	push   $0x0
  pushl $0
80105e07:	6a 00                	push   $0x0
  jmp alltraps
80105e09:	e9 0a fb ff ff       	jmp    80105918 <alltraps>

80105e0e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e0e:	6a 00                	push   $0x0
  pushl $1
80105e10:	6a 01                	push   $0x1
  jmp alltraps
80105e12:	e9 01 fb ff ff       	jmp    80105918 <alltraps>

80105e17 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e17:	6a 00                	push   $0x0
  pushl $2
80105e19:	6a 02                	push   $0x2
  jmp alltraps
80105e1b:	e9 f8 fa ff ff       	jmp    80105918 <alltraps>

80105e20 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e20:	6a 00                	push   $0x0
  pushl $3
80105e22:	6a 03                	push   $0x3
  jmp alltraps
80105e24:	e9 ef fa ff ff       	jmp    80105918 <alltraps>

80105e29 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e29:	6a 00                	push   $0x0
  pushl $4
80105e2b:	6a 04                	push   $0x4
  jmp alltraps
80105e2d:	e9 e6 fa ff ff       	jmp    80105918 <alltraps>

80105e32 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e32:	6a 00                	push   $0x0
  pushl $5
80105e34:	6a 05                	push   $0x5
  jmp alltraps
80105e36:	e9 dd fa ff ff       	jmp    80105918 <alltraps>

80105e3b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e3b:	6a 00                	push   $0x0
  pushl $6
80105e3d:	6a 06                	push   $0x6
  jmp alltraps
80105e3f:	e9 d4 fa ff ff       	jmp    80105918 <alltraps>

80105e44 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $7
80105e46:	6a 07                	push   $0x7
  jmp alltraps
80105e48:	e9 cb fa ff ff       	jmp    80105918 <alltraps>

80105e4d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e4d:	6a 08                	push   $0x8
  jmp alltraps
80105e4f:	e9 c4 fa ff ff       	jmp    80105918 <alltraps>

80105e54 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e54:	6a 00                	push   $0x0
  pushl $9
80105e56:	6a 09                	push   $0x9
  jmp alltraps
80105e58:	e9 bb fa ff ff       	jmp    80105918 <alltraps>

80105e5d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e5d:	6a 0a                	push   $0xa
  jmp alltraps
80105e5f:	e9 b4 fa ff ff       	jmp    80105918 <alltraps>

80105e64 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e64:	6a 0b                	push   $0xb
  jmp alltraps
80105e66:	e9 ad fa ff ff       	jmp    80105918 <alltraps>

80105e6b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e6b:	6a 0c                	push   $0xc
  jmp alltraps
80105e6d:	e9 a6 fa ff ff       	jmp    80105918 <alltraps>

80105e72 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e72:	6a 0d                	push   $0xd
  jmp alltraps
80105e74:	e9 9f fa ff ff       	jmp    80105918 <alltraps>

80105e79 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e79:	6a 0e                	push   $0xe
  jmp alltraps
80105e7b:	e9 98 fa ff ff       	jmp    80105918 <alltraps>

80105e80 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e80:	6a 00                	push   $0x0
  pushl $15
80105e82:	6a 0f                	push   $0xf
  jmp alltraps
80105e84:	e9 8f fa ff ff       	jmp    80105918 <alltraps>

80105e89 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $16
80105e8b:	6a 10                	push   $0x10
  jmp alltraps
80105e8d:	e9 86 fa ff ff       	jmp    80105918 <alltraps>

80105e92 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e92:	6a 11                	push   $0x11
  jmp alltraps
80105e94:	e9 7f fa ff ff       	jmp    80105918 <alltraps>

80105e99 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $18
80105e9b:	6a 12                	push   $0x12
  jmp alltraps
80105e9d:	e9 76 fa ff ff       	jmp    80105918 <alltraps>

80105ea2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $19
80105ea4:	6a 13                	push   $0x13
  jmp alltraps
80105ea6:	e9 6d fa ff ff       	jmp    80105918 <alltraps>

80105eab <vector20>:
.globl vector20
vector20:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $20
80105ead:	6a 14                	push   $0x14
  jmp alltraps
80105eaf:	e9 64 fa ff ff       	jmp    80105918 <alltraps>

80105eb4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $21
80105eb6:	6a 15                	push   $0x15
  jmp alltraps
80105eb8:	e9 5b fa ff ff       	jmp    80105918 <alltraps>

80105ebd <vector22>:
.globl vector22
vector22:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $22
80105ebf:	6a 16                	push   $0x16
  jmp alltraps
80105ec1:	e9 52 fa ff ff       	jmp    80105918 <alltraps>

80105ec6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $23
80105ec8:	6a 17                	push   $0x17
  jmp alltraps
80105eca:	e9 49 fa ff ff       	jmp    80105918 <alltraps>

80105ecf <vector24>:
.globl vector24
vector24:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $24
80105ed1:	6a 18                	push   $0x18
  jmp alltraps
80105ed3:	e9 40 fa ff ff       	jmp    80105918 <alltraps>

80105ed8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $25
80105eda:	6a 19                	push   $0x19
  jmp alltraps
80105edc:	e9 37 fa ff ff       	jmp    80105918 <alltraps>

80105ee1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $26
80105ee3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ee5:	e9 2e fa ff ff       	jmp    80105918 <alltraps>

80105eea <vector27>:
.globl vector27
vector27:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $27
80105eec:	6a 1b                	push   $0x1b
  jmp alltraps
80105eee:	e9 25 fa ff ff       	jmp    80105918 <alltraps>

80105ef3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $28
80105ef5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ef7:	e9 1c fa ff ff       	jmp    80105918 <alltraps>

80105efc <vector29>:
.globl vector29
vector29:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $29
80105efe:	6a 1d                	push   $0x1d
  jmp alltraps
80105f00:	e9 13 fa ff ff       	jmp    80105918 <alltraps>

80105f05 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $30
80105f07:	6a 1e                	push   $0x1e
  jmp alltraps
80105f09:	e9 0a fa ff ff       	jmp    80105918 <alltraps>

80105f0e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $31
80105f10:	6a 1f                	push   $0x1f
  jmp alltraps
80105f12:	e9 01 fa ff ff       	jmp    80105918 <alltraps>

80105f17 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $32
80105f19:	6a 20                	push   $0x20
  jmp alltraps
80105f1b:	e9 f8 f9 ff ff       	jmp    80105918 <alltraps>

80105f20 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $33
80105f22:	6a 21                	push   $0x21
  jmp alltraps
80105f24:	e9 ef f9 ff ff       	jmp    80105918 <alltraps>

80105f29 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $34
80105f2b:	6a 22                	push   $0x22
  jmp alltraps
80105f2d:	e9 e6 f9 ff ff       	jmp    80105918 <alltraps>

80105f32 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $35
80105f34:	6a 23                	push   $0x23
  jmp alltraps
80105f36:	e9 dd f9 ff ff       	jmp    80105918 <alltraps>

80105f3b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $36
80105f3d:	6a 24                	push   $0x24
  jmp alltraps
80105f3f:	e9 d4 f9 ff ff       	jmp    80105918 <alltraps>

80105f44 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $37
80105f46:	6a 25                	push   $0x25
  jmp alltraps
80105f48:	e9 cb f9 ff ff       	jmp    80105918 <alltraps>

80105f4d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $38
80105f4f:	6a 26                	push   $0x26
  jmp alltraps
80105f51:	e9 c2 f9 ff ff       	jmp    80105918 <alltraps>

80105f56 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $39
80105f58:	6a 27                	push   $0x27
  jmp alltraps
80105f5a:	e9 b9 f9 ff ff       	jmp    80105918 <alltraps>

80105f5f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $40
80105f61:	6a 28                	push   $0x28
  jmp alltraps
80105f63:	e9 b0 f9 ff ff       	jmp    80105918 <alltraps>

80105f68 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $41
80105f6a:	6a 29                	push   $0x29
  jmp alltraps
80105f6c:	e9 a7 f9 ff ff       	jmp    80105918 <alltraps>

80105f71 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $42
80105f73:	6a 2a                	push   $0x2a
  jmp alltraps
80105f75:	e9 9e f9 ff ff       	jmp    80105918 <alltraps>

80105f7a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $43
80105f7c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f7e:	e9 95 f9 ff ff       	jmp    80105918 <alltraps>

80105f83 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $44
80105f85:	6a 2c                	push   $0x2c
  jmp alltraps
80105f87:	e9 8c f9 ff ff       	jmp    80105918 <alltraps>

80105f8c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $45
80105f8e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f90:	e9 83 f9 ff ff       	jmp    80105918 <alltraps>

80105f95 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $46
80105f97:	6a 2e                	push   $0x2e
  jmp alltraps
80105f99:	e9 7a f9 ff ff       	jmp    80105918 <alltraps>

80105f9e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $47
80105fa0:	6a 2f                	push   $0x2f
  jmp alltraps
80105fa2:	e9 71 f9 ff ff       	jmp    80105918 <alltraps>

80105fa7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $48
80105fa9:	6a 30                	push   $0x30
  jmp alltraps
80105fab:	e9 68 f9 ff ff       	jmp    80105918 <alltraps>

80105fb0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $49
80105fb2:	6a 31                	push   $0x31
  jmp alltraps
80105fb4:	e9 5f f9 ff ff       	jmp    80105918 <alltraps>

80105fb9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $50
80105fbb:	6a 32                	push   $0x32
  jmp alltraps
80105fbd:	e9 56 f9 ff ff       	jmp    80105918 <alltraps>

80105fc2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $51
80105fc4:	6a 33                	push   $0x33
  jmp alltraps
80105fc6:	e9 4d f9 ff ff       	jmp    80105918 <alltraps>

80105fcb <vector52>:
.globl vector52
vector52:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $52
80105fcd:	6a 34                	push   $0x34
  jmp alltraps
80105fcf:	e9 44 f9 ff ff       	jmp    80105918 <alltraps>

80105fd4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $53
80105fd6:	6a 35                	push   $0x35
  jmp alltraps
80105fd8:	e9 3b f9 ff ff       	jmp    80105918 <alltraps>

80105fdd <vector54>:
.globl vector54
vector54:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $54
80105fdf:	6a 36                	push   $0x36
  jmp alltraps
80105fe1:	e9 32 f9 ff ff       	jmp    80105918 <alltraps>

80105fe6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $55
80105fe8:	6a 37                	push   $0x37
  jmp alltraps
80105fea:	e9 29 f9 ff ff       	jmp    80105918 <alltraps>

80105fef <vector56>:
.globl vector56
vector56:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $56
80105ff1:	6a 38                	push   $0x38
  jmp alltraps
80105ff3:	e9 20 f9 ff ff       	jmp    80105918 <alltraps>

80105ff8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $57
80105ffa:	6a 39                	push   $0x39
  jmp alltraps
80105ffc:	e9 17 f9 ff ff       	jmp    80105918 <alltraps>

80106001 <vector58>:
.globl vector58
vector58:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $58
80106003:	6a 3a                	push   $0x3a
  jmp alltraps
80106005:	e9 0e f9 ff ff       	jmp    80105918 <alltraps>

8010600a <vector59>:
.globl vector59
vector59:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $59
8010600c:	6a 3b                	push   $0x3b
  jmp alltraps
8010600e:	e9 05 f9 ff ff       	jmp    80105918 <alltraps>

80106013 <vector60>:
.globl vector60
vector60:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $60
80106015:	6a 3c                	push   $0x3c
  jmp alltraps
80106017:	e9 fc f8 ff ff       	jmp    80105918 <alltraps>

8010601c <vector61>:
.globl vector61
vector61:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $61
8010601e:	6a 3d                	push   $0x3d
  jmp alltraps
80106020:	e9 f3 f8 ff ff       	jmp    80105918 <alltraps>

80106025 <vector62>:
.globl vector62
vector62:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $62
80106027:	6a 3e                	push   $0x3e
  jmp alltraps
80106029:	e9 ea f8 ff ff       	jmp    80105918 <alltraps>

8010602e <vector63>:
.globl vector63
vector63:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $63
80106030:	6a 3f                	push   $0x3f
  jmp alltraps
80106032:	e9 e1 f8 ff ff       	jmp    80105918 <alltraps>

80106037 <vector64>:
.globl vector64
vector64:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $64
80106039:	6a 40                	push   $0x40
  jmp alltraps
8010603b:	e9 d8 f8 ff ff       	jmp    80105918 <alltraps>

80106040 <vector65>:
.globl vector65
vector65:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $65
80106042:	6a 41                	push   $0x41
  jmp alltraps
80106044:	e9 cf f8 ff ff       	jmp    80105918 <alltraps>

80106049 <vector66>:
.globl vector66
vector66:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $66
8010604b:	6a 42                	push   $0x42
  jmp alltraps
8010604d:	e9 c6 f8 ff ff       	jmp    80105918 <alltraps>

80106052 <vector67>:
.globl vector67
vector67:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $67
80106054:	6a 43                	push   $0x43
  jmp alltraps
80106056:	e9 bd f8 ff ff       	jmp    80105918 <alltraps>

8010605b <vector68>:
.globl vector68
vector68:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $68
8010605d:	6a 44                	push   $0x44
  jmp alltraps
8010605f:	e9 b4 f8 ff ff       	jmp    80105918 <alltraps>

80106064 <vector69>:
.globl vector69
vector69:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $69
80106066:	6a 45                	push   $0x45
  jmp alltraps
80106068:	e9 ab f8 ff ff       	jmp    80105918 <alltraps>

8010606d <vector70>:
.globl vector70
vector70:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $70
8010606f:	6a 46                	push   $0x46
  jmp alltraps
80106071:	e9 a2 f8 ff ff       	jmp    80105918 <alltraps>

80106076 <vector71>:
.globl vector71
vector71:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $71
80106078:	6a 47                	push   $0x47
  jmp alltraps
8010607a:	e9 99 f8 ff ff       	jmp    80105918 <alltraps>

8010607f <vector72>:
.globl vector72
vector72:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $72
80106081:	6a 48                	push   $0x48
  jmp alltraps
80106083:	e9 90 f8 ff ff       	jmp    80105918 <alltraps>

80106088 <vector73>:
.globl vector73
vector73:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $73
8010608a:	6a 49                	push   $0x49
  jmp alltraps
8010608c:	e9 87 f8 ff ff       	jmp    80105918 <alltraps>

80106091 <vector74>:
.globl vector74
vector74:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $74
80106093:	6a 4a                	push   $0x4a
  jmp alltraps
80106095:	e9 7e f8 ff ff       	jmp    80105918 <alltraps>

8010609a <vector75>:
.globl vector75
vector75:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $75
8010609c:	6a 4b                	push   $0x4b
  jmp alltraps
8010609e:	e9 75 f8 ff ff       	jmp    80105918 <alltraps>

801060a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $76
801060a5:	6a 4c                	push   $0x4c
  jmp alltraps
801060a7:	e9 6c f8 ff ff       	jmp    80105918 <alltraps>

801060ac <vector77>:
.globl vector77
vector77:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $77
801060ae:	6a 4d                	push   $0x4d
  jmp alltraps
801060b0:	e9 63 f8 ff ff       	jmp    80105918 <alltraps>

801060b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $78
801060b7:	6a 4e                	push   $0x4e
  jmp alltraps
801060b9:	e9 5a f8 ff ff       	jmp    80105918 <alltraps>

801060be <vector79>:
.globl vector79
vector79:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $79
801060c0:	6a 4f                	push   $0x4f
  jmp alltraps
801060c2:	e9 51 f8 ff ff       	jmp    80105918 <alltraps>

801060c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $80
801060c9:	6a 50                	push   $0x50
  jmp alltraps
801060cb:	e9 48 f8 ff ff       	jmp    80105918 <alltraps>

801060d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $81
801060d2:	6a 51                	push   $0x51
  jmp alltraps
801060d4:	e9 3f f8 ff ff       	jmp    80105918 <alltraps>

801060d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $82
801060db:	6a 52                	push   $0x52
  jmp alltraps
801060dd:	e9 36 f8 ff ff       	jmp    80105918 <alltraps>

801060e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $83
801060e4:	6a 53                	push   $0x53
  jmp alltraps
801060e6:	e9 2d f8 ff ff       	jmp    80105918 <alltraps>

801060eb <vector84>:
.globl vector84
vector84:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $84
801060ed:	6a 54                	push   $0x54
  jmp alltraps
801060ef:	e9 24 f8 ff ff       	jmp    80105918 <alltraps>

801060f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $85
801060f6:	6a 55                	push   $0x55
  jmp alltraps
801060f8:	e9 1b f8 ff ff       	jmp    80105918 <alltraps>

801060fd <vector86>:
.globl vector86
vector86:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $86
801060ff:	6a 56                	push   $0x56
  jmp alltraps
80106101:	e9 12 f8 ff ff       	jmp    80105918 <alltraps>

80106106 <vector87>:
.globl vector87
vector87:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $87
80106108:	6a 57                	push   $0x57
  jmp alltraps
8010610a:	e9 09 f8 ff ff       	jmp    80105918 <alltraps>

8010610f <vector88>:
.globl vector88
vector88:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $88
80106111:	6a 58                	push   $0x58
  jmp alltraps
80106113:	e9 00 f8 ff ff       	jmp    80105918 <alltraps>

80106118 <vector89>:
.globl vector89
vector89:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $89
8010611a:	6a 59                	push   $0x59
  jmp alltraps
8010611c:	e9 f7 f7 ff ff       	jmp    80105918 <alltraps>

80106121 <vector90>:
.globl vector90
vector90:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $90
80106123:	6a 5a                	push   $0x5a
  jmp alltraps
80106125:	e9 ee f7 ff ff       	jmp    80105918 <alltraps>

8010612a <vector91>:
.globl vector91
vector91:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $91
8010612c:	6a 5b                	push   $0x5b
  jmp alltraps
8010612e:	e9 e5 f7 ff ff       	jmp    80105918 <alltraps>

80106133 <vector92>:
.globl vector92
vector92:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $92
80106135:	6a 5c                	push   $0x5c
  jmp alltraps
80106137:	e9 dc f7 ff ff       	jmp    80105918 <alltraps>

8010613c <vector93>:
.globl vector93
vector93:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $93
8010613e:	6a 5d                	push   $0x5d
  jmp alltraps
80106140:	e9 d3 f7 ff ff       	jmp    80105918 <alltraps>

80106145 <vector94>:
.globl vector94
vector94:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $94
80106147:	6a 5e                	push   $0x5e
  jmp alltraps
80106149:	e9 ca f7 ff ff       	jmp    80105918 <alltraps>

8010614e <vector95>:
.globl vector95
vector95:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $95
80106150:	6a 5f                	push   $0x5f
  jmp alltraps
80106152:	e9 c1 f7 ff ff       	jmp    80105918 <alltraps>

80106157 <vector96>:
.globl vector96
vector96:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $96
80106159:	6a 60                	push   $0x60
  jmp alltraps
8010615b:	e9 b8 f7 ff ff       	jmp    80105918 <alltraps>

80106160 <vector97>:
.globl vector97
vector97:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $97
80106162:	6a 61                	push   $0x61
  jmp alltraps
80106164:	e9 af f7 ff ff       	jmp    80105918 <alltraps>

80106169 <vector98>:
.globl vector98
vector98:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $98
8010616b:	6a 62                	push   $0x62
  jmp alltraps
8010616d:	e9 a6 f7 ff ff       	jmp    80105918 <alltraps>

80106172 <vector99>:
.globl vector99
vector99:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $99
80106174:	6a 63                	push   $0x63
  jmp alltraps
80106176:	e9 9d f7 ff ff       	jmp    80105918 <alltraps>

8010617b <vector100>:
.globl vector100
vector100:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $100
8010617d:	6a 64                	push   $0x64
  jmp alltraps
8010617f:	e9 94 f7 ff ff       	jmp    80105918 <alltraps>

80106184 <vector101>:
.globl vector101
vector101:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $101
80106186:	6a 65                	push   $0x65
  jmp alltraps
80106188:	e9 8b f7 ff ff       	jmp    80105918 <alltraps>

8010618d <vector102>:
.globl vector102
vector102:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $102
8010618f:	6a 66                	push   $0x66
  jmp alltraps
80106191:	e9 82 f7 ff ff       	jmp    80105918 <alltraps>

80106196 <vector103>:
.globl vector103
vector103:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $103
80106198:	6a 67                	push   $0x67
  jmp alltraps
8010619a:	e9 79 f7 ff ff       	jmp    80105918 <alltraps>

8010619f <vector104>:
.globl vector104
vector104:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $104
801061a1:	6a 68                	push   $0x68
  jmp alltraps
801061a3:	e9 70 f7 ff ff       	jmp    80105918 <alltraps>

801061a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $105
801061aa:	6a 69                	push   $0x69
  jmp alltraps
801061ac:	e9 67 f7 ff ff       	jmp    80105918 <alltraps>

801061b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $106
801061b3:	6a 6a                	push   $0x6a
  jmp alltraps
801061b5:	e9 5e f7 ff ff       	jmp    80105918 <alltraps>

801061ba <vector107>:
.globl vector107
vector107:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $107
801061bc:	6a 6b                	push   $0x6b
  jmp alltraps
801061be:	e9 55 f7 ff ff       	jmp    80105918 <alltraps>

801061c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $108
801061c5:	6a 6c                	push   $0x6c
  jmp alltraps
801061c7:	e9 4c f7 ff ff       	jmp    80105918 <alltraps>

801061cc <vector109>:
.globl vector109
vector109:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $109
801061ce:	6a 6d                	push   $0x6d
  jmp alltraps
801061d0:	e9 43 f7 ff ff       	jmp    80105918 <alltraps>

801061d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $110
801061d7:	6a 6e                	push   $0x6e
  jmp alltraps
801061d9:	e9 3a f7 ff ff       	jmp    80105918 <alltraps>

801061de <vector111>:
.globl vector111
vector111:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $111
801061e0:	6a 6f                	push   $0x6f
  jmp alltraps
801061e2:	e9 31 f7 ff ff       	jmp    80105918 <alltraps>

801061e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $112
801061e9:	6a 70                	push   $0x70
  jmp alltraps
801061eb:	e9 28 f7 ff ff       	jmp    80105918 <alltraps>

801061f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $113
801061f2:	6a 71                	push   $0x71
  jmp alltraps
801061f4:	e9 1f f7 ff ff       	jmp    80105918 <alltraps>

801061f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $114
801061fb:	6a 72                	push   $0x72
  jmp alltraps
801061fd:	e9 16 f7 ff ff       	jmp    80105918 <alltraps>

80106202 <vector115>:
.globl vector115
vector115:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $115
80106204:	6a 73                	push   $0x73
  jmp alltraps
80106206:	e9 0d f7 ff ff       	jmp    80105918 <alltraps>

8010620b <vector116>:
.globl vector116
vector116:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $116
8010620d:	6a 74                	push   $0x74
  jmp alltraps
8010620f:	e9 04 f7 ff ff       	jmp    80105918 <alltraps>

80106214 <vector117>:
.globl vector117
vector117:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $117
80106216:	6a 75                	push   $0x75
  jmp alltraps
80106218:	e9 fb f6 ff ff       	jmp    80105918 <alltraps>

8010621d <vector118>:
.globl vector118
vector118:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $118
8010621f:	6a 76                	push   $0x76
  jmp alltraps
80106221:	e9 f2 f6 ff ff       	jmp    80105918 <alltraps>

80106226 <vector119>:
.globl vector119
vector119:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $119
80106228:	6a 77                	push   $0x77
  jmp alltraps
8010622a:	e9 e9 f6 ff ff       	jmp    80105918 <alltraps>

8010622f <vector120>:
.globl vector120
vector120:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $120
80106231:	6a 78                	push   $0x78
  jmp alltraps
80106233:	e9 e0 f6 ff ff       	jmp    80105918 <alltraps>

80106238 <vector121>:
.globl vector121
vector121:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $121
8010623a:	6a 79                	push   $0x79
  jmp alltraps
8010623c:	e9 d7 f6 ff ff       	jmp    80105918 <alltraps>

80106241 <vector122>:
.globl vector122
vector122:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $122
80106243:	6a 7a                	push   $0x7a
  jmp alltraps
80106245:	e9 ce f6 ff ff       	jmp    80105918 <alltraps>

8010624a <vector123>:
.globl vector123
vector123:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $123
8010624c:	6a 7b                	push   $0x7b
  jmp alltraps
8010624e:	e9 c5 f6 ff ff       	jmp    80105918 <alltraps>

80106253 <vector124>:
.globl vector124
vector124:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $124
80106255:	6a 7c                	push   $0x7c
  jmp alltraps
80106257:	e9 bc f6 ff ff       	jmp    80105918 <alltraps>

8010625c <vector125>:
.globl vector125
vector125:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $125
8010625e:	6a 7d                	push   $0x7d
  jmp alltraps
80106260:	e9 b3 f6 ff ff       	jmp    80105918 <alltraps>

80106265 <vector126>:
.globl vector126
vector126:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $126
80106267:	6a 7e                	push   $0x7e
  jmp alltraps
80106269:	e9 aa f6 ff ff       	jmp    80105918 <alltraps>

8010626e <vector127>:
.globl vector127
vector127:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $127
80106270:	6a 7f                	push   $0x7f
  jmp alltraps
80106272:	e9 a1 f6 ff ff       	jmp    80105918 <alltraps>

80106277 <vector128>:
.globl vector128
vector128:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $128
80106279:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010627e:	e9 95 f6 ff ff       	jmp    80105918 <alltraps>

80106283 <vector129>:
.globl vector129
vector129:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $129
80106285:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010628a:	e9 89 f6 ff ff       	jmp    80105918 <alltraps>

8010628f <vector130>:
.globl vector130
vector130:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $130
80106291:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106296:	e9 7d f6 ff ff       	jmp    80105918 <alltraps>

8010629b <vector131>:
.globl vector131
vector131:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $131
8010629d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062a2:	e9 71 f6 ff ff       	jmp    80105918 <alltraps>

801062a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $132
801062a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062ae:	e9 65 f6 ff ff       	jmp    80105918 <alltraps>

801062b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $133
801062b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062ba:	e9 59 f6 ff ff       	jmp    80105918 <alltraps>

801062bf <vector134>:
.globl vector134
vector134:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $134
801062c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062c6:	e9 4d f6 ff ff       	jmp    80105918 <alltraps>

801062cb <vector135>:
.globl vector135
vector135:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $135
801062cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062d2:	e9 41 f6 ff ff       	jmp    80105918 <alltraps>

801062d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $136
801062d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062de:	e9 35 f6 ff ff       	jmp    80105918 <alltraps>

801062e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $137
801062e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062ea:	e9 29 f6 ff ff       	jmp    80105918 <alltraps>

801062ef <vector138>:
.globl vector138
vector138:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $138
801062f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062f6:	e9 1d f6 ff ff       	jmp    80105918 <alltraps>

801062fb <vector139>:
.globl vector139
vector139:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $139
801062fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106302:	e9 11 f6 ff ff       	jmp    80105918 <alltraps>

80106307 <vector140>:
.globl vector140
vector140:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $140
80106309:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010630e:	e9 05 f6 ff ff       	jmp    80105918 <alltraps>

80106313 <vector141>:
.globl vector141
vector141:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $141
80106315:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010631a:	e9 f9 f5 ff ff       	jmp    80105918 <alltraps>

8010631f <vector142>:
.globl vector142
vector142:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $142
80106321:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106326:	e9 ed f5 ff ff       	jmp    80105918 <alltraps>

8010632b <vector143>:
.globl vector143
vector143:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $143
8010632d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106332:	e9 e1 f5 ff ff       	jmp    80105918 <alltraps>

80106337 <vector144>:
.globl vector144
vector144:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $144
80106339:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010633e:	e9 d5 f5 ff ff       	jmp    80105918 <alltraps>

80106343 <vector145>:
.globl vector145
vector145:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $145
80106345:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010634a:	e9 c9 f5 ff ff       	jmp    80105918 <alltraps>

8010634f <vector146>:
.globl vector146
vector146:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $146
80106351:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106356:	e9 bd f5 ff ff       	jmp    80105918 <alltraps>

8010635b <vector147>:
.globl vector147
vector147:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $147
8010635d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106362:	e9 b1 f5 ff ff       	jmp    80105918 <alltraps>

80106367 <vector148>:
.globl vector148
vector148:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $148
80106369:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010636e:	e9 a5 f5 ff ff       	jmp    80105918 <alltraps>

80106373 <vector149>:
.globl vector149
vector149:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $149
80106375:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010637a:	e9 99 f5 ff ff       	jmp    80105918 <alltraps>

8010637f <vector150>:
.globl vector150
vector150:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $150
80106381:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106386:	e9 8d f5 ff ff       	jmp    80105918 <alltraps>

8010638b <vector151>:
.globl vector151
vector151:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $151
8010638d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106392:	e9 81 f5 ff ff       	jmp    80105918 <alltraps>

80106397 <vector152>:
.globl vector152
vector152:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $152
80106399:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010639e:	e9 75 f5 ff ff       	jmp    80105918 <alltraps>

801063a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $153
801063a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063aa:	e9 69 f5 ff ff       	jmp    80105918 <alltraps>

801063af <vector154>:
.globl vector154
vector154:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $154
801063b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063b6:	e9 5d f5 ff ff       	jmp    80105918 <alltraps>

801063bb <vector155>:
.globl vector155
vector155:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $155
801063bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063c2:	e9 51 f5 ff ff       	jmp    80105918 <alltraps>

801063c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $156
801063c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063ce:	e9 45 f5 ff ff       	jmp    80105918 <alltraps>

801063d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $157
801063d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063da:	e9 39 f5 ff ff       	jmp    80105918 <alltraps>

801063df <vector158>:
.globl vector158
vector158:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $158
801063e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063e6:	e9 2d f5 ff ff       	jmp    80105918 <alltraps>

801063eb <vector159>:
.globl vector159
vector159:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $159
801063ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063f2:	e9 21 f5 ff ff       	jmp    80105918 <alltraps>

801063f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $160
801063f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063fe:	e9 15 f5 ff ff       	jmp    80105918 <alltraps>

80106403 <vector161>:
.globl vector161
vector161:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $161
80106405:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010640a:	e9 09 f5 ff ff       	jmp    80105918 <alltraps>

8010640f <vector162>:
.globl vector162
vector162:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $162
80106411:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106416:	e9 fd f4 ff ff       	jmp    80105918 <alltraps>

8010641b <vector163>:
.globl vector163
vector163:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $163
8010641d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106422:	e9 f1 f4 ff ff       	jmp    80105918 <alltraps>

80106427 <vector164>:
.globl vector164
vector164:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $164
80106429:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010642e:	e9 e5 f4 ff ff       	jmp    80105918 <alltraps>

80106433 <vector165>:
.globl vector165
vector165:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $165
80106435:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010643a:	e9 d9 f4 ff ff       	jmp    80105918 <alltraps>

8010643f <vector166>:
.globl vector166
vector166:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $166
80106441:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106446:	e9 cd f4 ff ff       	jmp    80105918 <alltraps>

8010644b <vector167>:
.globl vector167
vector167:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $167
8010644d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106452:	e9 c1 f4 ff ff       	jmp    80105918 <alltraps>

80106457 <vector168>:
.globl vector168
vector168:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $168
80106459:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010645e:	e9 b5 f4 ff ff       	jmp    80105918 <alltraps>

80106463 <vector169>:
.globl vector169
vector169:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $169
80106465:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010646a:	e9 a9 f4 ff ff       	jmp    80105918 <alltraps>

8010646f <vector170>:
.globl vector170
vector170:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $170
80106471:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106476:	e9 9d f4 ff ff       	jmp    80105918 <alltraps>

8010647b <vector171>:
.globl vector171
vector171:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $171
8010647d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106482:	e9 91 f4 ff ff       	jmp    80105918 <alltraps>

80106487 <vector172>:
.globl vector172
vector172:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $172
80106489:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010648e:	e9 85 f4 ff ff       	jmp    80105918 <alltraps>

80106493 <vector173>:
.globl vector173
vector173:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $173
80106495:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010649a:	e9 79 f4 ff ff       	jmp    80105918 <alltraps>

8010649f <vector174>:
.globl vector174
vector174:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $174
801064a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064a6:	e9 6d f4 ff ff       	jmp    80105918 <alltraps>

801064ab <vector175>:
.globl vector175
vector175:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $175
801064ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064b2:	e9 61 f4 ff ff       	jmp    80105918 <alltraps>

801064b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $176
801064b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064be:	e9 55 f4 ff ff       	jmp    80105918 <alltraps>

801064c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $177
801064c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ca:	e9 49 f4 ff ff       	jmp    80105918 <alltraps>

801064cf <vector178>:
.globl vector178
vector178:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $178
801064d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064d6:	e9 3d f4 ff ff       	jmp    80105918 <alltraps>

801064db <vector179>:
.globl vector179
vector179:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $179
801064dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064e2:	e9 31 f4 ff ff       	jmp    80105918 <alltraps>

801064e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $180
801064e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064ee:	e9 25 f4 ff ff       	jmp    80105918 <alltraps>

801064f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $181
801064f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064fa:	e9 19 f4 ff ff       	jmp    80105918 <alltraps>

801064ff <vector182>:
.globl vector182
vector182:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $182
80106501:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106506:	e9 0d f4 ff ff       	jmp    80105918 <alltraps>

8010650b <vector183>:
.globl vector183
vector183:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $183
8010650d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106512:	e9 01 f4 ff ff       	jmp    80105918 <alltraps>

80106517 <vector184>:
.globl vector184
vector184:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $184
80106519:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010651e:	e9 f5 f3 ff ff       	jmp    80105918 <alltraps>

80106523 <vector185>:
.globl vector185
vector185:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $185
80106525:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010652a:	e9 e9 f3 ff ff       	jmp    80105918 <alltraps>

8010652f <vector186>:
.globl vector186
vector186:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $186
80106531:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106536:	e9 dd f3 ff ff       	jmp    80105918 <alltraps>

8010653b <vector187>:
.globl vector187
vector187:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $187
8010653d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106542:	e9 d1 f3 ff ff       	jmp    80105918 <alltraps>

80106547 <vector188>:
.globl vector188
vector188:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $188
80106549:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010654e:	e9 c5 f3 ff ff       	jmp    80105918 <alltraps>

80106553 <vector189>:
.globl vector189
vector189:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $189
80106555:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010655a:	e9 b9 f3 ff ff       	jmp    80105918 <alltraps>

8010655f <vector190>:
.globl vector190
vector190:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $190
80106561:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106566:	e9 ad f3 ff ff       	jmp    80105918 <alltraps>

8010656b <vector191>:
.globl vector191
vector191:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $191
8010656d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106572:	e9 a1 f3 ff ff       	jmp    80105918 <alltraps>

80106577 <vector192>:
.globl vector192
vector192:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $192
80106579:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010657e:	e9 95 f3 ff ff       	jmp    80105918 <alltraps>

80106583 <vector193>:
.globl vector193
vector193:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $193
80106585:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010658a:	e9 89 f3 ff ff       	jmp    80105918 <alltraps>

8010658f <vector194>:
.globl vector194
vector194:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $194
80106591:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106596:	e9 7d f3 ff ff       	jmp    80105918 <alltraps>

8010659b <vector195>:
.globl vector195
vector195:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $195
8010659d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065a2:	e9 71 f3 ff ff       	jmp    80105918 <alltraps>

801065a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $196
801065a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065ae:	e9 65 f3 ff ff       	jmp    80105918 <alltraps>

801065b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $197
801065b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065ba:	e9 59 f3 ff ff       	jmp    80105918 <alltraps>

801065bf <vector198>:
.globl vector198
vector198:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $198
801065c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065c6:	e9 4d f3 ff ff       	jmp    80105918 <alltraps>

801065cb <vector199>:
.globl vector199
vector199:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $199
801065cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065d2:	e9 41 f3 ff ff       	jmp    80105918 <alltraps>

801065d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $200
801065d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065de:	e9 35 f3 ff ff       	jmp    80105918 <alltraps>

801065e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $201
801065e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065ea:	e9 29 f3 ff ff       	jmp    80105918 <alltraps>

801065ef <vector202>:
.globl vector202
vector202:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $202
801065f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065f6:	e9 1d f3 ff ff       	jmp    80105918 <alltraps>

801065fb <vector203>:
.globl vector203
vector203:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $203
801065fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106602:	e9 11 f3 ff ff       	jmp    80105918 <alltraps>

80106607 <vector204>:
.globl vector204
vector204:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $204
80106609:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010660e:	e9 05 f3 ff ff       	jmp    80105918 <alltraps>

80106613 <vector205>:
.globl vector205
vector205:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $205
80106615:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010661a:	e9 f9 f2 ff ff       	jmp    80105918 <alltraps>

8010661f <vector206>:
.globl vector206
vector206:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $206
80106621:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106626:	e9 ed f2 ff ff       	jmp    80105918 <alltraps>

8010662b <vector207>:
.globl vector207
vector207:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $207
8010662d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106632:	e9 e1 f2 ff ff       	jmp    80105918 <alltraps>

80106637 <vector208>:
.globl vector208
vector208:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $208
80106639:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010663e:	e9 d5 f2 ff ff       	jmp    80105918 <alltraps>

80106643 <vector209>:
.globl vector209
vector209:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $209
80106645:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010664a:	e9 c9 f2 ff ff       	jmp    80105918 <alltraps>

8010664f <vector210>:
.globl vector210
vector210:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $210
80106651:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106656:	e9 bd f2 ff ff       	jmp    80105918 <alltraps>

8010665b <vector211>:
.globl vector211
vector211:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $211
8010665d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106662:	e9 b1 f2 ff ff       	jmp    80105918 <alltraps>

80106667 <vector212>:
.globl vector212
vector212:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $212
80106669:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010666e:	e9 a5 f2 ff ff       	jmp    80105918 <alltraps>

80106673 <vector213>:
.globl vector213
vector213:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $213
80106675:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010667a:	e9 99 f2 ff ff       	jmp    80105918 <alltraps>

8010667f <vector214>:
.globl vector214
vector214:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $214
80106681:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106686:	e9 8d f2 ff ff       	jmp    80105918 <alltraps>

8010668b <vector215>:
.globl vector215
vector215:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $215
8010668d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106692:	e9 81 f2 ff ff       	jmp    80105918 <alltraps>

80106697 <vector216>:
.globl vector216
vector216:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $216
80106699:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010669e:	e9 75 f2 ff ff       	jmp    80105918 <alltraps>

801066a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $217
801066a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066aa:	e9 69 f2 ff ff       	jmp    80105918 <alltraps>

801066af <vector218>:
.globl vector218
vector218:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $218
801066b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066b6:	e9 5d f2 ff ff       	jmp    80105918 <alltraps>

801066bb <vector219>:
.globl vector219
vector219:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $219
801066bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066c2:	e9 51 f2 ff ff       	jmp    80105918 <alltraps>

801066c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $220
801066c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066ce:	e9 45 f2 ff ff       	jmp    80105918 <alltraps>

801066d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $221
801066d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066da:	e9 39 f2 ff ff       	jmp    80105918 <alltraps>

801066df <vector222>:
.globl vector222
vector222:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $222
801066e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066e6:	e9 2d f2 ff ff       	jmp    80105918 <alltraps>

801066eb <vector223>:
.globl vector223
vector223:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $223
801066ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066f2:	e9 21 f2 ff ff       	jmp    80105918 <alltraps>

801066f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $224
801066f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066fe:	e9 15 f2 ff ff       	jmp    80105918 <alltraps>

80106703 <vector225>:
.globl vector225
vector225:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $225
80106705:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010670a:	e9 09 f2 ff ff       	jmp    80105918 <alltraps>

8010670f <vector226>:
.globl vector226
vector226:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $226
80106711:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106716:	e9 fd f1 ff ff       	jmp    80105918 <alltraps>

8010671b <vector227>:
.globl vector227
vector227:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $227
8010671d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106722:	e9 f1 f1 ff ff       	jmp    80105918 <alltraps>

80106727 <vector228>:
.globl vector228
vector228:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $228
80106729:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010672e:	e9 e5 f1 ff ff       	jmp    80105918 <alltraps>

80106733 <vector229>:
.globl vector229
vector229:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $229
80106735:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010673a:	e9 d9 f1 ff ff       	jmp    80105918 <alltraps>

8010673f <vector230>:
.globl vector230
vector230:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $230
80106741:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106746:	e9 cd f1 ff ff       	jmp    80105918 <alltraps>

8010674b <vector231>:
.globl vector231
vector231:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $231
8010674d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106752:	e9 c1 f1 ff ff       	jmp    80105918 <alltraps>

80106757 <vector232>:
.globl vector232
vector232:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $232
80106759:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010675e:	e9 b5 f1 ff ff       	jmp    80105918 <alltraps>

80106763 <vector233>:
.globl vector233
vector233:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $233
80106765:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010676a:	e9 a9 f1 ff ff       	jmp    80105918 <alltraps>

8010676f <vector234>:
.globl vector234
vector234:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $234
80106771:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106776:	e9 9d f1 ff ff       	jmp    80105918 <alltraps>

8010677b <vector235>:
.globl vector235
vector235:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $235
8010677d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106782:	e9 91 f1 ff ff       	jmp    80105918 <alltraps>

80106787 <vector236>:
.globl vector236
vector236:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $236
80106789:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010678e:	e9 85 f1 ff ff       	jmp    80105918 <alltraps>

80106793 <vector237>:
.globl vector237
vector237:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $237
80106795:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010679a:	e9 79 f1 ff ff       	jmp    80105918 <alltraps>

8010679f <vector238>:
.globl vector238
vector238:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $238
801067a1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067a6:	e9 6d f1 ff ff       	jmp    80105918 <alltraps>

801067ab <vector239>:
.globl vector239
vector239:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $239
801067ad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067b2:	e9 61 f1 ff ff       	jmp    80105918 <alltraps>

801067b7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $240
801067b9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067be:	e9 55 f1 ff ff       	jmp    80105918 <alltraps>

801067c3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $241
801067c5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ca:	e9 49 f1 ff ff       	jmp    80105918 <alltraps>

801067cf <vector242>:
.globl vector242
vector242:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $242
801067d1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067d6:	e9 3d f1 ff ff       	jmp    80105918 <alltraps>

801067db <vector243>:
.globl vector243
vector243:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $243
801067dd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067e2:	e9 31 f1 ff ff       	jmp    80105918 <alltraps>

801067e7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $244
801067e9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067ee:	e9 25 f1 ff ff       	jmp    80105918 <alltraps>

801067f3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $245
801067f5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067fa:	e9 19 f1 ff ff       	jmp    80105918 <alltraps>

801067ff <vector246>:
.globl vector246
vector246:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $246
80106801:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106806:	e9 0d f1 ff ff       	jmp    80105918 <alltraps>

8010680b <vector247>:
.globl vector247
vector247:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $247
8010680d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106812:	e9 01 f1 ff ff       	jmp    80105918 <alltraps>

80106817 <vector248>:
.globl vector248
vector248:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $248
80106819:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010681e:	e9 f5 f0 ff ff       	jmp    80105918 <alltraps>

80106823 <vector249>:
.globl vector249
vector249:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $249
80106825:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010682a:	e9 e9 f0 ff ff       	jmp    80105918 <alltraps>

8010682f <vector250>:
.globl vector250
vector250:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $250
80106831:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106836:	e9 dd f0 ff ff       	jmp    80105918 <alltraps>

8010683b <vector251>:
.globl vector251
vector251:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $251
8010683d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106842:	e9 d1 f0 ff ff       	jmp    80105918 <alltraps>

80106847 <vector252>:
.globl vector252
vector252:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $252
80106849:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010684e:	e9 c5 f0 ff ff       	jmp    80105918 <alltraps>

80106853 <vector253>:
.globl vector253
vector253:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $253
80106855:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010685a:	e9 b9 f0 ff ff       	jmp    80105918 <alltraps>

8010685f <vector254>:
.globl vector254
vector254:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $254
80106861:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106866:	e9 ad f0 ff ff       	jmp    80105918 <alltraps>

8010686b <vector255>:
.globl vector255
vector255:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $255
8010686d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106872:	e9 a1 f0 ff ff       	jmp    80105918 <alltraps>
80106877:	66 90                	xchg   %ax,%ax
80106879:	66 90                	xchg   %ax,%ax
8010687b:	66 90                	xchg   %ax,%ax
8010687d:	66 90                	xchg   %ax,%ax
8010687f:	90                   	nop

80106880 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106886:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010688c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106892:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106895:	39 d3                	cmp    %edx,%ebx
80106897:	73 56                	jae    801068ef <deallocuvm.part.0+0x6f>
80106899:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010689c:	89 c6                	mov    %eax,%esi
8010689e:	89 d7                	mov    %edx,%edi
801068a0:	eb 12                	jmp    801068b4 <deallocuvm.part.0+0x34>
801068a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068a8:	83 c2 01             	add    $0x1,%edx
801068ab:	89 d3                	mov    %edx,%ebx
801068ad:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068b0:	39 fb                	cmp    %edi,%ebx
801068b2:	73 38                	jae    801068ec <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
801068b4:	89 da                	mov    %ebx,%edx
801068b6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801068b9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801068bc:	a8 01                	test   $0x1,%al
801068be:	74 e8                	je     801068a8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
801068c0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801068c7:	c1 e9 0a             	shr    $0xa,%ecx
801068ca:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801068d0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801068d7:	85 c0                	test   %eax,%eax
801068d9:	74 cd                	je     801068a8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
801068db:	8b 10                	mov    (%eax),%edx
801068dd:	f6 c2 01             	test   $0x1,%dl
801068e0:	75 1e                	jne    80106900 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
801068e2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068e8:	39 fb                	cmp    %edi,%ebx
801068ea:	72 c8                	jb     801068b4 <deallocuvm.part.0+0x34>
801068ec:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801068ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068f2:	89 c8                	mov    %ecx,%eax
801068f4:	5b                   	pop    %ebx
801068f5:	5e                   	pop    %esi
801068f6:	5f                   	pop    %edi
801068f7:	5d                   	pop    %ebp
801068f8:	c3                   	ret
801068f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106900:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106906:	74 26                	je     8010692e <deallocuvm.part.0+0xae>
      kfree(v);
80106908:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010690b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106911:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106914:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010691a:	52                   	push   %edx
8010691b:	e8 70 bb ff ff       	call   80102490 <kfree>
      *pte = 0;
80106920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106923:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106926:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010692c:	eb 82                	jmp    801068b0 <deallocuvm.part.0+0x30>
        panic("kfree");
8010692e:	83 ec 0c             	sub    $0xc,%esp
80106931:	68 0c 74 10 80       	push   $0x8010740c
80106936:	e8 45 9a ff ff       	call   80100380 <panic>
8010693b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106940 <mappages>:
{
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	57                   	push   %edi
80106944:	56                   	push   %esi
80106945:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106946:	89 d3                	mov    %edx,%ebx
80106948:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010694e:	83 ec 1c             	sub    $0x1c,%esp
80106951:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106954:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106958:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010695d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106960:	8b 45 08             	mov    0x8(%ebp),%eax
80106963:	29 d8                	sub    %ebx,%eax
80106965:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106968:	eb 3f                	jmp    801069a9 <mappages+0x69>
8010696a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106970:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106972:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106977:	c1 ea 0a             	shr    $0xa,%edx
8010697a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106980:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106987:	85 c0                	test   %eax,%eax
80106989:	74 75                	je     80106a00 <mappages+0xc0>
    if(*pte & PTE_P)
8010698b:	f6 00 01             	testb  $0x1,(%eax)
8010698e:	0f 85 86 00 00 00    	jne    80106a1a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106994:	0b 75 0c             	or     0xc(%ebp),%esi
80106997:	83 ce 01             	or     $0x1,%esi
8010699a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010699c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010699f:	39 c3                	cmp    %eax,%ebx
801069a1:	74 6d                	je     80106a10 <mappages+0xd0>
    a += PGSIZE;
801069a3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801069a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801069ac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801069af:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801069b2:	89 d8                	mov    %ebx,%eax
801069b4:	c1 e8 16             	shr    $0x16,%eax
801069b7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801069ba:	8b 07                	mov    (%edi),%eax
801069bc:	a8 01                	test   $0x1,%al
801069be:	75 b0                	jne    80106970 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069c0:	e8 8b bc ff ff       	call   80102650 <kalloc>
801069c5:	85 c0                	test   %eax,%eax
801069c7:	74 37                	je     80106a00 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801069c9:	83 ec 04             	sub    $0x4,%esp
801069cc:	68 00 10 00 00       	push   $0x1000
801069d1:	6a 00                	push   $0x0
801069d3:	50                   	push   %eax
801069d4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801069d7:	e8 34 dd ff ff       	call   80104710 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069dc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801069df:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069e2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801069e8:	83 c8 07             	or     $0x7,%eax
801069eb:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801069ed:	89 d8                	mov    %ebx,%eax
801069ef:	c1 e8 0a             	shr    $0xa,%eax
801069f2:	25 fc 0f 00 00       	and    $0xffc,%eax
801069f7:	01 d0                	add    %edx,%eax
801069f9:	eb 90                	jmp    8010698b <mappages+0x4b>
801069fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a08:	5b                   	pop    %ebx
80106a09:	5e                   	pop    %esi
80106a0a:	5f                   	pop    %edi
80106a0b:	5d                   	pop    %ebp
80106a0c:	c3                   	ret
80106a0d:	8d 76 00             	lea    0x0(%esi),%esi
80106a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a13:	31 c0                	xor    %eax,%eax
}
80106a15:	5b                   	pop    %ebx
80106a16:	5e                   	pop    %esi
80106a17:	5f                   	pop    %edi
80106a18:	5d                   	pop    %ebp
80106a19:	c3                   	ret
      panic("remap");
80106a1a:	83 ec 0c             	sub    $0xc,%esp
80106a1d:	68 5c 76 10 80       	push   $0x8010765c
80106a22:	e8 59 99 ff ff       	call   80100380 <panic>
80106a27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106a2e:	00 
80106a2f:	90                   	nop

80106a30 <seginit>:
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a36:	e8 25 cf ff ff       	call   80103960 <cpuid>
  pd[0] = size-1;
80106a3b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a40:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a46:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106a4a:	c7 80 38 34 11 80 ff 	movl   $0xffff,-0x7feecbc8(%eax)
80106a51:	ff 00 00 
80106a54:	c7 80 3c 34 11 80 00 	movl   $0xcf9a00,-0x7feecbc4(%eax)
80106a5b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a5e:	c7 80 40 34 11 80 ff 	movl   $0xffff,-0x7feecbc0(%eax)
80106a65:	ff 00 00 
80106a68:	c7 80 44 34 11 80 00 	movl   $0xcf9200,-0x7feecbbc(%eax)
80106a6f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a72:	c7 80 48 34 11 80 ff 	movl   $0xffff,-0x7feecbb8(%eax)
80106a79:	ff 00 00 
80106a7c:	c7 80 4c 34 11 80 00 	movl   $0xcffa00,-0x7feecbb4(%eax)
80106a83:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a86:	c7 80 50 34 11 80 ff 	movl   $0xffff,-0x7feecbb0(%eax)
80106a8d:	ff 00 00 
80106a90:	c7 80 54 34 11 80 00 	movl   $0xcff200,-0x7feecbac(%eax)
80106a97:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a9a:	05 30 34 11 80       	add    $0x80113430,%eax
  pd[1] = (uint)p;
80106a9f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106aa3:	c1 e8 10             	shr    $0x10,%eax
80106aa6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106aaa:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106aad:	0f 01 10             	lgdtl  (%eax)
}
80106ab0:	c9                   	leave
80106ab1:	c3                   	ret
80106ab2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ab9:	00 
80106aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ac0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ac0:	a1 e4 60 11 80       	mov    0x801160e4,%eax
80106ac5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106aca:	0f 22 d8             	mov    %eax,%cr3
}
80106acd:	c3                   	ret
80106ace:	66 90                	xchg   %ax,%ax

80106ad0 <switchuvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106adc:	85 f6                	test   %esi,%esi
80106ade:	0f 84 cb 00 00 00    	je     80106baf <switchuvm+0xdf>
  if(p->kstack == 0)
80106ae4:	8b 46 08             	mov    0x8(%esi),%eax
80106ae7:	85 c0                	test   %eax,%eax
80106ae9:	0f 84 da 00 00 00    	je     80106bc9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106aef:	8b 46 04             	mov    0x4(%esi),%eax
80106af2:	85 c0                	test   %eax,%eax
80106af4:	0f 84 c2 00 00 00    	je     80106bbc <switchuvm+0xec>
  pushcli();
80106afa:	e8 c1 d9 ff ff       	call   801044c0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106aff:	e8 fc cd ff ff       	call   80103900 <mycpu>
80106b04:	89 c3                	mov    %eax,%ebx
80106b06:	e8 f5 cd ff ff       	call   80103900 <mycpu>
80106b0b:	89 c7                	mov    %eax,%edi
80106b0d:	e8 ee cd ff ff       	call   80103900 <mycpu>
80106b12:	83 c7 08             	add    $0x8,%edi
80106b15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b18:	e8 e3 cd ff ff       	call   80103900 <mycpu>
80106b1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b20:	ba 67 00 00 00       	mov    $0x67,%edx
80106b25:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b2c:	83 c0 08             	add    $0x8,%eax
80106b2f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b36:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b3b:	83 c1 08             	add    $0x8,%ecx
80106b3e:	c1 e8 18             	shr    $0x18,%eax
80106b41:	c1 e9 10             	shr    $0x10,%ecx
80106b44:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106b4a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106b50:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b55:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b5c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106b61:	e8 9a cd ff ff       	call   80103900 <mycpu>
80106b66:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b6d:	e8 8e cd ff ff       	call   80103900 <mycpu>
80106b72:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b76:	8b 5e 08             	mov    0x8(%esi),%ebx
80106b79:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b7f:	e8 7c cd ff ff       	call   80103900 <mycpu>
80106b84:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b87:	e8 74 cd ff ff       	call   80103900 <mycpu>
80106b8c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b90:	b8 28 00 00 00       	mov    $0x28,%eax
80106b95:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b98:	8b 46 04             	mov    0x4(%esi),%eax
80106b9b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ba0:	0f 22 d8             	mov    %eax,%cr3
}
80106ba3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ba6:	5b                   	pop    %ebx
80106ba7:	5e                   	pop    %esi
80106ba8:	5f                   	pop    %edi
80106ba9:	5d                   	pop    %ebp
  popcli();
80106baa:	e9 61 d9 ff ff       	jmp    80104510 <popcli>
    panic("switchuvm: no process");
80106baf:	83 ec 0c             	sub    $0xc,%esp
80106bb2:	68 62 76 10 80       	push   $0x80107662
80106bb7:	e8 c4 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106bbc:	83 ec 0c             	sub    $0xc,%esp
80106bbf:	68 8d 76 10 80       	push   $0x8010768d
80106bc4:	e8 b7 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106bc9:	83 ec 0c             	sub    $0xc,%esp
80106bcc:	68 78 76 10 80       	push   $0x80107678
80106bd1:	e8 aa 97 ff ff       	call   80100380 <panic>
80106bd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bdd:	00 
80106bde:	66 90                	xchg   %ax,%ax

80106be0 <inituvm>:
{
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 1c             	sub    $0x1c,%esp
80106be9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bec:	8b 75 10             	mov    0x10(%ebp),%esi
80106bef:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106bf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106bf5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bfb:	77 49                	ja     80106c46 <inituvm+0x66>
  mem = kalloc();
80106bfd:	e8 4e ba ff ff       	call   80102650 <kalloc>
  memset(mem, 0, PGSIZE);
80106c02:	83 ec 04             	sub    $0x4,%esp
80106c05:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106c0a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c0c:	6a 00                	push   $0x0
80106c0e:	50                   	push   %eax
80106c0f:	e8 fc da ff ff       	call   80104710 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c14:	58                   	pop    %eax
80106c15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c1b:	5a                   	pop    %edx
80106c1c:	6a 06                	push   $0x6
80106c1e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c23:	31 d2                	xor    %edx,%edx
80106c25:	50                   	push   %eax
80106c26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c29:	e8 12 fd ff ff       	call   80106940 <mappages>
  memmove(mem, init, sz);
80106c2e:	83 c4 10             	add    $0x10,%esp
80106c31:	89 75 10             	mov    %esi,0x10(%ebp)
80106c34:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c37:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c3d:	5b                   	pop    %ebx
80106c3e:	5e                   	pop    %esi
80106c3f:	5f                   	pop    %edi
80106c40:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106c41:	e9 5a db ff ff       	jmp    801047a0 <memmove>
    panic("inituvm: more than a page");
80106c46:	83 ec 0c             	sub    $0xc,%esp
80106c49:	68 a1 76 10 80       	push   $0x801076a1
80106c4e:	e8 2d 97 ff ff       	call   80100380 <panic>
80106c53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c5a:	00 
80106c5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106c60 <loaduvm>:
{
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	53                   	push   %ebx
80106c66:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106c69:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106c6c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106c6f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106c75:	0f 85 a2 00 00 00    	jne    80106d1d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106c7b:	85 ff                	test   %edi,%edi
80106c7d:	74 7d                	je     80106cfc <loaduvm+0x9c>
80106c7f:	90                   	nop
  pde = &pgdir[PDX(va)];
80106c80:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106c83:	8b 55 08             	mov    0x8(%ebp),%edx
80106c86:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106c88:	89 c1                	mov    %eax,%ecx
80106c8a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106c8d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106c90:	f6 c1 01             	test   $0x1,%cl
80106c93:	75 13                	jne    80106ca8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106c95:	83 ec 0c             	sub    $0xc,%esp
80106c98:	68 bb 76 10 80       	push   $0x801076bb
80106c9d:	e8 de 96 ff ff       	call   80100380 <panic>
80106ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106ca8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106cab:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106cb1:	25 fc 0f 00 00       	and    $0xffc,%eax
80106cb6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106cbd:	85 c9                	test   %ecx,%ecx
80106cbf:	74 d4                	je     80106c95 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106cc1:	89 fb                	mov    %edi,%ebx
80106cc3:	b8 00 10 00 00       	mov    $0x1000,%eax
80106cc8:	29 f3                	sub    %esi,%ebx
80106cca:	39 c3                	cmp    %eax,%ebx
80106ccc:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ccf:	53                   	push   %ebx
80106cd0:	8b 45 14             	mov    0x14(%ebp),%eax
80106cd3:	01 f0                	add    %esi,%eax
80106cd5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106cd6:	8b 01                	mov    (%ecx),%eax
80106cd8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cdd:	05 00 00 00 80       	add    $0x80000000,%eax
80106ce2:	50                   	push   %eax
80106ce3:	ff 75 10             	push   0x10(%ebp)
80106ce6:	e8 b5 ad ff ff       	call   80101aa0 <readi>
80106ceb:	83 c4 10             	add    $0x10,%esp
80106cee:	39 d8                	cmp    %ebx,%eax
80106cf0:	75 1e                	jne    80106d10 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106cf2:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106cf8:	39 fe                	cmp    %edi,%esi
80106cfa:	72 84                	jb     80106c80 <loaduvm+0x20>
}
80106cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cff:	31 c0                	xor    %eax,%eax
}
80106d01:	5b                   	pop    %ebx
80106d02:	5e                   	pop    %esi
80106d03:	5f                   	pop    %edi
80106d04:	5d                   	pop    %ebp
80106d05:	c3                   	ret
80106d06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d0d:	00 
80106d0e:	66 90                	xchg   %ax,%ax
80106d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d18:	5b                   	pop    %ebx
80106d19:	5e                   	pop    %esi
80106d1a:	5f                   	pop    %edi
80106d1b:	5d                   	pop    %ebp
80106d1c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106d1d:	83 ec 0c             	sub    $0xc,%esp
80106d20:	68 54 79 10 80       	push   $0x80107954
80106d25:	e8 56 96 ff ff       	call   80100380 <panic>
80106d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d30 <allocuvm>:
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	83 ec 1c             	sub    $0x1c,%esp
80106d39:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106d3c:	85 f6                	test   %esi,%esi
80106d3e:	0f 88 98 00 00 00    	js     80106ddc <allocuvm+0xac>
80106d44:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106d46:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106d49:	0f 82 a1 00 00 00    	jb     80106df0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d52:	05 ff 0f 00 00       	add    $0xfff,%eax
80106d57:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d5c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106d5e:	39 f0                	cmp    %esi,%eax
80106d60:	0f 83 8d 00 00 00    	jae    80106df3 <allocuvm+0xc3>
80106d66:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106d69:	eb 44                	jmp    80106daf <allocuvm+0x7f>
80106d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106d70:	83 ec 04             	sub    $0x4,%esp
80106d73:	68 00 10 00 00       	push   $0x1000
80106d78:	6a 00                	push   $0x0
80106d7a:	50                   	push   %eax
80106d7b:	e8 90 d9 ff ff       	call   80104710 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d80:	58                   	pop    %eax
80106d81:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d87:	5a                   	pop    %edx
80106d88:	6a 06                	push   $0x6
80106d8a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d8f:	89 fa                	mov    %edi,%edx
80106d91:	50                   	push   %eax
80106d92:	8b 45 08             	mov    0x8(%ebp),%eax
80106d95:	e8 a6 fb ff ff       	call   80106940 <mappages>
80106d9a:	83 c4 10             	add    $0x10,%esp
80106d9d:	85 c0                	test   %eax,%eax
80106d9f:	78 5f                	js     80106e00 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106da1:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106da7:	39 f7                	cmp    %esi,%edi
80106da9:	0f 83 89 00 00 00    	jae    80106e38 <allocuvm+0x108>
    mem = kalloc();
80106daf:	e8 9c b8 ff ff       	call   80102650 <kalloc>
80106db4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106db6:	85 c0                	test   %eax,%eax
80106db8:	75 b6                	jne    80106d70 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106dba:	83 ec 0c             	sub    $0xc,%esp
80106dbd:	68 d9 76 10 80       	push   $0x801076d9
80106dc2:	e8 e9 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106dc7:	83 c4 10             	add    $0x10,%esp
80106dca:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106dcd:	74 0d                	je     80106ddc <allocuvm+0xac>
80106dcf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dd2:	8b 45 08             	mov    0x8(%ebp),%eax
80106dd5:	89 f2                	mov    %esi,%edx
80106dd7:	e8 a4 fa ff ff       	call   80106880 <deallocuvm.part.0>
    return 0;
80106ddc:	31 d2                	xor    %edx,%edx
}
80106dde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de1:	89 d0                	mov    %edx,%eax
80106de3:	5b                   	pop    %ebx
80106de4:	5e                   	pop    %esi
80106de5:	5f                   	pop    %edi
80106de6:	5d                   	pop    %ebp
80106de7:	c3                   	ret
80106de8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106def:	00 
    return oldsz;
80106df0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106df3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df6:	89 d0                	mov    %edx,%eax
80106df8:	5b                   	pop    %ebx
80106df9:	5e                   	pop    %esi
80106dfa:	5f                   	pop    %edi
80106dfb:	5d                   	pop    %ebp
80106dfc:	c3                   	ret
80106dfd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106e00:	83 ec 0c             	sub    $0xc,%esp
80106e03:	68 f1 76 10 80       	push   $0x801076f1
80106e08:	e8 a3 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106e0d:	83 c4 10             	add    $0x10,%esp
80106e10:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e13:	74 0d                	je     80106e22 <allocuvm+0xf2>
80106e15:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e18:	8b 45 08             	mov    0x8(%ebp),%eax
80106e1b:	89 f2                	mov    %esi,%edx
80106e1d:	e8 5e fa ff ff       	call   80106880 <deallocuvm.part.0>
      kfree(mem);
80106e22:	83 ec 0c             	sub    $0xc,%esp
80106e25:	53                   	push   %ebx
80106e26:	e8 65 b6 ff ff       	call   80102490 <kfree>
      return 0;
80106e2b:	83 c4 10             	add    $0x10,%esp
    return 0;
80106e2e:	31 d2                	xor    %edx,%edx
80106e30:	eb ac                	jmp    80106dde <allocuvm+0xae>
80106e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e38:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106e3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e3e:	5b                   	pop    %ebx
80106e3f:	5e                   	pop    %esi
80106e40:	89 d0                	mov    %edx,%eax
80106e42:	5f                   	pop    %edi
80106e43:	5d                   	pop    %ebp
80106e44:	c3                   	ret
80106e45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e4c:	00 
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi

80106e50 <deallocuvm>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e59:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e5c:	39 d1                	cmp    %edx,%ecx
80106e5e:	73 10                	jae    80106e70 <deallocuvm+0x20>
}
80106e60:	5d                   	pop    %ebp
80106e61:	e9 1a fa ff ff       	jmp    80106880 <deallocuvm.part.0>
80106e66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e6d:	00 
80106e6e:	66 90                	xchg   %ax,%ax
80106e70:	89 d0                	mov    %edx,%eax
80106e72:	5d                   	pop    %ebp
80106e73:	c3                   	ret
80106e74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e7b:	00 
80106e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 0c             	sub    $0xc,%esp
80106e89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e8c:	85 f6                	test   %esi,%esi
80106e8e:	74 59                	je     80106ee9 <freevm+0x69>
  if(newsz >= oldsz)
80106e90:	31 c9                	xor    %ecx,%ecx
80106e92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e97:	89 f0                	mov    %esi,%eax
80106e99:	89 f3                	mov    %esi,%ebx
80106e9b:	e8 e0 f9 ff ff       	call   80106880 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106ea0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ea6:	eb 0f                	jmp    80106eb7 <freevm+0x37>
80106ea8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eaf:	00 
80106eb0:	83 c3 04             	add    $0x4,%ebx
80106eb3:	39 fb                	cmp    %edi,%ebx
80106eb5:	74 23                	je     80106eda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106eb7:	8b 03                	mov    (%ebx),%eax
80106eb9:	a8 01                	test   $0x1,%al
80106ebb:	74 f3                	je     80106eb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ebd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106ec2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ec5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ec8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ecd:	50                   	push   %eax
80106ece:	e8 bd b5 ff ff       	call   80102490 <kfree>
80106ed3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ed6:	39 fb                	cmp    %edi,%ebx
80106ed8:	75 dd                	jne    80106eb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106eda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ee0:	5b                   	pop    %ebx
80106ee1:	5e                   	pop    %esi
80106ee2:	5f                   	pop    %edi
80106ee3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106ee4:	e9 a7 b5 ff ff       	jmp    80102490 <kfree>
    panic("freevm: no pgdir");
80106ee9:	83 ec 0c             	sub    $0xc,%esp
80106eec:	68 0d 77 10 80       	push   $0x8010770d
80106ef1:	e8 8a 94 ff ff       	call   80100380 <panic>
80106ef6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106efd:	00 
80106efe:	66 90                	xchg   %ax,%ax

80106f00 <setupkvm>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	56                   	push   %esi
80106f04:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f05:	e8 46 b7 ff ff       	call   80102650 <kalloc>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	74 5e                	je     80106f6c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80106f0e:	83 ec 04             	sub    $0x4,%esp
80106f11:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f13:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f18:	68 00 10 00 00       	push   $0x1000
80106f1d:	6a 00                	push   $0x0
80106f1f:	50                   	push   %eax
80106f20:	e8 eb d7 ff ff       	call   80104710 <memset>
80106f25:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f28:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f2b:	83 ec 08             	sub    $0x8,%esp
80106f2e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f31:	8b 13                	mov    (%ebx),%edx
80106f33:	ff 73 0c             	push   0xc(%ebx)
80106f36:	50                   	push   %eax
80106f37:	29 c1                	sub    %eax,%ecx
80106f39:	89 f0                	mov    %esi,%eax
80106f3b:	e8 00 fa ff ff       	call   80106940 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 19                	js     80106f60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f47:	83 c3 10             	add    $0x10,%ebx
80106f4a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f50:	75 d6                	jne    80106f28 <setupkvm+0x28>
}
80106f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f55:	89 f0                	mov    %esi,%eax
80106f57:	5b                   	pop    %ebx
80106f58:	5e                   	pop    %esi
80106f59:	5d                   	pop    %ebp
80106f5a:	c3                   	ret
80106f5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	56                   	push   %esi
80106f64:	e8 17 ff ff ff       	call   80106e80 <freevm>
      return 0;
80106f69:	83 c4 10             	add    $0x10,%esp
}
80106f6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106f6f:	31 f6                	xor    %esi,%esi
}
80106f71:	89 f0                	mov    %esi,%eax
80106f73:	5b                   	pop    %ebx
80106f74:	5e                   	pop    %esi
80106f75:	5d                   	pop    %ebp
80106f76:	c3                   	ret
80106f77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f7e:	00 
80106f7f:	90                   	nop

80106f80 <kvmalloc>:
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f86:	e8 75 ff ff ff       	call   80106f00 <setupkvm>
80106f8b:	a3 e4 60 11 80       	mov    %eax,0x801160e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f90:	05 00 00 00 80       	add    $0x80000000,%eax
80106f95:	0f 22 d8             	mov    %eax,%cr3
}
80106f98:	c9                   	leave
80106f99:	c3                   	ret
80106f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fa0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	83 ec 08             	sub    $0x8,%esp
80106fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106fa9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80106fac:	89 c1                	mov    %eax,%ecx
80106fae:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106fb1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80106fb4:	f6 c2 01             	test   $0x1,%dl
80106fb7:	75 17                	jne    80106fd0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106fb9:	83 ec 0c             	sub    $0xc,%esp
80106fbc:	68 1e 77 10 80       	push   $0x8010771e
80106fc1:	e8 ba 93 ff ff       	call   80100380 <panic>
80106fc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fcd:	00 
80106fce:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80106fd0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fd3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106fd9:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fde:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80106fe5:	85 c0                	test   %eax,%eax
80106fe7:	74 d0                	je     80106fb9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80106fe9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106fec:	c9                   	leave
80106fed:	c3                   	ret
80106fee:	66 90                	xchg   %ax,%ax

80106ff0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ff9:	e8 02 ff ff ff       	call   80106f00 <setupkvm>
80106ffe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107001:	85 c0                	test   %eax,%eax
80107003:	0f 84 e9 00 00 00    	je     801070f2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107009:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010700c:	85 c9                	test   %ecx,%ecx
8010700e:	0f 84 b2 00 00 00    	je     801070c6 <copyuvm+0xd6>
80107014:	31 f6                	xor    %esi,%esi
80107016:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010701d:	00 
8010701e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107020:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107023:	89 f0                	mov    %esi,%eax
80107025:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107028:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010702b:	a8 01                	test   $0x1,%al
8010702d:	75 11                	jne    80107040 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010702f:	83 ec 0c             	sub    $0xc,%esp
80107032:	68 28 77 10 80       	push   $0x80107728
80107037:	e8 44 93 ff ff       	call   80100380 <panic>
8010703c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107040:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107042:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107047:	c1 ea 0a             	shr    $0xa,%edx
8010704a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107050:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107057:	85 c0                	test   %eax,%eax
80107059:	74 d4                	je     8010702f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010705b:	8b 00                	mov    (%eax),%eax
8010705d:	a8 01                	test   $0x1,%al
8010705f:	0f 84 9f 00 00 00    	je     80107104 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107065:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107067:	25 ff 0f 00 00       	and    $0xfff,%eax
8010706c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010706f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107075:	e8 d6 b5 ff ff       	call   80102650 <kalloc>
8010707a:	89 c3                	mov    %eax,%ebx
8010707c:	85 c0                	test   %eax,%eax
8010707e:	74 64                	je     801070e4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107080:	83 ec 04             	sub    $0x4,%esp
80107083:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107089:	68 00 10 00 00       	push   $0x1000
8010708e:	57                   	push   %edi
8010708f:	50                   	push   %eax
80107090:	e8 0b d7 ff ff       	call   801047a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107095:	58                   	pop    %eax
80107096:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010709c:	5a                   	pop    %edx
8010709d:	ff 75 e4             	push   -0x1c(%ebp)
801070a0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070a5:	89 f2                	mov    %esi,%edx
801070a7:	50                   	push   %eax
801070a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070ab:	e8 90 f8 ff ff       	call   80106940 <mappages>
801070b0:	83 c4 10             	add    $0x10,%esp
801070b3:	85 c0                	test   %eax,%eax
801070b5:	78 21                	js     801070d8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801070b7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070bd:	3b 75 0c             	cmp    0xc(%ebp),%esi
801070c0:	0f 82 5a ff ff ff    	jb     80107020 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801070c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070cc:	5b                   	pop    %ebx
801070cd:	5e                   	pop    %esi
801070ce:	5f                   	pop    %edi
801070cf:	5d                   	pop    %ebp
801070d0:	c3                   	ret
801070d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801070d8:	83 ec 0c             	sub    $0xc,%esp
801070db:	53                   	push   %ebx
801070dc:	e8 af b3 ff ff       	call   80102490 <kfree>
      goto bad;
801070e1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801070e4:	83 ec 0c             	sub    $0xc,%esp
801070e7:	ff 75 e0             	push   -0x20(%ebp)
801070ea:	e8 91 fd ff ff       	call   80106e80 <freevm>
  return 0;
801070ef:	83 c4 10             	add    $0x10,%esp
    return 0;
801070f2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801070f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070ff:	5b                   	pop    %ebx
80107100:	5e                   	pop    %esi
80107101:	5f                   	pop    %edi
80107102:	5d                   	pop    %ebp
80107103:	c3                   	ret
      panic("copyuvm: page not present");
80107104:	83 ec 0c             	sub    $0xc,%esp
80107107:	68 42 77 10 80       	push   $0x80107742
8010710c:	e8 6f 92 ff ff       	call   80100380 <panic>
80107111:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107118:	00 
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107120 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107126:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107129:	89 c1                	mov    %eax,%ecx
8010712b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010712e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107131:	f6 c2 01             	test   $0x1,%dl
80107134:	0f 84 f8 00 00 00    	je     80107232 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010713a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010713d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107143:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107144:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107149:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107150:	89 d0                	mov    %edx,%eax
80107152:	f7 d2                	not    %edx
80107154:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107159:	05 00 00 00 80       	add    $0x80000000,%eax
8010715e:	83 e2 05             	and    $0x5,%edx
80107161:	ba 00 00 00 00       	mov    $0x0,%edx
80107166:	0f 45 c2             	cmovne %edx,%eax
}
80107169:	c3                   	ret
8010716a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107170 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 0c             	sub    $0xc,%esp
80107179:	8b 75 14             	mov    0x14(%ebp),%esi
8010717c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010717f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107182:	85 f6                	test   %esi,%esi
80107184:	75 51                	jne    801071d7 <copyout+0x67>
80107186:	e9 9d 00 00 00       	jmp    80107228 <copyout+0xb8>
8010718b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107190:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107196:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010719c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801071a2:	74 74                	je     80107218 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
801071a4:	89 fb                	mov    %edi,%ebx
801071a6:	29 c3                	sub    %eax,%ebx
801071a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801071ae:	39 f3                	cmp    %esi,%ebx
801071b0:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071b3:	29 f8                	sub    %edi,%eax
801071b5:	83 ec 04             	sub    $0x4,%esp
801071b8:	01 c1                	add    %eax,%ecx
801071ba:	53                   	push   %ebx
801071bb:	52                   	push   %edx
801071bc:	89 55 10             	mov    %edx,0x10(%ebp)
801071bf:	51                   	push   %ecx
801071c0:	e8 db d5 ff ff       	call   801047a0 <memmove>
    len -= n;
    buf += n;
801071c5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801071c8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801071ce:	83 c4 10             	add    $0x10,%esp
    buf += n;
801071d1:	01 da                	add    %ebx,%edx
  while(len > 0){
801071d3:	29 de                	sub    %ebx,%esi
801071d5:	74 51                	je     80107228 <copyout+0xb8>
  if(*pde & PTE_P){
801071d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801071da:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801071dc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801071de:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801071e1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801071e7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801071ea:	f6 c1 01             	test   $0x1,%cl
801071ed:	0f 84 46 00 00 00    	je     80107239 <copyout.cold>
  return &pgtab[PTX(va)];
801071f3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071f5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801071fb:	c1 eb 0c             	shr    $0xc,%ebx
801071fe:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107204:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010720b:	89 d9                	mov    %ebx,%ecx
8010720d:	f7 d1                	not    %ecx
8010720f:	83 e1 05             	and    $0x5,%ecx
80107212:	0f 84 78 ff ff ff    	je     80107190 <copyout+0x20>
  }
  return 0;
}
80107218:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010721b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107220:	5b                   	pop    %ebx
80107221:	5e                   	pop    %esi
80107222:	5f                   	pop    %edi
80107223:	5d                   	pop    %ebp
80107224:	c3                   	ret
80107225:	8d 76 00             	lea    0x0(%esi),%esi
80107228:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010722b:	31 c0                	xor    %eax,%eax
}
8010722d:	5b                   	pop    %ebx
8010722e:	5e                   	pop    %esi
8010722f:	5f                   	pop    %edi
80107230:	5d                   	pop    %ebp
80107231:	c3                   	ret

80107232 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107232:	a1 00 00 00 00       	mov    0x0,%eax
80107237:	0f 0b                	ud2

80107239 <copyout.cold>:
80107239:	a1 00 00 00 00       	mov    0x0,%eax
8010723e:	0f 0b                	ud2
