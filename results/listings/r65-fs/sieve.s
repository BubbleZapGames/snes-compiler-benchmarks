bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/sieve/bench.r65:10
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
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
    STA $3A
bench__L5:
    .ACCU 16
    LDX $3A
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    BNE bench__L8
bench__L7:
    .ACCU 8
    INY  ; Y++
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3A
    CLC
    ADC $3A
    STA $38
    CMP #$0400
    BCS bench__L8
bench__L10:
    .ACCU 16
    LDX $38
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$01
    STA $0200,X
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $38
    CLC
    ADC $3A
    STA $38
    CMP #$0400
    BCC bench__L10  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
bench__L8:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $3A
    INC A  ; INC A (folded CLC/ADC #1)
    STA $3A
    CMP #$0400
    BCC bench__L5  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    TYA
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
