_fini:
	rts

bench_init:
	rts

bench:
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	phx
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$ff
	ldx	#$e9
	ldy	#$3
	sty	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	jsr	$815d <__memset>
	ldx	#$1
	ldy	#$3
	sty	$ec                     ; 0xec <__zp_bss_start+0xec>
	stz	$ed                     ; 0xed <__zp_bss_start+0xed>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$ea                     ; 0xea <__zp_bss_start+0xea>
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lsr
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ror	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lsr
	ror	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lsr
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ror	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	#$2
	clc
	ldx	#$1
	bcs	$8068 <bench+0x44>
	ldx	#$0
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tax
	lda	#$2
	adc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	tax
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	and	#$7
	tay
	txa
	and	$817b,y                 ; 0x817b <bitv>
	bne	$8086 <bench+0x62>
	jmp	$811d <bench+0xf9>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	asl
	tax
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol
	tay
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cmp	#$1
	txa
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tya
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tay
	clc
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	adc	#$3
	tax
	tya
	adc	#$0
	cmp	#$1f
	bne	$80af <bench+0x8b>
	cpx	#$40
	bcc	$80b6 <bench+0x92>
	jmp	$8117 <bench+0xf3>
	cmp	#$1f
	bcc	$80b6 <bench+0x92>
	jmp	$8117 <bench+0xf3>
	ldx	$ec                     ; 0xec <__zp_bss_start+0xec>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$ed                     ; 0xed <__zp_bss_start+0xed>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	and	#$7
	tay
	lda	#$ff
	eor	$817b,y                 ; 0x817b <bitv>
	tax
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lsr
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ror	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lsr
	ror	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lsr
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ror	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$2
	ldy	#$0
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	clc
	adc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	tay
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$2
	adc	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	txa
	and	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	sta	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	lda	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	ldx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	cpx	#$1
	adc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	cmp	#$1f
	bne	$8110 <bench+0xec>
	ldx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	cpx	#$40
	bcs	$8117 <bench+0xf3>
	jmp	$80bc <bench+0x98>
	cmp	#$1f
	bcs	$8117 <bench+0xf3>
	jmp	$80bc <bench+0x98>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$811d <bench+0xf9>
	inc	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	inx
	bne	$8125 <bench+0x101>
	iny
	clc
	lda	$ec                     ; 0xec <__zp_bss_start+0xec>
	adc	#$3
	sta	$ec                     ; 0xec <__zp_bss_start+0xec>
	lda	$ed                     ; 0xed <__zp_bss_start+0xed>
	adc	#$0
	sta	$ed                     ; 0xed <__zp_bss_start+0xed>
	clc
	lda	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	adc	#$2
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	adc	#$0
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$1f
	beq	$814a <bench+0x126>
	jmp	$804e <bench+0x2a>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpx	#$40
	beq	$8155 <bench+0x131>
	jmp	$804e <bench+0x2a>
	ldx	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ply
	sty	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	rts
