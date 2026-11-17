; 0! to 15!, 20 times, summed in 32 bits: recursion and 32-bit multiplies (after c-bench-64's fact.c).
; Hand-written reference: fact(i) takes i in X, returns i! in the direct-page
; long R and preserves X, so a call needs no saves. Below i = 256 it recurses
; in fact8, whose 32 x 8 multiply is four (or, while i! fits 16 bits, two)
; hardware 8 x 8 products; above, i * fact(i-1) is two of those multiplies.

WRMPYA = $4202
WRMPYB = $4203
RDMPY  = $4216

.RAMSECTION "fact dp" SLOT 2 ORGA $0000 FORCE
    R     dsw 2          ; fact's 32-bit result
    U     dsb 5          ; partial products lined up for one 32-bit add (U+0 stays 0)
    COUNT dw             ; outer loop counter
    F     dsw 2          ; fact: (i-1)! and R * lo(i), for i > 255
    G     dsw 2
.ENDS

.RAMSECTION "fact data" SLOT 2
    ARRAY  dsw 32        ; uint32_t array[16]
    N_ITER dw
    SIZE   dw
.ENDS

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #20
    STA.w N_ITER
    LDA #16
    STA.w SIZE
    RTS

; R = X!, recursively: X > 1 ? X * fact(X - 1) : 1. Preserves X; A 16-bit.
fact:
    .ACCU 16
    .INDEX 16
    CPX #$0100
    BCC fact8            ; i fits a byte, and so does every i below it
    DEX
    JSR fact             ; R = (i - 1)!
    INX
    LDA.b R+0            ; R * i = R * lo(i) + (R * hi(i)) << 8
    STA.b F+0
    LDA.b R+2
    STA.b F+2
    SEP #$20
    .ACCU 8
    TXA
    JSR mul8             ; R = F * lo(i)
    .ACCU 16
    LDA.b R+0
    STA.b G+0
    LDA.b R+2
    STA.b G+2
    LDA.b F+0
    STA.b R+0
    LDA.b F+2
    STA.b R+2
    TXA
    XBA
    SEP #$20
    .ACCU 8
    JSR mul8             ; R = F * hi(i)
    .ACCU 16
    LDA.b R+0            ; R = G + R << 8
    XBA
    AND #$FF00
    CLC
    ADC.b G+0
    TAY
    LDA.b R+1
    ADC.b G+2
    STA.b R+2
    STY.b R+0
    RTS

; fact for X < 256.
fact8:
    CPX #2
    BCC fact_one
    DEX
    JSR fact8            ; R = (X - 1)!
    INX
    SEP #$20
    .ACCU 8
    TXA
; R = R * A (8-bit), entered with A 8-bit, returns with A 16-bit. Preserves X.
mul8:
    STA.w WRMPYA         ; multiplicand = i
    LDA.b R+0
    STA.w WRMPYB         ; p0 = r0 * i
    LDY.b R+2            ; (wait) does R fit 16 bits?
    BNE fact_wide
    LDA.b R+1
    LDY.w RDMPY          ; Y = p0, 8 cycles after the start
    STA.w WRMPYB         ; p1 = r1 * i
    STY.b R+0            ; R0 = p0 lo, R1 = p0 hi (R2, R3 are 0)
    REP #$20
    .ACCU 16
    CLC                  ; (wait)
    LDA.w RDMPY
    ADC.b R+1            ; R2:R1 = p0 hi + p1 (cannot carry out)
    STA.b R+1
    RTS

fact_wide:               ; R * i = p0 + p1<<8 + p2<<16 + p3<<24
    .ACCU 8
    LDA.b R+1            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; p1 = r1 * i
    STY.b R+0            ; R1:R0 = p0
    LDA.b R+2            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; p2 = r2 * i
    STY.b U+1            ; U2:U1 = p1
    LDA.b R+3            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; p3 = r3 * i
    STY.b R+2            ; R3:R2 = p2
    REP #$20
    .ACCU 16
    LDA.b R+0            ; (wait) low word: p0 + p1<<8
    CLC
    ADC.b U+0
    STA.b R+0
    LDA.w RDMPY
    STA.b U+3            ; U3 = p3 lo
    LDA.b R+2            ; high word: p2 + p3<<8 + p1>>8 + carry
    ADC.b U+2
    STA.b R+2
    RTS

fact_one:
    LDA #1
    STA.b R+0
    STZ.b R+2
    RTS

bench:
    .ACCU 16
    .INDEX 16
    STZ.b U+0            ; the zero byte under U1
    LDX #0               ; array[j] = 0 for j < size
    LDY.w SIZE
    BEQ +
-   STZ.w ARRAY,X
    STZ.w ARRAY+2,X
    INX
    INX
    INX
    INX
    DEY
    BNE -
+
    LDA.w N_ITER         ; for i < n_iter
    BEQ sum
    STA.b COUNT
outer:
    LDX #0               ; for j < size
    CPX.w SIZE
    BCS next
inner:
    JSR fact             ; R = j!  (X = j survives)
    TXA
    ASL A
    ASL A
    TAY
    CLC                  ; array[j] += R
    LDA.w ARRAY,Y
    ADC.b R+0
    STA.w ARRAY,Y
    LDA.w ARRAY+2,Y
    ADC.b R+2
    STA.w ARRAY+2,Y
    INX
    CPX.w SIZE
    BCC inner
next:
    DEC.b COUNT
    BNE outer

sum:
    STZ.b R+0            ; res = sum of array[j]
    STZ.b R+2
    LDY #0
    LDX.w SIZE
    BEQ fold
-   CLC
    LDA.w ARRAY,Y
    ADC.b R+0
    STA.b R+0
    LDA.w ARRAY+2,Y
    ADC.b R+2
    STA.b R+2
    INY
    INY
    INY
    INY
    DEX
    BNE -
fold:
    LDA.b R+2            ; (res >> 16) ^ res
    EOR.b R+0
    RTS
.ENDS
