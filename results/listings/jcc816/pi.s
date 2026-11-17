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
bench@i           = $7e218a
bench@j           = $7e218c
bench@d           = $7e218e
bench@carry       = $7e2190
bench@s           = $7e2192
bench@sum         = $7e2194
result            = $7e2198
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
  STA	bench@carry + 0
  STA	bench@s + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__a36fc76e_8785_48df_b08b_72bc7250b006:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_75bb4973_0809_4a31_a884_87819bcca410
  BNE	__CMP_NO_75bb4973_0809_4a31_a884_87819bcca410
  REP	#$20
  LDA	bench@i + 0
  CMP	#$00c4
  BCC	__CMP_YES_75bb4973_0809_4a31_a884_87819bcca410
  BNE	__CMP_NO_75bb4973_0809_4a31_a884_87819bcca410
  JMP	__CMP_YES_75bb4973_0809_4a31_a884_87819bcca410
  __CMP_YES_75bb4973_0809_4a31_a884_87819bcca410:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_75bb4973_0809_4a31_a884_87819bcca410
  __CMP_NO_75bb4973_0809_4a31_a884_87819bcca410:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_75bb4973_0809_4a31_a884_87819bcca410:
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
  BNE	__ITER__END__a36fc76e_8785_48df_b08b_72bc7250b006
  REP	#$20
  LDA	bench@i + 0
  ASL
  STA	__@scratchBase + 126
  LDA	#$07d0
  REP	#$10
  LDX	__@scratchBase + 126
  STA	arr + 0,X
  __ITER__ITER__a36fc76e_8785_48df_b08b_72bc7250b006:
  CLC
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__a36fc76e_8785_48df_b08b_72bc7250b006
  __ITER__END__a36fc76e_8785_48df_b08b_72bc7250b006:
  REP	#$20
  LDA	#$00c4
  STA	bench@i + 0
  __ITER__START__84bb8a88_085b_47c1_add1_3e1a35bfb60b:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_NO_688abd44_b952_41a0_acca_3d8dab4ca891
  BNE	__CMP_YES_688abd44_b952_41a0_acca_3d8dab4ca891
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0000
  BCC	__CMP_NO_688abd44_b952_41a0_acca_3d8dab4ca891
  BNE	__CMP_YES_688abd44_b952_41a0_acca_3d8dab4ca891
  JMP	__CMP_NO_688abd44_b952_41a0_acca_3d8dab4ca891
  __CMP_YES_688abd44_b952_41a0_acca_3d8dab4ca891:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_688abd44_b952_41a0_acca_3d8dab4ca891
  __CMP_NO_688abd44_b952_41a0_acca_3d8dab4ca891:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_688abd44_b952_41a0_acca_3d8dab4ca891:
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
  JMP	__ITER__END__84bb8a88_085b_47c1_add1_3e1a35bfb60b
  :
  REP	#$20
  LDA	#$0000
  STA	bench@sum + 0
  STA	bench@sum + 2
  LDA	bench@i + 0
  STA	bench@j + 0
  __ITER__START__5f337ea7_2693_475a_a7f6_decc35fc9fd4:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_NO_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  BNE	__CMP_YES_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  REP	#$20
  LDA	bench@j + 0
  CMP	#$0000
  BCC	__CMP_NO_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  BNE	__CMP_YES_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  JMP	__CMP_NO_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  __CMP_YES_17a278f0_266c_4081_9be4_e15ce4a0a6f2:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_17a278f0_266c_4081_9be4_e15ce4a0a6f2
  __CMP_NO_17a278f0_266c_4081_9be4_e15ce4a0a6f2:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_17a278f0_266c_4081_9be4_e15ce4a0a6f2:
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
  JMP	__ITER__END__5f337ea7_2693_475a_a7f6_decc35fc9fd4
  :
  REP	#$20
  LDA	bench@j + 0
  ASL
  STA	__@scratchBase + 0
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	__@scratchBase + 0
  SBC	#$0001
  STA	bench@d + 0
  LDA	bench@sum + 0
  STA	__@specSubX + 0
  LDA	bench@sum + 2
  STA	__@specSubX + 2
  LDA	bench@j + 0
  STA	__@specSubY + 0
  JSL	__mul32by16
  REP	#$20
  LDA	__@callResult + 0
  STA	__@scratchBase + 0
  LDA	__@callResult + 2
  STA	__@scratchBase + 2
  LDA	#$2710
  STA	__@specSubX + 0
  LDA	#$0000
  STA	__@specSubX + 2
  LDA	#$0000
  STA	__@signExtend
  LDA	bench@j + 0
  ASL
  STA	__@scratchBase + 11
  SEP	#$20
  LDA	__@signExtend
  ROL
  STA	__@scratchBase + 13
  REP	#$21
  LDA	#.loWord(arr)
  ADC	__@scratchBase + 11
  STA	__@scratchBase + 8
  SEP	#$20
  LDA	#.bankByte(arr)
  ADC	__@scratchBase + 13
  STA	__@scratchBase + 10
  REP	#$20
  SEP	#$10
  LDY	#$0000
  LDA	[__@scratchBase + 8],y
  STA	__@specSubY + 0
  JSL	__mul32by16
  REP	#$20
  LDA	__@callResult + 0
  STA	__@scratchBase + 4
  LDA	__@callResult + 2
  STA	__@scratchBase + 6
  CLC
  LDA	__@scratchBase + 0
  ADC	__@scratchBase + 4
  STA	bench@sum + 0
  LDA	__@scratchBase + 2
  ADC	__@scratchBase + 6
  STA	bench@sum + 2
  LDA	bench@j + 0
  ASL
  STA	__@scratchBase + 124
  SEP	#$20
  LDA	__@scratchBase + 124
  PHA
  LDA	__@scratchBase + 125
  PHA
  REP	#$20
  LDA	bench@sum + 0
  STA	__@specSubX + 0
  LDA	bench@sum + 2
  STA	__@specSubX + 2
  LDA	bench@d + 0
  STA	__@specSubY + 0
  JSL	__mod32by16
  SEP	#$20
  PLA
  STA	__@scratchBase + 125
  PLA
  STA	__@scratchBase + 124
  REP	#$20
  LDA	__@callResult + 0
  REP	#$10
  LDX	__@scratchBase + 124
  STA	arr + 0,X
  LDA	bench@sum + 0
  STA	__@specSubX + 0
  LDA	bench@sum + 2
  STA	__@specSubX + 2
  LDA	bench@d + 0
  STA	__@specSubY + 0
  JSL	__div32by16
  REP	#$20
  LDA	__@callResult + 0
  STA	bench@sum + 0
  LDA	__@callResult + 2
  STA	bench@sum + 2
  __ITER__ITER__5f337ea7_2693_475a_a7f6_decc35fc9fd4:
  SEC
  REP	#$20
  LDA	bench@j + 0
  SBC	#$0001
  STA	bench@j + 0
  JMP	__ITER__START__5f337ea7_2693_475a_a7f6_decc35fc9fd4
  __ITER__END__5f337ea7_2693_475a_a7f6_decc35fc9fd4:
  SEP	#$10
  REP	#$20
  LDA	bench@sum + 0
  STA	__@specSubX + 0
  LDA	bench@sum + 2
  STA	__@specSubX + 2
  LDA	#$2710
  STA	__@specSubY + 0
  SEP	#$20
  LDA	#$00
  STA	__@specSubY + 2
  LDY	#$00
  LDA	bench@sum + 3
  AND	#$80
  BEQ	:+
  INY
  SEC
  REP	#$20
  LDA	#$0000
  SBC	__@specSubX + 0
  STA	__@specSubX + 0
  LDA	#$0000
  SBC	__@specSubX + 2
  STA	__@specSubX + 2
  :
  SEP	#$30
  LDA	#$0000
  AND	#$80
  BEQ	:+
  DEY
  SEC
  SBC	__@specSubY + 0
  STA	__@specSubY + 0
  SEP	#$20
  LDA	#$00
  SBC	__@specSubY + 2
  STA	__@specSubY + 2
  :
  SEP	#$30
  JSL	__div32by24
  REP	#$20
  LDA	__@callResult + 0
  STA	__@scratchBase + 2
  CPY	#$00
  BEQ	:+
  SEC
  REP	#$20
  LDA	#$0000
  SBC	__@scratchBase + 2
  STA	__@scratchBase + 2
  :
  REP	#$21
  LDA	bench@carry + 0
  ADC	__@scratchBase + 2
  STA	__@scratchBase + 0
  CLC
  LDA	bench@s + 0
  ADC	__@scratchBase + 0
  STA	bench@s + 0
  SEP	#$10
  LDA	bench@sum + 0
  STA	__@specSubX + 0
  LDA	bench@sum + 2
  STA	__@specSubX + 2
  LDA	#$2710
  STA	__@specSubY + 0
  SEP	#$20
  LDA	#$00
  STA	__@specSubY + 2
  LDY	#$00
  LDA	bench@sum + 3
  AND	#$80
  BEQ	:+
  INY
  SEC
  REP	#$20
  LDA	#$0000
  SBC	__@specSubX + 0
  STA	__@specSubX + 0
  LDA	#$0000
  SBC	__@specSubX + 2
  STA	__@specSubX + 2
  :
  SEP	#$30
  LDA	#$0000
  AND	#$80
  BEQ	:+
  DEY
  SEC
  SBC	__@specSubY + 0
  STA	__@specSubY + 0
  SEP	#$20
  LDA	#$00
  SBC	__@specSubY + 2
  STA	__@specSubY + 2
  :
  SEP	#$30
  JSL	__mod32by24
  REP	#$20
  LDA	__@callResult + 0
  STA	bench@carry + 0
  CPY	#$00
  BEQ	:+
  SEC
  REP	#$20
  LDA	#$0000
  SBC	bench@carry + 0
  STA	bench@carry + 0
  :
  __ITER__ITER__84bb8a88_085b_47c1_add1_3e1a35bfb60b:
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	bench@i + 0
  SBC	#$000e
  STA	bench@i + 0
  JMP	__ITER__START__84bb8a88_085b_47c1_add1_3e1a35bfb60b
  __ITER__END__84bb8a88_085b_47c1_add1_3e1a35bfb60b:
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
  __ITER__START__855db97a_4d68_4e8b_bc32_5713369a8f25:
  __ITER__ITER__855db97a_4d68_4e8b_bc32_5713369a8f25:
  JMP	__ITER__START__855db97a_4d68_4e8b_bc32_5713369a8f25
  __ITER__END__855db97a_4d68_4e8b_bc32_5713369a8f25:
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
__mul32by16:		; @func
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
  TAX
  LDA	__@specSubY + 1
  STA	__REG@WRMPYB
  NOP
  TXA
  ADC	f:__REG@RDMPYL
  STA	__@callResult + 1
  LDA	__REG@RDMPYH
  STA	__@callResult + 2
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
  TAX
  LDA	__@specSubY + 1
  STA	__REG@WRMPYB
  NOP
  TXA
  ADC	f:__REG@RDMPYL
  CLC
  ADC	__@callResult + 2
  STA	__@callResult + 2
  LDA	__REG@RDMPYH
  STA	__@callResult + 3
  SEP	#$20
  LDA	__@specSubX + 2
  STA	__REG@WRMPYA
  LDA	__@specSubY + 0
  STA	__REG@WRMPYB
  NOP
  NOP
  LDA	f:__REG@RDMPYL
  CLC
  ADC	__@callResult + 2
  STA	__@callResult + 2
  LDA	__REG@RDMPYH
  TAX
  LDA	__@specSubY + 1
  STA	__REG@WRMPYB
  NOP
  TXA
  ADC	f:__REG@RDMPYL
  CLC
  ADC	__@callResult + 3
  STA	__@callResult + 3
  SEP	#$20
  LDA	__@specSubX + 3
  STA	__REG@WRMPYA
  LDA	__@specSubY + 0
  STA	__REG@WRMPYB
  NOP
  NOP
  LDA	f:__REG@RDMPYL
  CLC
  ADC	__@callResult + 3
  STA	__@callResult + 3
RTL		; @endfunc
; Division
; Modulation
; @asm
__div32by16:	; @func
  __div32by16@ret = __@callResult+0
  __div32by16@start = __@callResult+3
  REP	#$20
  LDA	#$0000
  STA	__div32by16@ret + 0
  SEP	#$20
  STA	__div32by16@ret + 2
  REP	#$20
  LDA	#$0001
  STA	__div32by16@start + 0
  SEP	#$20
  LDA	#$00
  STA	__div32by16@start + 2
  __ITER__START__fe1a5142_465f_4925_b317_5a9ce6b96671:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@specSubX + 2
  CMP	__@signExtend
  BCC	__CMP_NO_8f16d733_d7f1_4b23_abca_a135544984d3
  BNE	__CMP_YES_8f16d733_d7f1_4b23_abca_a135544984d3
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_8f16d733_d7f1_4b23_abca_a135544984d3
  BNE	__CMP_YES_8f16d733_d7f1_4b23_abca_a135544984d3
  JMP	__CMP_NO_8f16d733_d7f1_4b23_abca_a135544984d3
  __CMP_YES_8f16d733_d7f1_4b23_abca_a135544984d3:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_8f16d733_d7f1_4b23_abca_a135544984d3
  __CMP_NO_8f16d733_d7f1_4b23_abca_a135544984d3:
  SEP	#$20
  LDA	#$00
  __CMP_END_8f16d733_d7f1_4b23_abca_a135544984d3:
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__fe1a5142_465f_4925_b317_5a9ce6b96671
  :
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  LDA	#$8000
  AND	__@specSubY + 0
  STA	__@scratchBase + 3
  SEP	#$20
  LDA	#$00
  AND	__@signExtend
  STA	__@scratchBase + 5
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 3
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 5
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__IFNOT_2daec86a_dc70_4075_83b8_9d9cf0108bed
  JMP	__ITER__END__fe1a5142_465f_4925_b317_5a9ce6b96671
  __IFNOT_2daec86a_dc70_4075_83b8_9d9cf0108bed:
  REP	#$20
  LDA	__@specSubY + 0
  ASL
  STA	__@specSubY + 0
  LDA	__div32by16@start + 0
  ASL
  STA	__div32by16@start + 0
  SEP	#$20
  LDA	__div32by16@start + 2
  ROL
  STA	__div32by16@start + 2
  JMP	__ITER__START__fe1a5142_465f_4925_b317_5a9ce6b96671
  __ITER__END__fe1a5142_465f_4925_b317_5a9ce6b96671:
  __ITER__START__352b886d_9ddb_4a7a_9137_c8e7a289d48d:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	__div32by16@start + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__div32by16@start + 2
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__352b886d_9ddb_4a7a_9137_c8e7a289d48d
  :
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@specSubX + 2
  CMP	__@signExtend
  BCC	__CMP_NO_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  BNE	__CMP_YES_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  BNE	__CMP_YES_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  JMP	__CMP_YES_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  __CMP_YES_e43915cf_0c4a_4a60_a490_4cce6c4540c4:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_e43915cf_0c4a_4a60_a490_4cce6c4540c4
  __CMP_NO_e43915cf_0c4a_4a60_a490_4cce6c4540c4:
  SEP	#$20
  LDA	#$00
  __CMP_END_e43915cf_0c4a_4a60_a490_4cce6c4540c4:
  BEQ	__IFNOT_59efa018_755d_4be8_a3f1_e83caa328df3
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	__@specSubX + 0
  SBC	__@specSubY + 0
  STA	__@specSubX + 0
  LDA	__@specSubX + 2
  SBC	__@signExtend
  STA	__@specSubX + 2
  CLC
  LDA	__div32by16@ret + 0
  ADC	__div32by16@start + 0
  STA	__div32by16@ret + 0
  SEP	#$20
  LDA	__div32by16@ret + 2
  ADC	__div32by16@start + 2
  STA	__div32by16@ret + 2
  __IFNOT_59efa018_755d_4be8_a3f1_e83caa328df3:
  REP	#$20
  LDA	__@specSubY + 0
  LSR
  STA	__@specSubY + 0
  LDA	__div32by16@start + 1
  LSR
  STA	__div32by16@start + 1
  SEP	#$20
  LDA	__div32by16@start + 0
  ROR
  STA	__div32by16@start + 0
  JMP	__ITER__START__352b886d_9ddb_4a7a_9137_c8e7a289d48d
  __ITER__END__352b886d_9ddb_4a7a_9137_c8e7a289d48d:
  REP	#$20
  LDA	__div32by16@ret + 0
  STA	__@callResult + 0
  LDA	__div32by16@ret + 2
  STA	__@callResult + 2
  JMP	____div32by16_END
____div32by16_END:
RTL	; @endfunc
__div32by24:	; @func
  __div32by24@ret = __@callResult+0
  __div32by24@start = __@callResult+3
  REP	#$20
  LDA	#$0000
  STA	__div32by24@ret + 0
  SEP	#$20
  STA	__div32by24@ret + 2
  REP	#$20
  LDA	#$0001
  STA	__div32by24@start + 0
  SEP	#$20
  LDA	#$00
  STA	__div32by24@start + 2
  __ITER__START__a4d84e89_5e66_4af0_91b9_49290c2ab062:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@specSubX + 3
  CMP	__@signExtend
  BCC	__CMP_NO_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  BNE	__CMP_YES_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  LDA	__@specSubX + 1
  CMP	__@specSubY + 1
  BCC	__CMP_NO_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  BNE	__CMP_YES_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  BNE	__CMP_YES_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  JMP	__CMP_NO_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  __CMP_YES_06b61f19_40c2_413d_978e_b32c9ecbbeb2:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_06b61f19_40c2_413d_978e_b32c9ecbbeb2
  __CMP_NO_06b61f19_40c2_413d_978e_b32c9ecbbeb2:
  SEP	#$20
  LDA	#$00
  __CMP_END_06b61f19_40c2_413d_978e_b32c9ecbbeb2:
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__a4d84e89_5e66_4af0_91b9_49290c2ab062
  :
  REP	#$20
  LDA	#$0000
  AND	__@specSubY + 0
  STA	__@scratchBase + 3
  SEP	#$20
  LDA	#$80
  AND	__@specSubY + 2
  STA	__@scratchBase + 5
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 3
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 5
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__IFNOT_077171ed_1af9_4111_a87b_4bf6922bd2d8
  JMP	__ITER__END__a4d84e89_5e66_4af0_91b9_49290c2ab062
  __IFNOT_077171ed_1af9_4111_a87b_4bf6922bd2d8:
  REP	#$20
  LDA	__@specSubY + 0
  ASL
  STA	__@specSubY + 0
  SEP	#$20
  LDA	__@specSubY + 2
  ROL
  STA	__@specSubY + 2
  REP	#$20
  LDA	__div32by24@start + 0
  ASL
  STA	__div32by24@start + 0
  SEP	#$20
  LDA	__div32by24@start + 2
  ROL
  STA	__div32by24@start + 2
  JMP	__ITER__START__a4d84e89_5e66_4af0_91b9_49290c2ab062
  __ITER__END__a4d84e89_5e66_4af0_91b9_49290c2ab062:
  __ITER__START__6208bc6c_2189_4715_9835_c70bf7e5fde5:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	__div32by24@start + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__div32by24@start + 2
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__6208bc6c_2189_4715_9835_c70bf7e5fde5
  :
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@specSubX + 3
  CMP	__@signExtend
  BCC	__CMP_NO_397f12be_7a5a_469f_b675_3156c7472f1d
  BNE	__CMP_YES_397f12be_7a5a_469f_b675_3156c7472f1d
  LDA	__@specSubX + 1
  CMP	__@specSubY + 1
  BCC	__CMP_NO_397f12be_7a5a_469f_b675_3156c7472f1d
  BNE	__CMP_YES_397f12be_7a5a_469f_b675_3156c7472f1d
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_397f12be_7a5a_469f_b675_3156c7472f1d
  BNE	__CMP_YES_397f12be_7a5a_469f_b675_3156c7472f1d
  JMP	__CMP_YES_397f12be_7a5a_469f_b675_3156c7472f1d
  __CMP_YES_397f12be_7a5a_469f_b675_3156c7472f1d:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_397f12be_7a5a_469f_b675_3156c7472f1d
  __CMP_NO_397f12be_7a5a_469f_b675_3156c7472f1d:
  SEP	#$20
  LDA	#$00
  __CMP_END_397f12be_7a5a_469f_b675_3156c7472f1d:
  BEQ	__IFNOT_606f3cce_5936_448d_89ca_3e6dca83b09a
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	__@specSubX + 0
  SBC	__@specSubY + 0
  STA	__@specSubX + 0
  SEP	#$20
  LDA	__@specSubX + 2
  SBC	__@specSubY + 2
  STA	__@specSubX + 2
  LDA	__@specSubX + 3
  SBC	__@signExtend
  STA	__@specSubX + 3
  REP	#$21
  LDA	__div32by24@ret + 0
  ADC	__div32by24@start + 0
  STA	__div32by24@ret + 0
  SEP	#$20
  LDA	__div32by24@ret + 2
  ADC	__div32by24@start + 2
  STA	__div32by24@ret + 2
  __IFNOT_606f3cce_5936_448d_89ca_3e6dca83b09a:
  REP	#$20
  LDA	__@specSubY + 1
  LSR
  STA	__@specSubY + 1
  SEP	#$20
  LDA	__@specSubY + 0
  ROR
  STA	__@specSubY + 0
  REP	#$20
  LDA	__div32by24@start + 1
  LSR
  STA	__div32by24@start + 1
  SEP	#$20
  LDA	__div32by24@start + 0
  ROR
  STA	__div32by24@start + 0
  JMP	__ITER__START__6208bc6c_2189_4715_9835_c70bf7e5fde5
  __ITER__END__6208bc6c_2189_4715_9835_c70bf7e5fde5:
  REP	#$20
  LDA	__div32by24@ret + 0
  STA	__@callResult + 0
  LDA	__div32by24@ret + 2
  STA	__@callResult + 2
  JMP	____div32by24_END
____div32by24_END:
RTL	; @endfunc
__mod32by16:	; @func
  __mod32by16@ret = __@callResult+0
  __mod32by16@start = __@callResult+3
  REP	#$20
  LDA	#$0000
  STA	__mod32by16@ret + 0
  SEP	#$20
  STA	__mod32by16@ret + 2
  REP	#$20
  LDA	#$0001
  STA	__mod32by16@start + 0
  SEP	#$20
  LDA	#$00
  STA	__mod32by16@start + 2
  __ITER__START__6e522ee8_c3bb_492e_90d2_af5fcfcf6593:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@specSubX + 2
  CMP	__@signExtend
  BCC	__CMP_NO_f6a5304d_4694_4673_a785_5cdcc7b1434e
  BNE	__CMP_YES_f6a5304d_4694_4673_a785_5cdcc7b1434e
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_f6a5304d_4694_4673_a785_5cdcc7b1434e
  BNE	__CMP_YES_f6a5304d_4694_4673_a785_5cdcc7b1434e
  JMP	__CMP_NO_f6a5304d_4694_4673_a785_5cdcc7b1434e
  __CMP_YES_f6a5304d_4694_4673_a785_5cdcc7b1434e:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_f6a5304d_4694_4673_a785_5cdcc7b1434e
  __CMP_NO_f6a5304d_4694_4673_a785_5cdcc7b1434e:
  SEP	#$20
  LDA	#$00
  __CMP_END_f6a5304d_4694_4673_a785_5cdcc7b1434e:
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__6e522ee8_c3bb_492e_90d2_af5fcfcf6593
  :
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  LDA	#$8000
  AND	__@specSubY + 0
  STA	__@scratchBase + 3
  SEP	#$20
  LDA	#$00
  AND	__@signExtend
  STA	__@scratchBase + 5
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 3
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 5
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__IFNOT_8f35a3f2_133b_4c17_b046_e512c24c1928
  JMP	__ITER__END__6e522ee8_c3bb_492e_90d2_af5fcfcf6593
  __IFNOT_8f35a3f2_133b_4c17_b046_e512c24c1928:
  REP	#$20
  LDA	__@specSubY + 0
  ASL
  STA	__@specSubY + 0
  LDA	__mod32by16@start + 0
  ASL
  STA	__mod32by16@start + 0
  SEP	#$20
  LDA	__mod32by16@start + 2
  ROL
  STA	__mod32by16@start + 2
  JMP	__ITER__START__6e522ee8_c3bb_492e_90d2_af5fcfcf6593
  __ITER__END__6e522ee8_c3bb_492e_90d2_af5fcfcf6593:
  __ITER__START__19f600ab_7104_4ef3_a3e8_6977a6b73bd3:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	__mod32by16@start + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__mod32by16@start + 2
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__19f600ab_7104_4ef3_a3e8_6977a6b73bd3
  :
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  LDA	__@specSubX + 2
  CMP	__@signExtend
  BCC	__CMP_NO_3981fa01_7132_445e_b4fb_62f502ffaca1
  BNE	__CMP_YES_3981fa01_7132_445e_b4fb_62f502ffaca1
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_3981fa01_7132_445e_b4fb_62f502ffaca1
  BNE	__CMP_YES_3981fa01_7132_445e_b4fb_62f502ffaca1
  JMP	__CMP_YES_3981fa01_7132_445e_b4fb_62f502ffaca1
  __CMP_YES_3981fa01_7132_445e_b4fb_62f502ffaca1:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_3981fa01_7132_445e_b4fb_62f502ffaca1
  __CMP_NO_3981fa01_7132_445e_b4fb_62f502ffaca1:
  SEP	#$20
  LDA	#$00
  __CMP_END_3981fa01_7132_445e_b4fb_62f502ffaca1:
  BEQ	__IFNOT_fbab6515_0772_49e8_bed2_fb3784aac1bc
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	__@specSubX + 0
  SBC	__@specSubY + 0
  STA	__@specSubX + 0
  LDA	__@specSubX + 2
  SBC	__@signExtend
  STA	__@specSubX + 2
  CLC
  LDA	__mod32by16@ret + 0
  ADC	__mod32by16@start + 0
  STA	__mod32by16@ret + 0
  SEP	#$20
  LDA	__mod32by16@ret + 2
  ADC	__mod32by16@start + 2
  STA	__mod32by16@ret + 2
  __IFNOT_fbab6515_0772_49e8_bed2_fb3784aac1bc:
  REP	#$20
  LDA	__@specSubY + 0
  LSR
  STA	__@specSubY + 0
  LDA	__mod32by16@start + 1
  LSR
  STA	__mod32by16@start + 1
  SEP	#$20
  LDA	__mod32by16@start + 0
  ROR
  STA	__mod32by16@start + 0
  JMP	__ITER__START__19f600ab_7104_4ef3_a3e8_6977a6b73bd3
  __ITER__END__19f600ab_7104_4ef3_a3e8_6977a6b73bd3:
  REP	#$20
  LDA	__@specSubX + 0
  STA	__@callResult + 0
  LDA	__@specSubX + 2
  STA	__@callResult + 2
  JMP	____mod32by16_END
____mod32by16_END:
RTL	; @endfunc
__mod32by24:	; @func
  __mod32by24@ret = __@callResult+0
  __mod32by24@start = __@callResult+3
  REP	#$20
  LDA	#$0000
  STA	__mod32by24@ret + 0
  SEP	#$20
  STA	__mod32by24@ret + 2
  REP	#$20
  LDA	#$0001
  STA	__mod32by24@start + 0
  SEP	#$20
  LDA	#$00
  STA	__mod32by24@start + 2
  __ITER__START__9aa1e4ba_389b_468f_b2d4_a3f72eae33ad:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@specSubX + 3
  CMP	__@signExtend
  BCC	__CMP_NO_ea49c082_68ba_4a24_8e79_3d29c10f143e
  BNE	__CMP_YES_ea49c082_68ba_4a24_8e79_3d29c10f143e
  LDA	__@specSubX + 1
  CMP	__@specSubY + 1
  BCC	__CMP_NO_ea49c082_68ba_4a24_8e79_3d29c10f143e
  BNE	__CMP_YES_ea49c082_68ba_4a24_8e79_3d29c10f143e
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_ea49c082_68ba_4a24_8e79_3d29c10f143e
  BNE	__CMP_YES_ea49c082_68ba_4a24_8e79_3d29c10f143e
  JMP	__CMP_NO_ea49c082_68ba_4a24_8e79_3d29c10f143e
  __CMP_YES_ea49c082_68ba_4a24_8e79_3d29c10f143e:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_ea49c082_68ba_4a24_8e79_3d29c10f143e
  __CMP_NO_ea49c082_68ba_4a24_8e79_3d29c10f143e:
  SEP	#$20
  LDA	#$00
  __CMP_END_ea49c082_68ba_4a24_8e79_3d29c10f143e:
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__9aa1e4ba_389b_468f_b2d4_a3f72eae33ad
  :
  REP	#$20
  LDA	#$0000
  AND	__@specSubY + 0
  STA	__@scratchBase + 3
  SEP	#$20
  LDA	#$80
  AND	__@specSubY + 2
  STA	__@scratchBase + 5
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 3
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 5
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__IFNOT_150a1035_e337_463a_b95c_4760b1a239bc
  JMP	__ITER__END__9aa1e4ba_389b_468f_b2d4_a3f72eae33ad
  __IFNOT_150a1035_e337_463a_b95c_4760b1a239bc:
  REP	#$20
  LDA	__@specSubY + 0
  ASL
  STA	__@specSubY + 0
  SEP	#$20
  LDA	__@specSubY + 2
  ROL
  STA	__@specSubY + 2
  REP	#$20
  LDA	__mod32by24@start + 0
  ASL
  STA	__mod32by24@start + 0
  SEP	#$20
  LDA	__mod32by24@start + 2
  ROL
  STA	__mod32by24@start + 2
  JMP	__ITER__START__9aa1e4ba_389b_468f_b2d4_a3f72eae33ad
  __ITER__END__9aa1e4ba_389b_468f_b2d4_a3f72eae33ad:
  __ITER__START__434566d0_1dc5_44dc_abbd_150de83e76ba:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	__mod32by24@start + 0
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__mod32by24@start + 2
  CMP	#$00
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__434566d0_1dc5_44dc_abbd_150de83e76ba
  :
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@specSubX + 3
  CMP	__@signExtend
  BCC	__CMP_NO_1d3ef632_573d_41b1_b24f_5852bda98ab8
  BNE	__CMP_YES_1d3ef632_573d_41b1_b24f_5852bda98ab8
  LDA	__@specSubX + 1
  CMP	__@specSubY + 1
  BCC	__CMP_NO_1d3ef632_573d_41b1_b24f_5852bda98ab8
  BNE	__CMP_YES_1d3ef632_573d_41b1_b24f_5852bda98ab8
  LDA	__@specSubX + 0
  CMP	__@specSubY + 0
  BCC	__CMP_NO_1d3ef632_573d_41b1_b24f_5852bda98ab8
  BNE	__CMP_YES_1d3ef632_573d_41b1_b24f_5852bda98ab8
  JMP	__CMP_YES_1d3ef632_573d_41b1_b24f_5852bda98ab8
  __CMP_YES_1d3ef632_573d_41b1_b24f_5852bda98ab8:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_1d3ef632_573d_41b1_b24f_5852bda98ab8
  __CMP_NO_1d3ef632_573d_41b1_b24f_5852bda98ab8:
  SEP	#$20
  LDA	#$00
  __CMP_END_1d3ef632_573d_41b1_b24f_5852bda98ab8:
  BEQ	__IFNOT_3009ef0b_7498_4c7c_9666_56844288b923
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEC
  LDA	__@specSubX + 0
  SBC	__@specSubY + 0
  STA	__@specSubX + 0
  SEP	#$20
  LDA	__@specSubX + 2
  SBC	__@specSubY + 2
  STA	__@specSubX + 2
  LDA	__@specSubX + 3
  SBC	__@signExtend
  STA	__@specSubX + 3
  REP	#$21
  LDA	__mod32by24@ret + 0
  ADC	__mod32by24@start + 0
  STA	__mod32by24@ret + 0
  SEP	#$20
  LDA	__mod32by24@ret + 2
  ADC	__mod32by24@start + 2
  STA	__mod32by24@ret + 2
  __IFNOT_3009ef0b_7498_4c7c_9666_56844288b923:
  REP	#$20
  LDA	__@specSubY + 1
  LSR
  STA	__@specSubY + 1
  SEP	#$20
  LDA	__@specSubY + 0
  ROR
  STA	__@specSubY + 0
  REP	#$20
  LDA	__mod32by24@start + 1
  LSR
  STA	__mod32by24@start + 1
  SEP	#$20
  LDA	__mod32by24@start + 0
  ROR
  STA	__mod32by24@start + 0
  JMP	__ITER__START__434566d0_1dc5_44dc_abbd_150de83e76ba
  __ITER__END__434566d0_1dc5_44dc_abbd_150de83e76ba:
  REP	#$20
  LDA	__@specSubX + 0
  STA	__@callResult + 0
  LDA	__@specSubX + 2
  STA	__@callResult + 2
  JMP	____mod32by24_END
____mod32by24_END:
RTL	; @endfunc
; @endasm
; @endasm
