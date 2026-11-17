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
	sta	$202,x                  ; 0x202 <a>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$242,x                  ; 0x242 <b>
	inx
	cpx	#$40
	bne	$802b <bench_init+0x8>
	rts

bench:
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	phx
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	phx
	ldx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	phx
	ldx	#$0
	stz	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stz	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	txy
	lda	$202,x                  ; 0x202 <a>
	tax
	lda	$242,y                  ; 0x242 <b>
	sty	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$0
	jsr	$80a7 <__mulhi3>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	clc
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	lda	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	inx
	cpx	#$40
	bne	$806e <bench+0xf>
	tax
	lda	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	ply
	sty	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	ply
	sty	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	ply
	sty	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	rts
