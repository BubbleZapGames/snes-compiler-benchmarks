.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_locals 8

.SECTION ".bench_inittext_0x0" SUPERFREE

.define __bench_init_ret 0
bench_init:
rtl
.ENDS

.SECTION ".check_flagtext_0x1" SUPERFREE

.define __check_flag_ret 1
check_flag:
lda 3 + 1,s
lsr a
lsr a
lsr a
tax
lda 3 + 1,s
and.w #7
sta.b tcc__r2
lda.l flags,x
and.w #$00FF
sta.b tcc__r0
lda.w #0
sep #$20
ldx.b tcc__r2
lda.l tccs_{WLA_FILENAME}_bitv,x
rep #$20
and.b tcc__r0
and.w #255
sta.b tcc__r0
__local_0:
rtl
.ENDS

.SECTION ".clear_flagtext_0x2" SUPERFREE

.define __clear_flag_ret 0
clear_flag:
lda 3 + 1,s
lsr a
lsr a
lsr a
tax
lda 3 + 1,s
and.w #7
sta.b tcc__r0
lda.w #:tccs_{WLA_FILENAME}_bitv
sta.b tcc__r2h
lda.w #tccs_{WLA_FILENAME}_bitv + 0
clc
adc.b tcc__r0
sta.b tcc__r2
lda.b [tcc__r2]
and.w #$00FF
eor.w #65535
sta.b tcc__r0
lda.l flags,x
and.w #$00FF
and.b tcc__r0
sep #$20
sta.l flags,x
rep #$20
rtl
.ENDS

.SECTION ".benchtext_0x3" SUPERFREE

.define __bench_ret 1
bench:
.ifgr __bench_locals 0
tsa
sec
sbc #__bench_locals
tas
.endif
lda.w #1
sta -8 + __bench_locals + 1,s
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_locals + 1,s
__local_3:
cmp.w #1001
bcc __local_2
brl __local_1
__local_4:
txa
inc a
sta -2 + __bench_locals + 1,s
bra __local_3
__local_2:
tax
lda.w #255
sep #$20
sta.l flags,x
rep #$20
bra __local_4
__local_1:
lda.b tcc__r0
sta -2 + __bench_locals + 1,s
__local_7:
sta.b tcc__r0
cmp.w #8000
bcc __local_6
brl __local_5
__local_13:
lda -2 + __bench_locals + 1,s
inc a
sta -2 + __bench_locals + 1,s
bra __local_7
__local_6:
pha
jsr.l check_flag
pla
lda.b tcc__r0 ; DON'T OPTIMIZE
beq __local_13
lda -2 + __bench_locals + 1,s
clc
adc -2 + __bench_locals + 1,s
clc
adc.w #3
sta -4 + __bench_locals + 1,s
clc
adc -2 + __bench_locals + 1,s
sta -6 + __bench_locals + 1,s
__local_11:
cmp.w #8000
bcc __local_10
brl __local_9
__local_12:
lda -4 + __bench_locals + 1,s
clc
adc -6 + __bench_locals + 1,s
sta -6 + __bench_locals + 1,s
bra __local_11
__local_10:
pha
jsr.l clear_flag
pla
bra __local_12
__local_9:
lda -8 + __bench_locals + 1,s
inc a
sta -8 + __bench_locals + 1,s
__local_8:
jmp.w __local_13
__local_5:
lda -8 + __bench_locals + 1,s
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

tccs_{WLA_FILENAME}_bitv: .db $1,$2,$4,$8,$10,$20,$40,$80
.ENDS

.RAMSECTION ".bss" BANK $7e SLOT 2
flags dsb 1001
.ENDS
