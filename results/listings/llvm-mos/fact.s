_fini:
	rts

bench_init:
	ldx	#$1
	stx	$202                    ; 0x202 <n_iter>
	stx	$203                    ; 0x203 <size>
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
	stx	$246                    ; 0x246 <__rc31+0x147>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$247                    ; 0x247 <__rc31+0x148>
	ldx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	stx	$248                    ; 0x248 <__rc31+0x149>
	ldx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stx	$249                    ; 0x249 <__rc31+0x14a>
	ldx	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	stx	$24a                    ; 0x24a <__rc31+0x14b>
	lda	$203                    ; 0x203 <size>
	and	#$1
	tay
	ldx	#$10
	lda	#$0
	stx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stz	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	tyx
	bne	$8069 <bench+0x3d>
	stz	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stz	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	bne	$8076 <bench+0x4a>
	jmp	$8226 <bench+0x1fa>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$0
	rol
	asl	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol
	ldx	#$4
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$4
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$2
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$244                    ; 0x244 <__rc31+0x145>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$245                    ; 0x245 <__rc31+0x146>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$0
	jsr	$8255 <__memset>
	lda	$202                    ; 0x202 <n_iter>
	and	#$1
	bne	$80b0 <bench+0x84>
	jmp	$81d6 <bench+0x1aa>
	ldx	#$2
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stz	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	bra	$80c5 <bench+0x99>
	inc	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	stx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	bne	$80c5 <bench+0x99>
	jmp	$81cf <bench+0x1a3>
	ldx	#$0
	txy
	bra	$80d2 <bench+0xa6>
	iny
	cpy	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	bne	$80d2 <bench+0xa6>
	jmp	$81b7 <bench+0x18b>
	stx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	tya
	bne	$80ea <bench+0xbe>
	cpx	#$2
	bcs	$80ee <bench+0xc2>
	lda	#$1
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	stz	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	jmp	$814d <bench+0x121>
	cpy	#$0
	bcc	$80dd <bench+0xb1>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$2
	stx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	lda	#$1
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldx	#$0
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	#$ff
	dec	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	cpy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	bne	$8110 <bench+0xe4>
	dec	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	jsr	$8273 <__mulsi3>
	ldy	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bne	$8131 <bench+0x105>
	lda	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	cmp	#$2
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bcs	$80fe <bench+0xd2>
	bra	$8139 <bench+0x10d>
	cpy	#$0
	lda	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bcs	$80fe <bench+0xd2>
	ldy	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	asl
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	rol	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	asl
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	#$4
	clc
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	tax
	lda	#$2
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	clc
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$1
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	sty	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	#$3
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldy	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	lda	#$2
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	inx
	bne	$81b0 <bench+0x184>
	jmp	$80ca <bench+0x9e>
	cpy	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	beq	$81b7 <bench+0x18b>
	jmp	$80d2 <bench+0xa6>
	cpx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	beq	$81be <bench+0x192>
	jmp	$80d2 <bench+0xa6>
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	inx
	bne	$81c6 <bench+0x19a>
	jmp	$80ba <bench+0x8e>
	stx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	beq	$81cf <bench+0x1a3>
	jmp	$80c5 <bench+0x99>
	cpx	#$14
	beq	$81d6 <bench+0x1aa>
	jmp	$80c5 <bench+0x99>
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stz	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$244                    ; 0x244 <__rc31+0x145>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	$245                    ; 0x245 <__rc31+0x146>
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$0
	bra	$81ee <bench+0x1c2>
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	beq	$8222 <bench+0x1f6>
	clc
	adc	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	tax
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$1
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	iny
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	iny
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$4
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	ldx	#$ff
	dec	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	cpx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	bne	$81ea <bench+0x1be>
	dec	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	bra	$81ea <bench+0x1be>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	bne	$81ee <bench+0x1c2>
	eor	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tay
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	eor	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	tax
	tya
	ldy	$24a                    ; 0x24a <__rc31+0x14b>
	sty	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	ldy	$249                    ; 0x249 <__rc31+0x14a>
	sty	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldy	$248                    ; 0x248 <__rc31+0x149>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldy	$247                    ; 0x247 <__rc31+0x148>
	sty	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	$246                    ; 0x246 <__rc31+0x147>
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
