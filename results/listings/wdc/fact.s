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
	lda	#$14
	sta	|__n_iter
	lda	#$10
	sta	|__size
	rts
L2	equ	0
L3	equ	1
	ends
	efunc
	code
	xdef	__fact
	func
__fact:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
i_0	set	3
	lda	#$1
	cmp	<L5+i_0
	bcs	L10001
	lda	#$ffff
	clc
	adc	<L5+i_0
	pha
	jsr	__fact
	xref	__~lmul
	jsr	__~lmul
	sta	<R0
	stx	<R0+2
	ldx	<R0+2
	lda	<R0
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
	lda	#$0
	tax
	ina
	bra	L8
L5	equ	8
L6	equ	9
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
	sbc	#L9
	tcs
	phd
	tcd
i_1	set	0
j_1	set	2
res_1	set	4
	stz	<L10+res_1
	stz	<L10+res_1+2
	stz	<L10+j_1
	bra	L10005
L10004:
	lda	<L10+j_1
	asl	A
	asl	A
	clc
	adc	#<__array
	sta	<R1
	lda	#$0
	sta	(<R1)
	ldy	#$2
	sta	(<R1),Y
	inc	<L10+j_1
L10005:
	lda	<L10+j_1
	cmp	|__size
	bcc	L10004
	stz	<L10+i_1
	bra	L10009
L10008:
	stz	<L10+j_1
	bra	L10013
L10012:
	lda	<L10+j_1
	asl	A
	asl	A
	clc
	adc	#<__array
	sta	<R1
	pei	<L10+j_1
	jsr	__fact
	stx	<R0+2
	clc
	adc	(<R1)
	sta	(<R1)
	lda	<R0+2
	ldy	#$2
	adc	(<R1),Y
	sta	(<R1),Y
	inc	<L10+j_1
L10013:
	lda	<L10+j_1
	cmp	|__size
	bcc	L10012
	inc	<L10+i_1
L10009:
	lda	<L10+i_1
	cmp	|__n_iter
	bcc	L10008
	stz	<L10+j_1
	bra	L10017
L10016:
	lda	<L10+j_1
	asl	A
	asl	A
	clc
	adc	#<__array
	sta	<R1
	lda	(<R1)
	clc
	adc	<L10+res_1
	sta	<L10+res_1
	ldy	#$2
	lda	(<R1),Y
	adc	<L10+res_1+2
	sta	<L10+res_1+2
	inc	<L10+j_1
L10017:
	lda	<L10+j_1
	cmp	|__size
	bcc	L10016
	pei	<L10+res_1+2
	pei	<L10+res_1
	lda	#$10
	xref	__~llsr
	jsr	__~llsr
	sta	<R0
	stx	<R0+2
	lda	<L10+res_1
	eor	<R0
	tay
	pld
	tsc
	clc
	adc	#L9
	tcs
	tya
	rts
L9	equ	16
L10	equ	9
	ends
	efunc
	udata
	xdef	__size
__size
	ds	2
	ends
	udata
	xdef	__n_iter
__n_iter
	ds	2
	ends
	udata
	xdef	__array
__array
	ds	64
	ends
