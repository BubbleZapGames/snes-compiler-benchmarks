.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_locals 40

.SECTION ".bench_inittext_0x0" SUPERFREE

.define __bench_init_ret 0
bench_init:
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
sta -8 + __bench_locals + 1,s
sta -10 + __bench_locals + 1,s
sta -2 + __bench_locals + 1,s
__local_2:
cmp.w #196
beq +
bcc +
brl __local_0
+
bra __local_1
__local_3:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_2
__local_1:
asl a
sta.b tcc__r0
lda.w #:arr
sta.b tcc__r1h
lda.w #arr + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.w #2000
sta.b [tcc__r1]
bra __local_3
__local_0:
lda.w #196
sta -2 + __bench_locals + 1,s
__local_6:
cmp.w #0
beq ++
bcs +
++
brl __local_4
+
bra __local_5
__local_11:
lda -2 + __bench_locals + 1,s
sec
sbc.w #14
sta -2 + __bench_locals + 1,s
bra __local_6
__local_5:
stz.b tcc__r0
stz.b tcc__r1
lda.b tcc__r0
sta -16 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-16 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
lda -2 + __bench_locals + 1,s
sta -4 + __bench_locals + 1,s
__local_9:
cmp.w #0
beq ++
bcs +
++
brl __local_7
+
bra __local_8
__local_10:
lda -4 + __bench_locals + 1,s
clc
adc.w #65535
sta -4 + __bench_locals + 1,s
bra __local_9
__local_8:
asl a
dec a
sta -6 + __bench_locals + 1,s
lda -4 + __bench_locals + 1,s
stz.b tcc__r1
sta -20 + __bench_locals + 1,s
lda.b tcc__r1
sta -18 + __bench_locals + 1,s
lda -16 + __bench_locals + 1,s
sta.b tcc__r2
stz.b tcc__r0h
tsa
clc
adc #(-16 + __bench_locals + 1) + 2
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r1
lda.b tcc__r2
sta -22 + __bench_locals + 1,s
lda.b tcc__r1
sta -24 + __bench_locals + 1,s
lda -20 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-20 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda -22 + __bench_locals + 1,s
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r0
sta.b tcc__r10
stz.b tcc__r10h
jsr.l tcc__mull
stx.b tcc__r3
sty.b tcc__r4
lda -22 + __bench_locals + 1,s
sta.b tcc__r1
lda.b tcc__r2
sta.b tcc__r9
lda.b tcc__r1
sta.b tcc__r10
jsr.l tcc__mul
sta.b tcc__r1
lda -24 + __bench_locals + 1,s
sta.b tcc__r2
lda.b tcc__r0
sta.b tcc__r9
lda.b tcc__r2
sta.b tcc__r10
jsr.l tcc__mul
clc
adc.b tcc__r1
clc
adc.b tcc__r3
sta.b tcc__r3
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:arr
sta.b tcc__r1h
lda.w #arr + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r0
stz.b tcc__r1
lda.w #10000
sta.b tcc__r2
stz.b tcc__r5
lda.b tcc__r4
sta -28 + __bench_locals + 1,s
lda.b tcc__r3
sta -26 + __bench_locals + 1,s
lda.b tcc__r0
sta.b tcc__r9
stz.b tcc__r9h
lda.b tcc__r2
sta.b tcc__r10
stz.b tcc__r10h
jsr.l tcc__mull
stx.b tcc__r4
sty.b tcc__r3
lda.b tcc__r5
sta.b tcc__r9
lda.b tcc__r0
sta.b tcc__r10
jsr.l tcc__mul
sta.b tcc__r0
lda.b tcc__r2
sta.b tcc__r9
lda.b tcc__r1
sta.b tcc__r10
jsr.l tcc__mul
clc
adc.b tcc__r0
clc
adc.b tcc__r4
sta.b tcc__r4
lda.b tcc__r3
sta -32 + __bench_locals + 1,s
lda.b tcc__r4
sta -30 + __bench_locals + 1,s
lda -28 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-28 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
sta -34 + __bench_locals + 1,s
lda.b tcc__r2
sta -36 + __bench_locals + 1,s
stz.b tcc__r0h
tsa
clc
adc #(-32 + __bench_locals + 1) + 2
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r2
lda -34 + __bench_locals + 1,s
clc
adc -32 + __bench_locals + 1,s
sta.b tcc__r0
lda -36 + __bench_locals + 1,s
adc.b tcc__r2
sta.b tcc__r1
lda.b tcc__r0
sta -16 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-16 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
lda -4 + __bench_locals + 1,s
asl a
sta.b tcc__r0
lda.w #:arr
sta.b tcc__r1h
lda.w #arr + 0
clc
adc.b tcc__r0
sta.b tcc__r1
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
lda.w #0
pha
pei (tcc__r0)
lda.b tcc__r1
sta -36 + __bench_locals + 1,s
lda.b tcc__r1h
sta -34 + __bench_locals + 1,s
lda -12 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-12 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
pha
pei (tcc__r0)
jsr.l tcc__umoddi3
tsa
clc
adc #8
tas
lda -40 + __bench_locals + 1,s
sta.b tcc__r2
lda -38 + __bench_locals + 1,s
sta.b tcc__r2h
lda.b tcc__r0
sta.b [tcc__r2]
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
lda.w #0
pha
pei (tcc__r0)
lda -12 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-12 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
pha
pei (tcc__r0)
jsr.l tcc__udivdi3
tsa
clc
adc #8
tas
lda.b tcc__r0
sta -16 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-16 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
jmp.w __local_10
__local_7:
pea.w 0
pea.w 10000
lda -12 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-12 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
pha
pei (tcc__r0)
jsr.l tcc__udivdi3
tsa
clc
adc #8
tas
lda -8 + __bench_locals + 1,s
clc
adc.b tcc__r0
sta.b tcc__r2
lda -10 + __bench_locals + 1,s
clc
adc.b tcc__r2
sta -10 + __bench_locals + 1,s
pea.w 0
pea.w 10000
lda -12 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-12 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
pha
pei (tcc__r0)
jsr.l tcc__umoddi3
tsa
clc
adc #8
tas
lda.b tcc__r0
sta -8 + __bench_locals + 1,s
jmp.w __local_11
__local_4:
lda -10 + __bench_locals + 1,s
sta.b tcc__r0
__local_12:
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
arr dsb 394
.ENDS
