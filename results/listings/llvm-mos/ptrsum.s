_fini:
	rts

bench_init:
	lda	#$1
	ldy	#$2
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
	ldy	#$2
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	#$0
	bra	$809c <bench+0x15>
	tya
	beq	$80be <bench+0x37>
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	txa
	adc	#$0
	tax
	lda	#$ff
	dec	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	cmp	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	beq	$80b5 <bench+0x2e>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$8099 <bench+0x12>
	bra	$80ba <bench+0x33>
	dey
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$8099 <bench+0x12>
	inc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bra	$8099 <bench+0x12>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	bne	$809c <bench+0x15>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rts
