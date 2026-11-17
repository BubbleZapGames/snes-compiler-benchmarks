;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r0
	stz	r1
l25:
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
	sta	r31
	lda	r1
	and	#255
	tax
	clc
	adc	#<_arr
	tax
	lda	r31
	sep	#32
	a8
	sta	!0,x
	inc	r1
	lda	r1
	cmp	#64
	a16
	rep	#32
	bcc	l25
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r6
	stz	r1
l39:
	stz	r2
	lda	r1
	and	#255
	sta	r31
	lda	#63
	sec
	sbc	r31
	sta	r3
	clc
	sbc	#0
	bvc	l54
	eor	#32768
l54:
	bmi	l43
l40:
	lda	r2
	and	#255
	clc
	adc	#<_arr
	sta	r0
	lda	r2
	and	#255
	clc
	adc	#<1+_arr
	tax
	lda	(r0)
	sta	r5
	lda	!0,x
	sta	r4
	sep	#32
	a8
	lda	r5
	cmp	r4
	a16
	rep	#32
	bcc	l18
	beq	l18
	sep	#32
	a8
	lda	r4
	sta	(r0)
	lda	r5
	sta	!0,x
	a16
	rep	#32
l18:
	sep	#32
	a8
	inc	r2
	a16
	rep	#32
	lda	r2
	and	#255
	pha
	sec
	sbc	r3
	bvc	l56
	eor	#32768
l56:
	bmi	l55
	pla
l43:
	sep	#32
	a8
	inc	r1
	lda	r1
	cmp	#63
	a16
	rep	#32
	bcc	l39
	stz	r1
l41:
	lda	r6
	asl
	sta	r0
	lda	r1
	and	#255
	clc
	adc	#<_arr
	tax
	lda	!0,x
	and	#255
	eor	r0
	sta	r6
	sep	#32
	a8
	inc	r1
	lda	r1
	cmp	#64
	a16
	rep	#32
	bcc	l41
	lda	r6
	rtl
l55:
	pla
	bra	l40
; stacksize=0+??
	global	_arr
	section	"DONTMERGE_bss.near.arr.0","aurw"
_arr:
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
