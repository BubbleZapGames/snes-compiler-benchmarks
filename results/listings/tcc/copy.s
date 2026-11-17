.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_init_locals 4
.define __bench_locals 2

.SECTION ".bench_inittext_0x0" SUPERFREE

.define __bench_init_ret 0
bench_init:
.ifgr __bench_init_locals 0
tsa
sec
sbc #__bench_init_locals
tas
.endif
lda.w #1
sta -4 + __bench_init_locals + 1,s
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_init_locals + 1,s
__local_2:
cmp.w #1024
bcc __local_1
brl __local_0
__local_3:
txa
inc a
sta -2 + __bench_init_locals + 1,s
bra __local_2
__local_1:
lda -4 + __bench_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda -4 + __bench_init_locals + 1,s
clc
adc.b tcc__r0
clc
adc.w #13849
sta -4 + __bench_init_locals + 1,s
lda -2 + __bench_init_locals + 1,s
tax
lda -4 + __bench_init_locals + 1,s
xba
and #$00ff
and.w #255
sep #$20
sta.l src,x
rep #$20
bra __local_3
__local_0:
.ifgr __bench_init_locals 0
tsa
clc
adc #__bench_init_locals
tas
.endif
rtl
.ENDS

.SECTION ".benchtext_0x1" SUPERFREE

.define __bench_ret 1
bench:
.ifgr __bench_locals 0
tsa
sec
sbc #__bench_locals
tas
.endif
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_locals + 1,s
__local_6:
cmp.w #1024
bcc __local_5
brl __local_4
__local_7:
txa
inc a
sta -2 + __bench_locals + 1,s
bra __local_6
__local_5:
tax
lda.l src,x
and.w #$00FF
sep #$20
sta.l dst,x
rep #$20
bra __local_7
__local_4:
lda.w dst + 0
and.w #$00FF
sta.b tcc__r0
lda.w dst + 511
and.w #$00FF
clc
adc.b tcc__r0
sta.b tcc__r0
lda.w dst + 1023
and.w #$00FF
clc
adc.b tcc__r0
sta.b tcc__r0
__local_8:
.ifgr __bench_locals 0
tsa
clc
adc #__bench_locals
tas
.endif
rtl
.ENDS
.RAMSECTION "ram{WLA_FILENAME}.data" APPENDTO "globram.data"

.ENDS

.SECTION "{WLA_FILENAME}.data" APPENDTO "glob.data"

.ENDS

.SECTION ".rodata" SUPERFREE

.ENDS

.RAMSECTION ".bss" BANK $7e SLOT 2
src dsb 1024
dst dsb 1024
.ENDS
