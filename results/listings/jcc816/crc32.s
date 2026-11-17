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
data              = $7e2000
bench_init@i      = $7e2400
bench_init@v      = $7e2402
bench@crc         = $7e2400
bench@i           = $7e2404
bench@j           = $7e2406
result            = $7e2407
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
  __ITER__START__545347f5_0f82_4e95_8000_2efa2ba975d5:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  BNE	__CMP_NO_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0400
  BCC	__CMP_YES_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  BNE	__CMP_NO_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  JMP	__CMP_NO_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  __CMP_YES_2da45ca9_5abf_4f72_8274_478a7f2ee3ca:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_2da45ca9_5abf_4f72_8274_478a7f2ee3ca
  __CMP_NO_2da45ca9_5abf_4f72_8274_478a7f2ee3ca:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_2da45ca9_5abf_4f72_8274_478a7f2ee3ca:
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
  BNE	__ITER__END__545347f5_0f82_4e95_8000_2efa2ba975d5
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
  STA	data + 0,X
  __ITER__ITER__545347f5_0f82_4e95_8000_2efa2ba975d5:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__545347f5_0f82_4e95_8000_2efa2ba975d5
  __ITER__END__545347f5_0f82_4e95_8000_2efa2ba975d5:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@crc + 0
  STA	bench@crc + 2
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__5a0e4159_4c41_42de_bc40_f7fb21aae898:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  BNE	__CMP_NO_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0400
  BCC	__CMP_YES_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  BNE	__CMP_NO_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  JMP	__CMP_NO_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  __CMP_YES_942d1949_69e2_4ed5_b1e7_a0a73fef53c5:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_942d1949_69e2_4ed5_b1e7_a0a73fef53c5
  __CMP_NO_942d1949_69e2_4ed5_b1e7_a0a73fef53c5:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_942d1949_69e2_4ed5_b1e7_a0a73fef53c5:
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
  JMP	__ITER__END__5a0e4159_4c41_42de_bc40_f7fb21aae898
  :
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	data + 0,X
  STA	__@scratchBase + 4
  REP	#$20
  LDA	__@signExtend
  STA	__@scratchBase + 5
  SEP	#$20
  LDA	__@signExtend
  STA	__@scratchBase + 7
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  LDA	__@scratchBase + 4
  STA	__@scratchBase + 3
  REP	#$20
  LDA	bench@crc + 0
  EOR	__@scratchBase + 0
  STA	bench@crc + 0
  LDA	bench@crc + 2
  EOR	__@scratchBase + 2
  STA	bench@crc + 2
  SEP	#$20
  LDA	#$08
  STA	bench@j + 0
  __ITER__START__d5024e81_a5dd_48cc_9c0f_e977c65bcff0:
  SEP	#$10
  LDX	#$00
  SEP	#$20
  LDA	bench@j + 0
  CMP	#$00
  BNE	:+
  INX
: TXA
  BEQ	:+
  JMP	__ITER__END__d5024e81_a5dd_48cc_9c0f_e977c65bcff0
  :
  REP	#$20
  LDA	#$0000
  AND	bench@crc + 0
  STA	__@scratchBase + 0
  LDA	#$8000
  AND	bench@crc + 2
  STA	__@scratchBase + 2
  SEP	#$10
  LDX	#$00
  LDA	__@scratchBase + 0
  CMP	#$0000
  BNE	:+
  REP	#$20
  LDA	__@scratchBase + 2
  CMP	#$0000
  BNE	:+
  INX
: TXA
  BNE	__IFNOT_4699b06b_b216_44e6_bb5e_4d4d1b394373
  REP	#$20
  LDA	bench@crc + 0
  ASL
  STA	__@scratchBase + 0
  LDA	bench@crc + 2
  ROL
  STA	__@scratchBase + 2
  LDA	#$1db7
  EOR	__@scratchBase + 0
  STA	bench@crc + 0
  LDA	#$04c1
  EOR	__@scratchBase + 2
  STA	bench@crc + 2
  JMP	__IFNOTELSE_4699b06b_b216_44e6_bb5e_4d4d1b394373
  __IFNOT_4699b06b_b216_44e6_bb5e_4d4d1b394373:
  REP	#$20
  LDA	bench@crc + 0
  ASL
  STA	bench@crc + 0
  LDA	bench@crc + 2
  ROL
  STA	bench@crc + 2
  __IFNOTELSE_4699b06b_b216_44e6_bb5e_4d4d1b394373:
  __ITER__ITER__d5024e81_a5dd_48cc_9c0f_e977c65bcff0:
  SEP	#$21
  LDA	bench@j + 0
  SBC	#$01
  STA	bench@j + 0
  JMP	__ITER__START__d5024e81_a5dd_48cc_9c0f_e977c65bcff0
  __ITER__END__d5024e81_a5dd_48cc_9c0f_e977c65bcff0:
  __ITER__ITER__5a0e4159_4c41_42de_bc40_f7fb21aae898:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__5a0e4159_4c41_42de_bc40_f7fb21aae898
  __ITER__END__5a0e4159_4c41_42de_bc40_f7fb21aae898:
  REP	#$20
  LDA	bench@crc + 0
  EOR	#$ffff
  STA	bench@crc + 0
  LDA	bench@crc + 2
  EOR	#$ffff
  STA	bench@crc + 2
  LDA	#$0000
  STA	__@signExtend
  LDA	bench@crc + 0
  STA	__@scratchBase + 0
  LDA	bench@crc + 2
  STA	__@scratchBase + 2
  LDA	__@scratchBase + 0
  EOR	__@scratchBase + 2
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
  __ITER__START__b1372a92_8a5a_4f97_9573_ef2a89ef281b:
  __ITER__ITER__b1372a92_8a5a_4f97_9573_ef2a89ef281b:
  JMP	__ITER__START__b1372a92_8a5a_4f97_9573_ef2a89ef281b
  __ITER__END__b1372a92_8a5a_4f97_9573_ef2a89ef281b:
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
