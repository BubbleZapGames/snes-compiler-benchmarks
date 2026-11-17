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
	sta	$202,x                  ; 0x202 <arr>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	inx
	cpx	#$40
	bne	$802b <bench_init+0x8>
	rts

bench:
	ldx	#$3f
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	#$0
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$0
	ldy	$202,x                  ; 0x202 <arr>
	lda	$203,x                  ; 0x203 <arr+0x1>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cmp	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bcs	$8079 <bench+0x20>
	sta	$202,x                  ; 0x202 <arr>
	tya
	sta	$203,x                  ; 0x203 <arr+0x1>
	inx
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	cpy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$8063 <bench+0xa>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inx
	dec	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	cpx	#$3f
	bne	$805f <bench+0x6>
	lda	#$0
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tax
	asl
	rol	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	eor	$202,x                  ; 0x202 <arr>
	inx
	cpx	#$40
	bne	$8090 <bench+0x37>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	rts
