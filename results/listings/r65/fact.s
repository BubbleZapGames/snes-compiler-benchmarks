bench_init:
    .ACCU 8
    .INDEX 16
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$14
    STA $0248
    LDA #$10
    STA $024A
    SEP #$20  ; Switch to m8 for return
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; fact
; Source: build/r65/fact/bench.r65:26
;   included from main.r65:13
; 
; Parameters:
;   i: u16
;   r: far *U32
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    REP #$21  ; 16-bit A for frame setup (carry cleared here)
    .ACCU 16
    TSC  ; Get stack pointer
    SBC #$11  ; Allocate 18 bytes for locals
    TCS  ; Update stack pointer
    LDA #$00
    STA $09,S
bench__L1:
    .ACCU 16
    LDA $09,S
    CMP $024A
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    BCS bench__L3
bench__L2:
    .ACCU 8
    LDA #<$0200  ; Load address of ARRAY
    STA $05,S
    LDA #>$0200
    STA $06,S
    LDA #$00
    STA $07,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $09,S
    ASL A
    ASL A
    STA $0B,S
    LDA $05,S
    CLC
    ADC $0B,S
    STA $01,S
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    STA $03,S
bench__L13:
    .ACCU 8
    LDX #$00  ; inline U32__from_u16
    LDY #$00  ; Load field offset 0
    PHB  ; Save DBR
    LDA $04,S  ; Load ptr bank
    PHA  ; Push bank
    PLB  ; Set DBR to ptr bank
    REP #$20  ; 16-bit A
    .ACCU 16
    TXA  ; Transfer X to A for indirect store
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA ($02,S),Y  ; Store low byte through far pointer
    INY  ; Increment for high byte
    XBA  ; Swap to get high byte
    STA ($02,S),Y  ; Store high byte through far pointer
    XBA  ; Restore A low byte
    PLB  ; Restore DBR
    LDY #$02  ; Load field offset 2
    PHB  ; Save DBR
    LDA $04,S  ; Load ptr bank
    PHA  ; Push bank
    PLB  ; Set DBR to ptr bank
    LDA #$00
    STA ($02,S),Y  ; Store low byte through far pointer
    INY
    LDA #$00
    STA ($02,S),Y  ; Store high byte through far pointer
    PLB  ; Restore DBR
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L14:
    .ACCU 16
    LDA $09,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $09,S
    BRA bench__L1
bench__L3:
    .ACCU 8
    LDX #$00
bench__L4:
    .ACCU 8
    CPX $0248
    BCC __skip_0  ; long branch (was BCS)
    JMP.w bench__L6
