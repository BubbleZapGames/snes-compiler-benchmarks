;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#20
	sta	_n_iter
	lda	#16
	sta	_size
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.fact.0","acrx"
	a16
	x16
	global	_fact
_fact:
	pei	(r16)
	pei	(r17)
	sta	r17
	cmp	#1
	bcc	l6
	beq	l6
	lda	r17
	dea
	sta	r16
	cmp	#1
	bcc	l28
	beq	l28
	lda	r16
	dea
	jsl	>_fact
	sta	r4
	stx	r4+2
	lda	r16
	ldx	#0
	sta	r6
	stx	r6+2
	jsl	>___mulint32snes
	sta	r0
	stx	r0+2
	bra	l25
l28:
	lda	#1
	sta	r0
	stz	r0+2
l25:
	lda	r17
	ldx	#0
	sta	r31
	lda	r0
	sta	r4
	lda	r0+2
	sta	r4+2
	lda	r31
	sta	r6
	stx	r6+2
	jsl	>___mulint32snes
	bra	l3
l6:
	ldx	#0
	lda	#1
l3:
	tay
	pla
	sta	r17
	pla
	sta	r16
	tya
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	pei	(r16)
	pei	(r17)
	pei	(r18)
	pei	(r19)
	pei	(r20)
	pei	(r21)
	phy
	stz	r20
	stz	r20+2
	lda	_size
	beq	l75
	lda	#<_array
	sta	r0
	lda	_size
	sta	r1
	lda	r0
	sta	1,s
	tax
l67:
	stz	!0,x
	stz	!2,x
	txa
	clc
	adc	#4
	tax
	dec	r1
	lda	r1
	bne	l67
l75:
	stz	r19
	lda	_n_iter
	beq	l76
l72:
	stz	r17
	lda	_size
	beq	l77
	lda	#65535
	sta	r18
	lda	#<_array
	sta	r16
l73:
	lda	r17
	cmp	#1
	bcc	l32
	beq	l32
	lda	r18
	jsl	>_fact
	sta	r4
	stx	r4+2
	lda	r17
	ldx	#0
	sta	r6
	stx	r6+2
	jsl	>___mulint32snes
	sta	r0
	stx	r0+2
	bra	l29
l32:
	lda	#1
	sta	r0
	stz	r0+2
l29:
	clc
	lda	(r16)
	adc	r0
	sta	(r16)
	ldy	#2
	lda	(r16),y
	adc	r0+2
	sta	(r16),y
	inc	r17
	lda	r16
	clc
	adc	#4
	sta	r16
	inc	r18
	lda	r17
	cmp	_size
	bcc	l73
l77:
	inc	r19
	lda	r19
	cmp	_n_iter
	bcc	l72
l76:
	lda	_size
	beq	l78
	ldx	#<_array
	lda	_size
	sta	r2
l74:
	clc
	lda	r20
	adc	!0,x
	sta	r20
	lda	r20+2
	adc	!2,x
	sta	r20+2
	txa
	clc
	adc	#4
	tax
	dec	r2
	lda	r2
	bne	l74
l78:
	lda	r20+2
	ldx	#0
	sta	r31
	sta	r0
	lda	r20
	eor	r0
	ply
	plx
	stx	r21
	plx
	stx	r20
	plx
	stx	r19
	plx
	stx	r18
	plx
	stx	r17
	plx
	stx	r16
	rtl
; stacksize=0+??
	global	___mulint32snes
	global	_array
	section	"DONTMERGE_bss.near.array.0","aurw"
_array:
	reserve	64
	global	_n_iter
	section	"DONTMERGE_bss.near.n_iter.0","aurw"
_n_iter:
	reserve	2
	global	_size
	section	"DONTMERGE_bss.near.size.0","aurw"
_size:
	reserve	2
	zpage	r0
	zpage	r1
	zpage	r2
	zpage	r3
	zpage	r4
	zpage	r5
	zpage	r6
	zpage	r7
	zpage	r8
	zpage	r9
	zpage	r10
	zpage	r11
	zpage	r12
	zpage	r13
	zpage	r14
	zpage	r15
	zpage	r16
	zpage	r17
	zpage	r18
	zpage	r19
	zpage	r20
	zpage	r21
	zpage	r22
	zpage	r23
	zpage	r24
	zpage	r25
	zpage	r26
	zpage	r27
	zpage	r28
	zpage	r29
	zpage	r30
	zpage	r31
	zpage	btmp0
	zpage	btmp1
	zpage	btmp2
	zpage	btmp3
