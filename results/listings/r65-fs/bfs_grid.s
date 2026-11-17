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
    TXA
    AND #$1F
    STA $3A
    TXA
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA $3C
    LDA $3A
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
    RTS
bench_init__L10:
    .ACCU 16
    LDA $3A
    CMP #$1F
    BEQ bench_init__L4  ; Branch if equal
bench_init__L9:
    .ACCU 16
    LDA $3C
    BEQ bench_init__L4  ; Branch if equal
bench_init__L8:
    .ACCU 16
    LDA $3C
    CMP #$1F
    BEQ bench_init__L4  ; Branch if equal
bench_init__L7:
    .ACCU 16
    LDA $38
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
; Source: build/r65-fs/bfs_grid/bench.r65:34
;   included from main.r65:14
; 
; Parameters:
;   n: u16
;   d: u8
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHB  ; Allocate frame (8 bytes)
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
    PHB
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
    STA $38
    LDX $38
    SEP #$20  ; 8-bit A
    .ACCU 8
    STZ $0600,X
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $38
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
    BEQ bench__L6
bench__L5:
    .ACCU 16
    LDA $01,S
    ASL A
    TAX
    LDA $0A00,X
    STA $05,S
    LDA $01,S
    INC A  ; INC A (folded CLC/ADC #1)
    AND #$FF
    STA $01,S
    LDA $05,S
    TAX  ; Transfer to X (no LDX sr,S)
    LDA $0600,X
    AND #$FF
    CLC
    ADC $03,S
    STA $03,S
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $0600,X
    INC A  ; INC A (folded CLC/ADC #1)
    STA $07,S
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    SEC
    SBC #$20
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    JSR visit
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    DEC A  ; DEC A (folded SEC/SBC #1)
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    JSR visit
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    INC A  ; INC A (folded CLC/ADC #1)
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    JSR visit
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $05,S
    CLC
    ADC #$20
    TAX
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $07,S
    JSR visit
    REP #$20  ; REQUIRED: restore m16 mode for block
    .ACCU 16
    BRA bench__L4
bench__L6:
    .ACCU 16
    LDA $03,S
    SEP #$20  ; m8 for frame dealloc
    .ACCU 8
    STA $08,S  ; Save A return to top of frame
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    PLA  ; Deallocate frame (8 bytes)
    REP #$20  ; Restore m16
    .ACCU 16
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:19
; 
; ----------------------------------------------------------------------------
