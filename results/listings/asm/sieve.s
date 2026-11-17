; Sieve of Eratosthenes over 1024 byte flags; returns the prime count.
; Hand-written reference: FLAGS sits at $0000, the direct page, so the scan
; tests two flags per 16-bit load, and each prime strikes its multiples by
; walking D itself along the array (TCD, then STY $00), so j needs no index.

.RAMSECTION "sieve flags" SLOT 2 ORGA $0000 FORCE
    FLAGS dsb 1024
.ENDS

.RAMSECTION "sieve vars" SLOT 2
    COUNT dw
    STEP  dw                ; the prime being struck
.ENDS

.SECTION "bench"
bench_init:
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDX #1024-16            ; flags[0..1023] = 0, 16 bytes a pass
-   STZ.b FLAGS+0,X         ; 5 cycles each (dp,X with D = 0)
    STZ.b FLAGS+2,X
    STZ.b FLAGS+4,X
    STZ.b FLAGS+6,X
    STZ.b FLAGS+8,X
    STZ.b FLAGS+10,X
    STZ.b FLAGS+12,X
    STZ.b FLAGS+14,X
    TXA
    SEC
    SBC #16
    TAX
    BPL -

    STZ.w COUNT
    LDX #2                  ; X = i, always even here
scan:
    LDA.b FLAGS,X           ; 5  flags[i] | flags[i+1] << 8
    CMP #$0101              ; 3  both struck?
    BNE found               ; 2
next:
    INX                     ; 2
    INX                     ; 2
    CPX #1024               ; 3
    BNE scan                ; 3  => 20 cycles per two flags
    LDA.w COUNT
    RTS

found:                      ; flags[i] or flags[i+1] is clear
    BIT #$00FF
    BNE +                   ; flags[i] set: i is not prime
    JSR strike
    LDA.b FLAGS,X           ; reload: striking i only touches 2i and up
+   BIT #$FF00
    BNE next                ; flags[i+1] set
    INX
    JSR strike              ; i+1 is prime
    DEX
    BRA next

; Count prime X and set flags[j] = 1 for j = 2X, 3X, ... < 1024.
; Entry and exit: A, X, Y 16-bit, D = 0; X is preserved.
strike:
    INC.w COUNT
    STX.w STEP
    TXA
    ASL A                   ; j = 2i (C = 0)
    CMP #1024
    BCS +++
    SEP #$10                ; 8-bit index: STY stores one byte
    .INDEX 8
    LDY #1
-   TCD                     ; 2  D = &flags[j]
    STY.b $00               ; 4  flags[j] = 1
    ADC.w STEP              ; 5  j += i (C = 0 from the BCC)
    CMP #1024               ; 3
    BCC -                   ; 3  => 17 cycles per multiple
    REP #$10
    .INDEX 16
    LDA #0
    TCD
    LDX.w STEP              ; SEP #$10 cleared X's high byte
+++ RTS
.ENDS
