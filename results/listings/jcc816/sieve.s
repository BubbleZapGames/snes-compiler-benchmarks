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
flags             = $7e2000
bench@i           = $7e2400
bench@j           = $7e2402
bench@count       = $7e2404
result            = $7e2406
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
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@count + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__ca315d34_0dd6_4654_b47b_683717e171a4:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  BNE	__CMP_NO_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0400
  BCC	__CMP_YES_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  BNE	__CMP_NO_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  JMP	__CMP_NO_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  __CMP_YES_2c008a61_ec45_49e7_b6ee_afc3aaf1455f:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_2c008a61_ec45_49e7_b6ee_afc3aaf1455f
  __CMP_NO_2c008a61_ec45_49e7_b6ee_afc3aaf1455f:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_2c008a61_ec45_49e7_b6ee_afc3aaf1455f:
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
  BNE	__ITER__END__ca315d34_0dd6_4654_b47b_683717e171a4
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  LDA	#$00
  REP	#$10
  LDX	__@scratchBase + 126
  STA	flags + 0,X
  __ITER__ITER__ca315d34_0dd6_4654_b47b_683717e171a4:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__ca315d34_0dd6_4654_b47b_683717e171a4
  __ITER__END__ca315d34_0dd6_4654_b47b_683717e171a4:
  REP	#$20
  LDA	#$0002
  STA	bench@i + 0
  __ITER__START__d4706bfc_6e9d_4f3c_8099_e3499d096cdd:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  BNE	__CMP_NO_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0400
  BCC	__CMP_YES_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  BNE	__CMP_NO_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  JMP	__CMP_NO_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  __CMP_YES_9488188d_e8b0_4b95_9fc7_02bcf1f38a09:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_9488188d_e8b0_4b95_9fc7_02bcf1f38a09
  __CMP_NO_9488188d_e8b0_4b95_9fc7_02bcf1f38a09:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_9488188d_e8b0_4b95_9fc7_02bcf1f38a09:
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
  JMP	__ITER__END__d4706bfc_6e9d_4f3c_8099_e3499d096cdd
  :
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 124
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 124
  LDA	flags + 0,X
  STA	__@scratchBase + 0
  SEP	#$10
  LDX	#$00
  REP	#$10
  LDX	__@scratchBase + 124
  LDA	flags + 0,X
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	:+
  JMP	__IFNOT_62dca6cb_4477_4178_9e95_22efefdf07c8
  :
  REP	#$21
  LDA	bench@count + 0
  ADC	#$0001
  STA	bench@count + 0
  CLC
  LDA	bench@i + 0
  ADC	bench@i + 0
  STA	bench@j + 0
  __ITER__START__ad138f2d_45ab_46dd_ae16_8ff8fa4b6648:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_069756ef_8585_4896_80c6_c27c7cdeedac
  BNE	__CMP_NO_069756ef_8585_4896_80c6_c27c7cdeedac
  REP	#$20
  LDA	bench@j + 0
  CMP	#$0400
  BCC	__CMP_YES_069756ef_8585_4896_80c6_c27c7cdeedac
  BNE	__CMP_NO_069756ef_8585_4896_80c6_c27c7cdeedac
  JMP	__CMP_NO_069756ef_8585_4896_80c6_c27c7cdeedac
  __CMP_YES_069756ef_8585_4896_80c6_c27c7cdeedac:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_069756ef_8585_4896_80c6_c27c7cdeedac
  __CMP_NO_069756ef_8585_4896_80c6_c27c7cdeedac:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_069756ef_8585_4896_80c6_c27c7cdeedac:
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
  BNE	__ITER__END__ad138f2d_45ab_46dd_ae16_8ff8fa4b6648
  REP	#$20
  LDA	bench@j + 0
  STA	__@scratchBase + 122
  SEP	#$20
  LDA	#$01
  REP	#$10
  LDX	__@scratchBase + 122
  STA	flags + 0,X
  __ITER__ITER__ad138f2d_45ab_46dd_ae16_8ff8fa4b6648:
  REP	#$21
  LDA	bench@j + 0
  ADC	bench@i + 0
  STA	bench@j + 0
  JMP	__ITER__START__ad138f2d_45ab_46dd_ae16_8ff8fa4b6648
  __ITER__END__ad138f2d_45ab_46dd_ae16_8ff8fa4b6648:
  __IFNOT_62dca6cb_4477_4178_9e95_22efefdf07c8:
  __ITER__ITER__d4706bfc_6e9d_4f3c_8099_e3499d096cdd:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__d4706bfc_6e9d_4f3c_8099_e3499d096cdd
  __ITER__END__d4706bfc_6e9d_4f3c_8099_e3499d096cdd:
  REP	#$20
  LDA	bench@count + 0
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
  __ITER__START__630bcd19_d526_40ab_843a_c379d46f6494:
  __ITER__ITER__630bcd19_d526_40ab_843a_c379d46f6494:
  JMP	__ITER__START__630bcd19_d526_40ab_843a_c379d46f6494
  __ITER__END__630bcd19_d526_40ab_843a_c379d46f6494:
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
