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
v_1	set	2
	lda	#$1
	sta	<L3+v_1
	stz	<L3+i_1
L10003:
	lda	<L3+v_1
	asl	A
	asl	A
	clc
	adc	<L3+v_1
	clc
	adc	#$3619
	sta	<L3+v_1
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldx	<L3+i_1
	sta	|__a,X
	lda	<L3+v_1
	sta	|__b,X
	rep	#$20
	longa	on
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$40
	bcc	L10003
	pld
	tsc
	clc
	adc	#L2
	tcs
	rts
L2	equ	12
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
	sbc	#L6
	tcs
	phd
	tcd
i_1	set	0
s_1	set	2
	stz	<L7+s_1
	stz	<L7+i_1
L10006:
	ldx	<L7+i_1
	lda	|__b,X
	and	#$ff
	sta	<R0
	lda	|__a,X
	and	#$ff
	ldx	<R0
	xref	__~mul
	jsr	__~mul
	clc
	adc	<L7+s_1
	sta	<L7+s_1
	inc	<L7+i_1
	lda	<L7+i_1
	cmp	#<$40
	bcc	L10006
	lda	<L7+s_1
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	12
L7	equ	9
	ends
	efunc
	udata
	xdef	__b
__b
	ds	64
	ends
	udata
	xdef	__a
__a
	ds	64
	ends
