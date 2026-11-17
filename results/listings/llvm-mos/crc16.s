_fini:
	rts

bench_init:
	ldy	#$1
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$0
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	asl
	tay
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	rol
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	tay
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tya
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tay
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$19
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tya
	adc	#$36
	sta	$202,x                  ; 0x202 <buf>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	inx
	bne	$802b <bench_init+0x8>
	rts

bench:
	ldy	#$ff
	ldx	#$0
	tya
	bra	$806f <bench+0x18>
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	eor	#$21
	tay
	txa
	eor	#$10
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	inx
	bne	$806f <bench+0x18>
	jmp	$811d <bench+0xc6>
	eor	$202,x                  ; 0x202 <buf>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	asl	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	rol	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tax
	bmi	$808a <bench+0x33>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bra	$8094 <bench+0x3d>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	eor	#$21
	tax
	tya
	eor	#$10
	tay
	txa
	asl
	tax
	tya
	rol
	cpy	#$0
	bpl	$80a4 <bench+0x4d>
	tay
	txa
	eor	#$21
	tax
	tya
	eor	#$10
	tay
	txa
	asl
	tax
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$0
	bpl	$80b9 <bench+0x62>
	eor	#$21
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	eor	#$10
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	asl
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bpl	$80cb <bench+0x74>
	tay
	txa
	eor	#$21
	tax
	tya
	eor	#$10
	tay
	txa
	asl
	tax
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$0
	bpl	$80e0 <bench+0x89>
	eor	#$21
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	eor	#$10
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	asl
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bpl	$80f2 <bench+0x9b>
	tay
	txa
	eor	#$21
	tax
	tya
	eor	#$10
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	asl
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol
	tay
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bpl	$8107 <bench+0xb0>
	txa
	eor	#$21
	tax
	tya
	eor	#$10
	tay
	txa
	asl
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tya
	rol
	tyx
	bpl	$8113 <bench+0xbc>
	jmp	$805e <bench+0x7>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	inx
	beq	$811d <bench+0xc6>
	jmp	$806f <bench+0x18>
	tax
	tya
	rts
