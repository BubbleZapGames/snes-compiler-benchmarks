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
	rts
L2	equ	0
L3	equ	1
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
	sbc	#L5
	tcs
	phd
	tcd
i_1	set	0
j_1	set	2
d_1	set	4
carry_1	set	6
s_1	set	8
sum_1	set	10
	stz	<L6+carry_1
	stz	<L6+s_1
	stz	<L6+i_1
L10003:
	lda	<L6+i_1
	asl	A
	tax
	lda	#$7d0
	sta	|__arr,X
	inc	<L6+i_1
	lda	#$c4
	cmp	<L6+i_1
	bcs	L10003
	sta	<L6+i_1
L10006:
	stz	<L6+sum_1
	stz	<L6+sum_1+2
	lda	<L6+i_1
	sta	<L6+j_1
	bra	L10010
L10009:
	lda	<L6+j_1
	asl	A
	clc
	adc	#$ffff
	sta	<L6+d_1
	lda	<L6+j_1
	asl	A
	tax
	lda	|__arr,X
	sta	<R1
	stz	<R1+2
	pea	#^$2710
	pea	#<$2710
	pei	<R1+2
	pei	<R1
	xref	__~lmul
	jsr	__~lmul
	sta	<R1
	stx	<R1+2
	lda	<L6+j_1
	sta	<R2
	stz	<R2+2
	pei	<L6+sum_1+2
	pei	<L6+sum_1
	pei	<R2+2
	pei	<R2
	xref	__~lmul
	jsr	__~lmul
	stx	<R2+2
	clc
	adc	<R1
	sta	<L6+sum_1
	lda	<R2+2
	adc	<R1+2
	sta	<L6+sum_1+2
	lda	<L6+j_1
	asl	A
	sta	<R0
	lda	<L6+d_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L6+sum_1+2
	pei	<L6+sum_1
	xref	__~lumd
	jsr	__~lumd
	stx	<R1+2
	ldx	<R0
	sta	|__arr,X
	lda	<L6+d_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L6+sum_1+2
	pei	<L6+sum_1
	xref	__~ludv
	jsr	__~ludv
	sta	<L6+sum_1
	stx	<L6+sum_1+2
	dec	<L6+j_1
L10010:
	lda	#$0
	cmp	<L6+j_1
	bcc	L10009
	pea	#^$2710
	pea	#<$2710
	pei	<L6+sum_1+2
	pei	<L6+sum_1
	xref	__~ludv
	jsr	__~ludv
	stx	<R0+2
	clc
	adc	<L6+s_1
	clc
	adc	<L6+carry_1
	sta	<L6+s_1
	pea	#^$2710
	pea	#<$2710
	pei	<L6+sum_1+2
	pei	<L6+sum_1
	xref	__~lumd
	jsr	__~lumd
	stx	<R0+2
	sta	<L6+carry_1
	lda	#$fff2
	clc
	adc	<L6+i_1
	sta	<L6+i_1
	lda	#$0
	cmp	<L6+i_1
	bcs	*+5
	brl	L10006
	lda	<L6+s_1
	tay
	pld
	tsc
	clc
	adc	#L5
	tcs
	tya
	rts
L5	equ	26
L6	equ	13
	ends
	efunc
	udata
	xdef	__arr
__arr
	ds	394
	ends
