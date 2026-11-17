;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#1
	sta	r2
	stz	r0
	ldx	#<_grid
l34:
	lda	r2
	asl
	asl
	clc
	adc	r2
	clc
	adc	#13849
	sta	r2
	lda	r0
	and	#31
	sta	r1
	lda	r0
	lsr
	lsr
	lsr
	lsr
	lsr
	sta	r3
	lda	r1
	beq	l30
	lda	r1
	cmp	#31
	beq	l30
	lda	r3
	beq	l30
	lda	r3
	cmp	#31
	beq	l30
	lda	r2
	xba
	and	#255
	and	#3
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	bne	l31
l30:
	sep	#32
	a8
	lda	#1
	sta	!0,x
	a16
	rep	#32
	bra	l32
l31:
	sep	#32
	a8
	stz	!0,x
	a16
	rep	#32
l32:
	inc	r0
	inx
	lda	r2
	asl
	asl
	clc
	adc	r2
	clc
	adc	#13849
	sta	r2
	lda	r0
	and	#31
	sta	r1
	lda	r0
	lsr
	lsr
	lsr
	lsr
	lsr
	sta	r3
	lda	r1
	beq	l7
	lda	r1
	cmp	#31
	beq	l7
	lda	r3
	beq	l7
	lda	r3
	cmp	#31
	beq	l7
	lda	r2
	xba
	and	#255
	and	#3
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	bne	l8
l7:
	sep	#32
	a8
	lda	#1
	sta	!0,x
	a16
	rep	#32
	bra	l13
l8:
	sep	#32
	a8
	stz	!0,x
	a16
	rep	#32
l13:
	inc	r0
	inx
	lda	r0
	cmp	#1024
	bcc	l34
	lda	#33
	sta	_start
	sep	#32
	a8
	stz	33+_grid
	a16
	rep	#32
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.visit.0","acrx"
	a16
	x16
	global	_visit
_visit:
	sta	r1
	lda	#<_grid
	clc
	adc	r1
	tax
	sep	#32
	a8
	lda	!0,x
	a16
	rep	#32
	bne	l17
	lda	#<_dist
	clc
	adc	r1
	sta	r0
	sep	#32
	a8
	lda	(r0)
	cmp	#255
	a16
	rep	#32
	bne	l17
	sep	#32
	a8
	lda	4,s
	sta	(r0)
	a16
	rep	#32
	lda	_tail
	asl
	clc
	adc	#<_queue
	tax
	lda	r1
	sta	!0,x
	lda	_tail
	ina
	and	#255
	sta	_tail
l17:
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	stz	r12
	lda	#1008
	sta	r6
	lda	#65535
	sta	_dist
	sta	2+_dist
	sta	4+_dist
	sta	6+_dist
	sta	8+_dist
	sta	10+_dist
	sta	12+_dist
	sta	14+_dist
	ldx	#<16+_dist
l97:
	sep	#32
	a8
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	inx
	lda	#255
	sta	!0,x
	a16
	inx
	rep	#32
	lda	r6
	sec
	sbc	#24
	sta	r6
	cmp	#0
	bne	l97
	lda	#<_dist
	clc
	adc	_start
	tax
	sep	#32
	a8
	stz	!0,x
	a16
	rep	#32
	lda	_start
	sta	_queue
	stz	r7
	lda	#1
	sta	_tail
l98:
	lda	r7
	asl
	clc
	adc	#<_queue
	tax
	lda	!0,x
	sta	r4
	lda	r7
	ina
	and	#255
	sta	r7
	lda	#<_dist
	clc
	adc	r4
	tax
	lda	!0,x
	and	#255
	clc
	adc	r12
	sta	r12
	sep	#32
	a8
	lda	!0,x
	ina
	sta	r5
	a16
	rep	#32
	lda	r4
	sec
	sbc	#32
	sta	r6
	lda	#<_grid
	clc
	adc	r6
	tax
	sep	#32
	a8
	lda	!0,x
	a16
	rep	#32
	bne	l39
	lda	#<_dist
	clc
	adc	r6
	sta	r0
	sep	#32
	a8
	lda	(r0)
	cmp	#255
	a16
	rep	#32
	bne	l39
	sep	#32
	a8
	lda	r5
	sta	(r0)
	a16
	rep	#32
	lda	_tail
	asl
	clc
	adc	#<_queue
	tax
	lda	r6
	sta	!0,x
	lda	_tail
	ina
	and	#255
	sta	_tail
l39:
	lda	r4
	dea
	sta	r10
	lda	#<_grid
	clc
	adc	r10
	tax
	sep	#32
	a8
	lda	!0,x
	a16
	rep	#32
	bne	l44
	lda	#<_dist
	clc
	adc	r10
	sta	r2
	sep	#32
	a8
	lda	(r2)
	cmp	#255
	a16
	rep	#32
	bne	l44
	sep	#32
	a8
	lda	r5
	sta	(r2)
	a16
	rep	#32
	lda	_tail
	asl
	clc
	adc	#<_queue
	tax
	lda	r10
	sta	!0,x
	lda	_tail
	ina
	and	#255
	sta	_tail
l44:
	lda	r4
	ina
	sta	r9
	lda	#<_grid
	clc
	adc	r9
	tax
	sep	#32
	a8
	lda	!0,x
	a16
	rep	#32
	bne	l49
	lda	#<_dist
	clc
	adc	r9
	sta	r3
	sep	#32
	a8
	lda	(r3)
	cmp	#255
	a16
	rep	#32
	bne	l49
	sep	#32
	a8
	lda	r5
	sta	(r3)
	a16
	rep	#32
	lda	_tail
	asl
	clc
	adc	#<_queue
	tax
	lda	r9
	sta	!0,x
	lda	_tail
	ina
	and	#255
	sta	_tail
l49:
	lda	r4
	clc
	adc	#32
	sta	r8
	lda	#<_grid
	clc
	adc	r8
	tax
	sep	#32
	a8
	lda	!0,x
	a16
	rep	#32
	bne	l54
	lda	#<_dist
	clc
	adc	r8
	sta	r1
	sep	#32
	a8
	lda	(r1)
	cmp	#255
	a16
	rep	#32
	bne	l54
	sep	#32
	a8
	lda	r5
	sta	(r1)
	a16
	rep	#32
	lda	_tail
	asl
	clc
	adc	#<_queue
	tax
	lda	r8
	sta	!0,x
	lda	_tail
	ina
	and	#255
	sta	_tail
l54:
	lda	r7
	cmp	_tail
	bne	l98
	lda	r12
	rtl
; stacksize=0+??
	global	_grid
	section	"DONTMERGE_bss.near.grid.0","aurw"
_grid:
	reserve	1024
	global	_dist
	section	"DONTMERGE_bss.near.dist.0","aurw"
_dist:
	reserve	1024
	global	_queue
	section	"DONTMERGE_bss.near.queue.0","aurw"
_queue:
	reserve	512
	global	_start
	section	"DONTMERGE_bss.near.start.0","aurw"
_start:
	reserve	2
	global	_tail
	section	"DONTMERGE_bss.near.tail.0","aurw"
_tail:
	reserve	2
	zpage	r0
	zpage	r1
	zpage	r2
	zpage	r3
	zpage	r4
	zpage	r5
	zpage	r6
	zpage	r7
	zpage	r8
	zpage	r9
	zpage	r10
	zpage	r11
	zpage	r12
	zpage	r13
	zpage	r14
	zpage	r15
	zpage	r16
	zpage	r17
	zpage	r18
	zpage	r19
	zpage	r20
	zpage	r21
	zpage	r22
	zpage	r23
	zpage	r24
	zpage	r25
	zpage	r26
	zpage	r27
	zpage	r28
	zpage	r29
	zpage	r30
	zpage	r31
	zpage	btmp0
	zpage	btmp1
	zpage	btmp2
	zpage	btmp3
