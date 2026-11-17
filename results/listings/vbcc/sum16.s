;vcprmin=10000
	section	"DONTMERGE_text.far.bench_init.0","acrx"
	a16
	x16
	global	_bench_init
_bench_init:
	lda	#247
	sta	r1
	lda	#13854
	sta	_data
	lda	#17583
	sta	2+_data
	lda	#36228
	sta	4+_data
	lda	#63917
	sta	6+_data
	lda	#5754
	sta	8+_data
	lda	#42619
	sta	10+_data
	lda	#30336
	sta	12+_data
	lda	#34457
	sta	14+_data
	lda	#55062
	sta	r0
	sta	16+_data
	ldx	#<18+_data
l28:
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r0
	asl
	asl
	clc
	adc	r0
	clc
	adc	#13849
	sta	r0
	sta	!0,x
	inx
	inx
	lda	r1
	sec
	sbc	#13
	sta	r1
	cmp	#0
	bne	l28
	rtl
; stacksize=0+??
;vcprmin=10000
	section	"DONTMERGE_text.far.bench.0","acrx"
	a16
	x16
	global	_bench
_bench:
	lda	#247
	sta	r1
	lda	2+_data
	clc
	adc	_data
	sta	r0
	clc
	adc	4+_data
	sta	r0
	clc
	adc	6+_data
	sta	r0
	clc
	adc	8+_data
	sta	r0
	clc
	adc	10+_data
	sta	r0
	clc
	adc	12+_data
	sta	r0
	clc
	adc	14+_data
	sta	r0
	clc
	adc	16+_data
	sta	r0
	ldx	#<18+_data
l41:
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r0
	clc
	adc	!0,x
	sta	r0
	inx
	inx
	lda	r1
	sec
	sbc	#19
	sta	r1
	cmp	#0
	bne	l41
	lda	r0
	rtl
; stacksize=0+??
	global	_data
	section	"DONTMERGE_bss.near.data.0","aurw"
_data:
	reserve	512
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
