.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_init_locals 2
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
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_init_locals + 1,s
__local_2:
cmp.w #32
bcc __local_1
brl __local_0
__local_3:
lda -2 + __bench_init_locals + 1,s
inc a
sta -2 + __bench_init_locals + 1,s
bra __local_2
__local_1:
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -2 + __bench_init_locals + 1,s
asl a
asl a
asl a
sec
sbc -2 + __bench_init_locals + 1,s
sta.l ents,x
lda -2 + __bench_init_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -2 + __bench_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda -2 + __bench_init_locals + 1,s
clc
adc.b tcc__r0
sta.w ents + 2,x
lda -2 + __bench_init_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -2 + __bench_init_locals + 1,s
and.w #3
inc a
sta.w ents + 4,x
lda -2 + __bench_init_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -2 + __bench_init_locals + 1,s
and.w #1
inc a
inc a
sta.w ents + 6,x
lda -2 + __bench_init_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r0
lda.w #:ents
sta.b tcc__r1h
lda.w #ents + 0
clc
adc.b tcc__r0
clc
adc.w #8
sta.b tcc__r1
lda -2 + __bench_init_locals + 1,s
and.w #3
ldx #1
sec
sbc #0
tay
bne +
dex
+
stx.b tcc__r5
sep #$20
lda.b tcc__r5
sta.b [tcc__r1]
rep #$20
jmp.w __local_3
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
sta -2 + __bench_locals + 1,s
__local_6:
cmp.w #16
bcc __local_5
brl __local_4
__local_14:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_6
__local_5:
stz.b tcc__r0
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
__local_9:
cmp.w #32
bcc __local_8
bra __local_14
__local_13:
lda -4 + __bench_locals + 1,s
inc a
sta -4 + __bench_locals + 1,s
bra __local_9
__local_8:
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda.w ents + 8,x
and.w #$00FF
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
beq __local_13
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r0
lda.w #:ents
sta.b tcc__r2h
lda.w #ents + 0
clc
adc.b tcc__r0
clc
adc.w #4
sta.b tcc__r2
lda.l ents,x
sta.b tcc__r0
lda.b [tcc__r2]
clc
adc.b tcc__r0
sta.l ents,x
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda.l ents,x
cmp.w #240
beq ++
bcs +
++
brl __local_11
+
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r0
lda.w #ents + 0
clc
adc.b tcc__r0
clc
adc.w #4
sta.b tcc__r2
stz.b tcc__r0
lda.b [tcc__r2]
sta.b tcc__r3
sec
lda.b tcc__r0
sbc.b tcc__r3
sta.w ents + 4,x
__local_11:
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r0
lda.w #ents + 0
clc
adc.b tcc__r0
clc
adc.w #6
sta.b tcc__r2
lda.w ents + 2,x
sta.b tcc__r0
lda.b [tcc__r2]
clc
adc.b tcc__r0
sta.w ents + 2,x
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda.w ents + 2,x
cmp.w #200
beq ++
bcs +
++
jmp.w __local_13
+
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r0
lda.w #ents + 0
clc
adc.b tcc__r0
clc
adc.w #6
sta.b tcc__r2
stz.b tcc__r0
lda.b [tcc__r2]
sta.b tcc__r3
sec
lda.b tcc__r0
sbc.b tcc__r3
sta.w ents + 6,x
__local_12:
__local_10:
jmp.w __local_13
__local_7:
jmp.w __local_14
__local_4:
stz.b tcc__r0
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
__local_17:
cmp.w #32
bcc __local_16
brl __local_15
__local_18:
lda -4 + __bench_locals + 1,s
inc a
sta -4 + __bench_locals + 1,s
bra __local_17
__local_16:
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
tax
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r10
asl a
asl a
clc
adc.b tcc__r10
sta.b tcc__r2
lda.l ents,x
sta.b tcc__r0
ldx.b tcc__r2
lda.w ents + 2,x
clc
adc.b tcc__r0
sta.b tcc__r0
lda -6 + __bench_locals + 1,s
clc
adc.b tcc__r0
sta -6 + __bench_locals + 1,s
bra __local_18
__local_15:
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
__local_19:
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
ents dsb 320
.ENDS
