bench_init:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (2 bytes)
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$01
    STA $01,S
    LDX #$00
bench_init__L2:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $01,S
    ASL A
    ASL A
    CLC
    ADC $01,S
    CLC
    ADC #$3619
    STA $01,S
    XBA  ; Swap bytes (shift right 8)
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA $0200,X
    INX  ; X++
    CPX #$0400
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/crc32/bench.r65:19
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (6 bytes)
    PHY
    PHX
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $01,S
    STA $03,S
    LDX #$00
bench__L2:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    EOR $03,S
    STA $03,S
    LDY #$08
bench__L5:
    .ACCU 16
    LDA $03,S
    AND #$8000
    STA $05,S
    LDA $03,S
    ASL A
    STA $03,S
    LDA $01,S
    BPL bench__L8
bench__L7:
    .ACCU 16
    LDA $03,S
    ORA #$01
    STA $03,S
bench__L8:
    .ACCU 16
    LDA $01,S
    ASL A
    STA $01,S
    LDA $05,S
    BEQ bench__L10
bench__L9:
    .ACCU 16
    LDA $03,S
    EOR #$04C1
    STA $03,S
    LDA $01,S
    EOR #$1DB7
    STA $01,S
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
    LDA $03,S
    EOR #$FFFF  ; Bitwise complement
    STA $05,S
    LDA $01,S
    EOR #$FFFF  ; Bitwise complement
    EOR $05,S
    TAX  ; Save return value A in X
    TSC  ; SP to A
    CLC
    ADC #$06  ; Adjust past 6 bytes
    TCS  ; A to SP
    TXA  ; Restore return value A from X
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
