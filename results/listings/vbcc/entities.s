;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	stz	r4
	stz	r6
	stz	r5
	lda	#<8+_ents
	sta	r0
	lda	#<6+_ents
	sta	r1
	ldx	#<4+_ents
	lda	#<2+_ents
	sta	r3
	lda	#<_ents
	sta	r2
l36:
	lda	r5
	sec
	sbc	r4
	sta	(r2)
	lda	r6
	clc
	adc	r4
	sta	(r3)
	lda	r4
	and	#3
	ina
	sta	!0,x
	lda	r4
	and	#1
	ina
	ina
	sta	(r1)
	lda	r4
	and	#3
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	bne	l33
	stz	r7
	bra	l34
l33:
	lda	#1
	sta	r7
l34:
	sep	#32
	a8
	lda	r7
	sta	(r0)
	a16
	rep	#32
	inc	r4
	lda	r5
	clc
	adc	#8
	sta	r5
	lda	r2
	clc
	adc	#9
	sta	r2
	lda	r3
	clc
	adc	#9
	sta	r3
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	lda	r6
	clc
	adc	#4
	sta	r6
	lda	r5
	sec
	sbc	r4
	sta	(r2)
	lda	r6
	clc
	adc	r4
	sta	(r3)
	lda	r4
	and	#3
	ina
	sta	!0,x
	lda	r4
	and	#1
	ina
	ina
	sta	(r1)
	lda	r4
	and	#3
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	bne	l7
	stz	r7
	bra	l8
l7:
	lda	#1
	sta	r7
l8:
	sep	#32
	a8
	lda	r7
	sta	(r0)
	a16
	rep	#32
	inc	r4
	lda	r5
	clc
	adc	#8
	sta	r5
	lda	r2
	clc
	adc	#9
	sta	r2
	lda	r3
	clc
	adc	#9
	sta	r3
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	lda	r6
	clc
	adc	#4
	sta	r6
	lda	r4
	cmp	#32
	bcc	l36
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r5
l104:
	lda	#30
	sta	r4
	sep	#32
	a8
	lda	8+_ents
	a16
	rep	#32
	beq	l62
	lda	4+_ents
	clc
	adc	_ents
	sta	_ents
	cmp	#240
	bcc	l61
	beq	l61
	lda	#0
	sec
	sbc	4+_ents
	sta	4+_ents
l61:
	lda	6+_ents
	clc
	adc	2+_ents
	sta	2+_ents
	cmp	#200
	bcc	l62
	beq	l62
	lda	#0
	sec
	sbc	6+_ents
	sta	6+_ents
l62:
	sep	#32
	a8
	lda	17+_ents
	a16
	rep	#32
	beq	l64
	lda	13+_ents
	clc
	adc	9+_ents
	sta	9+_ents
	cmp	#240
	bcc	l63
	beq	l63
	lda	#0
	sec
	sbc	13+_ents
	sta	13+_ents
l63:
	lda	15+_ents
	clc
	adc	11+_ents
	sta	11+_ents
	cmp	#200
	bcc	l64
	beq	l64
	lda	#0
	sec
	sbc	15+_ents
	sta	15+_ents
l64:
	lda	#<26+_ents
	sta	r3
	lda	#<18+_ents
	sta	r2
	ldx	#<22+_ents
	lda	#<20+_ents
	sta	r1
	lda	#<24+_ents
	sta	r0
l105:
	sep	#32
	a8
	lda	(r3)
	a16
	rep	#32
	beq	l66
	lda	!0,x
	clc
	adc	(r2)
	sta	(r2)
	cmp	#240
	bcc	l65
	beq	l65
	lda	#0
	sec
	sbc	!0,x
	sta	!0,x
l65:
	lda	(r0)
	clc
	adc	(r1)
	sta	(r1)
	cmp	#200
	bcc	l66
	beq	l66
	lda	#0
	sec
	sbc	(r0)
	sta	(r0)
l66:
	lda	r3
	clc
	adc	#9
	sta	r3
	lda	r2
	clc
	adc	#9
	sta	r2
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	sep	#32
	a8
	lda	(r3)
	a16
	rep	#32
	beq	l68
	lda	!0,x
	clc
	adc	(r2)
	sta	(r2)
	cmp	#240
	bcc	l67
	beq	l67
	lda	#0
	sec
	sbc	!0,x
	sta	!0,x
l67:
	lda	(r0)
	clc
	adc	(r1)
	sta	(r1)
	cmp	#200
	bcc	l68
	beq	l68
	lda	#0
	sec
	sbc	(r0)
	sta	(r0)
l68:
	lda	r3
	clc
	adc	#9
	sta	r3
	lda	r2
	clc
	adc	#9
	sta	r2
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	sep	#32
	a8
	lda	(r3)
	a16
	rep	#32
	beq	l25
	lda	!0,x
	clc
	adc	(r2)
	sta	(r2)
	cmp	#240
	bcc	l23
	beq	l23
	lda	#0
	sec
	sbc	!0,x
	sta	!0,x
l23:
	lda	(r0)
	clc
	adc	(r1)
	sta	(r1)
	cmp	#200
	bcc	l25
	beq	l25
	lda	#0
	sec
	sbc	(r0)
	sta	(r0)
l25:
	lda	r3
	clc
	adc	#9
	sta	r3
	lda	r2
	clc
	adc	#9
	sta	r2
	txa
	clc
	adc	#9
	tax
	lda	r1
	clc
	adc	#9
	sta	r1
	lda	r0
	clc
	adc	#9
	sta	r0
	lda	r4
	sec
	sbc	#3
	sta	r4
	cmp	#0
	bne	l105
	inc	r5
	lda	r5
	cmp	#16
	bcc	l104
	lda	2+_ents
	clc
	adc	_ents
	sta	r31
	lda	11+_ents
	clc
	adc	9+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	20+_ents
	clc
	adc	18+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	29+_ents
	clc
	adc	27+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	38+_ents
	clc
	adc	36+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	47+_ents
	clc
	adc	45+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	56+_ents
	clc
	adc	54+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	65+_ents
	clc
	adc	63+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	74+_ents
	clc
	adc	72+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	83+_ents
	clc
	adc	81+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	92+_ents
	clc
	adc	90+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	101+_ents
	clc
	adc	99+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	110+_ents
	clc
	adc	108+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	119+_ents
	clc
	adc	117+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	128+_ents
	clc
	adc	126+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	137+_ents
	clc
	adc	135+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	146+_ents
	clc
	adc	144+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	155+_ents
	clc
	adc	153+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	164+_ents
	clc
	adc	162+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	173+_ents
	clc
	adc	171+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	182+_ents
	clc
	adc	180+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	191+_ents
	clc
	adc	189+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	200+_ents
	clc
	adc	198+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	209+_ents
	clc
	adc	207+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	218+_ents
	clc
	adc	216+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	227+_ents
	clc
	adc	225+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	236+_ents
	clc
	adc	234+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	245+_ents
	clc
	adc	243+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	254+_ents
	clc
	adc	252+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	263+_ents
	clc
	adc	261+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	272+_ents
	clc
	adc	270+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	sta	r31
	lda	281+_ents
	clc
	adc	279+_ents
	sta	r0
	lda	r31
	clc
	adc	r0
	rtl
; stacksize=0+??
	global	_ents
	section	"DONTMERGE_bss.near.ents.0","aurw"
_ents:
	reserve	288
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
