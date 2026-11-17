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
0001                  /* Naive recursive Fibonacci: call and stack-frame overhead. */
0002                  void bench_init(void)
0003                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0004                  }
    \ 000000 60                   rts
0005
0006                  unsigned int fib(unsigned int n)
0007                  {
    \ 000000                      .section code,text
    \ 000000                      .public fib
    \ 000000          fib:
    \ 000000 d4..                 pei     dp:.tiny (_Dp+8)
    \ 000002 5a                   phy
    \ 000003 8301                 sta     1,s
0008                      if (n < 2)
    \ 000005 a301                 lda     1,s
    \ 000007 c90200               cmp     ##2
    \ 00000a 9010                 bcc     `?L6`
0009                          return n;
0010                      return fib(n - 1) + fib(n - 2);
    \ 00000c 3a                   dec     a
    \ 00000d 20....               jsr     fib
    \ 000010 85..                 sta     dp:.tiny (_Dp+8)
    \ 000012 a301                 lda     1,s
    \ 000014 3a                   dec     a
    \ 000015 3a                   dec     a
    \ 000016 20....               jsr     fib
    \ 000019 18                   clc
    \ 00001a 65..                 adc     dp:.tiny (_Dp+8)
    \ 00001c          `?L6`:
0011                  }
    \ 00001c 7a                   ply
    \ 00001d 7a                   ply
    \ 00001e 84..                 sty     dp:.tiny (_Dp+8)
    \ 000020 60                   rts
0012
0013                  unsigned int bench(void)
0014                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
0015                      return fib(16);
    \ 000000 a91000               lda     ##16
    \ 000003 20....               jsr     fib
0016                  }
    \ 000006 60                   rts

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable  (Text): 41 bytes
