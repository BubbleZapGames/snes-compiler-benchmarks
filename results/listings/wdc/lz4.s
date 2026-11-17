;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
__lz:
	db	$81,$20,$21,$22,$23,$24,$50,$26,$27,$8
	db	$0,$1A,$25,$8,$0,$1B,$40,$10,$0,$2
	db	$20,$0,$2C,$40,$51,$28,$0,$9,$38,$0
	db	$12,$52,$48,$0,$13,$40,$50,$0,$F3,$3
	db	$36,$44,$8D,$F9,$16,$42,$45,$4E,$43,$48
	db	$4D,$41,$52,$4B,$53,$3A,$20,$0,$1,$0
	db	$F,$71,$0,$1,$16,$50,$81,$0,$16,$41
	db	$91,$0,$1E,$51,$69,$0,$19,$41,$B1,$0
	db	$10,$41,$B9,$0,$1B,$52,$C1,$0,$95,$A6
	db	$76,$86,$D7,$69,$45,$92,$13,$99,$7A,$0
	db	$35,$4C,$5A,$34,$7E,$0,$5,$8,$0,$2
	db	$F8,$0,$1C,$42,$0,$1,$1F,$50,$10,$1
	db	$1,$14,$42,$20,$1,$18,$51,$30,$1,$2F
	db	$42,$52,$10,$1,$9,$D6,$37,$4A,$A9,$83
	db	$C6,$18,$B2,$B2,$B0,$AA,$8C,$F2,$F1,$6
	db	$1,$F,$8C,$0,$2,$6,$95,$0,$1F,$43
	db	$5D,$1,$4,$1,$A5,$1,$11,$50,$AD,$1
	db	$16,$51,$AD,$1,$1F,$43,$8D,$1,$6,$0
	db	$DD,$1,$18,$43,$DD,$1,$11,$52,$E5,$1
	db	$FF,$5,$EB,$D1,$4F,$C3,$8,$5F,$16,$A4
	db	$6C,$52,$D1,$4F,$C2,$4,$4E,$C0,$F9,$45
	db	$52,$20,$A4,$1,$1,$F,$8,$0,$8,$1F
	db	$44,$0,$2,$5,$19,$50,$48,$2,$1A,$51
	db	$58,$2,$1A,$44,$68,$2,$1F,$52,$78,$2
	db	$3,$F8,$A,$44,$25,$26,$27,$13,$99,$34
	db	$3A,$5A,$FC,$25,$F3,$F6,$5,$51,$CF,$41
	db	$7F,$B4,$BA,$D9,$76,$88,$E0,$99,$CA,$1
	db	$4F,$42,$4C,$4F,$43,$A8,$0,$10,$B,$E9
	db	$1,$9,$E9,$2,$10,$45,$F1,$2,$1F,$50
	db	$C9,$2,$2,$4F,$51,$27,$20,$45,$84,$1
	db	$9,$2,$31,$3,$16,$52,$31,$3,$F9,$B
	db	$45,$37,$4B,$AE,$9E,$4D,$B8,$CF,$42,$84
	db	$CB,$2F,$23,$E8,$C0,$FA,$1C,$C6,$14,$9D
	db	$4A,$A8,$82,$C3,$7,$5C,$B2,$0,$4F,$4B
	db	$20,$44,$45,$B6,$0,$19,$F,$BF,$0,$0
	db	$2F,$46,$50,$80,$3,$A,$12,$51,$C8,$3
	db	$1F,$46,$A0,$3,$2,$18,$46,$E8,$3,$50
	db	$23,$24,$25,$26,$52
	ends
	code
	xdef	__bench_init
	func
__bench_init:
	longa	on
	longi	on
	rts
L2	equ	0
L3	equ	1
	ends
	efunc
	code
	xdef	__bench
	func
__bench:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
i_1	set	0
o_1	set	2
n_1	set	4
off_1	set	6
s_1	set	8
tok_1	set	10
b_1	set	11
	stz	<L6+i_1
	stz	<L6+o_1
	stz	<L6+s_1
L10003:
	sep	#$20
	longa	off
	ldx	<L6+i_1
	lda	|__lz,X
	sta	<L6+tok_1
	rep	#$20
	longa	on
	inc	<L6+i_1
	lda	<L6+tok_1
	and	#$ff
	ldx	#<$4
	xref	__~asr
	jsr	__~asr
	sta	<L6+n_1
	cmp	#<$f
L20004:
	bne	L10008
	sep	#$20
	longa	off
	ldx	<L6+i_1
	lda	|__lz,X
	sta	<L6+b_1
	rep	#$20
	longa	on
	inc	<L6+i_1
	lda	<L6+b_1
	and	#$ff
	clc
	adc	<L6+n_1
	sta	<L6+n_1
	sep	#$20
	longa	off
	lda	<L6+b_1
	cmp	#<$ff
	rep	#$20
	longa	on
	bra	L20004
L20001:
	sep	#$20
	longa	off
	ldx	<L6+i_1
	lda	|__lz,X
	ldx	<L6+o_1
	sta	|__out,X
	rep	#$20
	longa	on
	inc	<L6+i_1
	inc	<L6+o_1
	dec	<L6+n_1
L10008:
	lda	<L6+n_1
	bne	L20001
	lda	<L6+i_1
	cmp	#<$177
	bcs	L10002
	ldx	<L6+i_1
	lda	|__lz,X
	and	#$ff
	sta	<R0
	lda	|__lz+1,X
	and	#$ff
	xba
	and	#$ff00
	ora	<R0
	sta	<L6+off_1
	inc	<L6+i_1
	inc	<L6+i_1
	lda	<L6+tok_1
	and	#<$f
	sta	<L6+n_1
	cmp	#<$f
	bne	L10010
L10013:
	sep	#$20
	longa	off
	ldx	<L6+i_1
	lda	|__lz,X
	sta	<L6+b_1
	rep	#$20
	longa	on
	inc	<L6+i_1
	lda	<L6+b_1
	and	#$ff
	clc
	adc	<L6+n_1
	sta	<L6+n_1
	sep	#$20
	longa	off
	lda	<L6+b_1
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L10013
L10010:
	lda	#$4
	clc
	adc	<L6+n_1
	sta	<L6+n_1
	bra	L10014
L20003:
	sec
	lda	<L6+o_1
	sbc	<L6+off_1
	tax
	sep	#$20
	longa	off
	lda	|__out,X
	ldx	<L6+o_1
	sta	|__out,X
	rep	#$20
	longa	on
	inc	<L6+o_1
	dec	<L6+n_1
L10014:
	lda	<L6+n_1
	bne	L20003
	brl	L10003
L10002:
	stz	<L6+i_1
	bra	L10019
L10018:
	ldx	<L6+i_1
	lda	|__out,X
	and	#$ff
	clc
	adc	<L6+s_1
	sta	<L6+s_1
	inc	<L6+i_1
L10019:
	lda	<L6+i_1
	cmp	<L6+o_1
	bcc	L10018
	lda	<L6+s_1
	tay
	pld
	tsc
	clc
	adc	#L5
	tcs
	tya
	rts
L5	equ	24
L6	equ	13
	ends
	efunc
	udata
	xdef	__out
__out
	ds	1024
	ends
