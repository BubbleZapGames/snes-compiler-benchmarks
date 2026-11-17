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
x_1	set	2
y_1	set	4
v_1	set	6
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
	lda	<L3+i_1
	and	#<$1f
	sta	<L3+x_1
	lda	<L3+i_1
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	<L3+y_1
	lda	<L3+x_1
	beq	L4
	lda	<L3+x_1
	cmp	#<$1f
	beq	L4
	lda	<L3+y_1
	beq	L4
	lda	<L3+y_1
	cmp	#<$1f
	beq	L4
	lda	<L3+v_1
	xba
	and	#$00ff
	and	#<$3
	bne	L10004
L4:
	sep	#$20
	longa	off
	lda	#$1
	ldx	<L3+i_1
	sta	|__grid,X
	rep	#$20
	longa	on
	bra	L10001
L10004:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L3+i_1
	sta	|__grid,X
	rep	#$20
	longa	on
L10001:
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$400
	bcc	L10003
	lda	#$21
	sta	|__start
	sep	#$20
	longa	off
	lda	#$0
	ldx	|__start
	sta	|__grid,X
	rep	#$20
	longa	on
	pld
	tsc
	clc
	adc	#L2
	tcs
	rts
L2	equ	16
L3	equ	9
	ends
	efunc
	code
	xdef	__visit
	func
__visit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L12
	tcs
	phd
	tcd
n_0	set	3
d_0	set	5
	ldx	<L12+n_0
	lda	|__grid,X
	and	#$ff
	bne	L16
	sep	#$20
	longa	off
	lda	|__dist,X
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L16
	sep	#$20
	longa	off
	lda	<L12+d_0
	sta	|__dist,X
	rep	#$20
	longa	on
	lda	|__tail
	asl	A
	tax
	lda	<L12+n_0
	sta	|__queue,X
	lda	|__tail
	ina
	and	#<$ff
	sta	|__tail
L16:
	lda	<L12+1
	sta	<L12+1+4
	pld
	tsc
	clc
	adc	#L12+4
	tcs
	rts
L12	equ	4
L13	equ	5
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
	sbc	#L17
	tcs
	phd
	tcd
i_1	set	0
c_1	set	2
head_1	set	4
s_1	set	6
d_1	set	8
	stz	<L18+s_1
	stz	<L18+i_1
L10009:
	sep	#$20
	longa	off
	lda	#$ff
	ldx	<L18+i_1
	sta	|__dist,X
	rep	#$20
	longa	on
	inc	<L18+i_1
	lda	<L18+i_1
	cmp	#<$400
	bcc	L10009
	sep	#$20
	longa	off
	lda	#$0
	ldx	|__start
	sta	|__dist,X
	rep	#$20
	longa	on
	lda	|__start
	sta	|__queue
	stz	<L18+head_1
	lda	#$1
	sta	|__tail
	bra	L10010
L20001:
	lda	<L18+head_1
	asl	A
	tax
	lda	|__queue,X
	sta	<L18+c_1
	lda	<L18+head_1
	ina
	and	#<$ff
	sta	<L18+head_1
	ldx	<L18+c_1
	lda	|__dist,X
	and	#$ff
	clc
	adc	<L18+s_1
	sta	<L18+s_1
	sep	#$20
	longa	off
	lda	|__dist,X
	ina
	sta	<L18+d_1
	rep	#$20
	longa	on
	pei	<L18+d_1
	lda	#$ffe0
	clc
	adc	<L18+c_1
	pha
	jsr	__visit
	pei	<L18+d_1
	lda	#$ffff
	clc
	adc	<L18+c_1
	pha
	jsr	__visit
	pei	<L18+d_1
	lda	<L18+c_1
	ina
	pha
	jsr	__visit
	pei	<L18+d_1
	lda	#$20
	clc
	adc	<L18+c_1
	pha
	jsr	__visit
L10010:
	lda	<L18+head_1
	cmp	|__tail
	bne	L20001
	lda	<L18+s_1
	tay
	pld
	tsc
	clc
	adc	#L17
	tcs
	tya
	rts
L17	equ	13
L18	equ	5
	ends
	efunc
	udata
	xdef	__tail
__tail
	ds	2
	ends
	udata
	xdef	__start
__start
	ds	2
	ends
	udata
	xdef	__queue
__queue
	ds	512
	ends
	udata
	xdef	__dist
__dist
	ds	1024
	ends
	udata
	xdef	__grid
__grid
	ds	1024
	ends
