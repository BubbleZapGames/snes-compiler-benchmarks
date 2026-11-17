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
arr               = $7e2000
bench_init@v      = $7e2040
bench_init@i      = $7e2042
bench@i           = $7e2040
bench@j           = $7e2041
bench@t           = $7e2042
bench@s           = $7e2043
result            = $7e2045
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
  SEP	#$20
  LDA	#$00
  STA	bench_init@i + 0
  __ITER__START__2c7ad7e8_036a_48a5_9e2c_3b5efc037c93:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@signExtend
  EOR	#$8000
  CMP	#$8000
  BCC	__CMP_YES_465309f2_417c_48f0_a623_4966915be77f
  BNE	__CMP_NO_465309f2_417c_48f0_a623_4966915be77f
  SEP	#$20
  LDA	bench_init@i + 0
  CMP	#$40
  BCC	__CMP_YES_465309f2_417c_48f0_a623_4966915be77f
  BNE	__CMP_NO_465309f2_417c_48f0_a623_4966915be77f
  JMP	__CMP_NO_465309f2_417c_48f0_a623_4966915be77f
  __CMP_YES_465309f2_417c_48f0_a623_4966915be77f:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_465309f2_417c_48f0_a623_4966915be77f
  __CMP_NO_465309f2_417c_48f0_a623_4966915be77f:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_465309f2_417c_48f0_a623_4966915be77f:
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
  BNE	__ITER__END__2c7ad7e8_036a_48a5_9e2c_3b5efc037c93
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
  SEP	#$20
  LDA	bench_init@i + 0
  STA	__@scratchBase + 127
  LDA	bench_init@v + 1
  SEP	#$10
  LDX	__@scratchBase + 127
  STA	arr + 0,X
  __ITER__ITER__2c7ad7e8_036a_48a5_9e2c_3b5efc037c93:
  CLC
  SEP	#$20
  LDA	bench_init@i + 0
  ADC	#$01
  STA	bench_init@i + 0
  JMP	__ITER__START__2c7ad7e8_036a_48a5_9e2c_3b5efc037c93
  __ITER__END__2c7ad7e8_036a_48a5_9e2c_3b5efc037c93:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@s + 0
  SEP	#$20
  LDA	#$00
  STA	bench@i + 0
  __ITER__START__2b59d17b_f875_48d2_859d_5296ac3a3fd7:
  CLC
  SEP	#$20
  LDA	bench@i + 0
  CMP	#$3f
  BCC	__CMP_YES_eeff853e_69f8_485c_9fe6_b123a1821fa2
  BNE	__CMP_NO_eeff853e_69f8_485c_9fe6_b123a1821fa2
  JMP	__CMP_NO_eeff853e_69f8_485c_9fe6_b123a1821fa2
  __CMP_YES_eeff853e_69f8_485c_9fe6_b123a1821fa2:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_eeff853e_69f8_485c_9fe6_b123a1821fa2
  __CMP_NO_eeff853e_69f8_485c_9fe6_b123a1821fa2:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_eeff853e_69f8_485c_9fe6_b123a1821fa2:
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
  JMP	__ITER__END__2b59d17b_f875_48d2_859d_5296ac3a3fd7
  :
  SEP	#$20
  LDA	#$00
  STA	bench@j + 0
  __ITER__START__2daacd42_70b6_4f83_ae47_8dc1fc6290a0:
  SEP	#$21
  LDA	#$3f
  SBC	bench@i + 0
  STA	__@scratchBase + 3
  CLC
  LDA	bench@j + 0
  CMP	__@scratchBase + 3
  BCC	__CMP_YES_fc90fd0a_5b86_4fe6_b046_579c2ce663f4
  BNE	__CMP_NO_fc90fd0a_5b86_4fe6_b046_579c2ce663f4
  JMP	__CMP_NO_fc90fd0a_5b86_4fe6_b046_579c2ce663f4
  __CMP_YES_fc90fd0a_5b86_4fe6_b046_579c2ce663f4:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_fc90fd0a_5b86_4fe6_b046_579c2ce663f4
  __CMP_NO_fc90fd0a_5b86_4fe6_b046_579c2ce663f4:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_fc90fd0a_5b86_4fe6_b046_579c2ce663f4:
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
  JMP	__ITER__END__2daacd42_70b6_4f83_ae47_8dc1fc6290a0
  :
  SEP	#$20
  LDA	bench@j + 0
  STA	__@scratchBase + 127
  SEP	#$10
  LDX	__@scratchBase + 127
  LDA	arr + 0,X
  STA	__@scratchBase + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@j + 0
  ADC	#$01
  STA	__@scratchBase + 125
  LDA	__@signExtend
  ADC	#$00
  STA	__@scratchBase + 126
  REP	#$10
  LDX	__@scratchBase + 125
  LDA	arr + 0,X
  STA	__@scratchBase + 1
  CLC
  SEP	#$10
  LDX	__@scratchBase + 127
  LDA	arr + 0,X
  REP	#$10
  LDX	__@scratchBase + 125
  CMP	arr + 0,X
  BCC	__CMP_NO_55f40576_6295_4342_bcc3_26b36b28ebff
  BNE	__CMP_YES_55f40576_6295_4342_bcc3_26b36b28ebff
  JMP	__CMP_NO_55f40576_6295_4342_bcc3_26b36b28ebff
  __CMP_YES_55f40576_6295_4342_bcc3_26b36b28ebff:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_55f40576_6295_4342_bcc3_26b36b28ebff
  __CMP_NO_55f40576_6295_4342_bcc3_26b36b28ebff:
  SEP	#$20
  LDA	#$00
  __CMP_END_55f40576_6295_4342_bcc3_26b36b28ebff:
  BNE	:+
  JMP	__IFNOT_475540cf_6f07_4e77_9ce5_d87d5d76662f
  :
  SEP	#$20
  LDA	bench@j + 0
  STA	__@scratchBase + 124
  SEP	#$10
  LDX	__@scratchBase + 124
  LDA	arr + 0,X
  STA	bench@t + 0
  LDA	bench@j + 0
  STA	__@scratchBase + 123
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@j + 0
  ADC	#$01
  STA	__@scratchBase + 121
  LDA	__@signExtend
  ADC	#$00
  STA	__@scratchBase + 122
  REP	#$10
  LDX	__@scratchBase + 121
  LDA	arr + 0,X
  SEP	#$10
  LDX	__@scratchBase + 123
  STA	arr + 0,X
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@j + 0
  ADC	#$01
  STA	__@scratchBase + 119
  LDA	__@signExtend
  ADC	#$00
  STA	__@scratchBase + 120
  LDA	bench@t + 0
  REP	#$10
  LDX	__@scratchBase + 119
  STA	arr + 0,X
  __IFNOT_475540cf_6f07_4e77_9ce5_d87d5d76662f:
  __ITER__ITER__2daacd42_70b6_4f83_ae47_8dc1fc6290a0:
  CLC
  SEP	#$20
  LDA	bench@j + 0
  ADC	#$01
  STA	bench@j + 0
  JMP	__ITER__START__2daacd42_70b6_4f83_ae47_8dc1fc6290a0
  __ITER__END__2daacd42_70b6_4f83_ae47_8dc1fc6290a0:
  __ITER__ITER__2b59d17b_f875_48d2_859d_5296ac3a3fd7:
  CLC
  SEP	#$20
  LDA	bench@i + 0
  ADC	#$01
  STA	bench@i + 0
  JMP	__ITER__START__2b59d17b_f875_48d2_859d_5296ac3a3fd7
  __ITER__END__2b59d17b_f875_48d2_859d_5296ac3a3fd7:
  SEP	#$20
  LDA	#$00
  STA	bench@i + 0
  __ITER__START__5623219c_2b09_4593_8ff1_ea628db879ad:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@signExtend
  EOR	#$8000
  CMP	#$8000
  BCC	__CMP_YES_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  BNE	__CMP_NO_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  SEP	#$20
  LDA	bench@i + 0
  CMP	#$40
  BCC	__CMP_YES_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  BNE	__CMP_NO_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  JMP	__CMP_NO_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  __CMP_YES_cddcfffa_6b7d_4b91_b826_6fc6a1d63511:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_cddcfffa_6b7d_4b91_b826_6fc6a1d63511
  __CMP_NO_cddcfffa_6b7d_4b91_b826_6fc6a1d63511:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_cddcfffa_6b7d_4b91_b826_6fc6a1d63511:
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
  JMP	__ITER__END__5623219c_2b09_4593_8ff1_ea628db879ad
  :
  SEP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 118
  SEP	#$10
  LDX	__@scratchBase + 118
  LDA	arr + 0,X
  STA	__@scratchBase + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  LDA	bench@s + 0
  ASL
  STA	__@scratchBase + 1
  SEP	#$20
  LDA	__@signExtend
  ROL
  STA	__@scratchBase + 3
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDX	__@scratchBase + 118
  LDA	arr + 0,X
  EOR	__@scratchBase + 1
  STA	bench@s + 0
  LDA	__@signExtend
  EOR	__@scratchBase + 2
  STA	bench@s + 1
  __ITER__ITER__5623219c_2b09_4593_8ff1_ea628db879ad:
  CLC
  SEP	#$20
  LDA	bench@i + 0
  ADC	#$01
  STA	bench@i + 0
  JMP	__ITER__START__5623219c_2b09_4593_8ff1_ea628db879ad
  __ITER__END__5623219c_2b09_4593_8ff1_ea628db879ad:
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
  __ITER__START__994228a1_e875_4d2f_b9bb_96371372b15e:
  __ITER__ITER__994228a1_e875_4d2f_b9bb_96371372b15e:
  JMP	__ITER__START__994228a1_e875_4d2f_b9bb_96371372b15e
  __ITER__END__994228a1_e875_4d2f_b9bb_96371372b15e:
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
