###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  11:34:41 #
# Command line: --target SNES -O2 --speed --code-model small --data-model     #
#               small bench.c -o bench.o --list-file bench.lst                #
#                                                                             #
###############################################################################

    \ 000000                      .rtmodel version,"1"
    \ 000000                      .rtmodel codeModel,"small"
    \ 000000                      .rtmodel dataModel,"small"
    \ 000000                      .rtmodel core,"65816"
    \ 000000                      .rtmodel huge,"0"
    \ 000000                      .rtmodel target,"snes"
    \ 000000                      .rtmodel ppu,"1"
    \ 000000                      .extern _Dp
    \ 000000                      .extern _Vfp
0001                  /* Breadth-first search over a 32x32 tile map, as in enemy pathfinding: a
0002                   * distance map from one start cell, with a 256-entry ring-buffer queue.
0003                   * Returns the sum of distances over the cells reached. */
0004                  #define W 32
0005                  #define QN 256
0006
0007                  unsigned char grid[W * W];     /* 0 = floor, 1 = wall; the border is wall */
    \ 000000                      .section zdata,bss
    \ 000000                      .public grid
    \ 000000          grid:       .space  0x400
0008                  unsigned char dist[W * W];     /* 0xFF = not reached */
    \ 000000                      .section zdata,bss
    \ 000000                      .public dist
    \ 000000          dist:       .space  0x400
0009                  unsigned int queue[QN];
    \ 000000                      .section zdata,bss
    \ 000000                      .public queue
    \ 000000          queue:      .space  0x200
0010                  unsigned int start, tail;
    \ 000000                      .section zdata,bss
    \ 000000                      .public start
    \ 000000          start:      .space  2
    \ 000000                      .section zdata,bss
    \ 000000                      .public tail
    \ 000000          tail:       .space  2
0011
0012                  void bench_init(void)
0013                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000 5a       bench_init: phy
    \ 000001 5a                   phy
    \ 000002 5a                   phy
0014                      unsigned int i, x, y, v = 1;
    \ 000003 a00100               ldy     ##1
0015                      for (i = 0; i < W * W; i++) {
    \ 000006 a20000               ldx     ##0
    \ 000009 e00004   `?L5`:      cpx     ##0x400
    \ 00000c 9011                 bcc     `?L4`
0016                          v = (v << 2) + v + 0x3619;
0017                          x = i & (W - 1);
0018                          y = i >> 5;
0019                          if (x == 0 || x == W - 1 || y == 0 || y == W - 1 || ((v >> 8) & 3) == 0)
0020                              grid[i] = 1;
0021                          else
0022                              grid[i] = 0;
0023                      }
0024                      start = W + 1;
    \ 00000e a22100               ldx     ##33
    \ 000011 8e....               stx     start
0025                      grid[start] = 0;
    \ 000014 e220                 sep     #32
    \ 000016 9e....               stz     grid,x
    \ 000019 c220                 rep     #32
0026                  }
    \ 00001b 7a                   ply
    \ 00001c 7a                   ply
    \ 00001d 7a                   ply
    \ 00001e 60                   rts
    \ 00001f 98       `?L4`:      tya
    \ 000020 0a                   asl     a
    \ 000021 0a                   asl     a
    \ 000022 84..                 sty     dp:.tiny _Dp
    \ 000024 18                   clc
    \ 000025 65..                 adc     dp:.tiny _Dp
    \ 000027 18                   clc
    \ 000028 691936               adc     ##0x3619
    \ 00002b 8303                 sta     3,s
    \ 00002d 8a                   txa
    \ 00002e 291f00               and     ##31
    \ 000031 8301                 sta     1,s
    \ 000033 8a                   txa
    \ 000034 4a                   lsr     a
    \ 000035 4a                   lsr     a
    \ 000036 4a                   lsr     a
    \ 000037 4a                   lsr     a
    \ 000038 4a                   lsr     a
    \ 000039 8305                 sta     5,s
    \ 00003b a301                 lda     1,s
    \ 00003d f01c                 beq     `?L10`
    \ 00003f c91f00               cmp     ##31
    \ 000042 f017                 beq     `?L10`
    \ 000044 a305                 lda     5,s
    \ 000046 f013                 beq     `?L10`
    \ 000048 c91f00               cmp     ##31
    \ 00004b f00e                 beq     `?L10`
    \ 00004d a90003               lda     ##0x300
    \ 000050 2303                 and     3,s
    \ 000052 f007                 beq     `?L10`
    \ 000054 e220                 sep     #32
    \ 000056 9e....               stz     grid,x
    \ 000059 8007                 bra     `?L37`
    \ 00005b e220     `?L10`:     sep     #32
    \ 00005d a901                 lda     #1
    \ 00005f 9d....               sta     grid,x
    \ 000062 c220     `?L37`:     rep     #32
    \ 000064 8a                   txa
    \ 000065 1a                   inc     a
    \ 000066 8301                 sta     1,s
    \ 000068 aa                   tax
    \ 000069 a303                 lda     3,s
    \ 00006b a8                   tay
    \ 00006c 809b                 bra     `?L5`
0027
0028                  void visit(unsigned int n, unsigned char d)
0029                  {
    \ 000000                      .section code,text
    \ 000000                      .public visit
    \ 000000 aa       visit:      tax
0030                      if (grid[n] == 0 && dist[n] == 0xFF) {
    \ 000001 e220                 sep     #32
    \ 000003 bd....               lda     grid,x
    \ 000006 c220                 rep     #32
    \ 000008 d02a                 bne     `?L15`
    \ 00000a bd....               lda     dist,x
    \ 00000d e220                 sep     #32
    \ 00000f c9ff                 cmp     #-1
    \ 000011 c220                 rep     #32
    \ 000013 d01f                 bne     `?L15`
0031                          dist[n] = d;
    \ 000015 e220                 sep     #32
    \ 000017 a303                 lda     3,s
    \ 000019 9d....               sta     dist,x
    \ 00001c c220                 rep     #32
0032                          queue[tail] = n;
    \ 00001e 8a                   txa
    \ 00001f a8                   tay
    \ 000020 ad....               lda     tail
    \ 000023 0a                   asl     a
    \ 000024 aa                   tax
    \ 000025 98                   tya
    \ 000026 9d....               sta     queue,x
0033                          tail = (tail + 1) & (QN - 1);
    \ 000029 ad....               lda     tail
    \ 00002c 1a                   inc     a
    \ 00002d 29ff00               and     ##255
    \ 000030 8d....               sta     tail
    \ 000033 60                   rts
    \ 000034          `?L15`:
0034                      }
0035                  }
    \ 000034 60                   rts
0036
0037                  unsigned int bench(void)
0038                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
    \ 000001 5a                   phy
    \ 000002 5a                   phy
    \ 000003 5a                   phy
0039                      unsigned int i, c, head, s = 0;
    \ 000004 a90000               lda     ##0
    \ 000007 8301                 sta     1,s
    \ 000009          `?L38`:
0040                      unsigned char d;
0041                      for (i = 0; i < W * W; i++)
    \ 000009 aa                   tax
    \ 00000a e00004               cpx     ##0x400
    \ 00000d b003                 bcs     `?L39`
    \ 00000f 4c....               jmp     `?L20`
    \ 000012          `?L39`:
0042                          dist[i] = 0xFF;
0043                      dist[start] = 0;
    \ 000012 ae....               ldx     start
    \ 000015 e220                 sep     #32
    \ 000017 9e....               stz     dist,x
    \ 00001a c220                 rep     #32
0044                      queue[0] = start;
    \ 00001c ae....               ldx     start
    \ 00001f 8e....               stx     queue
0045                      head = 0;
    \ 000022 a90000               lda     ##0
0046                      tail = 1;
    \ 000025 a20100               ldx     ##1
    \ 000028 8e....               stx     tail
0047                      while (head != tail) {
    \ 00002b 8305                 sta     5,s
    \ 00002d a301                 lda     1,s
    \ 00002f 8303                 sta     3,s
    \ 000031 a305     `?L24`:     lda     5,s
    \ 000033 cd....               cmp     tail
    \ 000036 f059                 beq     `?L25`
0048                          c = queue[head];
    \ 000038 0a                   asl     a
    \ 000039 aa                   tax
    \ 00003a bd....               lda     queue,x
    \ 00003d 8307                 sta     7,s
0049                          head = (head + 1) & (QN - 1);
    \ 00003f a305                 lda     5,s
    \ 000041 1a                   inc     a
    \ 000042 29ff00               and     ##255
    \ 000045 8301                 sta     1,s
0050                          s += dist[c];
    \ 000047 a0....               ldy     ##dist
    \ 00004a b307                 lda     (7,s),y
    \ 00004c 29ff00               and     ##255
    \ 00004f 18                   clc
    \ 000050 6303                 adc     3,s
    \ 000052 8303                 sta     3,s
0051                          d = dist[c] + 1;
    \ 000054 b307                 lda     (7,s),y
    \ 000056 1a                   inc     a
    \ 000057 e220                 sep     #32
    \ 000059 8305                 sta     5,s
    \ 00005b c220                 rep     #32
0052                          visit(c - W, d);
    \ 00005d a305                 lda     5,s
    \ 00005f 48                   pha
    \ 000060 a309                 lda     9,s
    \ 000062 38                   sec
    \ 000063 e92000               sbc     ##32
    \ 000066 20....               jsr     visit
0053                          visit(c - 1, d);
    \ 000069 68                   pla
    \ 00006a a305                 lda     5,s
    \ 00006c 48                   pha
    \ 00006d a309                 lda     9,s
    \ 00006f 3a                   dec     a
    \ 000070 20....               jsr     visit
0054                          visit(c + 1, d);
    \ 000073 68                   pla
    \ 000074 a305                 lda     5,s
    \ 000076 48                   pha
    \ 000077 a309                 lda     9,s
    \ 000079 1a                   inc     a
    \ 00007a 20....               jsr     visit
0055                          visit(c + W, d);
    \ 00007d 68                   pla
    \ 00007e a305                 lda     5,s
    \ 000080 48                   pha
    \ 000081 a92000               lda     ##32
    \ 000084 18                   clc
    \ 000085 6309                 adc     9,s
    \ 000087 20....               jsr     visit
    \ 00008a 68                   pla
    \ 00008b a301                 lda     1,s
    \ 00008d 8305                 sta     5,s
    \ 00008f 80a0                 bra     `?L24`
    \ 000091          `?L25`:
0056                      }
0057                      return s;
    \ 000091 a303                 lda     3,s
0058                  }
    \ 000093 7a                   ply
    \ 000094 7a                   ply
    \ 000095 7a                   ply
    \ 000096 7a                   ply
    \ 000097 60                   rts
    \ 000098 e220     `?L20`:     sep     #32
    \ 00009a a9ff                 lda     #-1
    \ 00009c 9d....               sta     dist,x
    \ 00009f c220                 rep     #32
    \ 0000a1 8a                   txa
    \ 0000a2 1a                   inc     a
    \ 0000a3 8303                 sta     3,s
    \ 0000a5 4c....               jmp     `?L38`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  331 bytes
Zero initialized   (BSS): 2564 bytes
