;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r1
	ldx	#<_b
	lda	#<_a
	sta	r0
	lda	#64
	sta	r2
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
	sta	(r0)
	lda	r1
	sta	!0,x
	a16
	rep	#32
	inc	r0
	inx
	dec	r2
	lda	r2
	bne	l18
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
	stz	r19
	lda	#<_b
	sta	r16
	lda	#<_a
	sta	r17
	lda	#64
	sta	r18
l27:
	lda	(r17)
	and	#255
	sta	r1
	lda	(r16)
	and	#255
	sta	r0
	jsl	>___mulint16snes
	clc
	adc	r19
	sta	r19
	inc	r17
	inc	r16
	dec	r18
	lda	r18
	bne	l27
	lda	r19
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
