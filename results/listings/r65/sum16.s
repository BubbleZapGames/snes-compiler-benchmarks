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
    LDA $01,S
    ASL A
    ASL A
    CLC
    ADC $01,S
    CLC
    ADC #$3619
    STA $01,S
    STA $0200,X
    INX  ; X++
    INX  ; X++
    CPX #$0200
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/sum16/bench.r65:16
;   included from main.r65:13
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
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
