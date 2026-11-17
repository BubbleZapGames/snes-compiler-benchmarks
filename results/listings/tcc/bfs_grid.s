.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_init_locals 8
.define __bench_locals 9

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
sta -8 + __bench_init_locals + 1,s
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_init_locals + 1,s
__local_2:
cmp.w #1024
bcc __local_1
brl __local_0
__local_10:
txa
inc a
sta -2 + __bench_init_locals + 1,s
bra __local_2
__local_1:
lda -8 + __bench_init_locals + 1,s
asl a
asl a
sta.b tcc__r0
lda -8 + __bench_init_locals + 1,s
clc
adc.b tcc__r0
clc
adc.w #13849
sta -8 + __bench_init_locals + 1,s
lda -2 + __bench_init_locals + 1,s
and.w #31
sta -4 + __bench_init_locals + 1,s
lda -2 + __bench_init_locals + 1,s
lsr a
lsr a
lsr a
lsr a
lsr a
+
sta -6 + __bench_init_locals + 1,s
lda -4 + __bench_init_locals + 1,s
cmp #0
bne +
bra __local_7
+
cmp #31
bne +
__local_3:
bra __local_7
+
lda -6 + __bench_init_locals + 1,s
cmp #0
bne +
__local_4:
bra __local_7
+
cmp #31
bne +
__local_5:
bra __local_7
+
lda -8 + __bench_init_locals + 1,s
xba
and #$00ff
and.w #3
cmp #0
bne +
__local_6:
brl __local_7
+
bra __local_8
__local_7:
lda -2 + __bench_init_locals + 1,s
tax
lda.w #1
sep #$20
sta.l grid,x
rep #$20
jmp.w __local_10
__local_8:
lda -2 + __bench_init_locals + 1,s
tax
lda.w #0
sep #$20
sta.l grid,x
rep #$20
__local_9:
jmp.w __local_10
__local_0:
lda.w #33
sta.w start + 0
lda.w start + 0
tax
clc
adc.w #grid + 0
lda.w #0
sep #$20
sta.l grid,x
rep #$20
.ifgr __bench_init_locals 0
tsa
clc
adc #__bench_init_locals
tas
.endif
rtl
.ENDS

.SECTION ".visittext_0x1" SUPERFREE

.define __visit_ret 0
visit:
lda 3 + 1,s
tax
lda.l grid,x
and.w #$00FF
cmp #0
bne __local_12
txa
tax
lda.l dist,x
and.w #$00FF
cmp #255
beq +
__local_11:
brl __local_12
+
txa
tax
lda 5 + 1,s
and.w #$00FF
sep #$20
sta.l dist,x
rep #$20
lda.w tail + 0
asl a
tax
lda 3 + 1,s
sta.l queue,x
lda.w tail + 0
inc a
and.w #255
sta.w tail + 0
__local_12:
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
lda.b tcc__r0
sta -8 + __bench_locals + 1,s
sta -2 + __bench_locals + 1,s
__local_15:
cmp.w #1024
bcc __local_14
brl __local_13
__local_16:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_15
__local_14:
tax
lda.w #255
sep #$20
sta.l dist,x
rep #$20
bra __local_16
__local_13:
lda.w start + 0
tax
lda.w #0
sep #$20
sta.l dist,x
rep #$20
lda.w start + 0
sta.w queue + 0
lda.b tcc__r0
sta -6 + __bench_locals + 1,s
lda.w #1
sta.w tail + 0
__local_18:
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
lda.w tail + 0
sta.b tcc__r1
lda.b tcc__r0
cmp.b tcc__r1
bne +
brl __local_17
+
asl a
tax
lda.l queue,x
sta -4 + __bench_locals + 1,s
lda -6 + __bench_locals + 1,s
inc a
and.w #255
sta -6 + __bench_locals + 1,s
lda -4 + __bench_locals + 1,s
tax
lda.l dist,x
and.w #$00FF
sta.b tcc__r1
lda -8 + __bench_locals + 1,s
clc
adc.b tcc__r1
sta -8 + __bench_locals + 1,s
lda -4 + __bench_locals + 1,s
tax
lda.l dist,x
and.w #$00FF
sta.b tcc__r1
inc.b tcc__r1
sep #$20
lda.b tcc__r1
sta -9 + __bench_locals + 1,s
rep #$20
lda -4 + __bench_locals + 1,s
sec
sbc.w #32
sta.b tcc__r0
lda.w #0
sep #$20
lda -9 + __bench_locals + 1,s
pha
rep #$20
pei (tcc__r0)
jsr.l visit
tsa
clc
adc #3
tas
lda -4 + __bench_locals + 1,s
dec a
sta.b tcc__r0
lda.w #0
sep #$20
lda -9 + __bench_locals + 1,s
pha
rep #$20
pei (tcc__r0)
jsr.l visit
tsa
clc
adc #3
tas
lda -4 + __bench_locals + 1,s
inc a
sta.b tcc__r0
lda.w #0
sep #$20
lda -9 + __bench_locals + 1,s
pha
rep #$20
pei (tcc__r0)
jsr.l visit
tsa
clc
adc #3
tas
lda -4 + __bench_locals + 1,s
clc
adc.w #32
sta.b tcc__r0
lda.w #0
sep #$20
lda -9 + __bench_locals + 1,s
pha
rep #$20
pei (tcc__r0)
jsr.l visit
tsa
clc
adc #3
tas
jmp.w __local_18
__local_17:
lda -8 + __bench_locals + 1,s
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
grid dsb 1024
dist dsb 1024
queue dsb 512
start dsb 2
tail dsb 2
.ENDS
