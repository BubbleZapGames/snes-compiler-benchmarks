; Sum a 256-entry u16 array.
; Hand-written reference: the sum stays in A (16-bit) and X walks the array
; downward two bytes at a time, so the loop needs no compare.

.RAMSECTION "sum16 data" SLOT 2
    DATA dsw 256
    V    dw              ; LCG state, bench_init only
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
    STA.w DATA,X
    INX
    INX
    CPX #512
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDA #0
    LDX #510
-   CLC
    ADC.w DATA,X
    DEX
    DEX
    BPL -
    RTS
.ENDS
