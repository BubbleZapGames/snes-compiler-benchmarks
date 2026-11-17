; Count the set bits in 256 bytes, one shift at a time.
; Hand-written reference: each byte is shifted right in an 8-bit A until it is
; zero, and the bit falling into C is counted in Y. The last bit shifted out of
; a byte is always 1, so the loop exits on that bit without a separate test.

.RAMSECTION "popcount data" SLOT 2
    BUF  dsb 256
    V    dw              ; LCG state, bench_init only
.ENDS

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #1
    STA.w V
    LDX #0
-   LDA.w V              ; v = v*5 + $3619
    ASL A
    ASL A
    CLC
    ADC.w V
    CLC
    ADC #$3619
    STA.w V
    SEP #$20
    .ACCU 8
    LDA.w V+1            ; buf[i] = v >> 8
    STA.w BUF,X
    REP #$20
    .ACCU 16
    INX
    CPX #256
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    SEP #$20
    .ACCU 8
    LDY #0               ; c
    LDX #256-1
@byte:
    LDA.w BUF,X          ; v = buf[i]
    BNE @shift
    BRA @next            ; v = 0: no bits
@one:
    INY                  ; 2  c += 1
@shift:
    LSR A                ; 2  C = v & 1, v >>= 1
    BCC @shift           ; 3  a 0 bit: v is still non-zero
    BNE @one             ; 3  a 1 bit with more to come
    INY                  ; 2  the top bit; v is now 0
@next:
    DEX
    BPL @byte
    REP #$20
    .ACCU 16
    TYA
    RTS
.ENDS
