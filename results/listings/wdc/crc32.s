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
	sta	|__data,X
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
crc_1	set	0
i_1	set	4
j_1	set	6
	stz	<L7+crc_1
	stz	<L7+crc_1+2
	stz	<L7+i_1
L10006:
	ldx	<L7+i_1
	lda	|__data,X
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$18
	xref	__~lasl
	jsr	__~lasl
	sta	<R0
	stx	<R0+2
	lda	<L7+crc_1
	eor	<R0
	sta	<L7+crc_1
	lda	<L7+crc_1+2
	eor	<R0+2
	sta	<L7+crc_1+2
	sep	#$20
	longa	off
	lda	#$8
	sta	<L7+j_1
	rep	#$20
	longa	on
L10009:
	lda	<L7+crc_1+2
	and	#^$80000000
	beq	L10010
	lda	<L7+crc_1
	sta	<R0
	lda	<L7+crc_1+2
	sta	<R0+2
	asl	<R0
	rol	<R0+2
	lda	<R0
	eor	#<$4c11db7
	sta	<L7+crc_1
	lda	<R0+2
	eor	#^$4c11db7
	sta	<L7+crc_1+2
	bra	L10007
L10010:
	asl	<L7+crc_1
	rol	<L7+crc_1+2
L10007:
	sep	#$20
	longa	off
	dec	<L7+j_1
	rep	#$20
	longa	on
	lda	<L7+j_1
	and	#$ff
	bne	L10009
	inc	<L7+i_1
	lda	<L7+i_1
	cmp	#<$400
	bcc	L10006
	lda	<L7+crc_1
	eor	#<$ffffffff
	sta	<L7+crc_1
	lda	<L7+crc_1+2
	eor	#^$ffffffff
	sta	<L7+crc_1+2
	pha
	pei	<L7+crc_1
	lda	#$10
	xref	__~llsr
	jsr	__~llsr
	sta	<R0
	stx	<R0+2
	lda	<L7+crc_1
	eor	<R0
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rts
L6	equ	15
L7	equ	9
	ends
	efunc
	udata
	xdef	__data
__data
	ds	1024
	ends
