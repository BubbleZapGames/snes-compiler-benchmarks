.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_init_locals 3
.define __bench_locals 6

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
sta -2 + __bench_init_locals + 1,s
lda.w #0
sep #$20
sta -3 + __bench_init_locals + 1,s
rep #$20
__local_2:
lda -3 + __bench_init_locals + 1,s
and.w #$00FF
sec
sbc.w #64
bvc +
eor #$8000
+
bmi __local_1
brl __local_0
__local_3:
sep #$20
lda -3 + __bench_init_locals + 1,s
inc a
sta -3 + __bench_init_locals + 1,s
rep #$20
bra __local_2
__local_1:
lda -2 + __bench_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda -2 + __bench_init_locals + 1,s
clc
adc.b tcc__r0
clc
adc.w #13849
sta -2 + __bench_init_locals + 1,s
lda -3 + __bench_init_locals + 1,s
and.w #$00FF
tax
lda -2 + __bench_init_locals + 1,s
xba
and #$00ff
and.w #255
sep #$20
sta.l arr,x
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
sta -6 + __bench_locals + 1,s
sep #$20
sta -1 + __bench_locals + 1,s
rep #$20
__local_6:
lda -1 + __bench_locals + 1,s
and.w #$00FF
cmp.w #63
bcc __local_5
brl __local_4
__local_12:
sep #$20
lda -1 + __bench_locals + 1,s
inc a
sta -1 + __bench_locals + 1,s
rep #$20
bra __local_6
__local_5:
lda.w #0
sep #$20
sta -2 + __bench_locals + 1,s
rep #$20
__local_9:
lda -1 + __bench_locals + 1,s
and.w #$00FF
sta.b tcc__r0
lda.w #63
sec
sbc.b tcc__r0
sta.b tcc__r1
lda -2 + __bench_locals + 1,s
and.w #$00FF
sec
sbc.b tcc__r1
bvc +
eor #$8000
+
bmi __local_8
bra __local_12
__local_11:
sep #$20
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
rep #$20
bra __local_9
__local_8:
lda -2 + __bench_locals + 1,s
and.w #$00FF
tax
lda -2 + __bench_locals + 1,s
and.w #$00FF
inc a
sta.b tcc__r2
lda.l arr,x
and.w #$00FF
sta.b tcc__r0
lda.w #0
sep #$20
ldx.b tcc__r2
lda.l arr,x
rep #$20
sta.b tcc__r1
lda.b tcc__r0
sec
sbc.b tcc__r1
beq ++
bvc +
eor #$8000
+
bpl +++
++
jmp.w __local_11
+++
lda -2 + __bench_locals + 1,s
and.w #$00FF
tax
lda.w #0
sep #$20
lda.l arr,x
sta -3 + __bench_locals + 1,s
rep #$20
lda -2 + __bench_locals + 1,s
and.w #$00FF
tax
lda -2 + __bench_locals + 1,s
and.w #$00FF
inc a
sta.b tcc__r0
lda.w #:arr
sta.b tcc__r2h
lda.w #arr + 0
clc
adc.b tcc__r0
sta.b tcc__r2
lda.w #0
sep #$20
lda.b [tcc__r2]
sta.l arr,x
rep #$20
lda -2 + __bench_locals + 1,s
and.w #$00FF
inc a
tax
lda -3 + __bench_locals + 1,s
and.w #$00FF
sep #$20
sta.l arr,x
rep #$20
__local_10:
jmp.w __local_11
__local_7:
jmp.w __local_12
__local_4:
lda.w #0
sep #$20
sta -1 + __bench_locals + 1,s
rep #$20
__local_15:
lda -1 + __bench_locals + 1,s
and.w #$00FF
cmp.w #64
bcc __local_14
brl __local_13
__local_16:
sep #$20
lda -1 + __bench_locals + 1,s
inc a
sta -1 + __bench_locals + 1,s
rep #$20
bra __local_15
__local_14:
lda -6 + __bench_locals + 1,s
asl a
sta.b tcc__r0
lda -1 + __bench_locals + 1,s
and.w #$00FF
tax
lda.l arr,x
and.w #$00FF
sta.b tcc__r1
lda.b tcc__r0
eor.b tcc__r1
sta -6 + __bench_locals + 1,s
bra __local_16
__local_13:
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
__local_17:
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
arr dsb 64
.ENDS
