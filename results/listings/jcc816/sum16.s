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
bench_init@i      = $7e2200
bench_init@v      = $7e2202
bench@i           = $7e2200
bench@s           = $7e2202
result            = $7e2204
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
  __ITER__START__aad2bc23_a255_4a95_8dae_fa6f8a0841e7:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  BNE	__CMP_NO_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  REP	#$20
  LDA	bench_init@i + 0
  CMP	#$0100
  BCC	__CMP_YES_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  BNE	__CMP_NO_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  JMP	__CMP_NO_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  __CMP_YES_a6feaf81_3d0f_4f31_93b4_9a33c10f948f:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_a6feaf81_3d0f_4f31_93b4_9a33c10f948f
  __CMP_NO_a6feaf81_3d0f_4f31_93b4_9a33c10f948f:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_a6feaf81_3d0f_4f31_93b4_9a33c10f948f:
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
  BNE	__ITER__END__aad2bc23_a255_4a95_8dae_fa6f8a0841e7
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
  ASL
  STA	__@scratchBase + 126
  LDA	bench_init@v + 0
  REP	#$10
  LDX	__@scratchBase + 126
  STA	data + 0,X
  __ITER__ITER__aad2bc23_a255_4a95_8dae_fa6f8a0841e7:
  REP	#$21
  LDA	bench_init@i + 0
  ADC	#$0001
  STA	bench_init@i + 0
  JMP	__ITER__START__aad2bc23_a255_4a95_8dae_fa6f8a0841e7
  __ITER__END__aad2bc23_a255_4a95_8dae_fa6f8a0841e7:
__bench_init_END:
RTL	; @endfunc
bench:	; @func
  REP	#$20
  LDA	#$0000
  STA	bench@s + 0
  LDA	#$0000
  STA	bench@i + 0
  __ITER__START__ee993935_2dba_4735_941d_6c778a512000:
  REP	#$21
  LDA	#$0000
  STA	__@signExtend
  SEP	#$20
  LDA	__@signExtend
  EOR	#$80
  CMP	#$80
  BCC	__CMP_YES_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  BNE	__CMP_NO_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  REP	#$20
  LDA	bench@i + 0
  CMP	#$0100
  BCC	__CMP_YES_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  BNE	__CMP_NO_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  JMP	__CMP_NO_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  __CMP_YES_c93f38c5_0850_4b84_ac55_bf15e14dde0c:
  REP	#$20
  LDA	#$0001
  STA	__@scratchBase + 0
  SEP	#$20
  LDA	#$00
  STA	__@scratchBase + 2
  BRA	__CMP_END_c93f38c5_0850_4b84_ac55_bf15e14dde0c
  __CMP_NO_c93f38c5_0850_4b84_ac55_bf15e14dde0c:
  REP	#$20
  LDA	#$0000
  STA	__@scratchBase + 0
  SEP	#$20
  STA	__@scratchBase + 2
  __CMP_END_c93f38c5_0850_4b84_ac55_bf15e14dde0c:
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
  BNE	__ITER__END__ee993935_2dba_4735_941d_6c778a512000
  REP	#$20
  LDA	bench@i + 0
  ASL
  STA	__@scratchBase + 126
  REP	#$10
  LDX	__@scratchBase + 126
  LDA	data + 0,X
  STA	__@scratchBase + 0
  CLC
  LDA	bench@s + 0
  LDX	__@scratchBase + 126
  ADC	data + 0,X
  STA	bench@s + 0
  __ITER__ITER__ee993935_2dba_4735_941d_6c778a512000:
  REP	#$21
  LDA	bench@i + 0
  ADC	#$0001
  STA	bench@i + 0
  JMP	__ITER__START__ee993935_2dba_4735_941d_6c778a512000
  __ITER__END__ee993935_2dba_4735_941d_6c778a512000:
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
  __ITER__START__6839fe70_2ac0_4b00_9b00_e759c2647fe2:
  __ITER__ITER__6839fe70_2ac0_4b00_9b00_e759c2647fe2:
  JMP	__ITER__START__6839fe70_2ac0_4b00_9b00_e759c2647fe2
  __ITER__END__6839fe70_2ac0_4b00_9b00_e759c2647fe2:
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
