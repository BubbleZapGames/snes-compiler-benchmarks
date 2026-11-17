_fini:
	rts

bench_init:
	rts

bench:
	ldx	#$c5
	ldy	#$2
	sty	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	#$2
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldy	#$1
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$2
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$d0
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	lda	#$7
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	dex
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	bne	$8030 <bench+0xc>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	phx
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	phx
	ldx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	phx
	ldx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	phx
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stx	$39e                    ; 0x39e <__bss_size+0x212>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$39f                    ; 0x39f <__bss_size+0x213>
	ldx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	stx	$3a0                    ; 0x3a0 <__bss_size+0x214>
	ldx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stx	$3a1                    ; 0x3a1 <__bss_size+0x215>
	ldx	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	stx	$3a2                    ; 0x3a2 <__bss_size+0x216>
	ldx	$fd                     ; 0xfd <__zp_bss_start+0xfd>
	stx	$3a3                    ; 0x3a3 <__bss_size+0x217>
	ldx	$fe                     ; 0xfe <__zp_bss_start+0xfe>
	stx	$3a4                    ; 0x3a4 <__bss_size+0x218>
	ldx	$ff                     ; 0xff <__zp_bss_start+0xff>
	stx	$3a5                    ; 0x3a5 <__bss_size+0x219>
	ldx	#$c4
	stx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	lda	#$1
	ldy	#$88
	ldx	#$90
	stx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldx	#$3
	stx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$0
	stx	$396                    ; 0x396 <__bss_size+0x20a>
	stx	$397                    ; 0x397 <__bss_size+0x20b>
	stz	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	jmp	$8202 <bench+0x1de>
	clc
	lda	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	adc	#$fe
	tay
	lda	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	adc	#$ff
	sty	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	bne	$80b9 <bench+0x95>
	jmp	$817b <bench+0x157>
	ldy	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	sty	$394                    ; 0x394 <__bss_size+0x208>
	ldy	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	sty	$395                    ; 0x395 <__bss_size+0x209>
	ldy	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sty	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	sta	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	#$ff
	dec	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	cpy	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	bne	$80d3 <bench+0xaf>
	dec	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	jsr	$8427 <__mulsi3>
	sta	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	stx	$fd                     ; 0xfd <__zp_bss_start+0xfd>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	lda	#$2
	clc
	adc	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sta	$fe                     ; 0xfe <__zp_bss_start+0xfe>
	lda	#$2
	adc	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	sta	$ff                     ; 0xff <__zp_bss_start+0xff>
	lda	($fe)                   ; 0xfe <__zp_bss_start+0xfe>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	#$1
	lda	($fe),y                 ; 0xfe <__zp_bss_start+0xfe>
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	#$10
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$27
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	tax
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	jsr	$8427 <__mulsi3>
	clc
	adc	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	tay
	txa
	adc	$fd                     ; 0xfd <__zp_bss_start+0xfd>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldx	$394                    ; 0x394 <__bss_size+0x208>
	stx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldx	$395                    ; 0x395 <__bss_size+0x209>
	stx	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	phy
	ldy	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ply
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldx	$ea                     ; 0xea <__zp_bss_start+0xea>
	tya
	jsr	$8268 <__udivmodsi4>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	$390                    ; 0x390 <__bss_size+0x204>
	ldy	$391                    ; 0x391 <__bss_size+0x205>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	($fe)                   ; 0xfe <__zp_bss_start+0xfe>
	ldy	#$1
	lda	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	($fe),y                 ; 0xfe <__zp_bss_start+0xfe>
	ldy	#$ff
	dec	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	cpy	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	beq	$8176 <bench+0x152>
	jmp	$80a6 <bench+0x82>
	dec	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	jmp	$80a6 <bench+0x82>
	cpy	#$0
	beq	$8182 <bench+0x15e>
	jmp	$80b9 <bench+0x95>
	ldy	#$8c
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	#$3
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	#$10
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$27
	sty	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	stz	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	jsr	$8268 <__udivmodsi4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$396                    ; 0x396 <__bss_size+0x20a>
	ldx	$39c                    ; 0x39c <__bss_size+0x210>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$0
	clc
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$397                    ; 0x397 <__bss_size+0x20b>
	ldx	$39d                    ; 0x39d <__bss_size+0x211>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	tax
	clc
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$396                    ; 0x396 <__bss_size+0x20a>
	txa
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$397                    ; 0x397 <__bss_size+0x20b>
	clc
	lda	$398                    ; 0x398 <__bss_size+0x20c>
	adc	#$f2
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$39b                    ; 0x39b <__bss_size+0x20f>
	txa
	adc	#$ff
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	clc
	lda	$399                    ; 0x399 <__bss_size+0x20d>
	adc	#$e4
	tay
	lda	$39a                    ; 0x39a <__bss_size+0x20e>
	adc	#$ff
	ldx	$38c                    ; 0x38c <__bss_size+0x200>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	$38d                    ; 0x38d <__bss_size+0x201>
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	bne	$8202 <bench+0x1de>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	beq	$822c <bench+0x208>
	ldx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stx	$39d                    ; 0x39d <__bss_size+0x211>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$39c                    ; 0x39c <__bss_size+0x210>
	sty	$399                    ; 0x399 <__bss_size+0x20d>
	sty	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sta	$39a                    ; 0x39a <__bss_size+0x20e>
	sta	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stz	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldx	#$0
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldy	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sty	$398                    ; 0x398 <__bss_size+0x20c>
	ldy	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	sty	$39b                    ; 0x39b <__bss_size+0x20f>
	jmp	$80b9 <bench+0x95>
	ldx	$397                    ; 0x397 <__bss_size+0x20b>
	lda	$396                    ; 0x396 <__bss_size+0x20a>
	ldy	$3a5                    ; 0x3a5 <__bss_size+0x219>
	sty	$ff                     ; 0xff <__zp_bss_start+0xff>
	ldy	$3a4                    ; 0x3a4 <__bss_size+0x218>
	sty	$fe                     ; 0xfe <__zp_bss_start+0xfe>
	ldy	$3a3                    ; 0x3a3 <__bss_size+0x217>
	sty	$fd                     ; 0xfd <__zp_bss_start+0xfd>
	ldy	$3a2                    ; 0x3a2 <__bss_size+0x216>
	sty	$fc                     ; 0xfc <__zp_bss_start+0xfc>
	ldy	$3a1                    ; 0x3a1 <__bss_size+0x215>
	sty	$fb                     ; 0xfb <__zp_bss_start+0xfb>
	ldy	$3a0                    ; 0x3a0 <__bss_size+0x214>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldy	$39f                    ; 0x39f <__bss_size+0x213>
	sty	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	$39e                    ; 0x39e <__bss_size+0x212>
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
