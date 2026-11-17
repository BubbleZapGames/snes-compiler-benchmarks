bench_init:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (2 bytes)
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$01
    STA $01,S
    LDX #$00
bench_init__L2:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $01,S
    ASL A
    ASL A
    CLC
    ADC $01,S
    CLC
    ADC #$3619
    STA $01,S
    XBA  ; Swap bytes (shift right 8)
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA $0200,X
    INX  ; X++
    CPX #$0200
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/ptrsum/bench.r65:26
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (6 bytes)
    PHY
    PHX
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L1:
    .ACCU 16
    LDA #$0200  ; Load address of BUF; inline sum_bytes
    STA $01,S
    LDA #$0200
    STA $03,S
    LDA #$00
    STA $05,S
    LDY #$00
bench__L2:
    .ACCU 16
    TYA  ; Transfer Y to A for comparison
    CMP $03,S
    BCS bench__L5
bench__L3:
    .ACCU 16
    LDA $0200,Y
    AND #$FF
    CLC
    ADC $05,S
    STA $05,S
    INY  ; Y++
    BRA bench__L2
bench__L4:
    .ACCU 16
bench__L5:
    .ACCU 16
    LDA $05,S
    TAX  ; Save return value A in X
    TSC  ; SP to A
    CLC
    ADC #$06  ; Adjust past 6 bytes
    TCS  ; A to SP
    TXA  ; Restore return value A from X
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
