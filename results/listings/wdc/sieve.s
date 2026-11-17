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
count_1	set	4
	stz	<L6+count_1
	stz	<L6+i_1
L10003:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L6+i_1
	sta	|__flags,X
	rep	#$20
	longa	on
	inc	<L6+i_1
	lda	<L6+i_1
	cmp	#<$400
	bcc	L10003
	lda	#$2
	sta	<L6+i_1
L10006:
	ldx	<L6+i_1
	lda	|__flags,X
	and	#$ff
	bne	L10004
	inc	<L6+count_1
	clc
	lda	<L6+i_1
	bra	L20001
L10010:
	sep	#$20
	longa	off
	lda	#$1
	ldx	<L6+j_1
	sta	|__flags,X
	rep	#$20
	longa	on
	clc
	lda	<L6+j_1
L20001:
	adc	<L6+i_1
	sta	<L6+j_1
	cmp	#<$400
	bcc	L10010
L10004:
	inc	<L6+i_1
	lda	<L6+i_1
	cmp	#<$400
	bcc	L10006
	lda	<L6+count_1
	tay
	pld
	tsc
	clc
	adc	#L5
	tcs
	tya
	rts
L5	equ	6
L6	equ	1
	ends
	efunc
	udata
	xdef	__flags
__flags
	ds	1024
	ends
