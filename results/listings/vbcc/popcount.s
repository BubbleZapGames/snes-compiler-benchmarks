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
l27:
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
	bne	l27
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r2
	stz	r1
	ldx	#<_buf
l35:
	lda	!0,x
	sta	r0
	sep	#32
	a8
	lda	r0
	a16
	rep	#32
	beq	l38
l36:
	lda	r0
	and	#255
	and	#1
	clc
	adc	r2
	sta	r2
	sep	#32
	a8
	lsr	r0
	lda	r0
	a16
	rep	#32
	bne	l36
l38:
	inc	r1
	inx
	lda	r1
	cmp	#256
	bcc	l35
	lda	r2
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
