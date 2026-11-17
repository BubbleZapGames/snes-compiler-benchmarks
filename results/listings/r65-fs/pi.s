bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/pi/bench.r65:21
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHB  ; Allocate frame (22 bytes)
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $05,S
    STA $07,S
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
    STA $0D,S
bench__L5:
    .ACCU 16
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #<$038A  ; Load address of SUM
    STA $4B
    LDA #>$038A
    STA $4C
    LDA #$00
    STA $4D
bench__L10:
    .ACCU 8
    LDX #$00  ; inline U32__from_u16
    LDY #$00  ; Set Y=0 for indirect
    REP #$20  ; 16-bit A
    .ACCU 16
    TXA  ; Transfer X to A for indirect store
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA [$4B],Y  ; Store low byte through pointer
    INY  ; Increment for high byte
    XBA  ; Swap to get high byte
    STA [$4B],Y  ; Store high byte through pointer
    XBA  ; Restore A low byte
    LDY #$02  ; Load field offset 2
    LDA #$00
    STA [$4B],Y  ; Store low byte through pointer
    INY
    LDA #$00
    STA [$4B],Y  ; Store high byte through pointer
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L11:
    .ACCU 16
    LDA $0D,S
    STA $09,S
    BNE __skip_7  ; long branch (was BEQ)
    JMP.w bench__L9
