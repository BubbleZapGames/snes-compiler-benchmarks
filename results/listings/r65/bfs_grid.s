bench_init:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (6 bytes)
    PHY
    PHX
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$01
    STA $01,S
    LDX #$00
bench_init__L2:
    .ACCU 16
    LDA $01,S
    ASL A
    ASL A
    CLC
    ADC $01,S
    CLC
    ADC #$3619
    STA $01,S
    TXA
    AND #$1F
    STA $03,S
    TXA
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA $05,S
    LDA $03,S
    BNE bench_init__L10
bench_init__L4:
    .ACCU 16
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA #$01
    STA $0200,X
bench_init__L5:
    .ACCU 8
    INX  ; X++
    CPX #$0400
    REP #$20  ; REQUIRED: restore m16 mode for block
    .ACCU 16
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 16
    LDA #$21
    STA $0C00
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    STZ $0200,X
    REP #$21  ; 16-bit A for SP adjust (carry cleared here)
    .ACCU 16
    TSC  ; SP to A
    ADC #$06  ; Adjust past 6 bytes
    TCS  ; A to SP
    SEP #$20  ; Restore 8-bit A
    .ACCU 8
    RTS
bench_init__L10:
    .ACCU 16
    LDA $03,S
    CMP #$1F
    BEQ bench_init__L4  ; Branch if equal
bench_init__L9:
    .ACCU 16
    LDA $05,S
    BEQ bench_init__L4  ; Branch if equal
bench_init__L8:
    .ACCU 16
    LDA $05,S
    CMP #$1F
    BEQ bench_init__L4  ; Branch if equal
bench_init__L7:
    .ACCU 16
    LDA $01,S
    XBA  ; Swap bytes (shift right 8)
    AND #$03
    BEQ bench_init__L4  ; Branch if equal
bench_init__L6:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    STZ $0200,X
    BRA bench_init__L5

; ----------------------------------------------------------------------------
; visit
; Source: build/r65/bfs_grid/bench.r65:34
;   included from main.r65:13
; 
; Parameters:
;   n: u16
;   d: u8
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (8 bytes)
    PHY
    PHX
    PHY
    LDX #$00
    LDA #$FF
bench__L2:
    .ACCU 8
    STA $0600,X
    INX  ; X++
    CPX #$0400
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 8
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $0C00
    STA $01,S
    TAX  ; Transfer to X (no LDX sr,S)
    SEP #$20  ; 8-bit A
    .ACCU 8
    STZ $0600,X
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $01,S
    STA $0A00
    LDA #$00
    STA $01,S
    LDA #$01
    STA $0C02
    LDA #$00
    STA $03,S
bench__L4:
    .ACCU 16
    LDA $01,S
    CMP $0C02
    BNE __skip_0  ; long branch (was BEQ)
    JMP.w bench__L6
