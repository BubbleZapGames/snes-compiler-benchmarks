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
__a               = $7e2000
__b               = $7e2040
bench_init@i      = $7e2080
bench_init@v      = $7e2082
bench@i           = $7e2080
bench@s           = $7e2082
result            = $7e2084
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
  __ITER__START__74ab71e2_dd59_4975_9516_aad58fa3db78:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_17daa9c1_67b8_4345_802c_546da5fbfe48
  BNE	__CMP_NO_17daa9c1_67b8_4345_802c_546da5fbfe48
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0040
  BCC	__CMP_YES_17daa9c1_67b8_4345_802c_546da5fbfe48
  BNE	__CMP_NO_17daa9c1_67b8_4345_802c_546da5fbfe48
  JMP	__CMP_NO_17daa9c1_67b8_4345_802c_546da5fbfe48
  __CMP_YES_17daa9c1_67b8_4345_802c_546da5fbfe48:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_17daa9c1_67b8_4345_802c_546da5fbfe48
  __CMP_NO_17daa9c1_67b8_4345_802c_546da5fbfe48:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_17daa9c1_67b8_4345_802c_546da5fbfe48:
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
  JMP	__ITER__END__74ab71e2_dd59_4975_9516_aad58fa3db78
  :
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
  STA	__a + 0,X
  REP	#$20
  LDA	bench_init@i + 0
  STA	__@scratchBase + 124
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	bench_init@v + 0
  LDX	__@scratchBase + 124
  STA	__b + 0,X
  __ITER__ITER__74ab71e2_dd59_4975_9516_aad58fa3db78:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__74ab71e2_dd59_4975_9516_aad58fa3db78
  __ITER__END__74ab71e2_dd59_4975_9516_aad58fa3db78:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@s + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__d9ad4495_355e_489c_8e82_bb211f0aef80:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  BNE	__CMP_NO_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0040
  BCC	__CMP_YES_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  BNE	__CMP_NO_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  JMP	__CMP_NO_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  __CMP_YES_a29de9bc_b165_4d7f_ba18_a0cc589ef85f:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_a29de9bc_b165_4d7f_ba18_a0cc589ef85f
  __CMP_NO_a29de9bc_b165_4d7f_ba18_a0cc589ef85f:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_a29de9bc_b165_4d7f_ba18_a0cc589ef85f:
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
  JMP	__ITER__END__d9ad4495_355e_489c_8e82_bb211f0aef80
  :
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	__a + 0,X
  STA	__@specSubX + 0
  LDA	__@signExtend
  STA	__@specSubX + 1
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	#.loWord(__b)
  ADC	bench@i + 0
  STA	__@scratchBase + 2
  SEP	#$20
  LDA	#.bankByte(__b)
  ADC	__@signExtend
  STA	__@scratchBase + 4
  SEP	#$10
  LDY	#$00
  LDA	[__@scratchBase + 2],y
  STA	__@specSubY + 0
  JSL	__mul16by8
  REP	#$20
  LDA	__@callResult + 0
  STA	__@scratchBase + 0
  CLC
  LDA	bench@s + 0
  ADC	__@scratchBase + 0
  STA	bench@s + 0
  __ITER__ITER__d9ad4495_355e_489c_8e82_bb211f0aef80:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__d9ad4495_355e_489c_8e82_bb211f0aef80
  __ITER__END__d9ad4495_355e_489c_8e82_bb211f0aef80:
  REP	#$20
  LDA	bench@s + 0
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
  __ITER__START__97d255fd_daed_40d8_b646_561d42e14557:
  __ITER__ITER__97d255fd_daed_40d8_b646_561d42e14557:
  JMP	__ITER__START__97d255fd_daed_40d8_b646_561d42e14557
  __ITER__END__97d255fd_daed_40d8_b646_561d42e14557:
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
__mul16by8:		; @func
  CLC
  SEP	#$20
  LDA	__@specSubX + 0
  STA	__REG@WRMPYA
  LDA	__@specSubY + 0
  STA	__REG@WRMPYB
  NOP
  NOP
  LDA	f:__REG@RDMPYL
  STA	__@callResult + 0
  LDA	__REG@RDMPYH
  STA	__@callResult + 1
  SEP	#$20
  LDA	__@specSubX + 1
  STA	__REG@WRMPYA
  LDA	__@specSubY + 0
  STA	__REG@WRMPYB
  NOP
  NOP
  LDA	f:__REG@RDMPYL
  CLC
  ADC	__@callResult + 1
  STA	__@callResult + 1
  LDA	__REG@RDMPYH
  STA	__@callResult + 2
  LDA	__REG@RDMPYH
  ADC	#$00
  STA	__@callResult + 2
RTL		; @endfunc
; Division
; Modulation
; @endasm
