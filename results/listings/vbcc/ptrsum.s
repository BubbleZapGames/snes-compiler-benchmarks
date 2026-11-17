;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#510
	sta	r1
	sep	#32
	a8
	lda	#54
	sta	_buf
	a16
	rep	#32
	lda	#17583
	sta	r0
	sep	#32
	a8
	lda	#68
	sta	1+_buf
	a16
	ldx	#<2+_buf
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
	section	"DONTMERGE_text.far.sum_bytes.0","acrx"
	a16
	x16
	global	_sum_bytes
_sum_bytes:
	sta	r2
	stz	r1
	lda	4,s
	beq	l30
	ldx	r2
	lda	4,s
	sta	r0
l29:
	lda	!0,x
	and	#255
	clc
	adc	r1
	sta	r1
	inx
	dec	r0
	lda	r0
	bne	l29
l30:
	lda	r1
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#494
	sta	r1
	lda	_buf
	and	#255
	sta	r0
	lda	1+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	2+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	3+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	4+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	5+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	6+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	7+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	8+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	9+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	10+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	11+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	12+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	13+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	14+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	15+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	16+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	lda	17+_buf
	and	#255
	clc
	adc	r0
	sta	r0
	ldx	#<18+_buf
l52:
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	!0,x
	and	#255
	clc
	adc	r0
	sta	r0
	inx
	lda	r1
	sec
	sbc	#19
	sta	r1
	cmp	#0
	bne	l52
	lda	r0
	rtl
; stacksize=0+??
	global	_buf
	section	"DONTMERGE_bss.near.buf.0","aurw"
_buf:
	reserve	512
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
