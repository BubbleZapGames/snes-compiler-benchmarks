; Sieve of Eratosthenes with one bit per odd number, primes up to 16001: bit
; masks through a table (after c-bench-64's sieve_bit.c).
; Hand-written reference: FLAGS sits at $0000, so D can point at flags[k/8]
; and TRB $00 clears the bit. k is carried as that byte (D) plus its bit
; index (X, biased by $F8 so the bit add carries out), stepped by prime/8
; and prime%8, with the bit carry feeding the byte add.

.RAMSECTION "sieve_bit flags" SLOT 2 ORGA $0000 FORCE
    FLAGS dsb 1001
.ENDS

.RAMSECTION "sieve_bit vars" SLOT 2
    COUNT dw
    I     dw                ; the prime's index, then k
    P     dw                ; prime, then prime >> 3
    PR    dw                ; prime & 7
.ENDS

; Indexed as BITV-$F8 by $F8 + bit; aligned so that never crosses a page.
.SECTION "sieve_bit bitv" ALIGN 256 OFFSET $F8
BITV:
    .DB $01, $02, $04, $08, $10, $20, $40, $80
.ENDS

.SECTION "bench"
bench_init:
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDY #$FFFF              ; flags[0..1000] = $FF
    STY.w FLAGS+999         ; flags[999], flags[1000]
    LDX #1000-20            ; flags[0..999], 20 bytes a pass
-   STY.b FLAGS+0,X         ; 5 cycles each (dp,X with D = 0)
    STY.b FLAGS+2,X
    STY.b FLAGS+4,X
    STY.b FLAGS+6,X
    STY.b FLAGS+8,X
    STY.b FLAGS+10,X
    STY.b FLAGS+12,X
    STY.b FLAGS+14,X
    STY.b FLAGS+16,X
    STY.b FLAGS+18,X
    TXA
    SEC
    SBC #20
    TAX
    BPL -

    LDA #1                  ; 2 is prime
    STA.w COUNT
    SEP #$30
    .ACCU 8
    .INDEX 8
    LDY #$F8                ; i = 0: D = i >> 3 = 0, Y = $F8 + (i & 7)
scan:
    LDA.w BITV-$F8,Y        ; 4  bitv[i & 7]
    BIT.b $00               ; 4  & flags[i >> 3]
    BNE prime               ; 2
next:
    INY                     ; 2
    BNE scan                ; 3  => 15 cycles per flag
    LDY #$F8                ; next byte
    REP #$20
    .ACCU 16
    TDC
    INC A
    TCD
    CMP #1000               ; i < 8000
    SEP #$20
    .ACCU 8
    BCC scan
    REP #$30
    .ACCU 16
    .INDEX 16
    LDA #0
    TCD
    LDA.w COUNT
    RTS

prime:                      ; flag i is set: prime = 2i + 3
    .ACCU 8
    .INDEX 8
    REP #$20
    .ACCU 16
    INC.w COUNT
    TYA
    AND #7
    STA.w I
    TDC
    ASL A
    ASL A
    ASL A
    ORA.w I                 ; i
    STA.w I
    ASL A                   ; C = 0
    ADC #3                  ; prime = 2i + 3
    STA.w P
    ADC.w I                 ; k = i + prime
    CMP #8000
    BCS nostrike
    PHD                     ; the scan's byte
    STA.w I
    ORA #$F8
    TAX                     ; X = $F8 + (k & 7)
    LDA.w P
    AND #7
    STA.w PR
    LDA.w P
    LSR A
    LSR A
    LSR A
    STA.w P                 ; prime >> 3
    LDA.w I
    LSR A
    LSR A
    LSR A
    TCD                     ; D = &flags[k >> 3]
    SEP #$20
    .ACCU 8
    CLC
strike:                     ; clear flag k, k += prime
    LDA.w BITV-$F8,X        ; 4  bitv[k & 7]
    TRB.b $00               ; 6  flags[k >> 3] &= ~mask
    TXA                     ; 2
    ADC.w PR                ; 4  bit += prime & 7, C = it passed 7
    ORA #$F8                ; 2  rebias
    TAX                     ; 2
    REP #$20                ; 3
    .ACCU 16
    TDC                     ; 2
    ADC.w P                 ; 5  byte += (prime >> 3) + C
    TCD                     ; 2
    CMP #1000               ; 3  k < 8000
    SEP #$20                ; 3
    .ACCU 8
    BCC strike              ; 3  => 41 cycles per multiple
    PLD
    JMP next

nostrike:                   ; k >= 8000 already: nothing to strike
    .ACCU 16
    SEP #$20
    .ACCU 8
    JMP next
.ENDS
