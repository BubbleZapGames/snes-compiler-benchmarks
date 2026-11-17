_fini:
	rts

bench_init:
	rts

bench:
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$4
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$0
	txa
	jsr	$80ed <__memset>
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$2
	ldx	#$0
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$2
	clc
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$2
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	beq	$8071 <bench+0x4d>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$805c <bench+0x38>
	iny
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$4
	bne	$8040 <bench+0x1c>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bne	$8040 <bench+0x1c>
	jmp	$80ea <bench+0xc6>
	inc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	bne	$8076 <bench+0x52>
	inx
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$2
	bne	$8084 <bench+0x60>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cpy	#$0
	bcs	$8051 <bench+0x2d>
	bra	$808a <bench+0x66>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$2
	bcs	$8051 <bench+0x2d>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	asl
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$0
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	clc
	lda	#$2
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	phy
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$2
	adc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldy	$ea                     ; 0xea <__zp_bss_start+0xea>
	sty	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ply
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$1
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	tya
	ldy	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	cpy	#$1
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	cmp	#$4
	bne	$80df <bench+0xbb>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	cpy	#$0
	bcs	$80dc <bench+0xb8>
	jmp	$8099 <bench+0x75>
	jmp	$8051 <bench+0x2d>
	tay
	cpy	#$4
	bcs	$80e7 <bench+0xc3>
	jmp	$8099 <bench+0x75>
	jmp	$8051 <bench+0x2d>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rts
