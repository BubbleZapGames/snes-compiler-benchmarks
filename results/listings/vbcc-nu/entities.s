;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	stz	r4
	stz	r6
	stz	r5
	lda	#<8+_ents
	sta	r0
	lda	#<6+_ents
	sta	r1
	ldx	#<4+_ents
	lda	#<2+_ents
	sta	r3
	lda	#<_ents
	sta	r2
l34:
	lda	r5
	sec
	sbc	r4
	sta	(r2)
	lda	r6
	clc
	adc	r4
	sta	(r3)
	lda	r4
	and	#3
	ina
	sta	!0,x
	lda	r4
	and	#1
	ina
	ina
	sta	(r1)
	lda	r4
	and	#3
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	bne	l7
	stz	r7
	bra	l8
l7:
	lda	#1
	sta	r7
l8:
	sep	#32
	a8
	lda	r7
	sta	(r0)
	a16
	rep	#32
	inc	r4
	lda	r5
	clc
	adc	#8
	sta	r5
	lda	r2
	clc
	adc	#9
	sta	r2
	lda	r3
	clc
	adc	#9
	sta	r3
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	lda	r6
	clc
	adc	#4
	sta	r6
	lda	r4
	cmp	#32
	bcc	l34
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	phy
	stz	r9
	stz	r8
l59:
	lda	#<6+_ents
	sta	r0
	lda	#<2+_ents
	sta	r1
	ldx	#<4+_ents
	lda	#<_ents
	sta	r2
	lda	#<8+_ents
	sta	r3
	lda	#32
	sta	r4
l60:
	sep	#32
	a8
	lda	(r3)
	a16
	rep	#32
	beq	l25
	lda	!0,x
	clc
	adc	(r2)
	sta	(r2)
	cmp	#240
	bcc	l23
	beq	l23
	lda	#0
	sec
	sbc	!0,x
	sta	!0,x
l23:
	lda	(r0)
	clc
	adc	(r1)
	sta	(r1)
	cmp	#200
	bcc	l25
	beq	l25
	lda	#0
	sec
	sbc	(r0)
	sta	(r0)
l25:
	lda	r3
	clc
	adc	#9
	sta	r3
	lda	r2
	clc
	adc	#9
	sta	r2
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	dec	r4
	lda	r4
	bne	l60
	inc	r8
	lda	r8
	cmp	#16
	bcc	l59
	lda	#<2+_ents
	sta	r4
	lda	#<_ents
	sta	r5
	lda	#32
	sta	r7
	lda	r4
	sta	1,s
	tax
l58:
	lda	!0,x
	clc
	adc	(r5)
	clc
	adc	r9
	sta	r9
	lda	r5
	clc
	adc	#9
	sta	r5
	txa
	clc
	adc	#9
	tax
	dec	r7
	lda	r7
	bne	l58
	lda	r9
	ply
	rtl
; stacksize=0+??
	global	_ents
	section	"DONTMERGE_bss.near.ents.0","aurw"
_ents:
	reserve	288
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
