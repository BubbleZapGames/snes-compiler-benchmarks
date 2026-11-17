.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_locals 6

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
sta -6 + __bench_locals + 1,s
sta -2 + __bench_locals + 1,s
__local_2:
cmp.w #1024
bcc __local_1
brl __local_0
__local_3:
txa
inc a
sta -2 + __bench_locals + 1,s
bra __local_2
__local_1:
tax
lda.w #0
sep #$20
sta.l flags,x
rep #$20
bra __local_3
__local_0:
lda.w #2
sta -2 + __bench_locals + 1,s
__local_6:
cmp.w #1024
bcc __local_5
brl __local_4
__local_12:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_6
__local_5:
tax
lda.l flags,x
and.w #$00FF
cmp #0
bne __local_12
lda -6 + __bench_locals + 1,s
inc a
sta -6 + __bench_locals + 1,s
txa
clc
adc -2 + __bench_locals + 1,s
sta -4 + __bench_locals + 1,s
__local_10:
cmp.w #1024
bcc __local_9
bra __local_12
__local_11:
lda -2 + __bench_locals + 1,s
clc
adc -4 + __bench_locals + 1,s
sta -4 + __bench_locals + 1,s
bra __local_10
__local_9:
tax
lda.w #1
sep #$20
sta.l flags,x
rep #$20
bra __local_11
__local_8:
__local_7:
jmp.w __local_12
__local_4:
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
__local_13:
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
flags dsb 1024
.ENDS
