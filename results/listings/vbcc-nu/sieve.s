;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	phy
	stz	r5
	lda	#<_flags
	sta	r1
	lda	#1024
	sta	r4
	lda	r1
	sta	1,s
	tax
l29:
	sep	#32
	a8
	stz	!0,x
	a16
	inx
	rep	#32
	dec	r4
	lda	r4
	bne	l29
	lda	#2
	sta	r3
	lda	#<2+_flags
	sta	r0
l33:
	sep	#32
	a8
	lda	(r0)
	a16
	rep	#32
	bne	l37
	inc	r5
	lda	r3
	clc
	adc	r3
	sta	r1
	cmp	#1024
	bcs	l37
	lda	#<_flags
	clc
	adc	r1
	tax
l34:
	sep	#32
	a8
	lda	#1
	sta	!0,x
	a16
	rep	#32
	lda	r1
	clc
	adc	r3
	sta	r1
	txa
	clc
	adc	r3
	tax
	lda	r1
	cmp	#1024
	bcc	l34
l37:
	inc	r3
	inc	r0
	lda	r3
	cmp	#1024
	bcc	l33
	lda	r5
	ply
	rtl
; stacksize=0+??
	global	_flags
	section	"DONTMERGE_bss.near.flags.0","aurw"
_flags:
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
