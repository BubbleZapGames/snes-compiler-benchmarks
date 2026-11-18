.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __fact_locals 8
.define __bench_locals 28

.SECTION ".bench_inittext_0x0" SUPERFREE

.define __bench_init_ret 0
bench_init:
lda.w #20
sta.w n_iter + 0
lda.w #16
sta.w size + 0
rtl
.ENDS

.SECTION ".facttext_0x1" SUPERFREE

.define __fact_ret 3
fact:
.ifgr __fact_locals 0
tsa
sec
sbc #__fact_locals
tas
.endif
lda 3 + __fact_locals + 1,s
cmp.w #1
beq ++
bcs +
++
brl __local_0
+
sta.b tcc__r0
dec.b tcc__r0
pei (tcc__r0)
jsr.l fact
pla
lda.b tcc__r0
sta -4 + __fact_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-4 + __fact_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
lda 3 + __fact_locals + 1,s
stz.b tcc__r1
sta -6 + __fact_locals + 1,s
lda.b tcc__r1
sta -8 + __fact_locals + 1,s
lda -4 + __fact_locals + 1,s
sta.b tcc__r2
stz.b tcc__r0h
tsa
clc
adc #(-4 + __fact_locals + 1) + 2
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r1
lda -6 + __fact_locals + 1,s
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r2
sta.b tcc__r10
stz.b tcc__r10h
jsr.l tcc__mull
stx.b tcc__r3
sty.b tcc__r4
lda -6 + __fact_locals + 1,s
sta.b tcc__r0
lda.b tcc__r1
sta.b tcc__r9
lda.b tcc__r0
sta.b tcc__r10
jsr.l tcc__mul
sta.b tcc__r0
lda -8 + __fact_locals + 1,s
sta.b tcc__r1
lda.b tcc__r2
sta.b tcc__r9
lda.b tcc__r1
sta.b tcc__r10
jsr.l tcc__mul
clc
adc.b tcc__r0
clc
adc.b tcc__r3
sta.b tcc__r3
lda.b tcc__r4
sta.b tcc__r0
lda.b tcc__r4h
sta.b tcc__r0h
lda.b tcc__r3
sta.b tcc__r1
lda.b tcc__r3h
sta.b tcc__r1h
bra __local_1
__local_0:
lda.w #1
sta.b tcc__r0
lda.w #0
sta.b tcc__r1
__local_1:
__local_2:
.ifgr __fact_locals 0
tsa
clc
adc #__fact_locals
tas
.endif
rtl
.ENDS

.SECTION ".benchtext_0x2" SUPERFREE

.define __bench_ret 1
bench:
.ifgr __bench_locals 0
tsa
sec
sbc #__bench_locals
tas
.endif
stz.b tcc__r0
stz.b tcc__r1
lda.b tcc__r0
sta -8 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-8 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
sta -4 + __bench_locals + 1,s
__local_5:
sta.b tcc__r0
lda.w size + 0
sta.b tcc__r1
lda.b tcc__r0
cmp.b tcc__r1
bcc __local_4
brl __local_3
__local_6:
lda -4 + __bench_locals + 1,s
inc a
sta -4 + __bench_locals + 1,s
bra __local_5
__local_4:
asl a
asl a
sta.b tcc__r0
lda.w #:array
sta.b tcc__r1h
lda.w #array + 0
clc
adc.b tcc__r0
sta.b tcc__r1
stz.b tcc__r0
lda.b tcc__r0
sta.b [tcc__r1]
inc.b tcc__r1
inc.b tcc__r1
sta.b [tcc__r1]
bra __local_6
__local_3:
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_locals + 1,s
__local_9:
sta.b tcc__r0
lda.w n_iter + 0
sta.b tcc__r1
lda.b tcc__r0
cmp.b tcc__r1
bcc __local_8
brl __local_7
__local_14:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_9
__local_8:
stz.b tcc__r0
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
__local_12:
sta.b tcc__r0
lda.w size + 0
sta.b tcc__r1
lda.b tcc__r0
cmp.b tcc__r1
bcc __local_11
bra __local_14
__local_13:
lda -4 + __bench_locals + 1,s
inc a
sta -4 + __bench_locals + 1,s
bra __local_12
__local_11:
asl a
asl a
sta.b tcc__r0
lda.w #:array
sta.b tcc__r1h
lda.w #array + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda -4 + __bench_locals + 1,s
pha
lda.b tcc__r1
sta -10 + __bench_locals + 1,s
lda.b tcc__r1h
sta -8 + __bench_locals + 1,s
jsr.l fact
pla
lda.b tcc__r0
sta -16 + __bench_locals + 1,s
lda.b tcc__r1
sta -14 + __bench_locals + 1,s
lda -12 + __bench_locals + 1,s
sta.b tcc__r10
lda -10 + __bench_locals + 1,s
sta.b tcc__r10h
lda.b [tcc__r10]
sta.b tcc__r2
lda -10 + __bench_locals + 1,s
sta.b tcc__r0h
lda -12 + __bench_locals + 1,s
inc a
inc a
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r1
lda.b tcc__r2
sta -18 + __bench_locals + 1,s
lda.b tcc__r1
sta -20 + __bench_locals + 1,s
stz.b tcc__r1h
tsa
clc
adc #(-16 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda -18 + __bench_locals + 1,s
clc
adc -16 + __bench_locals + 1,s
sta.b tcc__r1
lda -20 + __bench_locals + 1,s
adc.b tcc__r2
sta.b tcc__r0
lda -12 + __bench_locals + 1,s
sta.b tcc__r2
lda -10 + __bench_locals + 1,s
sta.b tcc__r2h
lda.b tcc__r1
sta.b [tcc__r2]
inc.b tcc__r2
inc.b tcc__r2
lda.b tcc__r0
sta.b [tcc__r2]
jmp.w __local_13
__local_10:
jmp.w __local_14
__local_7:
stz.b tcc__r0
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
__local_17:
sta.b tcc__r0
lda.w size + 0
sta.b tcc__r1
lda.b tcc__r0
cmp.b tcc__r1
bcc __local_16
brl __local_15
__local_18:
lda -4 + __bench_locals + 1,s
inc a
sta -4 + __bench_locals + 1,s
bra __local_17
__local_16:
asl a
asl a
sta.b tcc__r0
lda.w #:array
sta.b tcc__r1h
lda.w #array + 0
clc
adc.b tcc__r0
sta -24 + __bench_locals + 1,s
lda.b tcc__r1h
sta -22 + __bench_locals + 1,s
lda -8 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-8 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
sta -26 + __bench_locals + 1,s
lda.b tcc__r2
sta -28 + __bench_locals + 1,s
lda -24 + __bench_locals + 1,s
sta.b tcc__r10
lda -22 + __bench_locals + 1,s
sta.b tcc__r10h
lda.b [tcc__r10]
sta.b tcc__r1
lda -22 + __bench_locals + 1,s
sta.b tcc__r0h
lda -24 + __bench_locals + 1,s
inc a
inc a
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r2
lda -26 + __bench_locals + 1,s
clc
adc.b tcc__r1
sta.b tcc__r0
lda -28 + __bench_locals + 1,s
adc.b tcc__r2
sta.b tcc__r1
lda.b tcc__r0
sta -8 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-8 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
jmp.w __local_18
__local_15:
stz.b tcc__r1h
tsa
clc
adc #(-8 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
eor -8 + __bench_locals + 1,s
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
array dsb 64
n_iter dsb 2
size dsb 2
.ENDS
