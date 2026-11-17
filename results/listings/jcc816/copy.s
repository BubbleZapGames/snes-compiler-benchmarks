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
src               = $7e2000
dst               = $7e2400
bench_init@i      = $7e2800
bench_init@v      = $7e2802
bench@i           = $7e2800
result            = $7e2804
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
  __ITER__START__80733853_814b_42df_a098_2cf5b78a3c17:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  BNE	__CMP_NO_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0400
  BCC	__CMP_YES_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  BNE	__CMP_NO_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  JMP	__CMP_NO_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  __CMP_YES_ed9d6ad4_4ad1_4abd_a079_fed94842116e:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_ed9d6ad4_4ad1_4abd_a079_fed94842116e
  __CMP_NO_ed9d6ad4_4ad1_4abd_a079_fed94842116e:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_ed9d6ad4_4ad1_4abd_a079_fed94842116e:
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
  BNE	__ITER__END__80733853_814b_42df_a098_2cf5b78a3c17
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
  STA	src + 0,X
  __ITER__ITER__80733853_814b_42df_a098_2cf5b78a3c17:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__80733853_814b_42df_a098_2cf5b78a3c17
  __ITER__END__80733853_814b_42df_a098_2cf5b78a3c17:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__5c83a921_a74d_4f8f_9bb5_7e829b519d88:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_f08bf5ea_60be_4a11_b171_68ef5732354b
  BNE	__CMP_NO_f08bf5ea_60be_4a11_b171_68ef5732354b
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0400
  BCC	__CMP_YES_f08bf5ea_60be_4a11_b171_68ef5732354b
  BNE	__CMP_NO_f08bf5ea_60be_4a11_b171_68ef5732354b
  JMP	__CMP_NO_f08bf5ea_60be_4a11_b171_68ef5732354b
  __CMP_YES_f08bf5ea_60be_4a11_b171_68ef5732354b:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_f08bf5ea_60be_4a11_b171_68ef5732354b
  __CMP_NO_f08bf5ea_60be_4a11_b171_68ef5732354b:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_f08bf5ea_60be_4a11_b171_68ef5732354b:
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
  BNE	__ITER__END__5c83a921_a74d_4f8f_9bb5_7e829b519d88
  REP	#$20
  LDA	bench@i + 0
  STA	__@scratchBase + 126
  LDA	bench@i + 0
  STA	__@scratchBase + 124
  SEP	#$20
  REP	#$10
  LDX	__@scratchBase + 124
  LDA	src + 0,X
  LDX	__@scratchBase + 126
  STA	dst + 0,X
  __ITER__ITER__5c83a921_a74d_4f8f_9bb5_7e829b519d88:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__5c83a921_a74d_4f8f_9bb5_7e829b519d88
  __ITER__END__5c83a921_a74d_4f8f_9bb5_7e829b519d88:
  CLC
  SEP	#$20
  LDA	dst + 0
  ADC	dst + 511
  STA	__@scratchBase + 0
  CLC
  LDA	__@scratchBase + 0
  ADC	dst + 1023
  STA	__@callResult + 0
  LDA	#$00
  STA	__@callResult + 1
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
  __ITER__START__1e689dbd_bce3_4bfa_9288_1d56e6488a4e:
  __ITER__ITER__1e689dbd_bce3_4bfa_9288_1d56e6488a4e:
  JMP	__ITER__START__1e689dbd_bce3_4bfa_9288_1d56e6488a4e
  __ITER__END__1e689dbd_bce3_4bfa_9288_1d56e6488a4e:
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
