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
bench_init@i      = $7e2100
bench_init@v      = $7e2102
bench@i           = $7e2100
bench@c           = $7e2102
bench@v           = $7e2104
result            = $7e2105
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
  __ITER__START__7f719597_52eb_4cd0_afb0_d3ac6be9b9d9:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  BNE	__CMP_NO_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0100
  BCC	__CMP_YES_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  BNE	__CMP_NO_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  JMP	__CMP_NO_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  __CMP_YES_9e1659e4_edc6_4d93_804b_a2eb6e7c022e:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_9e1659e4_edc6_4d93_804b_a2eb6e7c022e
  __CMP_NO_9e1659e4_edc6_4d93_804b_a2eb6e7c022e:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_9e1659e4_edc6_4d93_804b_a2eb6e7c022e:
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
  BNE	__ITER__END__7f719597_52eb_4cd0_afb0_d3ac6be9b9d9
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
  __ITER__ITER__7f719597_52eb_4cd0_afb0_d3ac6be9b9d9:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__7f719597_52eb_4cd0_afb0_d3ac6be9b9d9
  __ITER__END__7f719597_52eb_4cd0_afb0_d3ac6be9b9d9:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@c + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__9f811206_3f22_45dd_bb3b_237beb4091bc:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_0306c166_6455_45b9_943b_5056e61e27fb
  BNE	__CMP_NO_0306c166_6455_45b9_943b_5056e61e27fb
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0100
  BCC	__CMP_YES_0306c166_6455_45b9_943b_5056e61e27fb
  BNE	__CMP_NO_0306c166_6455_45b9_943b_5056e61e27fb
  JMP	__CMP_NO_0306c166_6455_45b9_943b_5056e61e27fb
  __CMP_YES_0306c166_6455_45b9_943b_5056e61e27fb:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_0306c166_6455_45b9_943b_5056e61e27fb
  __CMP_NO_0306c166_6455_45b9_943b_5056e61e27fb:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_0306c166_6455_45b9_943b_5056e61e27fb:
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
  BEQ	:+
  JMP	__ITER__END__9f811206_3f22_45dd_bb3b_237beb4091bc
  :
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	buf + 0,X
  STA	bench@v + 0
  __ITER__START__8b85d2c3_3e4c_4d6c_939c_24e4bb07c560:
  SEP	#$10
  LDX	#$01
  SEP	#$20
  LDA	bench@v + 0
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__8b85d2c3_3e4c_4d6c_939c_24e4bb07c560
  :
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	#$01
  AND	bench@v + 0
  STA	__@scratchBase + 1
  LDA	#$00
  AND	__@signExtend
  STA	__@scratchBase + 2
  REP	#$21
  LDA	bench@c + 0
  ADC	__@scratchBase + 1
  STA	bench@c + 0
  SEP	#$20
  LDA	bench@v + 0
  LSR
  STA	bench@v + 0
  JMP	__ITER__START__8b85d2c3_3e4c_4d6c_939c_24e4bb07c560
  __ITER__END__8b85d2c3_3e4c_4d6c_939c_24e4bb07c560:
  __ITER__ITER__9f811206_3f22_45dd_bb3b_237beb4091bc:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__9f811206_3f22_45dd_bb3b_237beb4091bc
  __ITER__END__9f811206_3f22_45dd_bb3b_237beb4091bc:
  REP	#$20
  LDA	bench@c + 0
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
  __ITER__START__2b06153e_3a93_4040_88f1_b9560b266557:
  __ITER__ITER__2b06153e_3a93_4040_88f1_b9560b266557:
  JMP	__ITER__START__2b06153e_3a93_4040_88f1_b9560b266557
  __ITER__END__2b06153e_3a93_4040_88f1_b9560b266557:
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
