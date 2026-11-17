;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1020
	sta	r1
	lda	#17462
	sta	_src
	sep	#32
	a8
	lda	#141
	sta	2+_src
	a16
	rep	#32
	lda	#63917
	sta	r0
	sep	#32
	a8
	lda	#249
	sta	3+_src
	a16
	ldx	#<4+_src
	rep	#32
l22:
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
	bne	l22
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#1007
	sta	r1
	sep	#32
	a8
	lda	_src
	sta	_dst
	lda	1+_src
	sta	1+_dst
	lda	2+_src
	sta	2+_dst
	lda	3+_src
	sta	3+_dst
	lda	4+_src
	sta	4+_dst
	lda	5+_src
	sta	5+_dst
	lda	6+_src
	sta	6+_dst
	lda	7+_src
	sta	7+_dst
	lda	8+_src
	sta	8+_dst
	lda	9+_src
	sta	9+_dst
	lda	10+_src
	sta	10+_dst
	lda	11+_src
	sta	11+_dst
	lda	12+_src
	sta	12+_dst
	lda	13+_src
	sta	13+_dst
	lda	14+_src
	sta	14+_dst
	lda	15+_src
	sta	15+_dst
	lda	16+_src
	sta	16+_dst
	a16
	rep	#32
	lda	#<17+_src
	sta	r0
	ldx	#<17+_dst
l46:
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	lda	r1
	sec
	sbc	#19
	sta	r1
	cmp	#0
	bne	l46
	lda	_dst
	and	#255
	sta	r0
	lda	511+_dst
	and	#255
	clc
	adc	r0
	sta	r0
	lda	1023+_dst
	and	#255
	clc
	adc	r0
	rtl
; stacksize=0+??
	global	_src
	section	"DONTMERGE_bss.near.src.0","aurw"
_src:
	reserve	1024
	global	_dst
	section	"DONTMERGE_bss.near.dst.0","aurw"
_dst:
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
