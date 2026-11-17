.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_init_locals 4
.define __bench_locals 16

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
sta.l data,x
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
stz.b tcc__r1
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
stz.b tcc__r2h
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r1
sta.b [tcc__r2]
sta -6 + __bench_locals + 1,s
__local_6:
cmp.w #1024
bcc __local_5
brl __local_4
__local_13:
lda -6 + __bench_locals + 1,s
inc a
sta -6 + __bench_locals + 1,s
bra __local_6
__local_5:
tax
lda.w #0
sep #$20
lda.l data,x
rep #$20
+
xba
and #$ff00
sta.b tcc__r1
stz.b tcc__r0
lda.b tcc__r0
sta -12 + __bench_locals + 1,s
lda.b tcc__r1
sta -10 + __bench_locals + 1,s
lda -4 + __bench_locals + 1,s
sta.b tcc__r2
stz.b tcc__r0h
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r0
lda.b [tcc__r0]
sta.b tcc__r1
lda.b tcc__r2
sta -14 + __bench_locals + 1,s
lda.b tcc__r1
sta -16 + __bench_locals + 1,s
stz.b tcc__r1h
tsa
clc
adc #(-12 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda -14 + __bench_locals + 1,s
eor.w #0
sta.b tcc__r1
lda -16 + __bench_locals + 1,s
eor.b tcc__r2
sta.b tcc__r0
lda.b tcc__r1
sta -4 + __bench_locals + 1,s
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r0
sta.b [tcc__r2]
lda.w #8
sep #$20
sta -7 + __bench_locals + 1,s
rep #$20
__local_9:
lda -7 + __bench_locals + 1,s
and.w #$00FF
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne __local_8
jmp.w __local_13
__local_12:
sep #$20
lda -7 + __bench_locals + 1,s
dec a
sta -7 + __bench_locals + 1,s
rep #$20
bra __local_9
__local_8:
lda -4 + __bench_locals + 1,s
sta.b tcc__r0
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
and.w #0
sta.b tcc__r0
lda.b tcc__r2
and.w #32768
ora.b tcc__r0
bne +
brl __local_10
+
lda -4 + __bench_locals + 1,s
sta.b tcc__r0
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
asl a
sta.b tcc__r1
lda.b tcc__r0
xba
and.w #$00ff
lsr a
lsr a
lsr a
lsr a
lsr a
lsr a
lsr a
+
asl.b tcc__r2
ora.b tcc__r2
sta.b tcc__r0
lda.b tcc__r1
eor.w #7607
sta.b tcc__r1
lda.b tcc__r0
eor.w #1217
sta.b tcc__r0
lda.b tcc__r1
sta -4 + __bench_locals + 1,s
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r0
sta.b [tcc__r2]
jmp.w __local_12
__local_10:
lda -4 + __bench_locals + 1,s
sta.b tcc__r0
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
asl a
sta.b tcc__r1
lda.b tcc__r0
xba
and.w #$00ff
lsr a
lsr a
lsr a
lsr a
lsr a
lsr a
lsr a
+
asl.b tcc__r2
ora.b tcc__r2
sta.b tcc__r0
lda.b tcc__r1
sta -4 + __bench_locals + 1,s
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r2
lda.b tcc__r0
sta.b [tcc__r2]
__local_11:
jmp.w __local_12
__local_7:
jmp.w __local_13
__local_4:
lda -4 + __bench_locals + 1,s
sta.b tcc__r0
stz.b tcc__r1h
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
sta.b tcc__r2
lda.b tcc__r0
eor.w #65535
sta.b tcc__r0
lda.b tcc__r2
eor.w #65535
sta.b tcc__r2
lda.b tcc__r0
sta -4 + __bench_locals + 1,s
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b tcc__r2
sta.b [tcc__r1]
tsa
clc
adc #(-4 + __bench_locals + 1) + 2
sta.b tcc__r1
lda.b [tcc__r1]
eor -4 + __bench_locals + 1,s
sta.b tcc__r0
__local_14:
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
data dsb 1024
.ENDS
