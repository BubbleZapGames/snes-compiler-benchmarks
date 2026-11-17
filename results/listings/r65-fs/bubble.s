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
    CPX #$40
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/bubble/bench.r65:16
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
    STZ $38
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$00
    STZ $30
bench__L2:
    .ACCU 8
    LDY #$00
bench__L4:
    .ACCU 8
    LDA #$3F
    SEC
    SBC $30
    STA $31
    TYA  ; Transfer Y to A for u8 comparison
    CMP $31
    BCS bench__L6
bench__L5:
    .ACCU 8
    TYX
    LDA $0200,X
    STA $32
    REP #$20  ; 16-bit A
    .ACCU 16
    TYA
    INC A  ; INC A (folded CLC/ADC #1)
    AND #$FF  ; Zero-extend u8 in A to 16-bit X/Y
    TAX  ; Transfer (zero-extended)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $32
    CMP $0200,X
    BEQ bench__L8  ; Skip if equal
    BCC bench__L8
bench__L7:
    .ACCU 8
    TYX
    LDA $0200,X
    STA $33
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
    LDA $33
    STA $0200,X
bench__L8:
    .ACCU 8
    INY  ; Y++
    BRA bench__L4
bench__L6:
    .ACCU 8
    LDA $30
    INC A  ; INC A (folded CLC/ADC #1)
    STA $30
    CMP #$3F
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    LDX #$00
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L10:
    .ACCU 16
    LDA $38
    ASL A
    STA $3A
    LDA $0200,X
    AND #$FF
    EOR $3A
    STA $38
    INX  ; X++
    CPX #$40
    BCC bench__L10  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
    LDA $38
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
