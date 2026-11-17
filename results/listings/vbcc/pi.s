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
	pei	(r16)
	pei	(r17)
	pei	(r18)
	pei	(r19)
	pei	(r20)
	pei	(r21)
	pei	(r22)
	pei	(r23)
	pei	(r24)
	pei	(r25)
	pei	(r26)
	pei	(r27)
	stz	r27
	stz	r26
	lda	#192
	sta	r0
	lda	#2000
	sta	_arr
	sta	2+_arr
	sta	4+_arr
	sta	6+_arr
	sta	8+_arr
	ldx	#<10+_arr
l60:
	lda	#2000
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	sta	!0,x
	inx
	inx
	lda	r0
	sec
	sbc	#24
	sta	r0
	cmp	#0
	bne	l60
	lda	#196
	sta	r19
	lda	#391
	sta	r24
	lda	#<392+_arr
	sta	r25
l61:
	stz	r20
	stz	r20+2
	lda	r19
	sta	r22
	lda	r19
	beq	l65
	lda	r25
	sta	r18
	lda	r24
	sta	r23
l62:
	lda	r22
	ldx	#0
	sta	r31
	lda	r20
	sta	r4
	lda	r20+2
	sta	r4+2
	lda	r31
	sta	r6
	stx	r6+2
	jsl	>___mulint32snes
	sta	r16
	stx	r16+2
	lda	(r18)
	ldx	#0
	sta	r31
	lda	#10000
	sta	r4
	stz	r4+2
	lda	r31
	sta	r6
	stx	r6+2
	jsl	>___mulint32snes
	clc
	adc	r16
	sta	r20
	txa
	adc	r16+2
	sta	r20+2
	lda	r23
	sta	r16
	stz	r16+2
	lda	r16
	sta	r2
	lda	r16+2
	sta	r2+2
	lda	r20
	sta	r0
	lda	r20+2
	sta	r0+2
	jsl	>___moduint32
	sta	r31
	sta	(r18)
	lda	r16
	sta	r2
	lda	r16+2
	sta	r2+2
	lda	r20
	sta	r0
	lda	r20+2
	sta	r0+2
	jsl	>___divuint32
	sta	r20
	stx	r20+2
	dec	r22
	dec	r23
	dec	r23
	dec	r18
	dec	r18
	lda	r22
	bne	l62
l65:
	lda	#10000
	sta	r2
	stz	r2+2
	lda	r20
	sta	r0
	lda	r20+2
	sta	r0+2
	jsl	>___divuint32
	sta	r0
	stx	r0+2
	lda	r0
	clc
	adc	r27
	clc
	adc	r26
	sta	r26
	lda	#10000
	sta	r2
	stz	r2+2
	lda	r20
	sta	r0
	lda	r20+2
	sta	r0+2
	jsl	>___moduint32
	sta	r31
	sta	r27
	lda	r19
	sec
	sbc	#14
	sta	r19
	lda	r25
	sec
	sbc	#28
	sta	r25
	lda	r24
	sec
	sbc	#28
	sta	r24
	lda	r19
	bne	l61
	lda	r26
	plx
	stx	r27
	plx
	stx	r26
	plx
	stx	r25
	plx
	stx	r24
	plx
	stx	r23
	plx
	stx	r22
	plx
	stx	r21
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
	global	___mulint32snes
	global	___divuint32
	global	___moduint32
	global	_arr
	section	"DONTMERGE_bss.near.arr.0","aurw"
_arr:
	reserve	394
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
