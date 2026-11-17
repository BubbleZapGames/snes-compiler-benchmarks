; Byte-at-a-time copy of 1024 bytes.
; Hand-written reference: one MVN, the 65816's block-move instruction, copies
; the whole array a byte at a time in hardware (7 cycles per byte).

.RAMSECTION "copy data" SLOT 2
    SRC  dsb 1024
    DST  dsb 1024
    V    dw              ; LCG state, bench_init only
    T    dw              ; partial sum of the result
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
    LDA.w V+1            ; src[i] = v >> 8
    STA.w SRC,X
    REP #$20
    .ACCU 16
    INX
    CPX #1024
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDX #SRC
    LDY #DST
    LDA #1024-1          ; MVN moves A+1 bytes
    MVN $00,$00          ; X, Y count up; DBR = $00 afterwards
    LDA.w DST            ; return dst[0] + dst[511] + dst[1023]
    AND #$00FF
    STA.w T
    LDA.w DST+511
    AND #$00FF
    CLC
    ADC.w T
    STA.w T
    LDA.w DST+1023
    AND #$00FF
    CLC
    ADC.w T
    RTS
.ENDS
