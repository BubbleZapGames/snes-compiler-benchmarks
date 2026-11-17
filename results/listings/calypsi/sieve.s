###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:12 #
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
0001                  /* Sieve of Eratosthenes over 1024 byte flags; returns the prime count. */
0002                  #define N 1024
0003
0004                  unsigned char flags[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public flags
    \ 000000          flags:      .space  0x400
0005
0006                  void bench_init(void)
0007                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0008                  }
    \ 000000 60                   rts
0009
0010                  unsigned int bench(void)
0011                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
    \ 000001 5a                   phy
0012                      unsigned int i, j, count = 0;
    \ 000002 a90000               lda     ##0
    \ 000005 8301                 sta     1,s
0013                      for (i = 0; i < N; i++)
    \ 000007 8303                 sta     3,s
    \ 000009 a303     `?L8`:      lda     3,s
    \ 00000b c90004               cmp     ##0x400
    \ 00000e 9042                 bcc     `?L7`
0014                          flags[i] = 0;
0015                      for (i = 2; i < N; i++) {
    \ 000010 a00200               ldy     ##2
    \ 000013 c00004   `?L12`:     cpy     ##0x400
    \ 000016 9005                 bcc     `?L11`
0016                          if (flags[i] == 0) {
0017                              count++;
0018                              for (j = i + i; j < N; j += i)
0019                                  flags[j] = 1;
0020                          }
0021                      }
0022                      return count;
    \ 000018 a301                 lda     1,s
0023                  }
    \ 00001a 7a                   ply
    \ 00001b 7a                   ply
    \ 00001c 60                   rts
    \ 00001d bb       `?L11`:     tyx
    \ 00001e e220                 sep     #32
    \ 000020 bd....               lda     flags,x
    \ 000023 c220                 rep     #32
    \ 000025 d024                 bne     `?L13`
    \ 000027 a301                 lda     1,s
    \ 000029 1a                   inc     a
    \ 00002a 8301                 sta     1,s
    \ 00002c 84..                 sty     dp:.tiny _Dp
    \ 00002e 98                   tya
    \ 00002f 18                   clc
    \ 000030 65..                 adc     dp:.tiny _Dp
    \ 000032 aa       `?L23`:     tax
    \ 000033 e00004               cpx     ##0x400
    \ 000036 b013                 bcs     `?L13`
    \ 000038 e220                 sep     #32
    \ 00003a a901                 lda     #1
    \ 00003c 9d....               sta     flags,x
    \ 00003f c220                 rep     #32
    \ 000041 86..                 stx     dp:.tiny _Dp
    \ 000043 98                   tya
    \ 000044 18                   clc
    \ 000045 65..                 adc     dp:.tiny _Dp
    \ 000047 8303                 sta     3,s
    \ 000049 80e7                 bra     `?L23`
    \ 00004b 98       `?L13`:     tya
    \ 00004c 1a                   inc     a
    \ 00004d 8303                 sta     3,s
    \ 00004f a8                   tay
    \ 000050 80c1                 bra     `?L12`
    \ 000052 aa       `?L7`:      tax
    \ 000053 e220                 sep     #32
    \ 000055 9e....               stz     flags,x
    \ 000058 c220                 rep     #32
    \ 00005a a303                 lda     3,s
    \ 00005c 1a                   inc     a
    \ 00005d 8303                 sta     3,s
    \ 00005f 80a8                 bra     `?L8`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):   98 bytes
Zero initialized   (BSS): 1024 bytes
