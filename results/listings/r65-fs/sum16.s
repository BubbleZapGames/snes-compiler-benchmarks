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
    LDA $38
    ASL A
    ASL A
    CLC
    ADC $38
    CLC
    ADC #$3619
    STA $38
    STA $0200,X
    INX  ; X++
    INX  ; X++
    CPX #$0200
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/sum16/bench.r65:16
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
    LDA #$00
    LDX #$00
bench__L2:
    .ACCU 16
    CLC
    ADC $0200,X
    INX  ; X++
    INX  ; X++
    CPX #$0200
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 16
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
