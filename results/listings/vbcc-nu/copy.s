;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r1
	ldx	#<_src
	lda	#1024
	sta	r0
l18:
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
	bne	l18
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	ldx	#<_dst
	lda	#<_src
	sta	r0
	lda	#1024
	sta	r1
l25:
	sep	#32
	a8
	lda	(r0)
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	dec	r1
	lda	r1
	bne	l25
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
