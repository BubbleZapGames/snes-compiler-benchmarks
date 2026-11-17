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
0001                  /* Byte-at-a-time copy of 1024 bytes. */
0002                  #define N 1024
0003
0004                  unsigned char src[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public src
    \ 000000          src:        .space  0x400
0005                  unsigned char dst[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public dst
    \ 000000          dst:        .space  0x400
0006
0007                  void bench_init(void)
0008                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0009                      unsigned int i, v = 1;
    \ 000000 a00100               ldy     ##1
0010                      for (i = 0; i < N; i++) {
    \ 000003 a20000               ldx     ##0
    \ 000006 e00004   `?L5`:      cpx     ##0x400
    \ 000009 9001                 bcc     `?L4`
0011                          v = (v << 2) + v + 0x3619;
0012                          src[i] = (unsigned char)(v >> 8);
0013                      }
0014                  }
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
    \ 000020 9d....               sta     src,x
    \ 000023 c220                 rep     #32
    \ 000025 e8                   inx
    \ 000026 80de                 bra     `?L5`
0015
0016                  unsigned int bench(void)
0017                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
0018                      unsigned int i;
0019                      for (i = 0; i < N; i++)
    \ 000000 a20000               ldx     ##0
    \ 000003 e00004   `?L12`:     cpx     ##0x400
    \ 000006 901d                 bcc     `?L11`
0020                          dst[i] = src[i];
0021                      return dst[0] + dst[511] + dst[1023];
    \ 000008 ad....               lda     dst
    \ 00000b 29ff00               and     ##255
    \ 00000e 85..                 sta     dp:.tiny _Dp
    \ 000010 ad....               lda     dst+0x1ff
    \ 000013 29ff00               and     ##255
    \ 000016 18                   clc
    \ 000017 65..                 adc     dp:.tiny _Dp
    \ 000019 85..                 sta     dp:.tiny _Dp
    \ 00001b ad....               lda     dst+0x3ff
    \ 00001e 29ff00               and     ##255
    \ 000021 18                   clc
    \ 000022 65..                 adc     dp:.tiny _Dp
0022                  }
    \ 000024 60                   rts
    \ 000025          `?L11`:
    \ 000025 bd....               lda     src,x
    \ 000028 e220                 sep     #32
    \ 00002a 9d....               sta     dst,x
    \ 00002d c220                 rep     #32
    \ 00002f e8                   inx
    \ 000030 80d1                 bra     `?L12`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):   90 bytes
Zero initialized   (BSS): 2048 bytes
