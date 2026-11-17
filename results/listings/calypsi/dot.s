###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:16 #
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
0001                  /* u8 x u8 dot product over 64 elements: the multiply routine. */
0002                  #define N 64
0003
0004                  unsigned char a[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public a
    \ 000000          a:          .space  64
0005                  unsigned char b[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public b
    \ 000000          b:          .space  64
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
    \ 000006 e04000   `?L5`:      cpx     ##64
    \ 000009 9001                 bcc     `?L4`
0011                          v = (v << 2) + v + 0x3619;
0012                          a[i] = (unsigned char)(v >> 8);
0013                          b[i] = (unsigned char)v;
0014                      }
0015                  }
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
    \ 000020 9d....               sta     a,x
    \ 000023 c220                 rep     #32
    \ 000025 98                   tya
    \ 000026 e220                 sep     #32
    \ 000028 9d....               sta     b,x
    \ 00002b c220                 rep     #32
    \ 00002d e8                   inx
    \ 00002e 80d6                 bra     `?L5`
0016
0017                  unsigned int bench(void)
0018                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
0019                      unsigned int i, s = 0;
    \ 000000 a90000               lda     ##0
0020                      for (i = 0; i < N; i++)
    \ 000003 aa                   tax
    \ 000004 e04000   `?L12`:     cpx     ##64
    \ 000007 9001                 bcc     `?L11`
0021                          s += (unsigned int)a[i] * b[i];
0022                      return s;
0023                  }
    \ 000009 60                   rts
    \ 00000a          `?L11`:
    \ 00000a 85..                 sta     dp:.tiny _Dp
    \ 00000c bd....               lda     b,x
    \ 00000f 08                   php
    \ 000010 78                   sei
    \ 000011 e220                 sep     #32
    \ 000013 8d0242               sta     0x4202
    \ 000016 bd....               lda     a,x
    \ 000019 8d0342               sta     0x4203
    \ 00001c c220                 rep     #32
    \ 00001e ea                   nop
    \ 00001f ea                   nop
    \ 000020 ea                   nop
    \ 000021 ad1642               lda     0x4216
    \ 000024 28                   plp
    \ 000025 18                   clc
    \ 000026 65..                 adc     dp:.tiny _Dp
    \ 000028 e8                   inx
    \ 000029 80d9                 bra     `?L12`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  91 bytes
Zero initialized   (BSS): 128 bytes
