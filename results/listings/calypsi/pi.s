###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:18 #
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
    \ 000000                      .extern _Mul16
    \ 000000                      .extern _Mul32
    \ 000000                      .extern _UDivMod32
    \ 000000                      .extern _Vfp
0001                  /* 56 digits of pi from the Rabinowitz-Wagon spigot over 196 terms: 32-bit
0002                   * multiplies, divides and remainders by 16-bit values. The algorithm of
0003                   * c-bench-64's pi.c, smaller. Returns the sum of the 4-digit groups. */
0004                  #include <stdint.h>
0005
0006                  #define SCALE 10000
0007                  #define ARRINIT 2000
0008                  #define TERMS 196
0009
0010                  unsigned int arr[TERMS + 1];
    \ 000000                      .section zdata,bss
    \ 000000                      .public arr
    \ 000000          arr:        .space  0x18a
0011
0012                  void bench_init(void)
0013                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0014                  }
    \ 000000 60                   rts
0015
0016                  unsigned int bench(void)
0017                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
    \ 000000 d4..                 pei     dp:.tiny (_Dp+8)
    \ 000002 d4..                 pei     dp:.tiny (_Dp+10)
    \ 000004 3b                   tsc
    \ 000005 38                   sec
    \ 000006 e90a00               sbc     ##10
    \ 000009 1b                   tcs
0018                      unsigned int i, j, d, carry = 0, s = 0;
    \ 00000a a90000               lda     ##0
    \ 00000d 8301                 sta     1,s
    \ 00000f 8303                 sta     3,s
    \ 000011          `?L28`:
0019                      uint32_t sum;
0020
0021                      for (i = 0; i <= TERMS; i++)
    \ 000011 a8                   tay
    \ 000012 a2c400               ldx     ##196
    \ 000015 84..                 sty     dp:.tiny _Dp
    \ 000017 e4..                 cpx     dp:.tiny _Dp
    \ 000019 9003                 bcc     `?L31`
    \ 00001b 4c....               jmp     `?L7`
    \ 00001e          `?L31`:
0022                          arr[i] = ARRINIT;
0023                      for (i = TERMS; i > 0; i -= 14) {
    \ 00001e 8a                   txa
    \ 00001f 8307                 sta     7,s
    \ 000021 a303                 lda     3,s
    \ 000023 8305     `?L27`:     sta     5,s
    \ 000025 a307                 lda     7,s
    \ 000027 d011                 bne     `?L11`
0024                          sum = 0;
0025                          for (j = i; j > 0; j--) {
0026                              d = j * 2 - 1;
0027                              sum = sum * j + (uint32_t)SCALE * arr[j];
0028                              arr[j] = (unsigned int)(sum % d);
0029                              sum /= d;
0030                          }
0031                          s += carry + (unsigned int)(sum / SCALE);   /* the next four digits */
0032                          carry = (unsigned int)(sum % SCALE);
0033                      }
0034                      return s;
    \ 000029 a305                 lda     5,s
0035                  }
    \ 00002b a8                   tay
    \ 00002c 3b                   tsc
    \ 00002d 18                   clc
    \ 00002e 690a00               adc     ##10
    \ 000031 1b                   tcs
    \ 000032 98                   tya
    \ 000033 7a                   ply
    \ 000034 84..                 sty     dp:.tiny (_Dp+10)
    \ 000036 7a                   ply
    \ 000037 84..                 sty     dp:.tiny (_Dp+8)
    \ 000039 60                   rts
    \ 00003a          `?L11`:
    \ 00003a 64..                 stz     dp:.tiny (_Dp+8)
    \ 00003c 64..                 stz     dp:.tiny (_Dp+10)
    \ 00003e 8309     `?L26`:     sta     9,s
    \ 000040 a309                 lda     9,s
    \ 000042 d01e                 bne     `?L15`
    \ 000044 20....               jsr     `?L29`
    \ 000047 18                   clc
    \ 000048 6301                 adc     1,s
    \ 00004a 18                   clc
    \ 00004b 6305                 adc     5,s
    \ 00004d 8303                 sta     3,s
    \ 00004f 20....               jsr     `?L29`
    \ 000052 a5..                 lda     dp:.tiny _Dp
    \ 000054 8301                 sta     1,s
    \ 000056 a307                 lda     7,s
    \ 000058 38                   sec
    \ 000059 e90e00               sbc     ##14
    \ 00005c 8307                 sta     7,s
    \ 00005e a303                 lda     3,s
    \ 000060 80c1                 bra     `?L27`
    \ 000062 0a       `?L15`:     asl     a
    \ 000063 3a                   dec     a
    \ 000064 8303                 sta     3,s
    \ 000066 a5..                 lda     dp:.tiny (_Dp+8)
    \ 000068 85..                 sta     dp:.tiny _Dp
    \ 00006a a5..                 lda     dp:.tiny (_Dp+10)
    \ 00006c 85..                 sta     dp:.tiny (_Dp+2)
    \ 00006e a309                 lda     9,s
    \ 000070 a20000               ldx     ##0
    \ 000073 86..                 stx     dp:.tiny (_Dp+6)
    \ 000075 85..                 sta     dp:.tiny (_Dp+4)
    \ 000077 20....               jsr     _Mul32
    \ 00007a 86..                 stx     dp:.tiny (_Dp+2)
    \ 00007c 85..                 sta     dp:.tiny _Dp
    \ 00007e a309                 lda     9,s
    \ 000080 0a                   asl     a
    \ 000081 aa                   tax
    \ 000082 bd....               lda     arr,x
    \ 000085 a21027               ldx     ##10000
    \ 000088 20....               jsr     _Mul16
    \ 00008b 18                   clc
    \ 00008c 65..                 adc     dp:.tiny _Dp
    \ 00008e 48                   pha
    \ 00008f 8a                   txa
    \ 000090 65..                 adc     dp:.tiny (_Dp+2)
    \ 000092 aa                   tax
    \ 000093 68                   pla
    \ 000094 86..                 stx     dp:.tiny (_Dp+10)
    \ 000096 85..                 sta     dp:.tiny (_Dp+8)
    \ 000098 20....               jsr     `?L30`
    \ 00009b a5..                 lda     dp:.tiny _Dp
    \ 00009d 48                   pha
    \ 00009e a30b                 lda     11,s
    \ 0000a0 0a                   asl     a
    \ 0000a1 aa                   tax
    \ 0000a2 68                   pla
    \ 0000a3 9d....               sta     arr,x
    \ 0000a6 a5..                 lda     dp:.tiny (_Dp+8)
    \ 0000a8 20....               jsr     `?L30`
    \ 0000ab 86..                 stx     dp:.tiny (_Dp+10)
    \ 0000ad 85..                 sta     dp:.tiny (_Dp+8)
    \ 0000af a309                 lda     9,s
    \ 0000b1 3a                   dec     a
    \ 0000b2 8303                 sta     3,s
    \ 0000b4 8088                 bra     `?L26`
    \ 0000b6 98       `?L7`:      tya
    \ 0000b7 0a                   asl     a
    \ 0000b8 aa                   tax
    \ 0000b9 a9d007               lda     ##2000
    \ 0000bc 9d....               sta     arr,x
    \ 0000bf 98                   tya
    \ 0000c0 1a                   inc     a
    \ 0000c1 8305                 sta     5,s
    \ 0000c3 4c....               jmp     `?L28`
    \ 000000                      .section code,text
    \ 000000          `?L29`:
    \ 000000 a5..                 lda     dp:.tiny (_Dp+8)
    \ 000002 85..                 sta     dp:.tiny _Dp
    \ 000004 a5..                 lda     dp:.tiny (_Dp+10)
    \ 000006 85..                 sta     dp:.tiny (_Dp+2)
    \ 000008 a91027               lda     ##10000
    \ 00000b 85..                 sta     dp:.tiny (_Dp+4)
    \ 00000d a90000               lda     ##0
    \ 000010 85..                 sta     dp:.tiny (_Dp+6)
    \ 000012 4c....               jmp     _UDivMod32
    \ 000000                      .section code,text
    \ 000000          `?L30`:
    \ 000000 85..                 sta     dp:.tiny _Dp
    \ 000002 a5..                 lda     dp:.tiny (_Dp+10)
    \ 000004 85..                 sta     dp:.tiny (_Dp+2)
    \ 000006 a305                 lda     5,s
    \ 000008 a20000               ldx     ##0
    \ 00000b 86..                 stx     dp:.tiny (_Dp+6)
    \ 00000d 85..                 sta     dp:.tiny (_Dp+4)
    \ 00000f 4c....               jmp     _UDivMod32

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text): 238 bytes
Zero initialized   (BSS): 394 bytes
