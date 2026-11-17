_fini:
	rts

bench_init:
	ldy	#$1
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$0
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	asl	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	clc
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	clc
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	adc	#$19
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	#$36
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$2
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	dex
	beq	$807d <bench_init+0x5a>
	jmp	$8033 <bench_init+0x10>
	rts

bench:
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$1
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	#$0
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	txa
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	tax
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$2
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	dec	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bne	$808e <bench+0x10>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rts
