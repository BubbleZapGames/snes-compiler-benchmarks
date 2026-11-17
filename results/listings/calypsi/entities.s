###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:14 #
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
0001                  /* 16 frames of moving and bouncing 32 entities: an array of 9-byte structs. */
0002                  #define N 32
0003
0004                  struct entity {
0005                      unsigned int x, y, vx, vy;
0006                      unsigned char alive;
0007                  };
0008
0009                  struct entity ents[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public ents
    \ 000000          ents:       .space  0x120
0010
0011                  void bench_init(void)
0012                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000 5a       bench_init: phy
    \ 000001 5a                   phy
    \ 000002 5a                   phy
0013                      unsigned int i;
0014                      for (i = 0; i < N; i++) {
    \ 000003 a00000               ldy     ##0
    \ 000006 c02000   `?L5`:      cpy     ##32
    \ 000009 9004                 bcc     `?L4`
0015                          ents[i].x = (i << 3) - i;
0016                          ents[i].y = (i << 2) + i;
0017                          ents[i].vx = (i & 3) + 1;
0018                          ents[i].vy = (i & 1) + 2;
0019                          ents[i].alive = (i & 3) != 0;
0020                      }
0021                  }
    \ 00000b 7a                   ply
    \ 00000c 7a                   ply
    \ 00000d 7a                   ply
    \ 00000e 60                   rts
    \ 00000f          `?L4`:
    \ 00000f 20....               jsr     `?L43`
    \ 000012 86..                 stx     dp:.tiny _Dp
    \ 000014 18                   clc
    \ 000015 65..                 adc     dp:.tiny _Dp
    \ 000017 aa                   tax
    \ 000018 98                   tya
    \ 000019 0a                   asl     a
    \ 00001a 0a                   asl     a
    \ 00001b 0a                   asl     a
    \ 00001c 84..                 sty     dp:.tiny _Dp
    \ 00001e 38                   sec
    \ 00001f e5..                 sbc     dp:.tiny _Dp
    \ 000021 9d....               sta     ents,x
    \ 000024 20....               jsr     `?L43`
    \ 000027 8301                 sta     1,s
    \ 000029 8a                   txa
    \ 00002a 18                   clc
    \ 00002b 6301                 adc     1,s
    \ 00002d 8301                 sta     1,s
    \ 00002f 98                   tya
    \ 000030 0a                   asl     a
    \ 000031 0a                   asl     a
    \ 000032 bb                   tyx
    \ 000033 86..                 stx     dp:.tiny _Dp
    \ 000035 18                   clc
    \ 000036 65..                 adc     dp:.tiny _Dp
    \ 000038 48                   pha
    \ 000039 a303                 lda     3,s
    \ 00003b 20....               jsr     `?L41`
    \ 00003e 68                   pla
    \ 00003f 9d0200               sta     2,x
    \ 000042 20....               jsr     `?L43`
    \ 000045 8301                 sta     1,s
    \ 000047 8a                   txa
    \ 000048 18                   clc
    \ 000049 6301                 adc     1,s
    \ 00004b 8301                 sta     1,s
    \ 00004d 98                   tya
    \ 00004e 290300               and     ##3
    \ 000051 1a                   inc     a
    \ 000052 48                   pha
    \ 000053 a303                 lda     3,s
    \ 000055 20....               jsr     `?L41`
    \ 000058 68                   pla
    \ 000059 9d0400               sta     4,x
    \ 00005c 20....               jsr     `?L43`
    \ 00005f 8301                 sta     1,s
    \ 000061 8a                   txa
    \ 000062 18                   clc
    \ 000063 6301                 adc     1,s
    \ 000065 8301                 sta     1,s
    \ 000067 98                   tya
    \ 000068 290100               and     ##1
    \ 00006b 1a                   inc     a
    \ 00006c 1a                   inc     a
    \ 00006d 48                   pha
    \ 00006e a303                 lda     3,s
    \ 000070 20....               jsr     `?L41`
    \ 000073 68                   pla
    \ 000074 9d0600               sta     6,x
    \ 000077 98                   tya
    \ 000078 290300               and     ##3
    \ 00007b d005                 bne     `?L34`
    \ 00007d a90000               lda     ##0
    \ 000080 8003                 bra     `?L36`
    \ 000082 a90100   `?L34`:     lda     ##1
    \ 000085 8301     `?L36`:     sta     1,s
    \ 000087 98                   tya
    \ 000088 8303                 sta     3,s
    \ 00008a 0a                   asl     a
    \ 00008b 0a                   asl     a
    \ 00008c 0a                   asl     a
    \ 00008d 8305                 sta     5,s
    \ 00008f 18                   clc
    \ 000090 6303                 adc     3,s
    \ 000092 8303                 sta     3,s
    \ 000094 20....               jsr     `?L41`
    \ 000097 a301                 lda     1,s
    \ 000099 e220                 sep     #32
    \ 00009b 9d0800               sta     8,x
    \ 00009e c220                 rep     #32
    \ 0000a0 98                   tya
    \ 0000a1 1a                   inc     a
    \ 0000a2 8301                 sta     1,s
    \ 0000a4 a8                   tay
    \ 0000a5 4c....               jmp     `?L5`
0022
0023                  unsigned int bench(void)
0024                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 3b       bench:      tsc
    \ 000001 38                   sec
    \ 000002 e90e00               sbc     ##14
    \ 000005 1b                   tcs
0025                      unsigned int f, i, s = 0;
    \ 000006 a90000               lda     ##0
    \ 000009 8301                 sta     1,s
    \ 00000b          `?L39`:
0026                      for (f = 0; f < 16; f++) {
    \ 00000b 830b                 sta     11,s
    \ 00000d a30b                 lda     11,s
    \ 00000f c91000               cmp     ##16
    \ 000012 905e                 bcc     `?L11`
0027                          for (i = 0; i < N; i++) {
0028                              if (ents[i].alive) {
0029                                  ents[i].x += ents[i].vx;
0030                                  if (ents[i].x > 240)
0031                                      ents[i].vx = 0 - ents[i].vx;
0032                                  ents[i].y += ents[i].vy;
0033                                  if (ents[i].y > 200)
0034                                      ents[i].vy = 0 - ents[i].vy;
0035                              }
0036                          }
0037                      }
0038                      for (i = 0; i < N; i++)
    \ 000014 a90000               lda     ##0
    \ 000017 8309                 sta     9,s
    \ 000019 a301                 lda     1,s
    \ 00001b 8307     `?L37`:     sta     7,s
    \ 00001d a309                 lda     9,s
    \ 00001f c92000               cmp     ##32
    \ 000022 900b                 bcc     `?L28`
0039                          s += ents[i].x + ents[i].y;
0040                      return s;
    \ 000024 a307                 lda     7,s
0041                  }
    \ 000026 a8                   tay
    \ 000027 3b                   tsc
    \ 000028 18                   clc
    \ 000029 690e00               adc     ##14
    \ 00002c 1b                   tcs
    \ 00002d 98                   tya
    \ 00002e 60                   rts
    \ 00002f 8303     `?L28`:     sta     3,s
    \ 000031 8301                 sta     1,s
    \ 000033 3b                   tsc
    \ 000034 18                   clc
    \ 000035 690300               adc     ##3
    \ 000038 20....               jsr     `?L40`
    \ 00003b a303                 lda     3,s
    \ 00003d 18                   clc
    \ 00003e 6301                 adc     1,s
    \ 000040 8301                 sta     1,s
    \ 000042 a309                 lda     9,s
    \ 000044 8305                 sta     5,s
    \ 000046 8303                 sta     3,s
    \ 000048 3b                   tsc
    \ 000049 20....               jsr     `?L42`
    \ 00004c 20....               jsr     `?L40`
    \ 00004f a305                 lda     5,s
    \ 000051 18                   clc
    \ 000052 6303                 adc     3,s
    \ 000054 8303                 sta     3,s
    \ 000056 a0....               ldy     ##ents
    \ 000059 a303                 lda     3,s
    \ 00005b 20....               jsr     `?L41`
    \ 00005e bd0200               lda     2,x
    \ 000061 18                   clc
    \ 000062 7301                 adc     (1,s),y
    \ 000064 18                   clc
    \ 000065 6307                 adc     7,s
    \ 000067 aa                   tax
    \ 000068 a309                 lda     9,s
    \ 00006a 1a                   inc     a
    \ 00006b 8301                 sta     1,s
    \ 00006d 8309                 sta     9,s
    \ 00006f 8a                   txa
    \ 000070 80a9                 bra     `?L37`
    \ 000072 a90000   `?L11`:     lda     ##0
    \ 000075 830d     `?L38`:     sta     13,s
    \ 000077 a30d                 lda     13,s
    \ 000079 c92000               cmp     ##32
    \ 00007c 9007                 bcc     `?L15`
    \ 00007e a30b                 lda     11,s
    \ 000080 1a                   inc     a
    \ 000081 8303                 sta     3,s
    \ 000083 8086                 bra     `?L39`
    \ 000085 8305     `?L15`:     sta     5,s
    \ 000087 8303                 sta     3,s
    \ 000089 3b                   tsc
    \ 00008a 20....               jsr     `?L42`
    \ 00008d 20....               jsr     `?L40`
    \ 000090 a305                 lda     5,s
    \ 000092 18                   clc
    \ 000093 6303                 adc     3,s
    \ 000095 8303                 sta     3,s
    \ 000097 20....               jsr     `?L41`
    \ 00009a e220                 sep     #32
    \ 00009c bd0800               lda     8,x
    \ 00009f c220                 rep     #32
    \ 0000a1 d003                 bne     `?L83`
    \ 0000a3 4c....               jmp     `?L17`
    \ 0000a6 a30d     `?L83`:     lda     13,s
    \ 0000a8 8305                 sta     5,s
    \ 0000aa 8303                 sta     3,s
    \ 0000ac 3b                   tsc
    \ 0000ad 20....               jsr     `?L42`
    \ 0000b0 20....               jsr     `?L40`
    \ 0000b3 a305                 lda     5,s
    \ 0000b5 18                   clc
    \ 0000b6 6303                 adc     3,s
    \ 0000b8 8303                 sta     3,s
    \ 0000ba a30d                 lda     13,s
    \ 0000bc 8307                 sta     7,s
    \ 0000be 8305                 sta     5,s
    \ 0000c0 3b                   tsc
    \ 0000c1 18                   clc
    \ 0000c2 690700               adc     ##7
    \ 0000c5 20....               jsr     `?L40`
    \ 0000c8 a307                 lda     7,s
    \ 0000ca 18                   clc
    \ 0000cb 6305                 adc     5,s
    \ 0000cd 8305                 sta     5,s
    \ 0000cf a30d                 lda     13,s
    \ 0000d1 8309                 sta     9,s
    \ 0000d3 8307                 sta     7,s
    \ 0000d5 3b                   tsc
    \ 0000d6 18                   clc
    \ 0000d7 690900               adc     ##9
    \ 0000da 20....               jsr     `?L40`
    \ 0000dd a309                 lda     9,s
    \ 0000df 18                   clc
    \ 0000e0 6307                 adc     7,s
    \ 0000e2 8307                 sta     7,s
    \ 0000e4 a0....               ldy     ##ents
    \ 0000e7 a307                 lda     7,s
    \ 0000e9 20....               jsr     `?L41`
    \ 0000ec bd0400               lda     4,x
    \ 0000ef 18                   clc
    \ 0000f0 7305                 adc     (5,s),y
    \ 0000f2 9303                 sta     (3,s),y
    \ 0000f4 a30d                 lda     13,s
    \ 0000f6 8305                 sta     5,s
    \ 0000f8 8303                 sta     3,s
    \ 0000fa 3b                   tsc
    \ 0000fb 20....               jsr     `?L42`
    \ 0000fe 20....               jsr     `?L40`
    \ 000101 a305                 lda     5,s
    \ 000103 18                   clc
    \ 000104 6303                 adc     3,s
    \ 000106 8303                 sta     3,s
    \ 000108 a9f000               lda     ##240
    \ 00010b d303                 cmp     (3,s),y
    \ 00010d b043                 bcs     `?L23`
    \ 00010f a30d                 lda     13,s
    \ 000111 8305                 sta     5,s
    \ 000113 8303                 sta     3,s
    \ 000115 3b                   tsc
    \ 000116 20....               jsr     `?L42`
    \ 000119 20....               jsr     `?L40`
    \ 00011c a305                 lda     5,s
    \ 00011e 18                   clc
    \ 00011f 6303                 adc     3,s
    \ 000121 8303                 sta     3,s
    \ 000123 a30d                 lda     13,s
    \ 000125 8307                 sta     7,s
    \ 000127 8305                 sta     5,s
    \ 000129 3b                   tsc
    \ 00012a 18                   clc
    \ 00012b 690700               adc     ##7
    \ 00012e 20....               jsr     `?L40`
    \ 000131 a307                 lda     7,s
    \ 000133 18                   clc
    \ 000134 6305                 adc     5,s
    \ 000136 8305                 sta     5,s
    \ 000138 18                   clc
    \ 000139 69....               adc     ##ents
    \ 00013c 18                   clc
    \ 00013d 690400               adc     ##4
    \ 000140 85..                 sta     dp:.tiny _Dp
    \ 000142 38                   sec
    \ 000143 a90000               lda     ##0
    \ 000146 f2..                 sbc     (.tiny _Dp)
    \ 000148 a8                   tay
    \ 000149 a303                 lda     3,s
    \ 00014b 20....               jsr     `?L41`
    \ 00014e 98                   tya
    \ 00014f 9d0400               sta     4,x
    \ 000152 a30d     `?L23`:     lda     13,s
    \ 000154 8305                 sta     5,s
    \ 000156 8303                 sta     3,s
    \ 000158 3b                   tsc
    \ 000159 20....               jsr     `?L42`
    \ 00015c 20....               jsr     `?L40`
    \ 00015f a305                 lda     5,s
    \ 000161 18                   clc
    \ 000162 6303                 adc     3,s
    \ 000164 8303                 sta     3,s
    \ 000166 a30d                 lda     13,s
    \ 000168 8307                 sta     7,s
    \ 00016a 8305                 sta     5,s
    \ 00016c 3b                   tsc
    \ 00016d 18                   clc
    \ 00016e 690700               adc     ##7
    \ 000171 20....               jsr     `?L40`
    \ 000174 a307                 lda     7,s
    \ 000176 18                   clc
    \ 000177 6305                 adc     5,s
    \ 000179 8305                 sta     5,s
    \ 00017b a30d                 lda     13,s
    \ 00017d 8309                 sta     9,s
    \ 00017f 8307                 sta     7,s
    \ 000181 3b                   tsc
    \ 000182 18                   clc
    \ 000183 690900               adc     ##9
    \ 000186 20....               jsr     `?L40`
    \ 000189 a309                 lda     9,s
    \ 00018b 18                   clc
    \ 00018c 6307                 adc     7,s
    \ 00018e 8307                 sta     7,s
    \ 000190 a305                 lda     5,s
    \ 000192 20....               jsr     `?L41`
    \ 000195 9b                   txy
    \ 000196 a307                 lda     7,s
    \ 000198 18                   clc
    \ 000199 69....               adc     ##ents
    \ 00019c aa                   tax
    \ 00019d bd0600               lda     6,x
    \ 0001a0 bb                   tyx
    \ 0001a1 18                   clc
    \ 0001a2 7d0200               adc     2,x
    \ 0001a5 a8                   tay
    \ 0001a6 a303                 lda     3,s
    \ 0001a8 20....               jsr     `?L41`
    \ 0001ab 98                   tya
    \ 0001ac 9d0200               sta     2,x
    \ 0001af a30d                 lda     13,s
    \ 0001b1 8305                 sta     5,s
    \ 0001b3 8303                 sta     3,s
    \ 0001b5 3b                   tsc
    \ 0001b6 20....               jsr     `?L42`
    \ 0001b9 20....               jsr     `?L40`
    \ 0001bc a305                 lda     5,s
    \ 0001be 18                   clc
    \ 0001bf 6303                 adc     3,s
    \ 0001c1 8303                 sta     3,s
    \ 0001c3 20....               jsr     `?L41`
    \ 0001c6 a9c800               lda     ##200
    \ 0001c9 dd0200               cmp     2,x
    \ 0001cc b042                 bcs     `?L17`
    \ 0001ce a30d                 lda     13,s
    \ 0001d0 8305                 sta     5,s
    \ 0001d2 8303                 sta     3,s
    \ 0001d4 3b                   tsc
    \ 0001d5 20....               jsr     `?L42`
    \ 0001d8 20....               jsr     `?L40`
    \ 0001db a305                 lda     5,s
    \ 0001dd 18                   clc
    \ 0001de 6303                 adc     3,s
    \ 0001e0 8303                 sta     3,s
    \ 0001e2 a30d                 lda     13,s
    \ 0001e4 8307                 sta     7,s
    \ 0001e6 8305                 sta     5,s
    \ 0001e8 3b                   tsc
    \ 0001e9 18                   clc
    \ 0001ea 690700               adc     ##7
    \ 0001ed 20....               jsr     `?L40`
    \ 0001f0 a307                 lda     7,s
    \ 0001f2 18                   clc
    \ 0001f3 6305                 adc     5,s
    \ 0001f5 8305                 sta     5,s
    \ 0001f7 18                   clc
    \ 0001f8 69....               adc     ##ents
    \ 0001fb 85..                 sta     dp:.tiny _Dp
    \ 0001fd a00600               ldy     ##6
    \ 000200 38                   sec
    \ 000201 a90000               lda     ##0
    \ 000204 f1..                 sbc     (.tiny _Dp),y
    \ 000206 48                   pha
    \ 000207 a305                 lda     5,s
    \ 000209 20....               jsr     `?L41`
    \ 00020c 68                   pla
    \ 00020d 9d0600               sta     6,x
    \ 000210 a30d     `?L17`:     lda     13,s
    \ 000212 1a                   inc     a
    \ 000213 8303                 sta     3,s
    \ 000215 4c....               jmp     `?L38`
    \ 000000                      .section code,text
    \ 000000 aa       `?L40`:     tax
    \ 000001 1e0000               asl     0,x
    \ 000004 1e0000               asl     0,x
    \ 000007 1e0000               asl     0,x
    \ 00000a 60                   rts
    \ 000000                      .section code,text
    \ 000000 18       `?L41`:     clc
    \ 000001 69....               adc     ##ents
    \ 000004 aa                   tax
    \ 000005 60                   rts
    \ 000000                      .section code,text
    \ 000000 18       `?L42`:     clc
    \ 000001 690500               adc     ##5
    \ 000004 60                   rts
    \ 000000                      .section code,text
    \ 000000 98       `?L43`:     tya
    \ 000001 aa                   tax
    \ 000002 0a                   asl     a
    \ 000003 0a                   asl     a
    \ 000004 0a                   asl     a
    \ 000005 60                   rts

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text): 732 bytes
Zero initialized   (BSS): 288 bytes
