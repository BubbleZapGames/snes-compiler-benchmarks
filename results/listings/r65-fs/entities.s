bench_init:
    .ACCU 8
    .INDEX 16
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STZ $38
bench_init__L2:
    .ACCU 16
    LDA $38
    ASL A
    ASL A
    ASL A
    SEC
    SBC $38
    STA $3A
    LDA $38
    ASL A
    ASL A
    ASL A
    CLC
    ADC $38
    TAX
    LDA $3A
    STA $0200,X
    LDA $38
    ASL A
    ASL A
    CLC
    ADC $38
    STA $0202,X
    LDA $38
    AND #$03
    INC A  ; INC A (folded CLC/ADC #1)
    STA $0204,X
    LDA $38
    AND #$01
    CLC
    ADC #$02
    STA $0206,X
    LDA $38
    AND #$03
    BEQ bench_init__L6
bench_init__L4:
    .ACCU 16
    LDA $38
    ASL A
    ASL A
    ASL A
    CLC
    ADC $38
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$01
    STA $0208,X
bench_init__L5:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $38
    INC A  ; INC A (folded CLC/ADC #1)
    STA $38
    CMP #$20
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    RTS
bench_init__L6:
    .ACCU 16
    LDA $38
    ASL A
    ASL A
    ASL A
    CLC
    ADC $38
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    STZ $0208,X
    BRA bench_init__L5

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/entities/bench.r65:30
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
    LDY #$10
bench__L2:
    .ACCU 16
    LDA #$00
    STZ $3A
bench__L5:
    .ACCU 16
    LDA $3A
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3A
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0208,X
    BEQ bench__L8
bench__L7:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3A
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3A
    TAX
    LDA $0200,X
    CLC
    ADC $0204,X
    STA $0200,X
    CMP #$F1
    BCC bench__L10
bench__L9:
    .ACCU 16
    LDA $3A
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3A
    TAX
    LDA #$00
    SEC
    SBC $0204,X
    STA $0204,X
bench__L10:
    .ACCU 16
    LDA $3A
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3A
    TAX
    LDA $0202,X
    CLC
    ADC $0206,X
    STA $0202,X
    CMP #$C9
    BCC bench__L8
bench__L11:
    .ACCU 16
    LDA $3A
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3A
    TAX
    LDA #$00
    SEC
    SBC $0206,X
    STA $0206,X
bench__L12:
    .ACCU 16
bench__L8:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $3A
    INC A  ; INC A (folded CLC/ADC #1)
    STA $3A
    CMP #$20
    BCC bench__L5  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    DEY  ; Y--
    BNE bench__L2  ; Branch if not equal
bench__L3:
    .ACCU 16
    LDA #$00
    STZ $3C
bench__L14:
    .ACCU 16
    LDA $3C
    ASL A
    ASL A
    ASL A
    CLC
    ADC $3C
    TAX
    LDA $38
    CLC
    ADC $0200,X
    CLC
    ADC $0202,X
    STA $38
    LDA $3C
    INC A  ; INC A (folded CLC/ADC #1)
    STA $3C
    CMP #$20
    BCC bench__L14  ; Branch if less than (unsigned)
bench__L15:
    .ACCU 16
    LDA $38
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
