;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
__bitv:
	db	$1,$2,$4,$8,$10,$20,$40,$80
	ends
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
	xdef	__check_flag
	func
__check_flag:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
idx_0	set	3
	lda	<L5+idx_0
	lsr	A
	lsr	A
	lsr	A
	tax
	lda	|__flags,X
	and	#$ff
	sta	<R1
	lda	<L5+idx_0
	and	#<$7
	tax
	lda	|__bitv,X
	and	#$ff
	and	<R1
	sta	<17
	and	#$ff
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
L5	equ	20
L6	equ	21
	ends
	efunc
	code
	xdef	__clear_flag
	func
__clear_flag:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
idx_0	set	3
	lda	<L8+idx_0
	lsr	A
	lsr	A
	lsr	A
	clc
	adc	#<__flags
	sta	<R1
	lda	<L8+idx_0
	and	#<$7
	tax
	lda	|__bitv,X
	and	#$ff
	sep	#$20
	longa	off
	eor	#<$ffffffff
	and	(<R1)
	sta	(<R1)
	rep	#$20
	longa	on
	lda	<L8+1
	sta	<L8+1+2
	pld
	tsc
	clc
	adc	#L8+2
	tcs
	rts
L8	equ	12
L9	equ	13
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
	sbc	#L11
	tcs
	phd
	tcd
i_1	set	0
prime_1	set	2
k_1	set	4
count_1	set	6
	lda	#$1
	sta	<L12+count_1
	stz	<L12+i_1
L10003:
	sep	#$20
	longa	off
	lda	#$ff
	ldx	<L12+i_1
	sta	|__flags,X
	rep	#$20
	longa	on
	inc	<L12+i_1
	lda	<L12+i_1
	cmp	#<$3e9
	bcc	L10003
	stz	<L12+i_1
L10006:
	pei	<L12+i_1
	jsr	__check_flag
	and	#$ff
	beq	L10004
	lda	<L12+i_1
	clc
	adc	<L12+i_1
	clc
	adc	#$3
	sta	<L12+prime_1
	clc
	lda	<L12+i_1
	bra	L20001
L10010:
	pei	<L12+k_1
	jsr	__clear_flag
	clc
	lda	<L12+k_1
L20001:
	adc	<L12+prime_1
	sta	<L12+k_1
	cmp	#<$1f40
	bcc	L10010
	inc	<L12+count_1
L10004:
	inc	<L12+i_1
	lda	<L12+i_1
	cmp	#<$1f40
	bcc	L10006
	lda	<L12+count_1
	tay
	pld
	tsc
	clc
	adc	#L11
	tcs
	tya
	rts
L11	equ	12
L12	equ	5
	ends
	efunc
	udata
	xdef	__flags
__flags
	ds	1001
	ends
