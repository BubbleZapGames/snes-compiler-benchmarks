bench_init:
    .ACCU 8
    .INDEX 16
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$01
    STA $38
    LDX #$00
bench_init__L2:
    .ACCU 16
    REP #$20  ; REQUIRED: restore m16 mode for block
    LDA $38
    ASL A
    ASL A
    CLC
    ADC $38
    CLC
    ADC #$3619
    STA $38
    XBA  ; Swap bytes (shift right 8)
    SEP #$20  ; 8-bit A
    .ACCU 8
    STA $0200,X
    INX  ; X++
    CPX #$0200
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/ptrsum/bench.r65:26
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L1:
    .ACCU 16
    LDA #$0200  ; Load address of BUF; inline sum_bytes
    STA $3A
    LDA #$0200
    STA $3C
    LDA #$00
    STZ $3E
    LDY #$00
bench__L2:
    .ACCU 16
    CPY $3C
    BCS bench__L5
bench__L3:
    .ACCU 16
    LDA $0200,Y
    AND #$FF
    CLC
    ADC $3E
    STA $3E
    INY  ; Y++
    BRA bench__L2
bench__L4:
    .ACCU 16
bench__L5:
    .ACCU 16
    LDA $3E
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
