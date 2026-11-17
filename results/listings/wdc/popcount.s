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
	sta	|__buf,X
	rep	#$20
	longa	on
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$100
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
c_1	set	2
v_1	set	4
	stz	<L7+c_1
	stz	<L7+i_1
L10006:
	sep	#$20
	longa	off
	ldx	<L7+i_1
	lda	|__buf,X
	sta	<L7+v_1
	rep	#$20
	longa	on
	bra	L10007
L20001:
	lda	<L7+v_1
	and	#<$1
	clc
	adc	<L7+c_1
	sta	<L7+c_1
	sep	#$20
	longa	off
	lsr	<L7+v_1
	rep	#$20
	longa	on
L10007:
	lda	<L7+v_1
	and	#$ff
	bne	L20001
	inc	<L7+i_1
	lda	<L7+i_1
	cmp	#<$100
	bcc	L10006
	lda	<L7+c_1
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	9
L7	equ	5
	ends
	efunc
	udata
	xdef	__buf
__buf
	ds	256
	ends
