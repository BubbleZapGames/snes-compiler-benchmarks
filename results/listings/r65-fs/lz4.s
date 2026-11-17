bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; bench
; Source: build/r65-fs/lz4/bench.r65:42
;   included from main.r65:14
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PHB  ; Allocate frame (14 bytes)
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
    STZ $46
    STZ $38
    STZ $40
    STZ $3C
bench__L1:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L2:
    .ACCU 8
    LDX $46
    LDA.l __LZ_data,X
    STA $30
    REP #$20  ; 16-bit A
    .ACCU 16
    LDA $46
    INC A  ; INC A (folded CLC/ADC #1)
    STA $3E
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $30
    LSR A
    LSR A
    LSR A
    LSR A
    REP #$20  ; 16-bit A
    .ACCU 16
    AND #$FF  ; Zero-extend u8 to u16
    STA $40
    CMP #$0F
    BNE bench__L5
bench__L4:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L6:
    .ACCU 8
bench__L7:
    .ACCU 8
    LDX $3E
    LDA.l __LZ_data,X
    STA $31
    REP #$20  ; 16-bit A
    .ACCU 16
    INC $3E
    LDA $31
    AND #$FF  ; Zero-extend u8 to u16
    CLC
    ADC $40
    STA $40
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $31
    CMP #$FF
    BEQ bench__L7
bench__L9:
    .ACCU 8
bench__L8:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L5:
    .ACCU 16
    LDA $40
    BEQ bench__L13
bench__L12:
    .ACCU 16
    LDX $3E
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA.l __LZ_data,X
    STA $32
    LDX $38
    LDA $32
    STA $0200,X
    REP #$20  ; 16-bit A
    .ACCU 16
    INC $38
    INC $3E
    LDA $40
    SEC
    SBC #$01
    STA $40
    BNE bench__L12  ; Branch if not equal
bench__L13:
    .ACCU 16
    LDA $3E
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
    CPX $38
    BCS bench__L28
bench__L27:
    .ACCU 16
    LDA $0200,X
    AND #$FF
    CLC
    ADC $3C
    STA $3C
    INX  ; X++
    BRA bench__L26
bench__L28:
    .ACCU 16
    LDA $3C
    SEP #$20  ; m8 for frame dealloc
    .ACCU 8
    STA $0E,S  ; Save A return to top of frame
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    PLA  ; Deallocate frame (14 bytes)
    REP #$20  ; Restore m16
    .ACCU 16
    RTS
bench__L15:
    .ACCU 16
    LDX $3E
    LDA.l __LZ_data,X
    AND #$FF
    STA $42
    LDA.l __LZ_data+1,X
    AND #$FF
    XBA  ; Swap bytes (shift left 8)
    ORA $42
    STA $44
    LDA $3E
    CLC
    ADC #$02
    STA $46
    LDA $30
    AND #$0F
    STA $48
    CMP #$0F
    BNE bench__L17
bench__L16:
    .ACCU 16
    SEP #$20  ; REQUIRED: restore m8 mode for block
bench__L18:
    .ACCU 8
bench__L19:
    .ACCU 8
    LDX $46
    LDA.l __LZ_data,X
    STA $33
    REP #$20  ; 16-bit A
    .ACCU 16
    INC $46
    LDA $33
    AND #$FF  ; Zero-extend u8 to u16
    CLC
    ADC $48
    STA $48
    SEP #$20  ; 8-bit A
    .ACCU 8
    LDA $33
    CMP #$FF
    BEQ bench__L19
bench__L21:
    .ACCU 8
bench__L20:
    .ACCU 8
    REP #$20  ; REQUIRED: restore m16 mode for block
bench__L17:
    .ACCU 16
    LDA $48
    CLC
    ADC #$04
    STA $4B
    BNE __skip_0  ; long branch (was BEQ)
    JMP.w bench__L1
