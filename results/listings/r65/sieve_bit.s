bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/sieve_bit/bench.r65:25
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    REP #$21  ; 16-bit A for frame setup (carry cleared here)
    .ACCU 16
    TSC  ; Get stack pointer
    SBC #$09  ; Allocate 10 bytes for locals
    TCS  ; Update stack pointer
    LDA #$01
    STA $01,S
    LDX #$00
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    LDA #$FF
bench__L2:
    .ACCU 8
    STA $0200,X
    INX  ; X++
    CPX #$03E9
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $07,S
bench__L5:
    .ACCU 16
bench__L12:
    .ACCU 16
    LDA $07,S  ; inline check_flag
    LSR A
    LSR A
    LSR A
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    STA $03,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $07,S
    AND #$07
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $03,S
    AND.l __BITV_data,X
bench__L13:
    .ACCU 8
    CMP #$00
    BEQ bench__L8
bench__L7:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $07,S
    CLC
    ADC $07,S
    CLC
    ADC #$03
    STA $03,S
    LDA $07,S
    CLC
    ADC $03,S
    STA $05,S
    CMP #$1F40
    BCS bench__L11
bench__L10:
    .ACCU 16
bench__L14:
    .ACCU 16
    LDA $05,S  ; inline clear_flag
    LSR A
    LSR A
    LSR A
    TAY
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,Y
    STA $09,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    AND #$07
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __BITV_data,X
    EOR #$FF  ; Bitwise complement
    AND $09,S
    STA $0200,Y
bench__L15:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    CLC
    ADC $03,S
    STA $05,S
    CMP #$1F40
    BCC bench__L14  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
    LDA $01,S
    CLC
    ADC #$01
    STA $01,S
bench__L8:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $07,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $07,S
    CMP #$1F40
    BCC bench__L12  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    LDA $01,S
    TAX  ; Save return value A in X
    TSC  ; SP to A
    CLC
    ADC #$0A  ; Adjust past 10 bytes
    TCS  ; A to SP
    TXA  ; Restore return value A from X
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
