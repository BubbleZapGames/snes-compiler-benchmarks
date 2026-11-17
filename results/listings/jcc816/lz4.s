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
__@callResult                           = $000000
__@specSubY                             = $000040
__@specSubX                             = $000050
__@funcPointer                          = $000060
__@signExtend                           = $000063
__@scratchBase                          = $000065
out                                     = $7e2000
bench@i                                 = $7e2400
bench@o                                 = $7e2402
bench@n                                 = $7e2404
bench@off                               = $7e2406
bench@s                                 = $7e2408
bench@tok                               = $7e240a
bench@b                                 = $7e240b
result                                  = $7e240c
__REG@WRMPYA                            = $004202
__REG@WRMPYB                            = $004203
__REG@WRDIVL                            = $004204
__REG@WRDIVH                            = $004205
__REG@WRDIVB                            = $004206
__REG@RDDIVL                            = $004214
__REG@RDDIVH                            = $004215
__REG@RDMPYL                            = $004216
__REG@RDMPYH                            = $004217
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
  STA	bench@i + 0
  STA	bench@o + 0
  STA	bench@s + 0
  __ITER__START__52e1d9e9_bc8b_4329_bca6_f23407760162:
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	bench@tok + 0
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  SEP	#$20
  LDA	bench@i + 0
  STA	bench@tok + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	bench@tok + 0
  STA	__@scratchBase + 0
  LDA	__@signExtend
  STA	__@scratchBase + 1
  REP	#$20
  LDA	__@scratchBase + 0
  LSR
  LSR
  LSR
  LSR
  STA	bench@n + 0
  SEP	#$10
  LDX	#$00
  LDA	bench@n + 0
  CMP	#$000f
  BNE	:+
  INX
: TXA
  BNE	:+
  JMP	__IFNOT_e6658b9f_0b7e_48fb_8f39_e69ffea7cc53
  :
  __ITER__START__0f7b71e0_5558_4a78_a7f8_c4c69aa5a0e8:
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 124
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 124
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	bench@b + 0
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  SEP	#$20
  LDA	bench@i + 0
  STA	bench@b + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@n + 0
  ADC	bench@b + 0
  STA	bench@n + 0
  LDA	bench@n + 1
  ADC	__@signExtend
  STA	bench@n + 1
  __ITER__ITER__0f7b71e0_5558_4a78_a7f8_c4c69aa5a0e8:
  SEP	#$10
  LDX	#$00
  SEP	#$20
  LDA	bench@b + 0
  CMP	#$ff
  BNE	:+
  INX
: TXA
  SEP	#$20
  CMP	#$00
  BEQ	__ITER__END__0f7b71e0_5558_4a78_a7f8_c4c69aa5a0e8
  JMP	__ITER__START__0f7b71e0_5558_4a78_a7f8_c4c69aa5a0e8
  __ITER__END__0f7b71e0_5558_4a78_a7f8_c4c69aa5a0e8:
  __IFNOT_e6658b9f_0b7e_48fb_8f39_e69ffea7cc53:
  __ITER__START__aa1ac15c_888f_41ce_a986_82b483c743bf:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	bench@n + 0
  CMP	#$0000
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__aa1ac15c_888f_41ce_a986_82b483c743bf
  :
  REP	#$20
  LDA	bench@o + 0
  STA	__@scratchBase + 122
  LDA	bench@i + 0
  STA	__@scratchBase + 120
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 120
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  REP	#$10
  LDX	__@scratchBase + 122
  STA	out + 0,X
  REP	#$21
  LDA	bench@o + 0
  ADC	#$0001
  STA	bench@o + 0
  SEP	#$20
  LDA	bench@o + 0
  LDX	__@scratchBase + 122
  STA	out + 0,X
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  SEP	#$20
  LDA	bench@i + 0
  LDX	__@scratchBase + 122
  STA	out + 0,X
  SEC
  REP	#$20
  LDA	bench@n + 0
  SBC	#$0001
  STA	bench@n + 0
  JMP	__ITER__START__aa1ac15c_888f_41ce_a986_82b483c743bf
  __ITER__END__aa1ac15c_888f_41ce_a986_82b483c743bf:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_NO_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  BNE	__CMP_YES_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0177
  BCC	__CMP_NO_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  BNE	__CMP_YES_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  JMP	__CMP_YES_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  __CMP_YES_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4:
  SEP	#$20
  LDA	#$01
  BRA	__CMP_END_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4
  __CMP_NO_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4:
  SEP	#$20
  LDA	#$00
  __CMP_END_4dd1e846_5f34_47fd_ae22_c264ab8ad7c4:
  BEQ	__IFNOT_ca19faf1_c49b_421d_8bd3_24b82c850c9c
  JMP	__ITER__END__52e1d9e9_bc8b_4329_bca6_f23407760162
  __IFNOT_ca19faf1_c49b_421d_8bd3_24b82c850c9c:
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	bench@i + 0
  ADC	#$0001
  STA	__@scratchBase + 118
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 118
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	__@scratchBase + 5
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  REP	#$10
  LDX	__@scratchBase + 118
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	__@scratchBase + 3
  SEP	#$20
  LDA	__@signExtend
  STA	__@scratchBase + 4
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 116
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 116
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	__@scratchBase + 5
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@scratchBase + 2
  REP	#$10
  LDX	__@scratchBase + 116
  ORA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	bench@off + 0
  SEP	#$20
  LDA	__@scratchBase + 3
  ORA	__@signExtend
  STA	bench@off + 1
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	bench@i + 0
  ADC	#$0002
  STA	bench@i + 0
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	#$0f
  AND	bench@tok + 0
  STA	bench@n + 0
  LDA	#$00
  AND	__@signExtend
  STA	bench@n + 1
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	bench@n + 0
  CMP	#$000f
  BNE	:+
  INX
: TXA
  BNE	:+
  JMP	__IFNOT_8edd6ca8_8ac9_4f60_bd70_1a8033593a3a
  :
  __ITER__START__a8f97999_5334_491d_8bed_2ab447ce598d:
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 114
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 114
  LDA	f:lz@77bd22d2_17be_45a0_854f_4961704a9886 + 0,X
  STA	bench@b + 0
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  SEP	#$20
  LDA	bench@i + 0
  STA	bench@b + 0
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@n + 0
  ADC	bench@b + 0
  STA	bench@n + 0
  LDA	bench@n + 1
  ADC	__@signExtend
  STA	bench@n + 1
  __ITER__ITER__a8f97999_5334_491d_8bed_2ab447ce598d:
  SEP	#$10
  LDX	#$00
  SEP	#$20
  LDA	bench@b + 0
  CMP	#$ff
  BNE	:+
  INX
: TXA
  SEP	#$20
  CMP	#$00
  BEQ	__ITER__END__a8f97999_5334_491d_8bed_2ab447ce598d
  JMP	__ITER__START__a8f97999_5334_491d_8bed_2ab447ce598d
  __ITER__END__a8f97999_5334_491d_8bed_2ab447ce598d:
  __IFNOT_8edd6ca8_8ac9_4f60_bd70_1a8033593a3a:
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  LDA	bench@n + 0
  ADC	#$0004
  STA	bench@n + 0
  __ITER__START__7c389a36_6366_4542_89bf_73bf112d2194:
  SEP	#$10
  LDX	#$01
  REP	#$20
  LDA	bench@n + 0
  CMP	#$0000
  BNE	:+
  DEX
: TXA
  SEP	#$20
  CMP	#$00
  BNE	:+
  JMP	__ITER__END__7c389a36_6366_4542_89bf_73bf112d2194
  :
  REP	#$20
  LDA	bench@o + 0
  STA	__@scratchBase + 112
  SEC
  LDA	bench@o + 0
  SBC	bench@off + 0
  STA	__@scratchBase + 110
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 110
  LDA	out + 0,X
  LDX	__@scratchBase + 112
  STA	out + 0,X
  REP	#$21
  LDA	bench@o + 0
  ADC	#$0001
  STA	bench@o + 0
  SEC
  LDA	bench@n + 0
  SBC	#$0001
  STA	bench@n + 0
  JMP	__ITER__START__7c389a36_6366_4542_89bf_73bf112d2194
  __ITER__END__7c389a36_6366_4542_89bf_73bf112d2194:
  __ITER__ITER__52e1d9e9_bc8b_4329_bca6_f23407760162:
  JMP	__ITER__START__52e1d9e9_bc8b_4329_bca6_f23407760162
  __ITER__END__52e1d9e9_bc8b_4329_bca6_f23407760162:
  REP	#$20
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__7ecdc792_a6e9_4c4e_b5d4_2a301e555be4:
  REP	#$21
  LDA	bench@i + 0
  CMP	bench@o + 0
  BCC	__CMP_YES_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5
  BNE	__CMP_NO_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5
  JMP	__CMP_NO_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5
  __CMP_YES_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 4
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 6
  BRA	__CMP_END_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5
  __CMP_NO_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 4
  SEP	#$20
  STA	__@scratchBase + 6
  __CMP_END_9c6c4354_687d_4f20_a9e9_5e0d3dbb5de5:
  SEP	#$10
  LDX	#$00
  REP	#$20
  LDA	__@scratchBase + 4
  CMP	#$0000
  BNE	:+
  SEP	#$20
  LDA	__@scratchBase + 6
  CMP	#$00
  BNE	:+
  INX
: TXA
  BNE	__ITER__END__7ecdc792_a6e9_4c4e_b5d4_2a301e555be4
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 108
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 108
  LDA	out + 0,X
  STA	__@scratchBase + 4
  REP	#$20
  LDA	#$0000
  STA	__@signExtend
  CLC
  SEP	#$20
  LDA	bench@s + 0
  LDX	__@scratchBase + 108
  ADC	out + 0,X
  STA	bench@s + 0
  LDA	bench@s + 1
  ADC	__@signExtend
  STA	bench@s + 1
  __ITER__ITER__7ecdc792_a6e9_4c4e_b5d4_2a301e555be4:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__7ecdc792_a6e9_4c4e_b5d4_2a301e555be4
  __ITER__END__7ecdc792_a6e9_4c4e_b5d4_2a301e555be4:
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
  __ITER__START__8f352a93_6bca_4446_9c85_5b3d83146144:
  __ITER__ITER__8f352a93_6bca_4446_9c85_5b3d83146144:
  JMP	__ITER__START__8f352a93_6bca_4446_9c85_5b3d83146144
  __ITER__END__8f352a93_6bca_4446_9c85_5b3d83146144:
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
lz@77bd22d2_17be_45a0_854f_4961704a9886:
  .byte	$81, $20, $21, $22, $23, $24, $50, $26, $27, $08, $00, $1a, $25, $08, $00, $1b, $40, $10, $00, $02, $20, $00, $2c, $40, $51, $28, $00, $09, $38, $00, $12, $52
  .byte	$48, $00, $13, $40, $50, $00, $f3, $03, $36, $44, $8d, $f9, $16, $42, $45, $4e, $43, $48, $4d, $41, $52, $4b, $53, $3a, $20, $00, $01, $00, $0f, $71, $00, $01
  .byte	$16, $50, $81, $00, $16, $41, $91, $00, $1e, $51, $69, $00, $19, $41, $b1, $00, $10, $41, $b9, $00, $1b, $52, $c1, $00, $95, $a6, $76, $86, $d7, $69, $45, $92
  .byte	$13, $99, $7a, $00, $35, $4c, $5a, $34, $7e, $00, $05, $08, $00, $02, $f8, $00, $1c, $42, $00, $01, $1f, $50, $10, $01, $01, $14, $42, $20, $01, $18, $51, $30
  .byte	$01, $2f, $42, $52, $10, $01, $09, $d6, $37, $4a, $a9, $83, $c6, $18, $b2, $b2, $b0, $aa, $8c, $f2, $f1, $06, $01, $0f, $8c, $00, $02, $06, $95, $00, $1f, $43
  .byte	$5d, $01, $04, $01, $a5, $01, $11, $50, $ad, $01, $16, $51, $ad, $01, $1f, $43, $8d, $01, $06, $00, $dd, $01, $18, $43, $dd, $01, $11, $52, $e5, $01, $ff, $05
  .byte	$eb, $d1, $4f, $c3, $08, $5f, $16, $a4, $6c, $52, $d1, $4f, $c2, $04, $4e, $c0, $f9, $45, $52, $20, $a4, $01, $01, $0f, $08, $00, $08, $1f, $44, $00, $02, $05
  .byte	$19, $50, $48, $02, $1a, $51, $58, $02, $1a, $44, $68, $02, $1f, $52, $78, $02, $03, $f8, $0a, $44, $25, $26, $27, $13, $99, $34, $3a, $5a, $fc, $25, $f3, $f6
  .byte	$05, $51, $cf, $41, $7f, $b4, $ba, $d9, $76, $88, $e0, $99, $ca, $01, $4f, $42, $4c, $4f, $43, $a8, $00, $10, $0b, $e9, $01, $09, $e9, $02, $10, $45, $f1, $02
  .byte	$1f, $50, $c9, $02, $02, $4f, $51, $27, $20, $45, $84, $01, $09, $02, $31, $03, $16, $52, $31, $03, $f9, $0b, $45, $37, $4b, $ae, $9e, $4d, $b8, $cf, $42, $84
  .byte	$cb, $2f, $23, $e8, $c0, $fa, $1c, $c6, $14, $9d, $4a, $a8, $82, $c3, $07, $5c, $b2, $00, $4f, $4b, $20, $44, $45, $b6, $00, $19, $0f, $bf, $00, $00, $2f, $46
  .byte	$50, $80, $03, $0a, $12, $51, $c8, $03, $1f, $46, $a0, $03, $02, $18, $46, $e8, $03, $50, $23, $24, $25, $26, $52
