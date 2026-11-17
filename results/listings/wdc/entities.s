;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	__bench_init
	func
__bench_init:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
i_1	set	0
	stz	<L3+i_1
L10003:
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	adc	<L3+i_1
	tax
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	sec
	sbc	<L3+i_1
	sta	|__ents,X
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	adc	<L3+i_1
	tax
	lda	<L3+i_1
	asl	A
	asl	A
	clc
	adc	<L3+i_1
	sta	|__ents+2,X
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	adc	<L3+i_1
	tax
	lda	<L3+i_1
	and	#<$3
	ina
	sta	|__ents+4,X
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	adc	<L3+i_1
	tax
	lda	<L3+i_1
	and	#<$1
	sta	<R1
	clc
	adc	#$2
	sta	|__ents+6,X
	lda	<L3+i_1
	asl	A
	asl	A
	asl	A
	adc	<L3+i_1
	sta	<R0
	stz	<R1
	lda	<L3+i_1
	and	#<$3
	beq	L4
	inc	<R1
L4:
	sep	#$20
	longa	off
	lda	<R1
	ldx	<R0
	sta	|__ents+8,X
	rep	#$20
	longa	on
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$20
	bcc	L10003
	pld
	tsc
	clc
	adc	#L2
	tcs
	rts
L2	equ	10
L3	equ	9
	ends
	efunc
	code
	xdef	__bench
	func
__bench:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
f_1	set	0
i_1	set	2
s_1	set	4
	stz	<L9+s_1
	stz	<L9+f_1
L10006:
	stz	<L9+i_1
L10009:
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	lda	|__ents+8,X
	and	#$ff
	bne	*+5
	brl	L10007
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	clc
	adc	#<__ents
	sta	<R2
	lda	(<R2)
	clc
	adc	|__ents+4,X
	sta	(<R2)
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	lda	#$f0
	cmp	|__ents,X
	bcs	L10011
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	sta	<R0
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	sec
	lda	#$0
	sbc	|__ents+4,X
	ldx	<R0
	sta	|__ents+4,X
L10011:
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	clc
	adc	#$2
	clc
	adc	#<__ents
	sta	<R1
	lda	(<R1)
	clc
	adc	|__ents+6,X
	sta	(<R1)
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	lda	#$c8
	cmp	|__ents+2,X
	bcs	L10007
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	sta	<R0
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	sec
	lda	#$0
	sbc	|__ents+6,X
	ldx	<R0
	sta	|__ents+6,X
L10007:
	inc	<L9+i_1
	lda	<L9+i_1
	cmp	#<$20
	bcs	*+5
	brl	L10009
	inc	<L9+f_1
	lda	<L9+f_1
	cmp	#<$10
	bcs	*+5
	brl	L10006
	stz	<L9+i_1
L10015:
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	sta	<R0
	lda	<L9+i_1
	asl	A
	asl	A
	asl	A
	adc	<L9+i_1
	tax
	clc
	lda	|__ents+2,X
	ldx	<R0
	adc	|__ents,X
	clc
	adc	<L9+s_1
	sta	<L9+s_1
	inc	<L9+i_1
	lda	<L9+i_1
	cmp	#<$20
	bcc	L10015
	lda	<L9+s_1
	tay
	pld
	tsc
	clc
	adc	#L8
	tcs
	tya
	rts
L8	equ	18
L9	equ	13
	ends
	efunc
	udata
	xdef	__ents
__ents
	ds	288
	ends
