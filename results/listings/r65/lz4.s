bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/lz4/bench.r65:42
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
    SBC #$0D  ; Allocate 14 bytes for locals
    TCS  ; Update stack pointer
    LDA #$00
    STA $0B,S
    STA $01,S
    STA $07,S
    STA $03,S
bench__L1:
    .ACCU 16
bench__L2:
    .ACCU 16
    LDA $0B,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __LZ_data,X
    STA $0D,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $0B,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $05,S
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0D,S
    LSR A
    LSR A
    LSR A
    LSR A
    REP #$20  ; 16-bit A
    .ACCU 16
    AND #$FF  ; Zero-extend u8 to u16
    STA $07,S
    CMP #$0F
    BNE bench__L5
bench__L4:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L6:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L7:
    .ACCU 16
    LDA $05,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __LZ_data,X
    STA $09,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $05,S
    LDA $09,S
    AND #$FF  ; Zero-extend u8 to u16
    CLC
    ADC $07,S
    STA $07,S
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $09,S
    CMP #$FF
    BEQ bench__L6
bench__L9:
    .ACCU 8
bench__L8:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L5:
    .ACCU 16
    LDA $07,S
    BEQ bench__L13
bench__L12:
    .ACCU 16
    LDA $05,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __LZ_data,X
    STA $09,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $01,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $09,S
    STA $0200,X
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $01,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $01,S
    LDA $05,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $05,S
    LDA $07,S
    SEC
    SBC #$01
    STA $07,S
    BNE bench__L12  ; Branch if not equal
bench__L13:
    .ACCU 16
    LDA $05,S
    CMP #$0177
    BCC bench__L15
bench__L14:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L3:
    .ACCU 8
    LDX #$00
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L26:
    .ACCU 16
    TXA  ; Transfer X to A for comparison
    CMP $01,S
    BCS bench__L28
bench__L27:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    CLC
    ADC $03,S
    STA $03,S
    INX  ; X++
    BRA bench__L26
bench__L28:
    .ACCU 16
    LDA $03,S
    TAX  ; Save return value A in X
    TSC  ; SP to A
    CLC
    ADC #$0E  ; Adjust past 14 bytes
    TCS  ; A to SP
    TXA  ; Restore return value A from X
    RTS
bench__L15:
    .ACCU 16
    LDA $05,S
    TAX  ; Transfer to X (no LDX sr,S)
    LDA.l __LZ_data,X
    AND #$FF
    STA $07,S
    LDA.l __LZ_data+1,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    ORA $07,S
    STA $09,S
    LDA $05,S
    CLC
    ADC #$02
    STA $0B,S
    LDA $0D,S
    AND #$0F
    STA $05,S
    CMP #$0F
    BNE bench__L17
bench__L16:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L18:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L19:
    .ACCU 16
    LDA $0B,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __LZ_data,X
    STA $07,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $0B,S
    INC A  ; INC A (folded CLC/ADC #1)
    STA $0B,S
    LDA $07,S
    AND #$FF  ; Zero-extend u8 to u16
    CLC
    ADC $05,S
    STA $05,S
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    CMP #$FF
    BEQ bench__L18
bench__L21:
    .ACCU 8
bench__L20:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L17:
    .ACCU 16
    LDA $05,S
    CLC
    ADC #$04
    STA $07,S
    BNE __skip_0  ; long branch (was BEQ)
    JMP.w bench__L2
