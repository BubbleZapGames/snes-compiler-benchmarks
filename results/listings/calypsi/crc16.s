###############################################################################
#                                                                             #
# Calypsi ISO C compiler for 65816                               version 5.18 #
#                                                       17/Nov/2026  01:56:13 #
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
0001                  /* Bitwise CRC-16/CCITT-FALSE over 256 bytes. */
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
0017                      unsigned int i, crc = 0xFFFF;
    \ 000002 a2ffff               ldx     ##-1
0018                      unsigned char b;
0019                      for (i = 0; i < N; i++) {
    \ 000005 a00000               ldy     ##0
    \ 000008 c00001   `?L12`:     cpy     ##256
    \ 00000b 9004                 bcc     `?L11`
0020                          crc ^= (unsigned int)buf[i] << 8;
0021                          for (b = 0; b < 8; b++) {
0022                              if (crc & 0x8000)
0023                                  crc = (crc << 1) ^ 0x1021;
0024                              else
0025                                  crc <<= 1;
0026                          }
0027                      }
0028                      return crc;
    \ 00000d 8a                   txa
0029                  }
    \ 00000e 7a                   ply
    \ 00000f 7a                   ply
    \ 000010 60                   rts
    \ 000011          `?L11`:
    \ 000011 86..                 stx     dp:.tiny _Dp
    \ 000013 bb                   tyx
    \ 000014 bd....               lda     buf,x
    \ 000017 29ff00               and     ##255
    \ 00001a eb                   xba
    \ 00001b 2900ff               and     ##-256
    \ 00001e 45..                 eor     dp:.tiny _Dp
    \ 000020 aa                   tax
    \ 000021 a90000               lda     ##0
    \ 000024 e220                 sep     #32
    \ 000026 8303                 sta     3,s
    \ 000028 c220     `?L23`:     rep     #32
    \ 00002a a303                 lda     3,s
    \ 00002c e220                 sep     #32
    \ 00002e c908                 cmp     #8
    \ 000030 c220                 rep     #32
    \ 000032 9003                 bcc     `?L15`
    \ 000034 c8                   iny
    \ 000035 80d1                 bra     `?L12`
    \ 000037          `?L15`:
    \ 000037 86..                 stx     dp:.tiny _Dp
    \ 000039 a5..                 lda     dp:.tiny _Dp
    \ 00003b 1009                 bpl     `?L19`
    \ 00003d 8a                   txa
    \ 00003e 0a                   asl     a
    \ 00003f 492110               eor     ##0x1021
    \ 000042 8301                 sta     1,s
    \ 000044 8004                 bra     `?L17`
    \ 000046 8a       `?L19`:     txa
    \ 000047 0a                   asl     a
    \ 000048 8301                 sta     1,s
    \ 00004a 3b       `?L17`:     tsc
    \ 00004b 18                   clc
    \ 00004c 690300               adc     ##3
    \ 00004f aa                   tax
    \ 000050 e220                 sep     #32
    \ 000052 fe0000               inc     0,x
    \ 000055 c220                 rep     #32
    \ 000057 a301                 lda     1,s
    \ 000059 aa                   tax
    \ 00005a 80cc                 bra     `?L23`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text): 132 bytes
Zero initialized   (BSS): 256 bytes
