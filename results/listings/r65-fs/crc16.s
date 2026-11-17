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
; Source: build/r65-fs/crc16/bench.r65:16
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
    LDA #$FFFF
    STA $38
    LDX #$00
bench__L2:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    EOR $38
    STA $38
    LDY #$08
bench__L5:
    .ACCU 16
    BIT $38
    BPL bench__L9
bench__L7:
    .ACCU 16
    LDA $38
    ASL A
    EOR #$1021
    STA $38
bench__L8:
    .ACCU 16
    DEY  ; Y--
    BNE bench__L5  ; Branch if not equal
bench__L6:
    .ACCU 16
    INX  ; X++
    CPX #$0100
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 16
    LDA $38
    RTS
bench__L9:
    .ACCU 16
    LDA $38
    ASL A
    STA $38
    BRA bench__L8

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
