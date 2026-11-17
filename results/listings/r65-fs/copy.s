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
    CPX #$0400
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/copy/bench.r65:18
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    LDX #$00
bench__L2:
    .ACCU 8
    LDA $0200,X
    STA $0600,X
    INX  ; X++
    CPX #$0400
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $0600
    AND #$FF
    STA $38
    LDA $07FF
    AND #$FF
    CLC
    ADC $38
    STA $3A
    LDA $09FF
    AND #$FF
    CLC
    ADC $3A
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
