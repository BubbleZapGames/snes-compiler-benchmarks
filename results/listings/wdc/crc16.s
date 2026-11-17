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
crc_1	set	2
b_1	set	4
	lda	#$ffff
	sta	<L7+crc_1
	stz	<L7+i_1
L10006:
	ldx	<L7+i_1
	lda	|__buf,X
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	lda	<L7+crc_1
	eor	<R0
	sta	<L7+crc_1
	sep	#$20
	longa	off
	stz	<L7+b_1
	rep	#$20
	longa	on
	bra	L10010
L10009:
	lda	<L7+crc_1
	and	#<$8000
	beq	L10011
	lda	<L7+crc_1
	asl	A
	eor	#<$1021
	sta	<L7+crc_1
	bra	L10007
L10011:
	asl	<L7+crc_1
L10007:
	sep	#$20
	longa	off
	inc	<L7+b_1
	rep	#$20
	longa	on
L10010:
	sep	#$20
	longa	off
	lda	<L7+b_1
	cmp	#<$8
	rep	#$20
	longa	on
	bcc	L10009
	inc	<L7+i_1
	lda	<L7+i_1
	cmp	#<$100
	bcc	L10006
	lda	<L7+crc_1
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	13
L7	equ	9
	ends
	efunc
	udata
	xdef	__buf
__buf
	ds	256
	ends
