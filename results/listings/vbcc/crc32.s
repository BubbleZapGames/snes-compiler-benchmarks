;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1020
	sta	r1
	lda	#17462
	sta	_data
	sep	#32
	a8
	lda	#141
	sta	2+_data
	a16
	rep	#32
	lda	#63917
	sta	r0
	sep	#32
	a8
	lda	#249
	sta	3+_data
	a16
	ldx	#<4+_data
	rep	#32
l29:
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	xba
	and	#255
	sep	#32
	a8
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r1
	sec
	sbc	#10
	sta	r1
	cmp	#0
	bne	l29
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r2
	stz	r2+2
	lda	#<_data
	sta	r0
	lda	#1024
	sta	r1
l53:
	lda	(r0)
	and	#255
	ldx	#0
	xba
	and	#65280
	tax
	lda	#0
	eor	r2
	sta	r2
	txa
	eor	r2+2
	sta	r2+2
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l79
	cmp	#0
	beq	l35
l79:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l36
l35:
	asl	r2
	rol	r2+2
l36:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l80
	cmp	#0
	beq	l37
l80:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l38
l37:
	asl	r2
	rol	r2+2
l38:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l81
	cmp	#0
	beq	l39
l81:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l40
l39:
	asl	r2
	rol	r2+2
l40:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l82
	cmp	#0
	beq	l41
l82:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l42
l41:
	asl	r2
	rol	r2+2
l42:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l83
	cmp	#0
	beq	l43
l83:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l44
l43:
	asl	r2
	rol	r2+2
l44:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l84
	cmp	#0
	beq	l45
l84:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l46
l45:
	asl	r2
	rol	r2+2
l46:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l85
	cmp	#0
	beq	l47
l85:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l48
l47:
	asl	r2
	rol	r2+2
l48:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l86
	cmp	#0
	beq	l18
l86:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l19
l18:
	asl	r2
	rol	r2+2
l19:
	inc	r0
	dec	r1
	lda	r1
	bne	l53
	lda	r2
	eor	#65535
	sta	r2
	lda	r2+2
	eor	#65535
	sta	r2+2
	ldx	#0
	sta	r31
	sta	r0
	lda	r2
	eor	r0
	rtl
; stacksize=0+??
	global	_data
	section	"DONTMERGE_bss.near.data.0","aurw"
_data:
	reserve	1024
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
