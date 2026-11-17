###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:15 #
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
0001                  /* Count the set bits in 256 bytes, one shift at a time. */
0002                  #define N 256
0003
0004                  unsigned char buf[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public buf
    \ 000000          buf:        .space  256
0005
0006                  void bench_init(void)
0007                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0008                      unsigned int i, v = 1;
    \ 000000 a00100               ldy     ##1
0009                      for (i = 0; i < N; i++) {
    \ 000003 a20000               ldx     ##0
    \ 000006 e00001   `?L5`:      cpx     ##256
    \ 000009 9001                 bcc     `?L4`
0010                          v = (v << 2) + v + 0x3619;
0011                          buf[i] = (unsigned char)(v >> 8);
0012                      }
0013                  }
    \ 00000b 60                   rts
    \ 00000c 98       `?L4`:      tya
    \ 00000d 0a                   asl     a
    \ 00000e 0a                   asl     a
    \ 00000f 84..                 sty     dp:.tiny _Dp
    \ 000011 18                   clc
    \ 000012 65..                 adc     dp:.tiny _Dp
    \ 000014 18                   clc
    \ 000015 691936               adc     ##0x3619
    \ 000018 a8                   tay
    \ 000019 98                   tya
    \ 00001a eb                   xba
    \ 00001b 29ff00               and     ##255
    \ 00001e e220                 sep     #32
    \ 000020 9d....               sta     buf,x
    \ 000023 c220                 rep     #32
    \ 000025 e8                   inx
    \ 000026 80de                 bra     `?L5`
0014
0015                  unsigned int bench(void)
0016                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
    \ 000001 5a                   phy
0017                      unsigned int i, c = 0;
    \ 000002 a90000               lda     ##0
0018                      unsigned char v;
0019                      for (i = 0; i < N; i++) {
    \ 000005 a8                   tay
    \ 000006 8302                 sta     2,s
    \ 000008 c00001   `?L12`:     cpy     ##256
    \ 00000b 9005                 bcc     `?L11`
0020                          v = buf[i];
0021                          while (v) {
0022                              c += v & 1;
0023                              v >>= 1;
0024                          }
0025                      }
0026                      return c;
    \ 00000d a302                 lda     2,s
0027                  }
    \ 00000f 7a                   ply
    \ 000010 7a                   ply
    \ 000011 60                   rts
    \ 000012 bb       `?L11`:     tyx
    \ 000013 e220                 sep     #32
    \ 000015 bd....               lda     buf,x
    \ 000018 8301                 sta     1,s
    \ 00001a a301     `?L15`:     lda     1,s
    \ 00001c c220                 rep     #32
    \ 00001e f017                 beq     `?L13`
    \ 000020 a90100               lda     ##1
    \ 000023 2301                 and     1,s
    \ 000025 29ff00               and     ##255
    \ 000028 18                   clc
    \ 000029 6302                 adc     2,s
    \ 00002b 8302                 sta     2,s
    \ 00002d 3b                   tsc
    \ 00002e 1a                   inc     a
    \ 00002f aa                   tax
    \ 000030 e220                 sep     #32
    \ 000032 5e0000               lsr     0,x
    \ 000035 80e3                 bra     `?L15`
    \ 000037 c8       `?L13`:     iny
    \ 000038 80ce                 bra     `?L12`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  98 bytes
Zero initialized   (BSS): 256 bytes
