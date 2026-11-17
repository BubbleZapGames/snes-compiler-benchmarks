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
	ldx	#$0
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$2
	clc
	ldy	#$0
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$2
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	beq	$8095 <bench+0x3e>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	txa
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tay
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	and	#$1
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	cpx	#$1
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	tya
	adc	#$0
	lsr	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	bne	$807b <bench+0x24>
	bra	$8096 <bench+0x3f>
	txa
	tax
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$80a2 <bench+0x4b>
	iny
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$1
	beq	$80af <bench+0x58>
	jmp	$805f <bench+0x8>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	beq	$80ba <bench+0x63>
	jmp	$805f <bench+0x8>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rts
