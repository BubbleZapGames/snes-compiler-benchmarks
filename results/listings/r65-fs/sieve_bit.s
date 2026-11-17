bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/sieve_bit/bench.r65:25
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
    LDA #$01
    STA $38
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
    STZ $3E
bench__L5:
    .ACCU 16
bench__L12:
    .ACCU 16
    LDA $3E  ; inline check_flag
    LSR A
    LSR A
    LSR A
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    STA $30
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3E
    AND #$07
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $30
    AND.l __BITV_data,X
bench__L13:
    .ACCU 8
    CMP #$00
    BEQ bench__L8
bench__L7:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3E
    CLC
    ADC $3E
    CLC
    ADC #$03
    STA $3A
    LDA $3E
    CLC
    ADC $3A
    STA $3C
    CMP #$1F40
    BCS bench__L11
bench__L10:
    .ACCU 16
bench__L14:
    .ACCU 16
    LDA $3C  ; inline clear_flag
    LSR A
    LSR A
    LSR A
    TAY
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,Y
    STA $31
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3C
    AND #$07
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __BITV_data,X
    EOR #$FF  ; Bitwise complement
    AND $31
    STA $0200,Y
bench__L15:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $3C
    CLC
    ADC $3A
    STA $3C
    CMP #$1F40
    BCC bench__L14  ; Branch if less than (unsigned)
bench__L11:
    .ACCU 16
    LDA $38
    CLC
    ADC #$01
    STA $38
bench__L8:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $3E
    INC A  ; INC A (folded CLC/ADC #1)
    STA $3E
    CMP #$1F40
    BCC bench__L12  ; Branch if less than (unsigned)
bench__L6:
    .ACCU 16
    LDA $38
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
