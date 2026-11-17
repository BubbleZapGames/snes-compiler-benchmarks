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
0001                  /* Sum a 256-entry u16 array. */
0002                  #define N 256
0003
0004                  unsigned int data[N];
    \ 000000                      .section zdata,bss
    \ 000000                      .public data
    \ 000000          data:       .space  0x200
0005
0006                  void bench_init(void)
0007                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench_init
    \ 000000 5a       bench_init: phy
0008                      unsigned int i, v = 1;
    \ 000001 a20100               ldx     ##1
0009                      for (i = 0; i < N; i++) {
    \ 000004 a00000               ldy     ##0
    \ 000007 c00001   `?L5`:      cpy     ##256
    \ 00000a 9002                 bcc     `?L4`
0010                          v = (v << 2) + v + 0x3619;
0011                          data[i] = v;
0012                      }
0013                  }
    \ 00000c 7a                   ply
    \ 00000d 60                   rts
    \ 00000e 8a       `?L4`:      txa
    \ 00000f 0a                   asl     a
    \ 000010 0a                   asl     a
    \ 000011 86..                 stx     dp:.tiny _Dp
    \ 000013 18                   clc
    \ 000014 65..                 adc     dp:.tiny _Dp
    \ 000016 18                   clc
    \ 000017 691936               adc     ##0x3619
    \ 00001a 8301                 sta     1,s
    \ 00001c 98                   tya
    \ 00001d 0a                   asl     a
    \ 00001e aa                   tax
    \ 00001f a301                 lda     1,s
    \ 000021 9d....               sta     data,x
    \ 000024 c8                   iny
    \ 000025 aa                   tax
    \ 000026 80df                 bra     `?L5`
0014
0015                  unsigned int bench(void)
0016                  {
    \ 000000                      .section code,text
    \ 000000                      .public bench
    \ 000000 5a       bench:      phy
0017                      unsigned int i, s = 0;
    \ 000001 a90000               lda     ##0
0018                      for (i = 0; i < N; i++)
    \ 000004 a8                   tay
    \ 000005 8301                 sta     1,s
    \ 000007 c00001   `?L12`:     cpy     ##256
    \ 00000a 9004                 bcc     `?L11`
0019                          s += data[i];
0020                      return s;
    \ 00000c a301                 lda     1,s
0021                  }
    \ 00000e 7a                   ply
    \ 00000f 60                   rts
    \ 000010 98       `?L11`:     tya
    \ 000011 0a                   asl     a
    \ 000012 aa                   tax
    \ 000013 bd....               lda     data,x
    \ 000016 18                   clc
    \ 000017 6301                 adc     1,s
    \ 000019 8301                 sta     1,s
    \ 00001b c8                   iny
    \ 00001c 80e9                 bra     `?L12`

##########################
#                        #
# Memory sizes (decimal) #
#                        #
##########################

Executable        (Text):  70 bytes
Zero initialized   (BSS): 512 bytes
