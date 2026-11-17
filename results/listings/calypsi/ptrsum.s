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
0001                  /* Sum 512 bytes through a pointer argument. */
0002                  #define N 512
0003
0004                  unsigned char buf[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public buf
    \ 000000          buf:        .space  0x200
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
    \ 000006 e00002   `?L5`:      cpx     ##0x200
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
0015                  unsigned int sum_bytes(const unsigned char *p, unsigned int n)
0016                  {
    \ 000000                      .section code,text
    \ 000000                      .public sum_bytes
    \ 000000 5a       sum_bytes:  phy
    \ 000001 5a                   phy
    \ 000002 5a                   phy
    \ 000003 8301                 sta     1,s
0017                      unsigned int i, s = 0;
    \ 000005 a90000               lda     ##0
0018                      for (i = 0; i < n; i++)
    \ 000008 aa                   tax
    \ 000009          `?L12`:
    \ 000009 e4..                 cpx     dp:.tiny _Dp
    \ 00000b 9004                 bcc     `?L11`
0019                          s += p[i];
0020                      return s;
0021                  }
    \ 00000d 7a                   ply
    \ 00000e 7a                   ply
    \ 00000f 7a                   ply
    \ 000010 60                   rts
    \ 000011          `?L11`:
    \ 000011 85..                 sta     dp:.tiny (_Dp+2)
    \ 000013 9b                   txy
    \ 000014 b301                 lda     (1,s),y
    \ 000016 29ff00               and     ##255
    \ 000019 18                   clc
    \ 00001a 65..                 adc     dp:.tiny (_Dp+2)
    \ 00001c 8303                 sta     3,s
    \ 00001e 8a                   txa
    \ 00001f 1a                   inc     a
    \ 000020 8305                 sta     5,s
    \ 000022 aa                   tax
    \ 000023 a303                 lda     3,s
    \ 000025 80e2                 bra     `?L12`
0022
0023                  unsigned int bench(void)
0024                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000          bench:
0025                      return sum_bytes(buf, N);
    \ 000000 a20002               ldx     ##0x200
    \ 000003 86..                 stx     dp:.tiny _Dp
    \ 000005 a9....               lda     ##buf
    \ 000008 20....               jsr     sum_bytes
0026                  }
    \ 00000b 60                   rts

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  91 bytes
Zero initialized   (BSS): 512 bytes
