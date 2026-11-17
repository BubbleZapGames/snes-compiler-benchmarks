;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.fib.0","acrx"
	a16
	x16
	global	_fib
_fib:
	pei	(r16)
	pei	(r17)
	pei	(r18)
	pei	(r19)
	pei	(r20)
	sta	r19
	cmp	#2
	bcs	l6
	lda	r19
	bra	l3
l6:
	lda	r19
	dea
	sta	r17
	cmp	#2
	bcs	l12
	lda	r17
	sta	r20
	bra	l9
l12:
	lda	r17
	dea
	jsl	>_fib
	sta	r16
	lda	r17
	dea
	dea
	jsl	>_fib
	clc
	adc	r16
	sta	r20
l9:
	lda	r19
	dea
	dea
	sta	r18
	cmp	#2
	bcs	l16
	ldx	r18
	bra	l13
l16:
	lda	r18
	dea
	jsl	>_fib
	sta	r16
	lda	r18
	dea
	dea
	jsl	>_fib
	clc
	adc	r16
	tax
l13:
	txa
	clc
	adc	r20
l3:
	plx
	stx	r20
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
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#15
	jsl	>_fib
	sta	r0
	lda	#14
	jsl	>_fib
	clc
	adc	r0
	rtl
; stacksize=0+??
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
