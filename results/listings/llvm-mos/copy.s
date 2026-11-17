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
	ldx	#$6
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$2
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$2
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	#$0
	ldx	#$4
	jsr	$80bc <memcpy>
	lda	$602                    ; 0x602 <dst>
	clc
	adc	$801                    ; 0x801 <dst+0x1ff>
	tax
	lda	#$0
	adc	#$0
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	txa
	adc	$a01                    ; 0xa01 <dst+0x3ff>
	tay
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	#$0
	tax
	tya
	rts

memcpy:
	tay
	txa
	bne	$80c3 <memcpy+0x7>
	tya
	beq	$80e7 <memcpy+0x2b>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	inc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	bne	$80d5 <memcpy+0x19>
	inc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$80db <memcpy+0x1f>
	inc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	dey
	cpy	#$ff
	bne	$80e1 <memcpy+0x25>
	dex
	txa
	bne	$80cb <memcpy+0xf>
	tya
	bne	$80cb <memcpy+0xf>
	rts
