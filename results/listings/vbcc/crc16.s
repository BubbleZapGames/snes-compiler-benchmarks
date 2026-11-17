;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#250
	sta	r1
	lda	#17462
	sta	_buf
	lda	#63885
	sta	2+_buf
	sep	#32
	a8
	lda	#22
	sta	4+_buf
	a16
	rep	#32
	lda	#42619
	sta	r0
	sep	#32
	a8
	lda	#166
	sta	5+_buf
	a16
	ldx	#<6+_buf
	rep	#32
l31:
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
	bne	l31
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#65535
	sta	r0
	ldx	#<_buf
	lda	#256
	sta	r1
l60:
	lda	!0,x
	and	#255
	xba
	and	#65280
	eor	r0
	sta	r0
	and	#32768
	beq	l42
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l43
l42:
	asl	r0
l43:
	lda	r0
	and	#32768
	beq	l44
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l45
l44:
	asl	r0
l45:
	lda	r0
	and	#32768
	beq	l46
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l47
l46:
	asl	r0
l47:
	lda	r0
	and	#32768
	beq	l48
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l49
l48:
	asl	r0
l49:
	lda	r0
	and	#32768
	beq	l50
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l51
l50:
	asl	r0
l51:
	lda	r0
	and	#32768
	beq	l52
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l53
l52:
	asl	r0
l53:
	lda	r0
	and	#32768
	beq	l54
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l55
l54:
	asl	r0
l55:
	lda	r0
	and	#32768
	beq	l18
	lda	r0
	asl
	eor	#4129
	sta	r0
	bra	l19
l18:
	asl	r0
l19:
	inx
	dec	r1
	lda	r1
	bne	l60
	lda	r0
	rtl
; stacksize=0+??
	global	_buf
	section	"DONTMERGE_bss.near.buf.0","aurw"
_buf:
	reserve	256
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
