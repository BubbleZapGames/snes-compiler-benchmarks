;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r1
	ldx	#<_buf
	lda	#256
	sta	r0
l21:
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
	sta	!0,x
	a16
	inx
	rep	#32
	dec	r0
	lda	r0
	bne	l21
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
l29:
	lda	!0,x
	sta	r0
	sep	#32
	a8
	lda	r0
	a16
	rep	#32
	beq	l32
l30:
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
	bne	l30
l32:
	inc	r1
	inx
	lda	r1
	cmp	#256
	bcc	l29
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
