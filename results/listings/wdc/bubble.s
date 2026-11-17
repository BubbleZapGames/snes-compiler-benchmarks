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
v_1	set	0
i_1	set	2
	lda	#$1
	sta	<L3+v_1
	sep	#$20
	longa	off
	stz	<L3+i_1
	rep	#$20
	longa	on
	bra	L10004
L10003:
	lda	<L3+v_1
	asl	A
	asl	A
	clc
	adc	<L3+v_1
	clc
	adc	#$3619
	sta	<L3+v_1
	lda	<L3+i_1
	and	#$ff
	tax
	lda	<L3+v_1
	xba
	and	#$00ff
	sep	#$20
	longa	off
	sta	|__arr,X
	inc	<L3+i_1
	rep	#$20
	longa	on
L10004:
	sep	#$20
	longa	off
	lda	<L3+i_1
	cmp	#<$40
	rep	#$20
	longa	on
	bcc	L10003
	pld
	tsc
	clc
	adc	#L2
	tcs
	rts
L2	equ	11
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
j_1	set	1
t_1	set	2
s_1	set	3
	stz	<L7+s_1
	sep	#$20
	longa	off
	stz	<L7+i_1
	rep	#$20
	longa	on
	bra	L10008
L10007:
	sep	#$20
	longa	off
	stz	<L7+j_1
	rep	#$20
	longa	on
	bra	L10012
L10011:
	lda	<L7+j_1
	and	#$ff
	tax
	lda	<L7+j_1
	and	#$ff
	sta	<R1
	sep	#$20
	longa	off
	lda	|__arr+1,X
	ldx	<R1
	cmp	|__arr,X
	rep	#$20
	longa	on
	bcs	L10009
	lda	<L7+j_1
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	|__arr,X
	sta	<L7+t_1
	rep	#$20
	longa	on
	lda	<L7+j_1
	and	#$ff
	sta	<R0
	lda	<L7+j_1
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	|__arr+1,X
	ldx	<R0
	sta	|__arr,X
	rep	#$20
	longa	on
	lda	<L7+j_1
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	<L7+t_1
	sta	|__arr+1,X
	rep	#$20
	longa	on
L10009:
	sep	#$20
	longa	off
	inc	<L7+j_1
	rep	#$20
	longa	on
L10012:
	sep	#$20
	longa	off
	sec
	lda	#$3f
	sbc	<L7+i_1
	sta	<R0
	lda	<L7+j_1
	cmp	<R0
	rep	#$20
	longa	on
	bcc	L10011
	sep	#$20
	longa	off
	inc	<L7+i_1
	rep	#$20
	longa	on
L10008:
	sep	#$20
	longa	off
	lda	<L7+i_1
	cmp	#<$3f
	rep	#$20
	longa	on
	bcs	*+5
	brl	L10007
	sep	#$20
	longa	off
	stz	<L7+i_1
	rep	#$20
	longa	on
	bra	L10017
L10016:
	lda	<L7+s_1
	asl	A
	sta	<R0
	lda	<L7+i_1
	and	#$ff
	tax
	lda	|__arr,X
	and	#$ff
	eor	<R0
	sta	<L7+s_1
	sep	#$20
	longa	off
	inc	<L7+i_1
	rep	#$20
	longa	on
L10017:
	sep	#$20
	longa	off
	lda	<L7+i_1
	cmp	#<$40
	rep	#$20
	longa	on
	bcc	L10016
	lda	<L7+s_1
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	17
L7	equ	13
	ends
	efunc
	udata
	xdef	__arr
__arr
	ds	64
	ends
