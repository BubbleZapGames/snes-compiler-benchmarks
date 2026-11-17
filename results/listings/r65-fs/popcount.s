bench_init:
    .ACCU 8
    .INDEX 16
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$01
    STA $38
    LDX #$00
bench_init__L2:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $38
    ASL A
    ASL A
    CLC
    ADC $38
    CLC
    ADC #$3619
    STA $38
    XBA  ; Swap bytes (shift right 8)
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA $0200,X
    INX  ; X++
    CPX #$0100
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/popcount/bench.r65:16
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STZ $38
    LDX #$00
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L2:
    .ACCU 8
    LDA $0200,X
    STA $30
    BEQ bench__L6
bench__L5:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $30
    AND #$01
    CLC
    ADC $38
    STA $38
    SEP #$20  ; 8-bit A
    .ACCU 8
    LSR $30
    BNE bench__L5  ; Branch if not equal
bench__L6:
    .ACCU 8
    INX  ; X++
    CPX #$0100
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    REP #$20  ; Switch to m16 for return
    .ACCU 16
    LDA $38
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
