_fini:
	rts

bench_init:
	rts

bench:
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	phx
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	phx
	ldx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	phx
	ldx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	phx
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stx	$602                    ; 0x602 <__bss_size+0x200>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$603                    ; 0x603 <__bss_size+0x201>
	ldx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	stx	$604                    ; 0x604 <__bss_size+0x202>
	ldx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stx	$605                    ; 0x605 <__bss_size+0x203>
	lda	#$0
	tax
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	jmp	$81bb <bench+0x197>
	sta	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bra	$806a <bench+0x46>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	iny
	bne	$8064 <bench+0x40>
	inx
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$2
	ldx	#$0
	stx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	clc
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tay
	lda	#$2
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$e8
	clc
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tax
	lda	#$82
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sty	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	lda	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	jsr	$82bc <memcpy>
	lda	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	cpx	#$1
	adc	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	adc	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	cpx	#$1
	lda	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	adc	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	adc	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	cpx	#$1
	beq	$80ce <bench+0xaa>
	jmp	$8226 <bench+0x202>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	cpx	#$77
	bcc	$80d7 <bench+0xb3>
	jmp	$822f <bench+0x20b>
	lda	#$e8
	clc
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$82
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldy	#$1
	lda	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	clc
	adc	#$2
	tay
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	#$0
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	and	#$f
	cmp	#$f
	bne	$812f <bench+0x10b>
	ldx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sty	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$2
	lda	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	clc
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	#$f
	tax
	lda	#$0
	adc	#$0
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	bne	$8136 <bench+0x112>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	cmp	#$be
	bne	$8138 <bench+0x114>
	jmp	$82a9 <bench+0x285>
	tax
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bra	$8140 <bench+0x11c>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	inc
	bne	$813c <bench+0x118>
	iny
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	clc
	txa
	adc	#$4
	tay
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	#$0
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	#$0
	sec
	sbc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	tax
	lda	#$0
	sec
	sbc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	txa
	sbc	#$0
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$2
	clc
	adc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	#$2
	adc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	bra	$8174 <bench+0x150>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	tax
	bne	$8174 <bench+0x150>
	jmp	$81b5 <bench+0x191>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldx	#$0
	clc
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	phy
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sty	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ply
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	#$2
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	clc
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tax
	lda	#$2
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$ed                     ; 0xed <__zp_bss_start+0xed>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$ed                     ; 0xed <__zp_bss_start+0xed>
	stx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$81a7 <bench+0x183>
	inc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	dey
	cpy	#$ff
	beq	$81b1 <bench+0x18d>
	jmp	$816c <bench+0x148>
	dec
	jmp	$816c <bench+0x148>
	tya
	beq	$81bb <bench+0x197>
	jmp	$8174 <bench+0x150>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	iny
	bne	$81c3 <bench+0x19f>
	inx
	lda	#$e8
	phy
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpy	#$1
	ply
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$82
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	sta	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	lsr
	lsr
	lsr
	lsr
	beq	$8219 <bench+0x1f5>
	cmp	#$f
	beq	$81ee <bench+0x1ca>
	jmp	$8054 <bench+0x30>
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$1
	lda	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	clc
	adc	#$f
	sta	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	lda	#$0
	adc	#$0
	txy
	beq	$820d <bench+0x1e9>
	jmp	$805e <bench+0x3a>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	cpy	#$be
	bne	$8216 <bench+0x1f2>
	jmp	$8293 <bench+0x26f>
	jmp	$8060 <bench+0x3c>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	cpx	#$1
	bne	$8226 <bench+0x202>
	jmp	$80ce <bench+0xaa>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	cpx	#$1
	bcs	$822f <bench+0x20b>
	jmp	$80d7 <bench+0xb3>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	bne	$823a <bench+0x216>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$823a <bench+0x216>
	jmp	$82a4 <bench+0x280>
	ldx	#$2
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$2
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$0
	tya
	bra	$824b <bench+0x227>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	beq	$826c <bench+0x248>
	clc
	tax
	tya
	adc	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	tay
	txa
	adc	#$0
	ldx	#$ff
	dec	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	cpx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$8262 <bench+0x23e>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$8247 <bench+0x223>
	bra	$8268 <bench+0x244>
	dec	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$8247 <bench+0x223>
	inc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	bra	$8247 <bench+0x223>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$824b <bench+0x227>
	tax
	tya
	ldy	$605                    ; 0x605 <__bss_size+0x203>
	sty	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldy	$604                    ; 0x604 <__bss_size+0x202>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldy	$603                    ; 0x603 <__bss_size+0x201>
	sty	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	$602                    ; 0x602 <__bss_size+0x200>
	sty	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	ply
	sty	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	ply
	sty	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	ply
	sty	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	ply
	sty	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	rts
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	#$14
	sta	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldx	#$0
	txa
	adc	#$0
	ldy	#$bf
	jmp	$8060 <bench+0x3c>
	ldy	#$0
	tya
	bra	$8270 <bench+0x24c>
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	#$14
	tax
	lda	#$0
	adc	#$0
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	#$0
	lda	#$bf
	jmp	$8138 <bench+0x114>

memcpy:
	tay
	txa
	bne	$82c3 <memcpy+0x7>
	tya
	beq	$82e7 <memcpy+0x2b>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	inc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	bne	$82d5 <memcpy+0x19>
	inc	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$82db <memcpy+0x1f>
	inc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	dey
	cpy	#$ff
	bne	$82e1 <memcpy+0x25>
	dex
	txa
	bne	$82cb <memcpy+0xf>
	tya
	bne	$82cb <memcpy+0xf>
	rts
