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
	xdef	__fib
	func
__fib:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
n_0	set	3
a_1	set	0
b_1	set	2
	lda	<L5+n_0
	cmp	#<$2
	bcs	L10001
	lda	<L5+n_0
L8:
	tay
	lda	<L5+1
	sta	<L5+1+2
	pld
	tsc
	clc
	adc	#L5+2
	tcs
	tya
	rts
L10001:
	lda	#$ffff
	clc
	adc	<L5+n_0
	pha
	jsr	__fib
	sta	<L6+a_1
	lda	#$fffe
	clc
	adc	<L5+n_0
	pha
	jsr	__fib
	sta	<L6+b_1
	clc
	adc	<L6+a_1
	bra	L8
L5	equ	4
L6	equ	1
	ends
	efunc
	code
	xdef	__bench
	func
__bench:
	longa	on
	longi	on
	pea	#<$10
	jsr	__fib
	rts
L9	equ	0
L10	equ	1
	ends
	efunc
