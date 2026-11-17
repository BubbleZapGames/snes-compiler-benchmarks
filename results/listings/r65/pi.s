bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/pi/bench.r65:21
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
    SBC #$15  ; Allocate 22 bytes for locals
    TCS  ; Update stack pointer
    LDA #$00
    STA $01,S
    STA $03,S
    LDX #$00
    LDA #$07D0
bench__L2:
    .ACCU 16
    STA $0200,X
    INX  ; X++
    INX  ; X++
    CPX #$018A
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 16
    LDA #$C4
    STA $09,S
bench__L5:
    .ACCU 16
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #<$038A  ; Load address of SUM
    STA $05,S
    LDA #>$038A
    STA $06,S
    LDA #$00
    STA $07,S
bench__L10:
    .ACCU 8
    LDX #$00  ; inline U32__from_u16
    LDY #$00  ; Load field offset 0
    PHB  ; Save DBR
    LDA $08,S  ; Load ptr bank
    PHA  ; Push bank
    PLB  ; Set DBR to ptr bank
    REP #$20  ; 16-bit A
    .ACCU 16
    TXA  ; Transfer X to A for indirect store
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA ($06,S),Y  ; Store low byte through far pointer
    INY  ; Increment for high byte
    XBA  ; Swap to get high byte
    STA ($06,S),Y  ; Store high byte through far pointer
    XBA  ; Restore A low byte
    PLB  ; Restore DBR
    LDY #$02  ; Load field offset 2
    PHB  ; Save DBR
    LDA $08,S  ; Load ptr bank
    PHA  ; Push bank
    PLB  ; Set DBR to ptr bank
    LDA #$00
    STA ($06,S),Y  ; Store low byte through far pointer
    INY
    LDA #$00
    STA ($06,S),Y  ; Store high byte through far pointer
    PLB  ; Restore DBR
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L11:
    .ACCU 16
    LDA $09,S
    STA $05,S
    BNE __skip_6  ; long branch (was BEQ)
    JMP.w bench__L9
