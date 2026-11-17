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
    CPX #$0100
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/crc16/bench.r65:16
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (2 bytes)
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$FFFF
    STA $01,S
    LDX #$00
bench__L2:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    EOR $01,S
    STA $01,S
    LDY #$08
bench__L5:
    .ACCU 16
    LDA $01,S
    BPL bench__L9
bench__L7:
    .ACCU 16
    LDA $01,S
    ASL A
    EOR #$1021
    STA $01,S
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
    LDA $01,S
    SEP #$20  ; m8 for frame dealloc
    .ACCU 8
    STA $02,S  ; Save A return to top of frame
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    REP #$20  ; Restore m16
    .ACCU 16
    RTS
bench__L9:
    .ACCU 16
    LDA $01,S
    ASL A
    STA $01,S
    BRA bench__L8

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
