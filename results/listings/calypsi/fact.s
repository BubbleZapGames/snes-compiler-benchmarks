###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:20 #
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
    \ 000000                      .extern _FillDP4
    \ 000000                      .extern _Mul32
    \ 000000                      .extern _Vfp
0001                  /* The factorials 0! to 15!, 20 times over, summed in 32 bits (wrapping): a
0002                   * recursive function and 32-bit multiplies. The algorithm of c-bench-64's
0003                   * fact.c, fewer iterations. Returns the 32-bit sum folded to 16 bits. */
0004                  #include <stdint.h>
0005
0006                  #define N_ITER 20
0007                  #define SIZE 16
0008
0009                  uint32_t array[SIZE];
    \ 000000                      .section zdata,bss
    \ 000000                      .public array
    \ 000000          array:      .space  64
0010
0011                  /* Set at run time, so no compiler can work the result out at compile time. */
0012                  unsigned int n_iter, size;
    \ 000000                      .section zdata,bss
    \ 000000                      .public n_iter
    \ 000000          n_iter:     .space  2
    \ 000000                      .section zdata,bss
    \ 000000                      .public size
    \ 000000          size:       .space  2
0013
0014                  void bench_init(void)
0015                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0016                      n_iter = N_ITER;
    \ 000000 a21400               ldx     ##20
    \ 000003 8e....               stx     n_iter
0017                      size = SIZE;
    \ 000006 a21000               ldx     ##16
    \ 000009 8e....               stx     size
0018                  }
    \ 00000c 60                   rts
0019
0020                  uint32_t fact(unsigned int i)
0021                  {
    \ 000000                      .section code,text
    \ 000000                      .public fact
    \ 000000          fact:
0022                      if (i > 1)
    \ 000000 a20100               ldx     ##1
    \ 000003 85..                 sta     dp:.tiny _Dp
    \ 000005 e4..                 cpx     dp:.tiny _Dp
    \ 000007 b019                 bcs     `?L8`
0023                          return i * fact(i - 1);
    \ 000009 85..                 sta     dp:.tiny _Dp
    \ 00000b 64..                 stz     dp:.tiny (_Dp+2)
    \ 00000d d4..                 pei     dp:.tiny (_Dp+2)
    \ 00000f d4..                 pei     dp:.tiny _Dp
    \ 000011 3a                   dec     a
    \ 000012 20....               jsr     fact
    \ 000015 86..                 stx     dp:.tiny (_Dp+6)
    \ 000017 85..                 sta     dp:.tiny (_Dp+4)
    \ 000019 22......             jsl     long:_FillDP4
    \ 00001d ..                   .byte   .tiny _Dp
    \ 00001e 20....               jsr     _Mul32
    \ 000021 60                   rts
    \ 000022          `?L8`:
0024                      return 1;
    \ 000022 8a                   txa
    \ 000023 ca                   dex
    \ 000024 60                   rts
0025                  }
0026
0027                  unsigned int bench(void)
0028                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
    \ 000000 d4..                 pei     dp:.tiny (_Dp+8)
    \ 000002 d4..                 pei     dp:.tiny (_Dp+10)
    \ 000004 5a                   phy
    \ 000005 5a                   phy
0029                      unsigned int i, j;
0030                      uint32_t res = 0;
    \ 000006 64..                 stz     dp:.tiny (_Dp+8)
    \ 000008 64..                 stz     dp:.tiny (_Dp+10)
0031
0032                      for (j = 0; j < size; j++)
    \ 00000a a00000               ldy     ##0
    \ 00000d          `?L16`:
    \ 00000d cc....               cpy     size
    \ 000010 9077                 bcc     `?L15`
0033                          array[j] = 0;
0034                      for (i = 0; i < n_iter; i++)
    \ 000012 a90000               lda     ##0
    \ 000015 8303     `?L35`:     sta     3,s
    \ 000017 a303                 lda     3,s
    \ 000019 cd....               cmp     n_iter
    \ 00001c 9032                 bcc     `?L19`
0035                          for (j = 0; j < size; j++)
0036                              array[j] += fact(j);
0037                      for (j = 0; j < size; j++)
    \ 00001e a90000               lda     ##0
    \ 000021 8301                 sta     1,s
    \ 000023 a301     `?L28`:     lda     1,s
    \ 000025 cd....               cmp     size
    \ 000028 900d                 bcc     `?L27`
0038                          res += array[j];
0039                      return (unsigned int)(res >> 16) ^ (unsigned int)res;
    \ 00002a a5..                 lda     dp:.tiny (_Dp+8)
    \ 00002c 45..                 eor     dp:.tiny (_Dp+10)
0040                  }
    \ 00002e 7a                   ply
    \ 00002f 7a                   ply
    \ 000030 7a                   ply
    \ 000031 84..                 sty     dp:.tiny (_Dp+10)
    \ 000033 7a                   ply
    \ 000034 84..                 sty     dp:.tiny (_Dp+8)
    \ 000036 60                   rts
    \ 000037 0a       `?L27`:     asl     a
    \ 000038 0a                   asl     a
    \ 000039 aa                   tax
    \ 00003a 18                   clc
    \ 00003b a5..                 lda     dp:.tiny (_Dp+8)
    \ 00003d 7d....               adc     array,x
    \ 000040 85..                 sta     dp:.tiny (_Dp+8)
    \ 000042 a5..                 lda     dp:.tiny (_Dp+10)
    \ 000044 7d....               adc     array+2,x
    \ 000047 85..                 sta     dp:.tiny (_Dp+10)
    \ 000049 a301                 lda     1,s
    \ 00004b 1a                   inc     a
    \ 00004c 8301                 sta     1,s
    \ 00004e 80d3                 bra     `?L28`
    \ 000050 a90000   `?L19`:     lda     ##0
    \ 000053 8301                 sta     1,s
    \ 000055 a301     `?L24`:     lda     1,s
    \ 000057 cd....               cmp     size
    \ 00005a 9007                 bcc     `?L23`
    \ 00005c a303                 lda     3,s
    \ 00005e 1a                   inc     a
    \ 00005f 8301                 sta     1,s
    \ 000061 80b2                 bra     `?L35`
    \ 000063 0a       `?L23`:     asl     a
    \ 000064 0a                   asl     a
    \ 000065 aa                   tax
    \ 000066 da                   phx
    \ 000067 a303                 lda     3,s
    \ 000069 20....               jsr     fact
    \ 00006c 86..                 stx     dp:.tiny (_Dp+2)
    \ 00006e 85..                 sta     dp:.tiny _Dp
    \ 000070 fa                   plx
    \ 000071 18                   clc
    \ 000072 bd....               lda     array,x
    \ 000075 65..                 adc     dp:.tiny _Dp
    \ 000077 9d....               sta     array,x
    \ 00007a bd....               lda     array+2,x
    \ 00007d 65..                 adc     dp:.tiny (_Dp+2)
    \ 00007f 9d....               sta     array+2,x
    \ 000082 a301                 lda     1,s
    \ 000084 1a                   inc     a
    \ 000085 8301                 sta     1,s
    \ 000087 80cc                 bra     `?L24`
    \ 000089 98       `?L15`:     tya
    \ 00008a 0a                   asl     a
    \ 00008b 0a                   asl     a
    \ 00008c aa                   tax
    \ 00008d a90000               lda     ##0
    \ 000090 9d....               sta     array,x
    \ 000093 9d....               sta     array+2,x
    \ 000096 c8                   iny
    \ 000097 4c....               jmp     `?L16`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text): 204 bytes
Zero initialized   (BSS):  68 bytes
