_fini:
	rts

bench_init:
	rts

fib:
	txy
	beq	$802a <fib+0x6>
	jmp	$80a3 <fib+0x7f>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cmp	#$2
	ldy	#$0
	bcs	$8035 <fib+0x11>
	jmp	$80ae <fib+0x8a>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	phx
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	phx
	ldx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	phx
	ldx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	phx
	tax
	stz	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stz	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	stx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	txa
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	dec
	cmp	#$ff
	bne	$8055 <fib+0x31>
	dex
	jsr	$8024 <fib>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	adc	#$fe
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	adc	#$ff
	tay
	clc
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	txa
	adc	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	tyx
	bne	$8084 <fib+0x60>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	cpy	#$2
	ldy	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sta	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	bcc	$8093 <fib+0x6f>
	jmp	$8046 <fib+0x22>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cpy	#$0
	ldy	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sta	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	bcc	$8093 <fib+0x6f>
	jmp	$8046 <fib+0x22>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	pla
	sta	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	pla
	sta	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	pla
	sta	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	pla
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	bra	$80b1 <fib+0x8d>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cpx	#$0
	ldy	#$0
	bcc	$80ae <fib+0x8a>
	jmp	$8035 <fib+0x11>
	tax
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	clc
	tya
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tay
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tax
	tya
	rts

bench:
	lda	#$10
	ldx	#$0
	jmp	$8024 <fib>
