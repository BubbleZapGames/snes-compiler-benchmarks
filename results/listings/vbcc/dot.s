;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#63
	sta	r2
	lda	#13854
	sta	r1
	sep	#32
	a8
	lda	#54
	sta	_a
	lda	#30
	sta	_b
	a16
	rep	#32
	lda	#<1+_a
	sta	r0
	ldx	#<1+_b
l19:
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	asl
	asl
	clc
	adc	r1
	clc
	adc	#13849
	sta	r1
	xba
	and	#255
	sep	#32
	a8
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r2
	sec
	sbc	#7
	sta	r2
	cmp	#0
	bne	l19
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
	lda	#55
	sta	r19
	lda	_a
	and	#255
	tax
	lda	_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	sta	r18
	lda	1+_a
	and	#255
	tax
	lda	1+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	2+_a
	and	#255
	tax
	lda	2+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	3+_a
	and	#255
	tax
	lda	3+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	4+_a
	and	#255
	tax
	lda	4+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	5+_a
	and	#255
	tax
	lda	5+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	6+_a
	and	#255
	tax
	lda	6+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	7+_a
	and	#255
	tax
	lda	7+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	8+_a
	and	#255
	tax
	lda	8+_b
	and	#255
	stx	r1
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	lda	#<9+_a
	sta	r17
	lda	#<9+_b
	sta	r16
l33:
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r18
	sta	r18
	inc	r17
	inc	r16
	lda	r19
	sec
	sbc	#11
	sta	r19
	cmp	#0
	bne	l33
	lda	r18
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
	global	___mulint16snes
	global	_a
	section	"DONTMERGE_bss.near.a.0","aurw"
_a:
	reserve	64
	global	_b
	section	"DONTMERGE_bss.near.b.0","aurw"
_b:
	reserve	64
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
