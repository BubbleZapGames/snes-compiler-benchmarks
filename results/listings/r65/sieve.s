bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/sieve/bench.r65:10
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (4 bytes)
    PHY
    LDY #$00
    LDX #$00
bench__L2:
    .ACCU 8
    STZ $0200,X
    INX  ; X++
    CPX #$0400
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$02
    STA $03,S
bench__L5:
    .ACCU 16
    LDA $03,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    BNE bench__L8
bench__L7:
    .ACCU 8
    INY  ; Y++
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $03,S
    CLC
    ADC $03,S
    STA $01,S
    CMP #$0400
    BCS bench__L8
bench__L10:
    .ACCU 16
    LDA $01,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$01
    STA $0200,X
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $01,S
    CLC
    ADC $03,S
    STA $01,S
    CMP #$0400
    BCC bench__L10  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
bench__L8:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $03,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $03,S
    CMP #$0400
    BCC bench__L5  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    TYA
    SEP #$20  ; m8 for frame dealloc
    .ACCU 8
    STA $04,S  ; Save A return to top of frame
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    REP #$20  ; Restore m16
    .ACCU 16
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
