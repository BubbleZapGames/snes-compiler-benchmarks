.p816
.smart	+
.feature at_in_identifiers
.segment "LVECTORS"
__longCOP:JML	RESET
__longBRK:JML	RESET
__longABORT:JML	RESET
__longNMI:JML	RESET
__longRESET:JML	RESET
__longIRQ:JML	RESET
.segment "HEADER"
.res	48, 0;	HEADER_HERE
.segment "VECTORS"
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longCOP)
.word	.loWORD(__longBRK)
.word	.loWORD(__longABORT)
.word	.loWORD(__longNMI)
.word	.loWORD(__longRESET)
.word	.loWORD(__longIRQ)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
.word	.loWORD(__longRESET)
__@callResult     = $000000
__@specSubY       = $000040
__@specSubX       = $000050
__@funcPointer    = $000060
__@signExtend     = $000063
__@scratchBase    = $000065
buf               = $7e2000
bench_init@i      = $7e2200
bench_init@v      = $7e2202
sum_bytes@p       = $7e2200
sum_bytes@n       = $7e2203
sum_bytes@i       = $7e2205
sum_bytes@s       = $7e2207
result            = $7e2209
__REG@WRMPYA      = $004202
__REG@WRMPYB      = $004203
__REG@WRDIVL      = $004204
__REG@WRDIVH      = $004205
__REG@WRDIVB      = $004206
__REG@RDDIVL      = $004214
__REG@RDDIVH      = $004215
__REG@RDMPYL      = $004216
__REG@RDMPYH      = $004217
.segment "ROM000"
RESET:
SEI
CLC
XCE
REP	#$28
LDA	#$1eff
TCS
PHK
PEA	RESET
JML	main
done:	; @func
__done_END:
RTL	; @endfunc
bench_init:	; @func
  REP	#$20
  LDA	#$0001
  STA	bench_init@v + 0
  LDA	#$0000
  STA	bench_init@i + 0
  __ITER__START__517827cb_cbce_4411_b3c8_7e258ebf78ec:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_8135270a_de84_42d7_9331_c848f55ed1a1
  BNE	__CMP_NO_8135270a_de84_42d7_9331_c848f55ed1a1
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0200
  BCC	__CMP_YES_8135270a_de84_42d7_9331_c848f55ed1a1
  BNE	__CMP_NO_8135270a_de84_42d7_9331_c848f55ed1a1
  JMP	__CMP_NO_8135270a_de84_42d7_9331_c848f55ed1a1
  __CMP_YES_8135270a_de84_42d7_9331_c848f55ed1a1:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_8135270a_de84_42d7_9331_c848f55ed1a1
  __CMP_NO_8135270a_de84_42d7_9331_c848f55ed1a1:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_8135270a_de84_42d7_9331_c848f55ed1a1:
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 2
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__ITER__END__517827cb_cbce_4411_b3c8_7e258ebf78ec
  REP	#$20
  LDA	bench_init@v + 0
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench_init@v + 0
  STA	__@scratchBase + 0
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	__@scratchBase + 0
  ADC	#$3619
  STA	bench_init@v + 0
  LDA	bench_init@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  LDA	bench_init@v + 1
  REP	#$10
  LDX	__@scratchBase + 126
  STA	buf + 0,X
  __ITER__ITER__517827cb_cbce_4411_b3c8_7e258ebf78ec:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__517827cb_cbce_4411_b3c8_7e258ebf78ec
  __ITER__END__517827cb_cbce_4411_b3c8_7e258ebf78ec:
__bench_init_END:
RTL	; @endfunc
sum_bytes:	; @func
  REP	#$20
  LDA	#$0000
  STA	sum_bytes@s + 0
  LDA	#$0000
  STA	sum_bytes@i + 0
  __ITER__START__285ada89_f40f_4bfd_9d8d_bc350ba79ff5:
  REP	#$21
  LDA	sum_bytes@i + 0
  CMP	sum_bytes@n + 0
  BCC	__CMP_YES_4ba442c0_caf1_437e_af73_67a35fd8d7b0
  BNE	__CMP_NO_4ba442c0_caf1_437e_af73_67a35fd8d7b0
  JMP	__CMP_NO_4ba442c0_caf1_437e_af73_67a35fd8d7b0
  __CMP_YES_4ba442c0_caf1_437e_af73_67a35fd8d7b0:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_4ba442c0_caf1_437e_af73_67a35fd8d7b0
  __CMP_NO_4ba442c0_caf1_437e_af73_67a35fd8d7b0:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_4ba442c0_caf1_437e_af73_67a35fd8d7b0:
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 2
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__ITER__END__285ada89_f40f_4bfd_9d8d_bc350ba79ff5
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	f:sum_bytes@p + 0
  ADC	sum_bytes@i + 0
  STA	__@scratchBase + 1
  SEP	#$20
  LDA	f:sum_bytes@p + 2
  ADC	__@signExtend
  STA	__@scratchBase + 3
  SEP	#$30
  LDY	#$00
  LDA	[__@scratchBase + 1],y
  STA	__@scratchBase + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	sum_bytes@s + 0
  ADC	[__@scratchBase + 1],y
  STA	sum_bytes@s + 0
  LDA	sum_bytes@s + 1
  ADC	__@signExtend
  STA	sum_bytes@s + 1
  __ITER__ITER__285ada89_f40f_4bfd_9d8d_bc350ba79ff5:
  REP	#$21
  LDA	sum_bytes@i + 0
  ADC	#$0001
  STA	sum_bytes@i + 0
  JMP	__ITER__START__285ada89_f40f_4bfd_9d8d_bc350ba79ff5
  __ITER__END__285ada89_f40f_4bfd_9d8d_bc350ba79ff5:
  REP	#$20
  LDA	sum_bytes@s + 0
  STA	__@callResult + 0
  JMP	__sum_bytes_END
__sum_bytes_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#.loWord(buf)
  STA	f:sum_bytes@p + 0
  SEP	#$20
  LDA	#.bankByte(buf)
  STA	f:sum_bytes@p + 2
  REP	#$20
  LDA	#$0200
  STA	sum_bytes@n + 0
  JSL	sum_bytes
  REP	#$20
  LDA	__@callResult + 0
  STA	__@callResult + 0
  JMP	__bench_END
__bench_END:
RTL	; @endfunc
main:	; @func
  REP	#$20
  LDA	#$4200
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  STA	$004200
  JSL	bench_init
  JSL	bench
  REP	#$20
  LDA	__@callResult + 0
  STA	result + 0
  JSL	done
  __ITER__START__2908caa8_2cd6_4478_ada8_fce14ff9dbcc:
  __ITER__ITER__2908caa8_2cd6_4478_ada8_fce14ff9dbcc:
  JMP	__ITER__START__2908caa8_2cd6_4478_ada8_fce14ff9dbcc
  __ITER__END__2908caa8_2cd6_4478_ada8_fce14ff9dbcc:
  REP	#$20
  LDA	#$0000
  STA	__@callResult + 0
  SEP	#$20
  STA	__@callResult + 2
  JMP	__main_END
__main_END:
RTL	; @endfunc
; @asm
; Doubles
; @endasm
; @asm
; Thanks to Sir Walrus for long div/mod code
; Multiplication
; Division
; Modulation
; @endasm
