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
bench@crc         = $7e2102
bench@b           = $7e2104
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
  __ITER__START__541fb133_6f6a_40f5_81c5_10c36b02e2de:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_0a54e48e_fa02_4e80_a7d8_078990627d90
  BNE	__CMP_NO_0a54e48e_fa02_4e80_a7d8_078990627d90
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0100
  BCC	__CMP_YES_0a54e48e_fa02_4e80_a7d8_078990627d90
  BNE	__CMP_NO_0a54e48e_fa02_4e80_a7d8_078990627d90
  JMP	__CMP_NO_0a54e48e_fa02_4e80_a7d8_078990627d90
  __CMP_YES_0a54e48e_fa02_4e80_a7d8_078990627d90:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_0a54e48e_fa02_4e80_a7d8_078990627d90
  __CMP_NO_0a54e48e_fa02_4e80_a7d8_078990627d90:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_0a54e48e_fa02_4e80_a7d8_078990627d90:
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
  BNE	__ITER__END__541fb133_6f6a_40f5_81c5_10c36b02e2de
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
  __ITER__ITER__541fb133_6f6a_40f5_81c5_10c36b02e2de:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__541fb133_6f6a_40f5_81c5_10c36b02e2de
  __ITER__END__541fb133_6f6a_40f5_81c5_10c36b02e2de:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$ffff
  STA	bench@crc + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__e432e86b_4ca3_40a3_aa44_6f5036c3c9f6:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_e6c86696_c1b6_4f98_baf6_bb85d5949837
  BNE	__CMP_NO_e6c86696_c1b6_4f98_baf6_bb85d5949837
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0100
  BCC	__CMP_YES_e6c86696_c1b6_4f98_baf6_bb85d5949837
  BNE	__CMP_NO_e6c86696_c1b6_4f98_baf6_bb85d5949837
  JMP	__CMP_NO_e6c86696_c1b6_4f98_baf6_bb85d5949837
  __CMP_YES_e6c86696_c1b6_4f98_baf6_bb85d5949837:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_e6c86696_c1b6_4f98_baf6_bb85d5949837
  __CMP_NO_e6c86696_c1b6_4f98_baf6_bb85d5949837:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_e6c86696_c1b6_4f98_baf6_bb85d5949837:
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
  JMP	__ITER__END__e432e86b_4ca3_40a3_aa44_6f5036c3c9f6
  :
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	buf + 0,X
  STA	__@scratchBase + 3
  LDA	__@signExtend
  STA	__@scratchBase + 4
  LDA	#$00
  STA	__@scratchBase + 0
  REP	#$20
  LDA	__@scratchBase + 3
  STA	__@scratchBase + 1
  LDA	#$0000
  STA	__@signExtend
  LDA	bench@crc + 0
  EOR	__@scratchBase + 0
  STA	bench@crc + 0
  SEP	#$20
  LDA	#$00
  STA	bench@b + 0
  __ITER__START__21c33f3b_5843_4a00_8139_db3da6535ba0:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@signExtend
  EOR	#$8000
  CMP	#$8000
  BCC	__CMP_YES_d58bc50d_4e2b_4597_8f81_35378cf94c19
  BNE	__CMP_NO_d58bc50d_4e2b_4597_8f81_35378cf94c19
  SEP	#$20
  LDA	bench@b + 0
  CMP	#$08
  BCC	__CMP_YES_d58bc50d_4e2b_4597_8f81_35378cf94c19
  BNE	__CMP_NO_d58bc50d_4e2b_4597_8f81_35378cf94c19
  JMP	__CMP_NO_d58bc50d_4e2b_4597_8f81_35378cf94c19
  __CMP_YES_d58bc50d_4e2b_4597_8f81_35378cf94c19:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_d58bc50d_4e2b_4597_8f81_35378cf94c19
  __CMP_NO_d58bc50d_4e2b_4597_8f81_35378cf94c19:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_d58bc50d_4e2b_4597_8f81_35378cf94c19:
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
  JMP	__ITER__END__21c33f3b_5843_4a00_8139_db3da6535ba0
  :
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  LDA	#$8000
  AND	bench@crc + 0
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  AND	__@signExtend
  STA	__@scratchBase + 2
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
  BNE	__IFNOT_e8d5671b_4a6b_480b_82b8_095fca8d8f13
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  LDA	bench@crc + 0
  ASL
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	__@signExtend
  ROL
  STA	__@scratchBase + 2
  REP	#$20
  LDA	#$1021
  EOR	__@scratchBase + 0
  STA	bench@crc + 0
  JMP	__IFNOTELSE_e8d5671b_4a6b_480b_82b8_095fca8d8f13
  __IFNOT_e8d5671b_4a6b_480b_82b8_095fca8d8f13:
  REP	#$20
  LDA	bench@crc + 0
  ASL
  STA	bench@crc + 0
  __IFNOTELSE_e8d5671b_4a6b_480b_82b8_095fca8d8f13:
  __ITER__ITER__21c33f3b_5843_4a00_8139_db3da6535ba0:
  CLC
  SEP	#$20
  LDA	bench@b + 0
  ADC	#$01
  STA	bench@b + 0
  JMP	__ITER__START__21c33f3b_5843_4a00_8139_db3da6535ba0
  __ITER__END__21c33f3b_5843_4a00_8139_db3da6535ba0:
  __ITER__ITER__e432e86b_4ca3_40a3_aa44_6f5036c3c9f6:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__e432e86b_4ca3_40a3_aa44_6f5036c3c9f6
  __ITER__END__e432e86b_4ca3_40a3_aa44_6f5036c3c9f6:
  REP	#$20
  LDA	bench@crc + 0
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
  __ITER__START__b06382a8_22f5_4f04_abcd_898204fcb1e0:
  __ITER__ITER__b06382a8_22f5_4f04_abcd_898204fcb1e0:
  JMP	__ITER__START__b06382a8_22f5_4f04_abcd_898204fcb1e0
  __ITER__END__b06382a8_22f5_4f04_abcd_898204fcb1e0:
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
