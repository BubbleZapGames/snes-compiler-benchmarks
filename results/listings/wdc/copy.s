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
	sta	|__src,X
	rep	#$20
	longa	on
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$400
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
	stz	<L7+i_1
L10006:
	sep	#$20
	longa	off
	ldx	<L7+i_1
	lda	|__src,X
	sta	|__dst,X
	rep	#$20
	longa	on
	inc	<L7+i_1
	lda	<L7+i_1
	cmp	#<$400
	bcc	L10006
	lda	|__dst+1023
	and	#$ff
	sta	<R0
	lda	|__dst+511
	and	#$ff
	sta	<R1
	lda	|__dst
	and	#$ff
	clc
	adc	<R1
	clc
	adc	<R0
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	18
L7	equ	17
	ends
	efunc
	udata
	xdef	__dst
__dst
	ds	1024
	ends
	udata
	xdef	__src
__src
	ds	1024
	ends
