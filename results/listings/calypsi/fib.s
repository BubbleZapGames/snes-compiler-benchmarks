###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       18/Nov/2026  08:25:52 #
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
    \ 000000 5a       fib:        phy
    \ 000001 5a                   phy
    \ 000002 8303                 sta     3,s
0008                      unsigned int a, b;
0009
0010                      if (n < 2)
    \ 000004 a303                 lda     3,s
    \ 000006 c90200               cmp     ##2
    \ 000009 9012                 bcc     `?L6`
0011                          return n;
0012                      a = fib(n - 1);
    \ 00000b 3a                   dec     a
    \ 00000c 20....               jsr     fib
    \ 00000f 8301                 sta     1,s
0013                      b = fib(n - 2);
    \ 000011 a303                 lda     3,s
    \ 000013 3a                   dec     a
    \ 000014 3a                   dec     a
    \ 000015 20....               jsr     fib
    \ 000018 8303                 sta     3,s
0014                      return a + b;
    \ 00001a 18                   clc
    \ 00001b 6301                 adc     1,s
    \ 00001d          `?L6`:
0015                  }
    \ 00001d 7a                   ply
    \ 00001e 7a                   ply
    \ 00001f 60                   rts
0016
0017                  unsigned int bench(void)
0018                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
0019                      return fib(16);
    \ 000000 a91000               lda     ##16
    \ 000003 20....               jsr     fib
0020                  }
    \ 000006 60                   rts

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable  (Text): 40 bytes
