_fini:
	rts

bench_init:
	ldx	#$1
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$0
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stz	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl
	rol	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpx	#$1
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tay
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	tax
	clc
	tya
	adc	#$19
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	txa
	adc	#$36
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	and	#$1f
	ldx	#$0
	dec
	cmp	#$ff
	bne	$8060 <bench_init+0x3d>
	dex
	txy
	bne	$806b <bench_init+0x48>
	cmp	#$1e
	ldy	#$1
	bcc	$8071 <bench_init+0x4e>
	bra	$809d <bench_init+0x7a>
	cpx	#$0
	ldy	#$1
	bcs	$809d <bench_init+0x7a>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	asl	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	rol
	stz	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	rol
	rol	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$808d <bench_init+0x6a>
	tax
	beq	$809d <bench_init+0x7a>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$8095 <bench_init+0x72>
	cmp	#$1f
	beq	$809d <bench_init+0x7a>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	and	#$3
	beq	$809d <bench_init+0x7a>
	ldy	#$0
	lda	#$2
	clc
	ldx	#$0
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$2
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	tya
	sta	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inx
	bne	$80b9 <bench_init+0x96>
	iny
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	phy
	ldy	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ply
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	cpy	#$4
	beq	$80ce <bench_init+0xab>
	jmp	$8031 <bench_init+0xe>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	beq	$80de <bench_init+0xbb>
	jmp	$8031 <bench_init+0xe>
	ldx	#$1
	stx	$602                    ; 0x602 <start>
	stz	$223                    ; 0x223 <grid+0x21>
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
	stx	$c03                    ; 0xc03 <__bss_size+0x200>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$c04                    ; 0xc04 <__bss_size+0x201>
	ldx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	stx	$c05                    ; 0xc05 <__bss_size+0x202>
	ldx	#$3
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$6
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$ff
	ldx	#$4
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	#$0
	jsr	$837b <__memset>
	lda	$602                    ; 0x602 <start>
	and	#$1
	ldx	#$21
	ldy	#$0
	cmp	#$0
	bne	$8125 <bench+0x3e>
	ldx	#$0
	stz	$603,x                  ; 0x603 <dist>
	stx	$a03                    ; 0xa03 <queue>
	sty	$a04                    ; 0xa04 <queue+0x1>
	lda	#$1
	stz	$ee                     ; 0xee <__zp_bss_start+0xee>
	ldx	#$0
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	txa
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	stz	$ec                     ; 0xec <__zp_bss_start+0xec>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	#$3
	ldy	#$0
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	clc
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$a
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	sta	$ef                     ; 0xef <__zp_bss_start+0xef>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	iny
	lda	($e6),y                 ; 0xe6 <__zp_bss_start+0xe6>
	sta	$f2                     ; 0xf2 <__zp_bss_start+0xf2>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	#$3
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpy	#$1
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	tay
	lda	#$6
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	lda	#$2
	phy
	ldy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpy	#$1
	ply
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$2
	adc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	clc
	adc	#$e0
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sta	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	adc	#$ff
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	phy
	ldy	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	sta	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	clc
	lda	$ec                     ; 0xec <__zp_bss_start+0xec>
	adc	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	ldy	#$1
	bcs	$81a8 <bench+0xc1>
	ldy	#$0
	sty	$f3                     ; 0xf3 <__zp_bss_start+0xf3>
	ply
	sta	$ec                     ; 0xec <__zp_bss_start+0xec>
	inc	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	sty	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	beq	$81b9 <bench+0xd2>
	stx	$ed                     ; 0xed <__zp_bss_start+0xed>
	bra	$81d4 <bench+0xed>
	lda	#$1
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	stx	$ed                     ; 0xed <__zp_bss_start+0xed>
	tya
	clc
	adc	#$e0
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	adc	#$ff
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	cmp	#$ff
	bne	$81d4 <bench+0xed>
	jmp	$82d9 <bench+0x1f2>
	ldy	#$1
	sty	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	#$ff
	dec	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	cpy	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	bne	$81ea <bench+0x103>
	dec	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	ldx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldy	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	#$ff
	dec	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bne	$8202 <bench+0x11b>
	dec	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	bne	$8221 <bench+0x13a>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	#$ff
	dec	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	cpy	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	bne	$8218 <bench+0x131>
	dec	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	cmp	#$ff
	bne	$8221 <bench+0x13a>
	jmp	$8322 <bench+0x23b>
	ldy	$ea                     ; 0xea <__zp_bss_start+0xea>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$8229 <bench+0x142>
	inc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	($e6),y                 ; 0xe6 <__zp_bss_start+0xe6>
	bne	$8268 <bench+0x181>
	ldx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	cmp	#$ff
	bne	$8268 <bench+0x181>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	asl	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$3
	clc
	adc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	#$a
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	($e6),y                 ; 0xe6 <__zp_bss_start+0xe6>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$f7                     ; 0xf7 <__zp_bss_start+0xf7>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$f8                     ; 0xf8 <__zp_bss_start+0xf8>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$20
	lda	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	beq	$8279 <bench+0x192>
	jmp	$82b9 <bench+0x1d2>
	ldx	$f4                     ; 0xf4 <__zp_bss_start+0xf4>
	stx	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldx	$f5                     ; 0xf5 <__zp_bss_start+0xf5>
	stx	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	cmp	#$ff
	bne	$82b9 <bench+0x1d2>
	clc
	lda	$ef                     ; 0xef <__zp_bss_start+0xef>
	adc	#$20
	tax
	lda	$f2                     ; 0xf2 <__zp_bss_start+0xf2>
	adc	#$0
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	asl	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$3
	clc
	adc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$a
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	txa
	sta	($e4)                   ; 0xe4 <__zp_bss_start+0xe4>
	ldy	#$1
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$ed                     ; 0xed <__zp_bss_start+0xed>
	inx
	lda	$ee                     ; 0xee <__zp_bss_start+0xee>
	ldy	$f3                     ; 0xf3 <__zp_bss_start+0xf3>
	cpy	#$1
	adc	#$0
	sta	$ee                     ; 0xee <__zp_bss_start+0xee>
	lda	#$0
	cmp	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	beq	$82cf <bench+0x1e8>
	jmp	$813b <bench+0x54>
	cpx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	beq	$82d6 <bench+0x1ef>
	jmp	$813b <bench+0x54>
	jmp	$835b <bench+0x274>
	lda	$ef                     ; 0xef <__zp_bss_start+0xef>
	clc
	adc	#$e0
	ldx	#$1
	bcs	$82e4 <bench+0x1fd>
	ldx	#$0
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	tay
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	asl	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$3
	clc
	adc	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$a
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	$f2                     ; 0xf2 <__zp_bss_start+0xf2>
	ldx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	cpx	#$1
	adc	#$ff
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	ldx	$ea                     ; 0xea <__zp_bss_start+0xea>
	stx	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	tya
	sta	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$1
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldy	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sta	($e6)                   ; 0xe6 <__zp_bss_start+0xe6>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	jmp	$81d8 <bench+0xf1>
	ldx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	stx	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldx	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	stx	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stx	$ea                     ; 0xea <__zp_bss_start+0xea>
	asl	$ea                     ; 0xea <__zp_bss_start+0xea>
	rol	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$3
	clc
	adc	$ea                     ; 0xea <__zp_bss_start+0xea>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	#$a
	adc	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	lda	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	sta	($ea)                   ; 0xea <__zp_bss_start+0xea>
	ldy	#$1
	lda	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	sta	($ea),y                 ; 0xea <__zp_bss_start+0xea>
	lda	$f6                     ; 0xf6 <__zp_bss_start+0xf6>
	sta	($e8)                   ; 0xe8 <__zp_bss_start+0xe8>
	inc	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	stz	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	inc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	bne	$8358 <bench+0x271>
	jmp	$8227 <bench+0x140>
	jmp	$8229 <bench+0x142>
	ldx	$ee                     ; 0xee <__zp_bss_start+0xee>
	lda	$ec                     ; 0xec <__zp_bss_start+0xec>
	ldy	$c05                    ; 0xc05 <__bss_size+0x202>
	sty	$fa                     ; 0xfa <__zp_bss_start+0xfa>
	ldy	$c04                    ; 0xc04 <__bss_size+0x201>
	sty	$f9                     ; 0xf9 <__zp_bss_start+0xf9>
	ldy	$c03                    ; 0xc03 <__bss_size+0x200>
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
