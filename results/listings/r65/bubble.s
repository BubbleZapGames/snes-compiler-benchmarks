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
    CPX #$40
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/bubble/bench.r65:16
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
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$00
    STA $03,S
bench__L2:
    .ACCU 8
    LDY #$00
bench__L4:
    .ACCU 8
    LDA #$3F
    SEC
    SBC $03,S
    STA $05,S
    TYA  ; Transfer Y to A for u8 comparison
    CMP $05,S
    BCS bench__L6
bench__L5:
    .ACCU 8
    TYX
    LDA $0200,X
    STA $05,S
    REP #$20  ; 16-bit A
    .ACCU 16
    TYA
    INC A  ; INC A (folded CLC/ADC #1)
    AND #$FF  ; Zero-extend u8 in A to 16-bit X/Y
    TAX  ; Transfer (zero-extended)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $05,S
    CMP $0200,X
    BEQ bench__L8  ; Skip if equal
    BCC bench__L8
bench__L7:
    .ACCU 8
    TYX
    LDA $0200,X
    STA $05,S
    REP #$20  ; 16-bit A
    .ACCU 16
    TYA
    INC A  ; INC A (folded CLC/ADC #1)
    AND #$FF  ; Zero-extend u8 in A to 16-bit X/Y
    TAX  ; Transfer (zero-extended)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    TYX
    STA $0200,X
    REP #$20  ; 16-bit A
    .ACCU 16
    TYA
    CLC
    ADC #$01
    AND #$FF  ; Zero-extend u8 in A to 16-bit X/Y
    TAX  ; Transfer (zero-extended)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $05,S
    STA $0200,X
bench__L8:
    .ACCU 8
    INY  ; Y++
    BRA bench__L4
bench__L6:
    .ACCU 8
    LDA $03,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $03,S
    CMP #$3F
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    LDX #$00
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L10:
    .ACCU 16
    LDA $01,S
    ASL A
    STA $03,S
    LDA $0200,X
    AND #$FF
    EOR $03,S
    STA $01,S
    INX  ; X++
    CPX #$40
    BCC bench__L10  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
    LDA $01,S
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
