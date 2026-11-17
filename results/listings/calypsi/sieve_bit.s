###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:21 #
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
0001                  /* Sieve of Eratosthenes over the odd numbers with one bit per flag, through a
0002                   * bit-mask table: the primes up to 16001. The algorithm of c-bench-64's
0003                   * sieve_bit.c, smaller. Returns the prime count. */
0004                  #define SIZE 8000
0005
0006                  unsigned char flags[SIZE / 8 + 1];
    \ 000000                      .section zdata,bss
    \ 000000                      .public flags
    \ 000000          flags:      .space  0x3e9
0007
0008                  static const unsigned char bitv[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
    \ 000000                      .section cdata,rodata
    \ 000000 01020408 bitv:       .byte   1,2,4,8,16,32,64,-128
    \ 000004 10204080
0009
0010                  void bench_init(void)
0011                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0012                  }
    \ 000000 60                   rts
0013
0014                  unsigned char check_flag(unsigned int idx)
0015                  {
    \ 000000                      .section code,text
    \ 000000                      .public check_flag
    \ 000000 a8       check_flag: tay
0016                      return flags[idx / 8] & bitv[idx & 7];
    \ 000001 98                   tya
    \ 000002 4a                   lsr     a
    \ 000003 4a                   lsr     a
    \ 000004 4a                   lsr     a
    \ 000005 aa                   tax
    \ 000006 da                   phx
    \ 000007 98                   tya
    \ 000008 290700               and     ##7
    \ 00000b aa                   tax
    \ 00000c bd....               lda     bitv,x
    \ 00000f fa                   plx
    \ 000010 3d....               and     flags,x
0017                  }
    \ 000013 60                   rts
0018
0019                  void clear_flag(unsigned int idx)
0020                  {
    \ 000000                      .section code,text
    \ 000000                      .public clear_flag
    \ 000000 a8       clear_flag: tay
0021                      flags[idx / 8] &= ~bitv[idx & 7];
    \ 000001 98                   tya
    \ 000002 4a                   lsr     a
    \ 000003 4a                   lsr     a
    \ 000004 4a                   lsr     a
    \ 000005 aa                   tax
    \ 000006 da                   phx
    \ 000007 98                   tya
    \ 000008 290700               and     ##7
    \ 00000b aa                   tax
    \ 00000c bd....               lda     bitv,x
    \ 00000f 49ff00               eor     ##255
    \ 000012 fa                   plx
    \ 000013 e220                 sep     #32
    \ 000015 3d....               and     flags,x
    \ 000018 9d....               sta     flags,x
    \ 00001b c220                 rep     #32
0022                  }
    \ 00001d 60                   rts
0023
0024                  unsigned int bench(void)
0025                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
    \ 000001 5a                   phy
    \ 000002 5a                   phy
    \ 000003 5a                   phy
0026                      unsigned int i, prime, k, count = 1;    /* 2 is prime */
    \ 000004 a90100               lda     ##1
    \ 000007 8301                 sta     1,s
0027
0028                      for (i = 0; i < SIZE / 8 + 1; i++)
    \ 000009 a20000               ldx     ##0
    \ 00000c e0e903   `?L15`:     cpx     ##0x3e9
    \ 00000f 9057                 bcc     `?L14`
0029                          flags[i] = 0xff;
0030                      for (i = 0; i < SIZE; i++) {
    \ 000011 a90000               lda     ##0
    \ 000014 8307                 sta     7,s
    \ 000016 a301                 lda     1,s
    \ 000018 8305     `?L32`:     sta     5,s
    \ 00001a a307                 lda     7,s
    \ 00001c c9401f               cmp     ##8000
    \ 00001f 9007                 bcc     `?L18`
0031                          if (check_flag(i)) {                /* flag i stands for 2i + 3 */
0032                              prime = i + i + 3;
0033                              for (k = i + prime; k < SIZE; k += prime)
0034                                  clear_flag(k);
0035                              count++;
0036                          }
0037                      }
0038                      return count;
    \ 000021 a305                 lda     5,s
0039                  }
    \ 000023 7a                   ply
    \ 000024 7a                   ply
    \ 000025 7a                   ply
    \ 000026 7a                   ply
    \ 000027 60                   rts
    \ 000028          `?L18`:
    \ 000028 20....               jsr     check_flag
    \ 00002b 29ff00               and     ##255
    \ 00002e f029                 beq     `?L22`
    \ 000030 a307                 lda     7,s
    \ 000032 18                   clc
    \ 000033 6307                 adc     7,s
    \ 000035 1a                   inc     a
    \ 000036 1a                   inc     a
    \ 000037 1a                   inc     a
    \ 000038 8303                 sta     3,s
    \ 00003a 18                   clc
    \ 00003b 6307                 adc     7,s
    \ 00003d 8301                 sta     1,s
    \ 00003f a301     `?L26`:     lda     1,s
    \ 000041 c9401f               cmp     ##8000
    \ 000044 9007                 bcc     `?L25`
    \ 000046 a305                 lda     5,s
    \ 000048 1a                   inc     a
    \ 000049 8301                 sta     1,s
    \ 00004b 8010                 bra     `?L20`
    \ 00004d          `?L25`:
    \ 00004d 20....               jsr     clear_flag
    \ 000050 a303                 lda     3,s
    \ 000052 18                   clc
    \ 000053 6301                 adc     1,s
    \ 000055 8301                 sta     1,s
    \ 000057 80e6                 bra     `?L26`
    \ 000059 a305     `?L22`:     lda     5,s
    \ 00005b 8301                 sta     1,s
    \ 00005d a307     `?L20`:     lda     7,s
    \ 00005f 1a                   inc     a
    \ 000060 8303                 sta     3,s
    \ 000062 8307                 sta     7,s
    \ 000064 a301                 lda     1,s
    \ 000066 80b0                 bra     `?L32`
    \ 000068 e220     `?L14`:     sep     #32
    \ 00006a a9ff                 lda     #-1
    \ 00006c 9d....               sta     flags,x
    \ 00006f c220                 rep     #32
    \ 000071 8a                   txa
    \ 000072 1a                   inc     a
    \ 000073 8303                 sta     3,s
    \ 000075 aa                   tax
    \ 000076 8094                 bra     `?L15`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  171 bytes
Zero initialized   (BSS): 1001 bytes
Constant                :    8 bytes
