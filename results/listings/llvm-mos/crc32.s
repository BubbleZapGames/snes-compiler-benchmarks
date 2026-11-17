_fini:
	rts

bench_init:
	lda	#$1
	ldy	#$4
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	bra	$803d <bench_init+0x1a>
	tya
	bne	$803d <bench_init+0x1a>
	jmp	$807f <bench_init+0x5c>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl
	tax
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	stx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	asl	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	rol
	tax
	clc
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	txa
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	tax
	clc
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	adc	#$19
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	txa
	adc	#$36
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$ff
	dec	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	cpx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	beq	$8072 <bench_init+0x4f>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$807a <bench_init+0x57>
	jmp	$8037 <bench_init+0x14>
	dey
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$807a <bench_init+0x57>
	jmp	$8037 <bench_init+0x14>
	inc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	jmp	$8037 <bench_init+0x14>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	beq	$8086 <bench_init+0x63>
	jmp	$803d <bench_init+0x1a>
	rts

bench:
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldy	#$4
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	#$0
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	bra	$80a3 <bench+0x1c>
	tya
	bne	$80a3 <bench+0x1c>
	jmp	$824a <bench+0x1c3>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	asl	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	phy
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ply
	cmp	#$0
	bpl	$80d7 <bench+0x50>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$b7
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$1d
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	eor	#$c1
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	rol
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	inc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	dec	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	bpl	$810e <bench+0x87>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$1d
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$c1
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	eor	#$4
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	rol	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bpl	$8137 <bench+0xb0>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$1d
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$c1
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	phy
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ply
	rol	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bpl	$8168 <bench+0xe1>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$1d
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$c1
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	rol	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	cmp	#$0
	bpl	$8191 <bench+0x10a>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$1d
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$c1
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	rol	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	phy
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sty	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ply
	rol	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bpl	$81c2 <bench+0x13b>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$1d
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$c1
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	phy
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sty	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ply
	inc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	dec	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	bmi	$81e3 <bench+0x15c>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	bra	$81fd <bench+0x176>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$b7
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$1d
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$c1
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	eor	#$4
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	rol	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bmi	$8220 <bench+0x199>
	dex
	cpx	#$ff
	beq	$823d <bench+0x1b6>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$8245 <bench+0x1be>
	jmp	$809d <bench+0x16>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$b7
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$1d
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$c1
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$4
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	dex
	cpx	#$ff
	bne	$8219 <bench+0x192>
	dey
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$8245 <bench+0x1be>
	jmp	$809d <bench+0x16>
	inc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	jmp	$809d <bench+0x16>
	txa
	beq	$8250 <bench+0x1c9>
	jmp	$80a3 <bench+0x1c>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	eor	#$ff
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	eor	#$ff
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	#$ff
	tax
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	eor	#$ff
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	txa
	eor	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tay
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tax
	tya
	rts
