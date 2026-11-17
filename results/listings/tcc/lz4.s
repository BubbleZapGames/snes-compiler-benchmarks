.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __bench_locals 12

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
sta -2 + __bench_locals + 1,s
sta -4 + __bench_locals + 1,s
sta -10 + __bench_locals + 1,s
__local_10:
lda -2 + __bench_locals + 1,s
sta.b tcc__r1
inc a
sta -2 + __bench_locals + 1,s
ldx.b tcc__r1
lda.l tccs_{WLA_FILENAME}_lz,x
and.w #$00FF
sep #$20
sta -11 + __bench_locals + 1,s
rep #$20
lda -11 + __bench_locals + 1,s
and.w #$00FF
cmp #$8000
ror a
cmp #$8000
ror a
cmp #$8000
ror a
cmp #$8000
ror a
sta -6 + __bench_locals + 1,s
cmp #15
bne __local_0
__local_1:
lda -2 + __bench_locals + 1,s
sta.b tcc__r1
inc a
sta -2 + __bench_locals + 1,s
ldx.b tcc__r1
lda.w #0
sep #$20
lda.l tccs_{WLA_FILENAME}_lz,x
sta -12 + __bench_locals + 1,s
rep #$20
lda -12 + __bench_locals + 1,s
and.w #$00FF
sta.b tcc__r0
lda -6 + __bench_locals + 1,s
clc
adc.b tcc__r0
sta -6 + __bench_locals + 1,s
lda -12 + __bench_locals + 1,s
and.w #$00FF
cmp #255
beq __local_1
__local_0:
__local_3:
lda -6 + __bench_locals + 1,s
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
beq __local_2
lda -4 + __bench_locals + 1,s
sta.b tcc__r1
inc a
sta -4 + __bench_locals + 1,s
lda.b tcc__r1
sta.b tcc__r0
lda -2 + __bench_locals + 1,s
sta.b tcc__r2
inc a
sta -2 + __bench_locals + 1,s
ldx.b tcc__r2
lda.l tccs_{WLA_FILENAME}_lz,x
and.w #$00FF
sep #$20
ldx.b tcc__r0
sta.l out,x
rep #$20
lda -6 + __bench_locals + 1,s
clc
adc.w #65535
sta -6 + __bench_locals + 1,s
bra __local_3
__local_2:
lda -2 + __bench_locals + 1,s
cmp.w #375
bcc __local_4
jmp.w __local_5
__local_4:
sta.b tcc__r0
inc a
tax
lda.l tccs_{WLA_FILENAME}_lz,x
and.w #$00FF
xba
and #$ff00
sta.b tcc__r1
lda.w #0
sep #$20
ldx.b tcc__r0
lda.l tccs_{WLA_FILENAME}_lz,x
rep #$20
ora.b tcc__r1
sta -8 + __bench_locals + 1,s
txa
inc a
inc a
sta -2 + __bench_locals + 1,s
lda -11 + __bench_locals + 1,s
and.w #$00FF
and.w #15
sta -6 + __bench_locals + 1,s
cmp #15
bne __local_6
__local_7:
lda -2 + __bench_locals + 1,s
sta.b tcc__r1
inc a
sta -2 + __bench_locals + 1,s
ldx.b tcc__r1
lda.w #0
sep #$20
lda.l tccs_{WLA_FILENAME}_lz,x
sta -12 + __bench_locals + 1,s
rep #$20
lda -12 + __bench_locals + 1,s
and.w #$00FF
sta.b tcc__r0
lda -6 + __bench_locals + 1,s
clc
adc.b tcc__r0
sta -6 + __bench_locals + 1,s
lda -12 + __bench_locals + 1,s
and.w #$00FF
cmp #255
beq __local_7
__local_6:
lda -6 + __bench_locals + 1,s
clc
adc.w #4
sta -6 + __bench_locals + 1,s
__local_9:
sta.b tcc__r0
lda.b tcc__r0 ; DON'T OPTIMIZE
bne +
jmp.w __local_10
+
lda -4 + __bench_locals + 1,s
sta.b tcc__r0
sec
sbc -8 + __bench_locals + 1,s
tax
lda.l out,x
and.w #$00FF
sep #$20
ldx.b tcc__r0
sta.l out,x
rep #$20
txa
inc a
sta -4 + __bench_locals + 1,s
lda -6 + __bench_locals + 1,s
clc
adc.w #65535
sta -6 + __bench_locals + 1,s
bra __local_9
__local_8:
jmp.w __local_10
__local_5:
stz.b tcc__r0
lda.b tcc__r0
sta -2 + __bench_locals + 1,s
__local_13:
cmp -4 + __bench_locals + 1,s
bcc __local_12
brl __local_11
__local_14:
txa
inc a
sta -2 + __bench_locals + 1,s
bra __local_13
__local_12:
tax
lda.l out,x
and.w #$00FF
sta.b tcc__r1
lda -10 + __bench_locals + 1,s
clc
adc.b tcc__r1
sta -10 + __bench_locals + 1,s
bra __local_14
__local_11:
lda -10 + __bench_locals + 1,s
sta.b tcc__r0
__local_15:
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

tccs_{WLA_FILENAME}_lz: .db $81,$20,$21,$22,$23,$24,$50,$26,$27,$8,$0,$1a,$25,$8,$0,$1b,$40,$10,$0,$2,$20,$0,$2c,$40,$51,$28,$0,$9,$38,$0,$12,$52,$48,$0,$13,$40,$50,$0,$f3,$3,$36,$44,$8d,$f9,$16,$42,$45,$4e,$43,$48,$4d,$41,$52,$4b,$53,$3a,$20,$0,$1,$0,$f,$71,$0,$1,$16,$50,$81,$0,$16,$41,$91,$0,$1e,$51,$69,$0,$19,$41,$b1,$0,$10,$41,$b9,$0,$1b,$52,$c1,$0,$95,$a6,$76,$86,$d7,$69,$45,$92,$13,$99,$7a,$0,$35,$4c,$5a,$34,$7e,$0,$5,$8,$0,$2,$f8,$0,$1c,$42,$0,$1,$1f,$50,$10,$1,$1,$14,$42,$20,$1,$18,$51,$30,$1,$2f,$42,$52,$10,$1,$9,$d6,$37,$4a,$a9,$83,$c6,$18,$b2,$b2,$b0,$aa,$8c,$f2,$f1,$6,$1,$f,$8c,$0,$2,$6,$95,$0,$1f,$43,$5d,$1,$4,$1,$a5,$1,$11,$50,$ad,$1,$16,$51,$ad,$1,$1f,$43,$8d,$1,$6,$0,$dd,$1,$18,$43,$dd,$1,$11,$52,$e5,$1,$ff,$5,$eb,$d1,$4f,$c3,$8,$5f,$16,$a4,$6c,$52,$d1,$4f,$c2,$4,$4e,$c0,$f9,$45,$52,$20,$a4,$1,$1,$f,$8,$0,$8,$1f,$44,$0,$2,$5,$19,$50,$48,$2,$1a,$51,$58,$2,$1a,$44,$68,$2,$1f,$52,$78,$2,$3,$f8,$a,$44,$25,$26,$27,$13,$99,$34,$3a,$5a,$fc,$25,$f3,$f6,$5,$51,$cf,$41,$7f,$b4,$ba,$d9,$76,$88,$e0,$99,$ca,$1,$4f,$42,$4c,$4f,$43,$a8,$0,$10,$b,$e9,$1,$9,$e9,$2,$10,$45,$f1,$2,$1f,$50,$c9,$2,$2,$4f,$51,$27,$20,$45,$84,$1,$9,$2,$31,$3,$16,$52,$31,$3,$f9,$b,$45,$37,$4b,$ae,$9e,$4d,$b8,$cf,$42,$84,$cb,$2f,$23,$e8,$c0,$fa,$1c,$c6,$14,$9d,$4a,$a8,$82,$c3,$7,$5c,$b2,$0,$4f,$4b,$20,$44,$45,$b6,$0,$19,$f,$bf,$0,$0,$2f,$46,$50,$80,$3,$a,$12,$51,$c8,$3,$1f,$46,$a0,$3,$2,$18,$46,$e8,$3,$50,$23,$24,$25,$26,$52
.ENDS

.RAMSECTION ".bss" BANK $7e SLOT 2
out dsb 1024
.ENDS
