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
0001                  /* Bubble sort 64 bytes, then fold them into a checksum. */
0002                  #define N 64
0003
0004                  unsigned char arr[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public arr
    \ 000000          arr:        .space  64
0005
0006                  void bench_init(void)
0007                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000 5a       bench_init: phy
0008                      unsigned int v = 1;
    \ 000001 a00100               ldy     ##1
0009                      unsigned char i;
0010                      for (i = 0; i < N; i++) {
    \ 000004 a90000               lda     ##0
    \ 000007 e220                 sep     #32
    \ 000009 8301                 sta     1,s
    \ 00000b c220     `?L29`:     rep     #32
    \ 00000d a301                 lda     1,s
    \ 00000f e220                 sep     #32
    \ 000011 c940                 cmp     #64
    \ 000013 c220                 rep     #32
    \ 000015 9002                 bcc     `?L4`
0011                          v = (v << 2) + v + 0x3619;
0012                          arr[i] = (unsigned char)(v >> 8);
0013                      }
0014                  }
    \ 000017 7a                   ply
    \ 000018 60                   rts
    \ 000019 98       `?L4`:      tya
    \ 00001a 0a                   asl     a
    \ 00001b 0a                   asl     a
    \ 00001c 84..                 sty     dp:.tiny _Dp
    \ 00001e 18                   clc
    \ 00001f 65..                 adc     dp:.tiny _Dp
    \ 000021 18                   clc
    \ 000022 691936               adc     ##0x3619
    \ 000025 a8                   tay
    \ 000026 98                   tya
    \ 000027 eb                   xba
    \ 000028 29ff00               and     ##255
    \ 00002b 48                   pha
    \ 00002c a303                 lda     3,s
    \ 00002e 29ff00               and     ##255
    \ 000031 aa                   tax
    \ 000032 68                   pla
    \ 000033 e220                 sep     #32
    \ 000035 9d....               sta     arr,x
    \ 000038 c220                 rep     #32
    \ 00003a 3b                   tsc
    \ 00003b 1a                   inc     a
    \ 00003c aa                   tax
    \ 00003d e220                 sep     #32
    \ 00003f fe0000               inc     0,x
    \ 000042 80c7                 bra     `?L29`
0015
0016                  unsigned int bench(void)
0017                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
    \ 000001 5a                   phy
0018                      unsigned char i, j, t;
0019                      unsigned int s = 0;
    \ 000002 a00000               ldy     ##0
0020                      for (i = 0; i < N - 1; i++) {
    \ 000005 98                   tya
    \ 000006 e220                 sep     #32
    \ 000008 8302     `?L31`:     sta     2,s
    \ 00000a c220                 rep     #32
    \ 00000c a302                 lda     2,s
    \ 00000e e220                 sep     #32
    \ 000010 c93f                 cmp     #63
    \ 000012 c220                 rep     #32
    \ 000014 903a                 bcc     `?L11`
0021                          for (j = 0; j < N - 1 - i; j++) {
0022                              if (arr[j] > arr[j + 1]) {
0023                                  t = arr[j];
0024                                  arr[j] = arr[j + 1];
0025                                  arr[j + 1] = t;
0026                              }
0027                          }
0028                      }
0029                      for (i = 0; i < N; i++)
    \ 000016 98                   tya
    \ 000017 e220                 sep     #32
    \ 000019 8301                 sta     1,s
    \ 00001b c220                 rep     #32
    \ 00001d 98                   tya
    \ 00001e 8302                 sta     2,s
    \ 000020 a301     `?L23`:     lda     1,s
    \ 000022 e220                 sep     #32
    \ 000024 c940                 cmp     #64
    \ 000026 c220                 rep     #32
    \ 000028 9005                 bcc     `?L22`
0030                          s = (s << 1) ^ arr[i];
0031                      return s;
    \ 00002a a302                 lda     2,s
0032                  }
    \ 00002c 7a                   ply
    \ 00002d 7a                   ply
    \ 00002e 60                   rts
    \ 00002f a302     `?L22`:     lda     2,s
    \ 000031 0a                   asl     a
    \ 000032 85..                 sta     dp:.tiny _Dp
    \ 000034 a301                 lda     1,s
    \ 000036 29ff00               and     ##255
    \ 000039 aa                   tax
    \ 00003a bd....               lda     arr,x
    \ 00003d 29ff00               and     ##255
    \ 000040 45..                 eor     dp:.tiny _Dp
    \ 000042 8302                 sta     2,s
    \ 000044 3b                   tsc
    \ 000045 1a                   inc     a
    \ 000046 aa                   tax
    \ 000047 e220                 sep     #32
    \ 000049 fe0000               inc     0,x
    \ 00004c c220                 rep     #32
    \ 00004e 80d0                 bra     `?L23`
    \ 000050 98       `?L11`:     tya
    \ 000051 e220                 sep     #32
    \ 000053 8304     `?L30`:     sta     4,s
    \ 000055 c220                 rep     #32
    \ 000057 20....               jsr     `?L32`
    \ 00005a 48                   pha
    \ 00005b a304                 lda     4,s
    \ 00005d 29ff00               and     ##255
    \ 000060 85..                 sta     dp:.tiny _Dp
    \ 000062 a93f00               lda     ##63
    \ 000065 38                   sec
    \ 000066 e5..                 sbc     dp:.tiny _Dp
    \ 000068 85..                 sta     dp:.tiny _Dp
    \ 00006a 68                   pla
    \ 00006b 38                   sec
    \ 00006c e5..                 sbc     dp:.tiny _Dp
    \ 00006e 5003                 bvc     `?L27`
    \ 000070 490080               eor     ##-32768
    \ 000073 3009     `?L27`:     bmi     `?L15`
    \ 000075 a302                 lda     2,s
    \ 000077 1a                   inc     a
    \ 000078 e220                 sep     #32
    \ 00007a 8301                 sta     1,s
    \ 00007c 808a                 bra     `?L31`
    \ 00007e          `?L15`:
    \ 00007e 20....               jsr     `?L32`
    \ 000081 aa                   tax
    \ 000082 bd....               lda     arr+1,x
    \ 000085 48                   pha
    \ 000086 a306                 lda     6,s
    \ 000088 29ff00               and     ##255
    \ 00008b aa                   tax
    \ 00008c 68                   pla
    \ 00008d e220                 sep     #32
    \ 00008f dd....               cmp     arr,x
    \ 000092 c220                 rep     #32
    \ 000094 b030                 bcs     `?L17`
    \ 000096 20....               jsr     `?L32`
    \ 000099 aa                   tax
    \ 00009a e220                 sep     #32
    \ 00009c bd....               lda     arr,x
    \ 00009f 8301                 sta     1,s
    \ 0000a1 c220                 rep     #32
    \ 0000a3 20....               jsr     `?L32`
    \ 0000a6 aa                   tax
    \ 0000a7 bd....               lda     arr+1,x
    \ 0000aa 48                   pha
    \ 0000ab a306                 lda     6,s
    \ 0000ad 29ff00               and     ##255
    \ 0000b0 aa                   tax
    \ 0000b1 68                   pla
    \ 0000b2 e220                 sep     #32
    \ 0000b4 9d....               sta     arr,x
    \ 0000b7 c220                 rep     #32
    \ 0000b9 20....               jsr     `?L32`
    \ 0000bc aa                   tax
    \ 0000bd e220                 sep     #32
    \ 0000bf a301                 lda     1,s
    \ 0000c1 9d....               sta     arr+1,x
    \ 0000c4 c220                 rep     #32
    \ 0000c6 a304     `?L17`:     lda     4,s
    \ 0000c8 1a                   inc     a
    \ 0000c9 e220                 sep     #32
    \ 0000cb 8301                 sta     1,s
    \ 0000cd 8084                 bra     `?L30`
    \ 000000                      .section code,text
    \ 000000 a306     `?L32`:     lda     6,s
    \ 000002 29ff00               and     ##255
    \ 000005 60                   rts

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text): 281 bytes
Zero initialized   (BSS):  64 bytes
