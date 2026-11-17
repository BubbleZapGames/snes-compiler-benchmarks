_fini:
	rts

bench_init:
	ldx	#$2
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	ldx	#$2
	stx	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	#$0
	stz	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	tax
	clc
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	#$2
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$4
	sta	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	txa
	and	#$3
	sta	$ed                     ; 0xed <__zp_bss_start+0xed>
	inc
	ldy	#$4
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	#$6
	tay
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$ec                     ; 0xec <__zp_bss_start+0xec>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	#$1
	lda	#$0
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	iny
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	dey
	lda	#$0
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	sta	($e6),y                 ; 0xe6 <__zp_bss_start+0xe6>
	sty	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$ec                     ; 0xec <__zp_bss_start+0xec>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	txa
	and	#$1
	ora	#$2
	ldy	#$6
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	ldy	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	#$0
	sta	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	inc	$ed                     ; 0xed <__zp_bss_start+0xed>
	dec	$ed                     ; 0xed <__zp_bss_start+0xed>
	beq	$809a <bench_init+0x77>
	tya
	ldy	#$8
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	adc	#$5
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$9
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	inx
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	clc
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	adc	#$7
	cpx	#$20
	beq	$80bf <bench_init+0x9c>
	jmp	$8030 <bench_init+0xd>
	rts

bench:
	ldx	#$0
	stz	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	bra	$80cf <bench+0xf>
	inc	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	bne	$80cf <bench+0xf>
	jmp	$8208 <bench+0x148>
	stx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	ldx	#$20
	lda	#$2
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	#$2
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	jmp	$8126 <bench+0x66>
	cmp	#$0
	bcc	$80e5 <bench+0x25>
	jmp	$8169 <bench+0xa9>
	jmp	$818f <bench+0xcf>
	cmp	#$0
	bcc	$8112 <bench+0x52>
	sec
	lda	#$0
	sbc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$0
	sbc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$6
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$6
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	ldy	#$1
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	dex
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$9
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	txa
	bne	$8126 <bench+0x66>
	jmp	$81f9 <bench+0x139>
	ldy	#$8
	lda	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	beq	$8112 <bench+0x52>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$4
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	#$4
	lda	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	ldy	#$1
	lda	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	clc
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	adc	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	($e2)                   ; 0xe2 <__zp_bss_start+0xe2>
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	beq	$8163 <bench+0xa3>
	jmp	$80de <bench+0x1e>
	ldy	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	cpy	#$f1
	bcc	$818f <bench+0xcf>
	sec
	lda	#$0
	sbc	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	#$0
	sbc	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	#$4
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	ldy	#$4
	lda	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	ldy	#$1
	lda	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	sta	($e4),y                 ; 0xe4 <__zp_bss_start+0xe4>
	ldy	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	sty	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	clc
	adc	#$6
	sta	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	ldy	#$6
	lda	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sta	$e4                     ; 0xe4 <__zp_bss_start+0xe4>
	sta	$ea                     ; 0xea <__zp_bss_start+0xea>
	clc
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	adc	#$2
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	#$0
	sta	$ee                     ; 0xee <__zp_bss_start+0xee>
	ldy	#$1
	sty	$ec                     ; 0xec <__zp_bss_start+0xec>
	lda	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	sta	$e5                     ; 0xe5 <__zp_bss_start+0xe5>
	sta	$ed                     ; 0xed <__zp_bss_start+0xed>
	ldy	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	sty	$e8                     ; 0xe8 <__zp_bss_start+0xe8>
	ldy	$ee                     ; 0xee <__zp_bss_start+0xee>
	sty	$e9                     ; 0xe9 <__zp_bss_start+0xe9>
	clc
	ldy	#$2
	lda	$ea                     ; 0xea <__zp_bss_start+0xea>
	adc	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	sty	$ee                     ; 0xee <__zp_bss_start+0xee>
	sta	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	ldy	$ec                     ; 0xec <__zp_bss_start+0xec>
	lda	$ed                     ; 0xed <__zp_bss_start+0xed>
	adc	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	sta	$ed                     ; 0xed <__zp_bss_start+0xed>
	lda	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	ldy	$ee                     ; 0xee <__zp_bss_start+0xee>
	sta	($e2),y                 ; 0xe2 <__zp_bss_start+0xe2>
	lda	$ed                     ; 0xed <__zp_bss_start+0xed>
	ldy	$ec                     ; 0xec <__zp_bss_start+0xec>
	sta	($e8),y                 ; 0xe8 <__zp_bss_start+0xe8>
	ldy	$ed                     ; 0xed <__zp_bss_start+0xed>
	beq	$81ed <bench+0x12d>
	jmp	$80e8 <bench+0x28>
	ldy	$eb                     ; 0xeb <__zp_bss_start+0xeb>
	cpy	#$c9
	bcc	$81f6 <bench+0x136>
	jmp	$80ec <bench+0x2c>
	jmp	$8112 <bench+0x52>
	ldx	$e7                     ; 0xe7 <__zp_bss_start+0xe7>
	inx
	bne	$8201 <bench+0x141>
	jmp	$80c6 <bench+0x6>
	lda	$e6                     ; 0xe6 <__zp_bss_start+0xe6>
	beq	$8208 <bench+0x148>
	jmp	$80cf <bench+0xf>
	cpx	#$10
	beq	$820f <bench+0x14f>
	jmp	$80cf <bench+0xf>
	lda	$204                    ; 0x204 <ents+0x2>
	ldx	$205                    ; 0x205 <ents+0x3>
	stx	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	adc	$202                    ; 0x202 <ents>
	tax
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$203                    ; 0x203 <ents+0x1>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	txa
	adc	$20b                    ; 0x20b <ents+0x9>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$20c                    ; 0x20c <ents+0xa>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$20d                    ; 0x20d <ents+0xb>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$20e                    ; 0x20e <ents+0xc>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$214                    ; 0x214 <ents+0x12>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$215                    ; 0x215 <ents+0x13>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$216                    ; 0x216 <ents+0x14>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$217                    ; 0x217 <ents+0x15>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$21d                    ; 0x21d <ents+0x1b>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$21e                    ; 0x21e <ents+0x1c>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$21f                    ; 0x21f <ents+0x1d>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$220                    ; 0x220 <ents+0x1e>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$226                    ; 0x226 <ents+0x24>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$227                    ; 0x227 <ents+0x25>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$228                    ; 0x228 <ents+0x26>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$229                    ; 0x229 <ents+0x27>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$22f                    ; 0x22f <ents+0x2d>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$230                    ; 0x230 <ents+0x2e>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$231                    ; 0x231 <ents+0x2f>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$232                    ; 0x232 <ents+0x30>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$238                    ; 0x238 <ents+0x36>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$239                    ; 0x239 <ents+0x37>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$23a                    ; 0x23a <ents+0x38>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$23b                    ; 0x23b <ents+0x39>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$241                    ; 0x241 <ents+0x3f>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$242                    ; 0x242 <ents+0x40>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$243                    ; 0x243 <ents+0x41>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$244                    ; 0x244 <ents+0x42>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$24a                    ; 0x24a <ents+0x48>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$24b                    ; 0x24b <ents+0x49>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$24c                    ; 0x24c <ents+0x4a>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$24d                    ; 0x24d <ents+0x4b>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$253                    ; 0x253 <ents+0x51>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$254                    ; 0x254 <ents+0x52>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$255                    ; 0x255 <ents+0x53>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$256                    ; 0x256 <ents+0x54>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$25c                    ; 0x25c <ents+0x5a>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$25d                    ; 0x25d <ents+0x5b>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$25e                    ; 0x25e <ents+0x5c>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$25f                    ; 0x25f <ents+0x5d>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$265                    ; 0x265 <ents+0x63>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$266                    ; 0x266 <ents+0x64>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$267                    ; 0x267 <ents+0x65>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$268                    ; 0x268 <ents+0x66>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$26e                    ; 0x26e <ents+0x6c>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$26f                    ; 0x26f <ents+0x6d>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$270                    ; 0x270 <ents+0x6e>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$271                    ; 0x271 <ents+0x6f>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$277                    ; 0x277 <ents+0x75>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$278                    ; 0x278 <ents+0x76>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$279                    ; 0x279 <ents+0x77>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$27a                    ; 0x27a <ents+0x78>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$280                    ; 0x280 <ents+0x7e>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$281                    ; 0x281 <ents+0x7f>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$282                    ; 0x282 <ents+0x80>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$283                    ; 0x283 <ents+0x81>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$289                    ; 0x289 <ents+0x87>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$28a                    ; 0x28a <ents+0x88>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$28b                    ; 0x28b <ents+0x89>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$28c                    ; 0x28c <ents+0x8a>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$292                    ; 0x292 <ents+0x90>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$293                    ; 0x293 <ents+0x91>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$294                    ; 0x294 <ents+0x92>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$295                    ; 0x295 <ents+0x93>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$29b                    ; 0x29b <ents+0x99>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$29c                    ; 0x29c <ents+0x9a>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$29d                    ; 0x29d <ents+0x9b>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$29e                    ; 0x29e <ents+0x9c>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2a4                    ; 0x2a4 <ents+0xa2>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2a5                    ; 0x2a5 <ents+0xa3>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2a6                    ; 0x2a6 <ents+0xa4>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2a7                    ; 0x2a7 <ents+0xa5>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2ad                    ; 0x2ad <ents+0xab>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2ae                    ; 0x2ae <ents+0xac>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2af                    ; 0x2af <ents+0xad>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2b0                    ; 0x2b0 <ents+0xae>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2b6                    ; 0x2b6 <ents+0xb4>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2b7                    ; 0x2b7 <ents+0xb5>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2b8                    ; 0x2b8 <ents+0xb6>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2b9                    ; 0x2b9 <ents+0xb7>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2bf                    ; 0x2bf <ents+0xbd>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2c0                    ; 0x2c0 <ents+0xbe>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2c1                    ; 0x2c1 <ents+0xbf>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2c2                    ; 0x2c2 <ents+0xc0>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2c8                    ; 0x2c8 <ents+0xc6>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2c9                    ; 0x2c9 <ents+0xc7>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2ca                    ; 0x2ca <ents+0xc8>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2cb                    ; 0x2cb <ents+0xc9>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2d1                    ; 0x2d1 <ents+0xcf>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2d2                    ; 0x2d2 <ents+0xd0>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2d3                    ; 0x2d3 <ents+0xd1>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2d4                    ; 0x2d4 <ents+0xd2>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2da                    ; 0x2da <ents+0xd8>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2db                    ; 0x2db <ents+0xd9>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2dc                    ; 0x2dc <ents+0xda>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2dd                    ; 0x2dd <ents+0xdb>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2e3                    ; 0x2e3 <ents+0xe1>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2e4                    ; 0x2e4 <ents+0xe2>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2e5                    ; 0x2e5 <ents+0xe3>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2e6                    ; 0x2e6 <ents+0xe4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2ec                    ; 0x2ec <ents+0xea>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2ed                    ; 0x2ed <ents+0xeb>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2ee                    ; 0x2ee <ents+0xec>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2ef                    ; 0x2ef <ents+0xed>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2f5                    ; 0x2f5 <ents+0xf3>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2f6                    ; 0x2f6 <ents+0xf4>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2f7                    ; 0x2f7 <ents+0xf5>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2f8                    ; 0x2f8 <ents+0xf6>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$2fe                    ; 0x2fe <ents+0xfc>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$2ff                    ; 0x2ff <ents+0xfd>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$300                    ; 0x300 <ents+0xfe>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$301                    ; 0x301 <ents+0xff>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$307                    ; 0x307 <ents+0x105>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$308                    ; 0x308 <ents+0x106>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$309                    ; 0x309 <ents+0x107>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$30a                    ; 0x30a <ents+0x108>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$310                    ; 0x310 <ents+0x10e>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$311                    ; 0x311 <ents+0x10f>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$312                    ; 0x312 <ents+0x110>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$313                    ; 0x313 <ents+0x111>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$319                    ; 0x319 <ents+0x117>
	sta	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$31a                    ; 0x31a <ents+0x118>
	sta	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	clc
	lda	$e3                     ; 0xe3 <__zp_bss_start+0xe3>
	adc	$31b                    ; 0x31b <ents+0x119>
	tay
	lda	$e2                     ; 0xe2 <__zp_bss_start+0xe2>
	adc	$31c                    ; 0x31c <ents+0x11a>
	tax
	tya
	rts
