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
    LDA $01,S  ; Load low byte
    STA $0240,X
    INX  ; X++
    CPX #$40
    BCC bench_init__L2  ; Branch if less than (unsigned)
bench_init__L3:
    .ACCU 8
    PLA  ; Deallocate frame (2 bytes)
    PLA  ; Deallocate frame (2 bytes)
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65/dot/bench.r65:19
;   included from main.r65:13
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHX  ; Allocate frame (4 bytes)
    PHY
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA #$00
    STA $01,S
    LDX #$00
bench__L2:
    .ACCU 16
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0200,X
    STA $03,S
    LDA $0240,X
    PHX  ; Spill X (region start)
    XBA  ; Store to B
    LDA $05,S
    JSR mul8
    .ACCU 16
    PLX  ; Reload X (region end)
    CLC
    ADC $01,S
    STA $01,S
    INX  ; X++
    CPX #$40
    BCC bench__L2  ; Branch if less than (unsigned)
bench__L3:
    .ACCU 16
    LDA $01,S
    SEP #$20  ; m8 for frame dealloc
    .ACCU 8
    STA $04,S  ; Save A return to top of frame
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    PLA  ; Deallocate frame (4 bytes)
    REP #$20  ; Restore m16
    .ACCU 16
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
