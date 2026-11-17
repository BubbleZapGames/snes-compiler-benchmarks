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
    \ 000000                      .extern _Vfp
0001                  /* CRC-32/CKSUM (without the length) of 1024 bytes, a bit at a time: 32-bit
0002                   * shifts and xors. The algorithm of c-bench-64's crc32.c, on generated input.
0003                   * Returns the 32-bit CRC folded to 16 bits. */
0004                  #include <stdint.h>
0005
0006                  #define N 1024
0007
0008                  unsigned char data[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public data
    \ 000000          data:       .space  0x400
0009
0010                  void bench_init(void)
0011                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000          bench_init:
0012                      unsigned int i, v = 1;
    \ 000000 a00100               ldy     ##1
0013                      for (i = 0; i < N; i++) {
    \ 000003 a20000               ldx     ##0
    \ 000006 e00004   `?L5`:      cpx     ##0x400
    \ 000009 9001                 bcc     `?L4`
0014                          v = (v << 2) + v + 0x3619;
0015                          data[i] = (unsigned char)(v >> 8);
0016                      }
0017                  }
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
    \ 000020 9d....               sta     data,x
    \ 000023 c220                 rep     #32
    \ 000025 e8                   inx
    \ 000026 80de                 bra     `?L5`
0018
0019                  unsigned int bench(void)
0020                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
0021                      uint32_t crc = 0;
    \ 000001 64..                 stz     dp:.tiny _Dp
    \ 000003 64..                 stz     dp:.tiny (_Dp+2)
0022                      unsigned int i;
0023                      unsigned char j;
0024
0025                      for (i = 0; i < N; i++) {
    \ 000005 a00000               ldy     ##0
    \ 000008 c00004   `?L12`:     cpy     ##0x400
    \ 00000b 9013                 bcc     `?L11`
0026                          crc ^= (uint32_t)data[i] << 24;
0027                          for (j = 8; j; j--) {
0028                              if (crc & (uint32_t)0x80000000)
0029                                  crc = (crc << 1) ^ (uint32_t)0x04C11DB7;
0030                              else
0031                                  crc <<= 1;
0032                          }
0033                      }
0034                      crc ^= (uint32_t)0xFFFFFFFF;
    \ 00000d a5..                 lda     dp:.tiny (_Dp+2)
    \ 00000f 49ffff               eor     ##-1
    \ 000012 aa                   tax
    \ 000013 a5..                 lda     dp:.tiny _Dp
    \ 000015 49ffff               eor     ##-1
    \ 000018 86..                 stx     dp:.tiny (_Dp+2)
    \ 00001a 85..                 sta     dp:.tiny _Dp
0035                      return (unsigned int)(crc >> 16) ^ (unsigned int)crc;
    \ 00001c 45..                 eor     dp:.tiny (_Dp+2)
0036                  }
    \ 00001e 7a                   ply
    \ 00001f 60                   rts
    \ 000020 bb       `?L11`:     tyx
    \ 000021 bd....               lda     data,x
    \ 000024 29ff00               and     ##255
    \ 000027 eb                   xba
    \ 000028 2900ff               and     ##-256
    \ 00002b aa                   tax
    \ 00002c a90000               lda     ##0
    \ 00002f 86..                 stx     dp:.tiny (_Dp+6)
    \ 000031 85..                 sta     dp:.tiny (_Dp+4)
    \ 000033 a5..                 lda     dp:.tiny (_Dp+2)
    \ 000035 45..                 eor     dp:.tiny (_Dp+6)
    \ 000037 aa                   tax
    \ 000038 a5..                 lda     dp:.tiny _Dp
    \ 00003a 45..                 eor     dp:.tiny (_Dp+4)
    \ 00003c 86..                 stx     dp:.tiny (_Dp+2)
    \ 00003e 85..                 sta     dp:.tiny _Dp
    \ 000040 a90800               lda     ##8
    \ 000043 e220                 sep     #32
    \ 000045 8301                 sta     1,s
    \ 000047 a301     `?L16`:     lda     1,s
    \ 000049 c220                 rep     #32
    \ 00004b d003                 bne     `?L15`
    \ 00004d c8                   iny
    \ 00004e 80b8                 bra     `?L12`
    \ 000050          `?L15`:
    \ 000050 a5..                 lda     dp:.tiny (_Dp+2)
    \ 000052 1015                 bpl     `?L19`
    \ 000054 06..                 asl     dp:.tiny _Dp
    \ 000056 26..                 rol     dp:.tiny (_Dp+2)
    \ 000058 a5..                 lda     dp:.tiny (_Dp+2)
    \ 00005a 49c104               eor     ##0x4c1
    \ 00005d aa                   tax
    \ 00005e a5..                 lda     dp:.tiny _Dp
    \ 000060 49b71d               eor     ##0x1db7
    \ 000063 86..                 stx     dp:.tiny (_Dp+2)
    \ 000065 85..                 sta     dp:.tiny _Dp
    \ 000067 8004                 bra     `?L17`
    \ 000069          `?L19`:
    \ 000069 06..                 asl     dp:.tiny _Dp
    \ 00006b 26..                 rol     dp:.tiny (_Dp+2)
    \ 00006d 3b       `?L17`:     tsc
    \ 00006e 1a                   inc     a
    \ 00006f aa                   tax
    \ 000070 e220                 sep     #32
    \ 000072 de0000               dec     0,x
    \ 000075 80d0                 bra     `?L16`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  159 bytes
Zero initialized   (BSS): 1024 bytes
