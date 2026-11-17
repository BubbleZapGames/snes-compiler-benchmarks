;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r1
	ldx	#<_data
	lda	#1024
	sta	r0
l25:
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
	bne	l25
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r2
	stz	r2+2
	stz	r4
	lda	#<_data
	sta	r0
l33:
	lda	(r0)
	and	#255
	ldx	#0
	xba
	and	#65280
	tax
	lda	#0
	eor	r2
	sta	r2
	txa
	eor	r2+2
	sta	r2+2
	lda	#8
	sta	r1
l34:
	lda	#0
	pha
	lda	r2+2
	and	#32768
	tax
	pla
	cpx	#0
	bne	l40
	cmp	#0
	beq	l18
l40:
	lda	r2+2
	sta	r31
	lda	r2
	asl
	rol	r31
	ldx	r31
	eor	#7607
	sta	r2
	txa
	eor	#1217
	sta	r2+2
	bra	l19
l18:
	asl	r2
	rol	r2+2
l19:
	sep	#32
	a8
	dec	r1
	lda	r1
	a16
	rep	#32
	bne	l34
	inc	r4
	inc	r0
	lda	r4
	cmp	#1024
	bcc	l33
	lda	r2
	eor	#65535
	sta	r2
	lda	r2+2
	eor	#65535
	sta	r2+2
	ldx	#0
	sta	r31
	sta	r0
	lda	r2
	eor	r0
	rtl
; stacksize=0+??
	global	_data
	section	"DONTMERGE_bss.near.data.0","aurw"
_data:
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
