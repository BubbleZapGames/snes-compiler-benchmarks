;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r1
	ldx	#<_buf
	lda	#512
	sta	r0
l20:
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
	bne	l20
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
	beq	l28
	ldx	r2
	lda	4,s
	sta	r0
l27:
	lda	!0,x
	and	#255
	clc
	adc	r1
	sta	r1
	inx
	dec	r0
	lda	r0
	bne	l27
l28:
	lda	r1
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r1
	ldx	#<_buf
	lda	#512
	sta	r0
l40:
	lda	!0,x
	and	#255
	clc
	adc	r1
	sta	r1
	inx
	dec	r0
	lda	r0
	bne	l40
	lda	r1
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
