;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.check_flag.0","acrx"
	a16
	x16
	global	_check_flag
_check_flag:
	sta	r0
	lsr
	lsr
	lsr
	clc
	adc	#<_flags
	sta	r31
	lda	r0
	and	#7
	tax
	clc
	adc	#<l1
	tax
	lda	(r31)
	and	!0,x
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.clear_flag.0","acrx"
	a16
	x16
	global	_clear_flag
_clear_flag:
	sta	r0
	lsr
	lsr
	lsr
	clc
	adc	#<_flags
	tax
	lda	r0
	and	#7
	clc
	adc	#<l1
	sta	r31
	lda	(r31)
	eor	#-1
	sep	#32
	a8
	and	!0,x
	sta	!0,x
	a16
	rep	#32
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#1
	sta	r4
	lda	#984
	sta	r2
	lda	#65535
	sta	_flags
	sta	2+_flags
	sta	4+_flags
	sta	6+_flags
	sta	8+_flags
	sta	10+_flags
	sta	12+_flags
	sta	14+_flags
	sep	#32
	a8
	lda	#255
	sta	16+_flags
	a16
	ldx	#<17+_flags
	rep	#32
l90:
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
	lda	r2
	sec
	sbc	#24
	sta	r2
	cmp	#0
	bne	l90
	stz	r0
l91:
	lda	r0
	lsr
	lsr
	lsr
	clc
	adc	#<_flags
	sta	r31
	lda	r0
	and	#7
	tax
	clc
	adc	#<l1
	tax
	lda	(r31)
	and	!0,x
	sep	#32
	a8
	cmp	#0
	a16
	rep	#32
	beq	l19
	lda	r0
	clc
	adc	r0
	clc
	adc	#3
	sta	r2
	clc
	adc	r0
	sta	r1
	cmp	#8000
	bcs	l95
l92:
	lda	r1
	lsr
	lsr
	lsr
	clc
	adc	#<_flags
	tax
	lda	r1
	and	#7
	clc
	adc	#<l1
	sta	r31
	lda	(r31)
	eor	#-1
	sep	#32
	a8
	and	!0,x
	sta	!0,x
	a16
	rep	#32
	lda	r1
	clc
	adc	r2
	sta	r1
	cmp	#8000
	bcc	l92
l95:
	inc	r4
l19:
	inc	r0
	lda	r0
	cmp	#8000
	bcc	l91
	lda	r4
	rtl
; stacksize=0+??
	global	_flags
	section	"DONTMERGE_bss.near.flags.0","aurw"
_flags:
	reserve	1001
	section	"DONTMERGE_rodata.near.bitv.1","adr"
l1:
	db	1
	db	2
	db	4
	db	8
	db	16
	db	32
	db	64
	db	128
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
