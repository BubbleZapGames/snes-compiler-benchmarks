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
ents              = $7e2000
bench_init@i      = $7e2120
bench@f           = $7e2120
bench@i           = $7e2122
bench@s           = $7e2124
result            = $7e2126
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
  LDA	#$0000
  STA	bench_init@i + 0
  __ITER__START__fe2fdbba_fc7d_462d_8908_6d0c153f17cc:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_9e94a333_019a_4a5c_8a36_1681c591979c
  BNE	__CMP_NO_9e94a333_019a_4a5c_8a36_1681c591979c
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0020
  BCC	__CMP_YES_9e94a333_019a_4a5c_8a36_1681c591979c
  BNE	__CMP_NO_9e94a333_019a_4a5c_8a36_1681c591979c
  JMP	__CMP_NO_9e94a333_019a_4a5c_8a36_1681c591979c
  __CMP_YES_9e94a333_019a_4a5c_8a36_1681c591979c:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_9e94a333_019a_4a5c_8a36_1681c591979c
  __CMP_NO_9e94a333_019a_4a5c_8a36_1681c591979c:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_9e94a333_019a_4a5c_8a36_1681c591979c:
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
  JMP	__ITER__END__fe2fdbba_fc7d_462d_8908_6d0c153f17cc
  :
  REP	#$20
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  STA	__@scratchBase + 126
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  SEC
  LDA	__@scratchBase + 0
  SBC	bench_init@i + 0
  REP	#$10
  LDX	__@scratchBase + 126
  STA	ents + 0,X
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  STA	__@scratchBase + 124
  LDA	bench_init@i + 0
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  LDX	__@scratchBase + 124
  STA	ents + 2,X
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  STA	__@scratchBase + 122
  LDA	#$0000
  STA	__@signExtend
  LDA	#$0003
  AND	bench_init@i + 0
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	__@scratchBase + 1
  BPL	:+
  LDA	#$FF
  BRA	:++
  :
  LDA	#$00
  :
  STA	__@signExtend
  STA	__@signExtend + 1
  REP	#$21
  LDA	__@scratchBase + 0
  ADC	#$0001
  REP	#$10
  LDX	__@scratchBase + 122
  STA	ents + 4,X
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  STA	__@scratchBase + 120
  LDA	#$0000
  STA	__@signExtend
  LDA	#$0001
  AND	bench_init@i + 0
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	__@scratchBase + 1
  BPL	:+
  LDA	#$FF
  BRA	:++
  :
  LDA	#$00
  :
  STA	__@signExtend
  STA	__@signExtend + 1
  REP	#$21
  LDA	__@scratchBase + 0
  ADC	#$0002
  REP	#$10
  LDX	__@scratchBase + 120
  STA	ents + 6,X
  LDA	bench_init@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench_init@i + 0
  STA	__@scratchBase + 118
  LDA	#$0000
  STA	__@signExtend
  LDA	#$0003
  AND	bench_init@i + 0
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  AND	__@signExtend
  STA	__@scratchBase + 2
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	__@scratchBase + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 2
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 118
  STA	ents + 8,X
  __ITER__ITER__fe2fdbba_fc7d_462d_8908_6d0c153f17cc:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__fe2fdbba_fc7d_462d_8908_6d0c153f17cc
  __ITER__END__fe2fdbba_fc7d_462d_8908_6d0c153f17cc:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@s + 0
  LDA	#$0000
  STA	bench@f + 0
  __ITER__START__506ebe17_6c5e_4d33_8b80_c7a2137ec4f6:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  BNE	__CMP_NO_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  REP	#$20
  LDA	bench@f + 0
  CMP	#$0010
  BCC	__CMP_YES_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  BNE	__CMP_NO_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  JMP	__CMP_NO_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  __CMP_YES_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed
  __CMP_NO_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_dfd9ab07_b20a_4c6f_a5ad_81cd96ba55ed:
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
  JMP	__ITER__END__506ebe17_6c5e_4d33_8b80_c7a2137ec4f6
  :
  REP	#$20
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__6a5f3413_771d_4c15_8694_971e1467ee89:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_06d85d8a_9046_4fe1_8014_23cb64e13c80
  BNE	__CMP_NO_06d85d8a_9046_4fe1_8014_23cb64e13c80
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0020
  BCC	__CMP_YES_06d85d8a_9046_4fe1_8014_23cb64e13c80
  BNE	__CMP_NO_06d85d8a_9046_4fe1_8014_23cb64e13c80
  JMP	__CMP_NO_06d85d8a_9046_4fe1_8014_23cb64e13c80
  __CMP_YES_06d85d8a_9046_4fe1_8014_23cb64e13c80:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_06d85d8a_9046_4fe1_8014_23cb64e13c80
  __CMP_NO_06d85d8a_9046_4fe1_8014_23cb64e13c80:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_06d85d8a_9046_4fe1_8014_23cb64e13c80:
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
  JMP	__ITER__END__6a5f3413_771d_4c15_8694_971e1467ee89
  :
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 1
  CLC
  LDA	__@scratchBase + 1
  ADC	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	ents + 8,X
  STA	__@scratchBase + 0
  SEP	#$10
  LDX	#$00
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	ents + 8,X
  CMP	#$00
  BNE	:+
  INX
: TXA
  BEQ	:+
  JMP	__IFNOT_f2ea1e4d_3074_45e1_b2e7_50da581a509c
  :
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench@i + 0
  STA	__@scratchBase + 124
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 122
  REP	#$10
  LDX	__@scratchBase + 122
  LDA	ents + 0,X
  STA	__@scratchBase + 0
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 4
  CLC
  LDA	__@scratchBase + 4
  ADC	bench@i + 0
  STA	__@scratchBase + 120
  LDX	__@scratchBase + 120
  LDA	ents + 4,X
  STA	__@scratchBase + 2
  CLC
  LDX	__@scratchBase + 122
  LDA	ents + 0,X
  LDX	__@scratchBase + 120
  ADC	ents + 4,X
  LDX	__@scratchBase + 124
  STA	ents + 0,X
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 118
  LDX	__@scratchBase + 118
  LDA	ents + 0,X
  STA	__@scratchBase + 0
  CLC
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDX	__@scratchBase + 118
  LDA	ents + 2,X
  EOR	#$80
  CMP	#$80
  BCC	__CMP_NO_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  BNE	__CMP_YES_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  REP	#$20
  LDX	__@scratchBase + 118
  LDA	ents + 0,X
  CMP	#$00f0
  BCC	__CMP_NO_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  BNE	__CMP_YES_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  JMP	__CMP_NO_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  __CMP_YES_e4f7a2de_a399_4b37_8195_0ee4111e02cb:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_e4f7a2de_a399_4b37_8195_0ee4111e02cb
  __CMP_NO_e4f7a2de_a399_4b37_8195_0ee4111e02cb:
  SEP	#$20
  LDA	#$00
  __CMP_END_e4f7a2de_a399_4b37_8195_0ee4111e02cb:
  BNE	:+
  JMP	__IFNOT_c6b840ce_0508_4ae4_9c97_707e6715eb6d
  :
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench@i + 0
  STA	__@scratchBase + 116
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 114
  REP	#$10
  LDX	__@scratchBase + 114
  LDA	ents + 4,X
  STA	__@scratchBase + 0
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDX	__@scratchBase + 114
  SBC	ents + 4,X
  LDX	__@scratchBase + 116
  STA	ents + 4,X
  __IFNOT_c6b840ce_0508_4ae4_9c97_707e6715eb6d:
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench@i + 0
  STA	__@scratchBase + 112
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 110
  REP	#$10
  LDX	__@scratchBase + 110
  LDA	ents + 2,X
  STA	__@scratchBase + 0
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 4
  CLC
  LDA	__@scratchBase + 4
  ADC	bench@i + 0
  STA	__@scratchBase + 108
  LDX	__@scratchBase + 108
  LDA	ents + 6,X
  STA	__@scratchBase + 2
  CLC
  LDX	__@scratchBase + 110
  LDA	ents + 2,X
  LDX	__@scratchBase + 108
  ADC	ents + 6,X
  LDX	__@scratchBase + 112
  STA	ents + 2,X
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 106
  LDX	__@scratchBase + 106
  LDA	ents + 2,X
  STA	__@scratchBase + 0
  CLC
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDX	__@scratchBase + 106
  LDA	ents + 4,X
  EOR	#$80
  CMP	#$80
  BCC	__CMP_NO_d38a51d2_0b68_46e4_811b_97408ca20dfb
  BNE	__CMP_YES_d38a51d2_0b68_46e4_811b_97408ca20dfb
  REP	#$20
  LDX	__@scratchBase + 106
  LDA	ents + 2,X
  CMP	#$00c8
  BCC	__CMP_NO_d38a51d2_0b68_46e4_811b_97408ca20dfb
  BNE	__CMP_YES_d38a51d2_0b68_46e4_811b_97408ca20dfb
  JMP	__CMP_NO_d38a51d2_0b68_46e4_811b_97408ca20dfb
  __CMP_YES_d38a51d2_0b68_46e4_811b_97408ca20dfb:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_d38a51d2_0b68_46e4_811b_97408ca20dfb
  __CMP_NO_d38a51d2_0b68_46e4_811b_97408ca20dfb:
  SEP	#$20
  LDA	#$00
  __CMP_END_d38a51d2_0b68_46e4_811b_97408ca20dfb:
  BNE	:+
  JMP	__IFNOT_9f47e96b_d41e_4981_bc71_11e09bdcc998
  :
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	bench@i + 0
  STA	__@scratchBase + 104
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 2
  CLC
  LDA	__@scratchBase + 2
  ADC	bench@i + 0
  STA	__@scratchBase + 102
  REP	#$10
  LDX	__@scratchBase + 102
  LDA	ents + 6,X
  STA	__@scratchBase + 0
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDX	__@scratchBase + 102
  SBC	ents + 6,X
  LDX	__@scratchBase + 104
  STA	ents + 6,X
  __IFNOT_9f47e96b_d41e_4981_bc71_11e09bdcc998:
  __IFNOT_f2ea1e4d_3074_45e1_b2e7_50da581a509c:
  __ITER__ITER__6a5f3413_771d_4c15_8694_971e1467ee89:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__6a5f3413_771d_4c15_8694_971e1467ee89
  __ITER__END__6a5f3413_771d_4c15_8694_971e1467ee89:
  __ITER__ITER__506ebe17_6c5e_4d33_8b80_c7a2137ec4f6:
  REP	#$21
  LDA	bench@f + 0
  ADC	#$0001
  STA	bench@f + 0
  JMP	__ITER__START__506ebe17_6c5e_4d33_8b80_c7a2137ec4f6
  __ITER__END__506ebe17_6c5e_4d33_8b80_c7a2137ec4f6:
  REP	#$20
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__2c495781_1df2_4932_a095_8896505f8c9e:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  BNE	__CMP_NO_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0020
  BCC	__CMP_YES_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  BNE	__CMP_NO_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  JMP	__CMP_NO_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  __CMP_YES_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506
  __CMP_NO_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_5d39c7ce_a3b6_41cb_90b4_c4f59ef02506:
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
  JMP	__ITER__END__2c495781_1df2_4932_a095_8896505f8c9e
  :
  REP	#$20
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 4
  CLC
  LDA	__@scratchBase + 4
  ADC	bench@i + 0
  STA	__@scratchBase + 100
  REP	#$10
  LDX	__@scratchBase + 100
  LDA	ents + 0,X
  STA	__@scratchBase + 2
  LDA	bench@i + 0
  ASL
  ASL
  ASL
  STA	__@scratchBase + 6
  CLC
  LDA	__@scratchBase + 6
  ADC	bench@i + 0
  STA	__@scratchBase + 98
  LDX	__@scratchBase + 98
  LDA	ents + 2,X
  STA	__@scratchBase + 4
  CLC
  LDX	__@scratchBase + 100
  LDA	ents + 0,X
  LDX	__@scratchBase + 98
  ADC	ents + 2,X
  STA	__@scratchBase + 0
  CLC
  LDA	bench@s + 0
  ADC	__@scratchBase + 0
  STA	bench@s + 0
  __ITER__ITER__2c495781_1df2_4932_a095_8896505f8c9e:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__2c495781_1df2_4932_a095_8896505f8c9e
  __ITER__END__2c495781_1df2_4932_a095_8896505f8c9e:
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
  __ITER__START__88ea9f8a_ba58_4e63_bd59_a3fa5fca3a87:
  __ITER__ITER__88ea9f8a_ba58_4e63_bd59_a3fa5fca3a87:
  JMP	__ITER__START__88ea9f8a_ba58_4e63_bd59_a3fa5fca3a87
  __ITER__END__88ea9f8a_ba58_4e63_bd59_a3fa5fca3a87:
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
