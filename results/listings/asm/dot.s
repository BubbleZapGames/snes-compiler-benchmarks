; u8 x u8 dot product over 64 elements: the multiply routine.
; Hand-written reference: the SNES multiplier ($4202 * $4203 -> $4216) does
; each product; the loop is software-pipelined so product i+1 is read while
; the operands for product i are written, and no cycle is spent waiting.

.RAMSECTION "dot data" SLOT 2
    A_ARR dsb 64
    B_ARR dsb 64
    V     dw             ; LCG state, bench_init only
.ENDS

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #1
    STA.w V
    LDX #0
-   LDA.w V              ; v = v*5 + $3619
    ASL A
    ASL A
    CLC
    ADC.w V
    CLC
    ADC #$3619
    STA.w V
    SEP #$20
    .ACCU 8
    LDA.w V+1            ; a[i] = v >> 8
    STA.w A_ARR,X
    LDA.w V              ; b[i] = v & $FF
    STA.w B_ARR,X
    REP #$20
    .ACCU 16
    INX
    CPX #64
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    SEP #$10             ; 8-bit X and Y carry the operand bytes
    .INDEX 8
    LDY #0
    STY.w $4203          ; prime the pipeline with WRMPYA * 0 = 0
    LDA #0               ; s
    LDX #64-1
-   LDY.w A_ARR,X        ; 4  elements i and i-1 per pass
    CLC                  ; 2
    ADC.w $4216          ; 5  previous product
    STY.w $4202          ; 4  WRMPYA = a[i]
    LDY.w B_ARR,X        ; 4
    STY.w $4203          ; 4  WRMPYB = b[i]: start a[i]*b[i]
    DEX                  ; 2
    LDY.w A_ARR,X        ; 4  element i-1
    CLC                  ; 2  8 cycles since the start
    ADC.w $4216          ; 5  + a[i]*b[i]
    STY.w $4202          ; 4
    LDY.w B_ARR,X        ; 4
    STY.w $4203          ; 4  start a[i-1]*b[i-1]
    DEX                  ; 2
    BPL -                ; 3  53 cycles per two elements
    REP #$10             ; 3
    .INDEX 16
    CLC                  ; 2  9 cycles since the last start
    ADC.w $4216          ; 5  + a[0]*b[0]
    RTS
.ENDS
