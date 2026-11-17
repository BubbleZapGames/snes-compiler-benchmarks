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
; Source: build/r65-fs/crc32/bench.r65:19
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
    STZ $3A
    LDX #$00
bench__L2:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    EOR $3A
    STA $3A
    LDY #$08
bench__L5:
    .ACCU 16
    LDA $3A
    AND #$8000
    STA $3C
    LDA $3A
    ASL A
    STA $3A
    BIT $38
    BPL bench__L8
bench__L7:
    .ACCU 16
    LDA $3A
    ORA #$01
    STA $3A
bench__L8:
    .ACCU 16
    ASL $38
    LDA $3C
    BEQ bench__L10
bench__L9:
    .ACCU 16
    LDA $3A
    EOR #$04C1
    STA $3A
    LDA $38
    EOR #$1DB7
    STA $38
bench__L10:
    .ACCU 16
    DEY  ; Y--
    BNE bench__L5  ; Branch if not equal
bench__L6:
    .ACCU 16
    INX  ; X++
    CPX #$0400
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 16
    LDA $3A
    EOR #$FFFF  ; Bitwise complement
    STA $3E
    LDA $38
    EOR #$FFFF  ; Bitwise complement
    EOR $3E
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
