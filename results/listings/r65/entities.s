bench_init:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (4 bytes)
    PHY
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $01,S
bench_init__L2:
    .ACCU 16
    LDA $01,S
    ASL A
    ASL A
    ASL A
    SEC
    SBC $01,S
    STA $03,S
    LDA $01,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $01,S
    TAX
    LDA $03,S
    STA $0200,X
    LDA $01,S
    ASL A
    ASL A
    CLC
    ADC $01,S
    STA $0202,X
    LDA $01,S
    AND #$03
    INC A  ; INC A (folded CLC/ADC #1)
    STA $0204,X
    LDA $01,S
    AND #$01
    CLC
    ADC #$02
    STA $0206,X
    LDA $01,S
    AND #$03
    BEQ bench_init__L6
bench_init__L4:
    .ACCU 16
    LDA $01,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $01,S
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$01
    STA $0208,X
bench_init__L5:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $01,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $01,S
    CMP #$20
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    RTS
bench_init__L6:
    .ACCU 16
    LDA $01,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $01,S
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    STZ $0208,X
    BRA bench_init__L5

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/entities/bench.r65:30
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
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $01,S
    LDY #$10
bench__L2:
    .ACCU 16
    LDA #$00
    STA $03,S
bench__L5:
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0208,X
    BEQ bench__L8
bench__L7:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
    TAX
    LDA $0200,X
    CLC
    ADC $0204,X
    STA $0200,X
    CMP #$F1
    BCC bench__L10
bench__L9:
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
    TAX
    LDA #$00
    SEC
    SBC $0204,X
    STA $0204,X
bench__L10:
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
    TAX
    LDA $0202,X
    CLC
    ADC $0206,X
    STA $0202,X
    CMP #$C9
    BCC bench__L8
bench__L11:
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
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
    LDA $03,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $03,S
    CMP #$20
    BCC bench__L5  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    DEY  ; Y--
    BNE bench__L2  ; Branch if not equal
bench__L3:
    .ACCU 16
    LDA #$00
    STA $03,S
bench__L14:
    .ACCU 16
    LDA $03,S
    ASL A
    ASL A
    ASL A
    CLC
    ADC $03,S
    TAX
    LDA $01,S
    CLC
    ADC $0200,X
    CLC
    ADC $0202,X
    STA $01,S
    LDA $03,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $03,S
    CMP #$20
    BCC bench__L14  ; Branch if less than (unsigned)
bench__L15:
    .ACCU 16
    LDA $01,S
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
