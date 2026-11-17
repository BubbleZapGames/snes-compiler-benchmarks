; 56 digits of pi by the Rabinowitz-Wagon spigot: 32-bit multiply, divide and remainder (after c-bench-64's pi.c).
; Hand-written reference: sum*j + 10000*arr[j] is summed from 8 x 8 hardware
; products, and sum / d is a byte-wise long division on the hardware 16 / 8
; divider while d < 256; d > 255 (j > 128) takes a shift-and-subtract divide.

TERMS  = 196

WRMPYA = $4202
WRMPYB = $4203
WRDIVL = $4204
WRDIVH = $4205
WRDIVB = $4206
RDDIV  = $4214
RDMPY  = $4216           ; product, or division remainder

.RAMSECTION "pi dp" SLOT 2 ORGA $0000 FORCE
    Q     dsw 2          ; sum, between steps (the last quotient)
    S     dsw 2          ; sum * j + 10000 * arr[j]
    U     dsb 5          ; products at odd byte offsets (U+0 stays 0)
    T0    dw             ; partial products
    T1    dw
    T2    dw
    J     dw             ; j
    D     dw             ; d = 2j - 1
    N     dw             ; div16's dividend / quotient word
    I     dw             ; i
    CARRY dw
    SUMS  dw             ; s, the returned checksum
.ENDS

.RAMSECTION "pi data" SLOT 2
    ARR   dsw TERMS+1
.ENDS

.SECTION "bench"
bench_init:
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDA #2000            ; arr[i] = 2000
    LDX #TERMS*2
-   STA.w ARR,X
    DEX
    DEX
    BPL -
    STZ.b U+0
    STZ.b CARRY
    STZ.b SUMS
    LDA #TERMS
    STA.b I

outer:                   ; for i = TERMS; i > 0; i -= 14
    STZ.b Q+0            ; sum = 0
    STZ.b Q+2
    LDA.b I
    STA.b J
    ASL A
    TAX                  ; X = 2j, the arr[] offset, all through the inner loop
    DEC A
    STA.b D

inner:                   ; for j = i; j > 0; j--
    .ACCU 16
    ; ---- S = Q * j + 10000 * arr[j]. With 10000 = $2710 and every factor a
    ; byte, S is a sum of 16-bit products a byte apart. j <= 196 keeps each
    ; column below $10000, so only the final 32-bit add carries.
    LDA.b Q+2
    BEQ +
    JMP mul_wide
+   LDA.w ARR,X
    CMP #$0100
    BCC +
    JMP mul_wide
+
    STZ.b S+2            ; the usual case: Q < $10000, arr[j] < $100
    SEP #$20
    .ACCU 8
    STA.w WRMPYA         ; a = arr[j]
    LDA #$10
    STA.w WRMPYB         ; a * $10
    LDA #$27             ; (wait)
    NOP
    NOP
    LDY.w RDMPY
    STA.w WRMPYB         ; a * $27
    STY.b T0
    LDA.b J              ; (wait)
    LDY.w RDMPY
    STA.w WRMPYA         ; j
    LDA.b Q+0
    STA.w WRMPYB         ; q0 * j
    STY.b T1
    LDA.b Q+1            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; q1 * j
    REP #$20
    .ACCU 16
    TYA                  ; (wait) low column: q0*j + a*$10
    CLC
    ADC.b T0
    STA.b S+0
    LDA.w RDMPY          ; high column: q1*j + a*$27, plus the low column's top byte
    ADC.b T1
    ADC.b S+1
    STA.b S+1            ; S = low + high << 8, S3 = 0

divide:
    ; ---- Q = S / d, arr[j] = S % d
    CPX #2*129
    BCS div_soft         ; d > 255
    LDA.b S+2
    CMP.b D
    BCC div_narrow
    STA.w WRDIVL         ; Q >= $10000: first S3:S2 / d
    SEP #$20
    .ACCU 8
    LDA.b D
    STA.w WRDIVB
    NOP                  ; (16 cycles)
    NOP
    NOP
    NOP
    NOP
    NOP
    REP #$20
    .ACCU 16
    LDA.w RDDIV
    STA.b Q+2
    SEP #$20
    .ACCU 8
    LDA.w RDMPY          ; remainder : S1
    STA.w WRDIVH
    LDA.b S+1
    STA.w WRDIVL
    BRA div_bytes
div_narrow:
    .ACCU 16
    STZ.b Q+2            ; S < d << 16, so Q < $10000
    LDA.b S+1            ; S2:S1, S2 < d
    STA.w WRDIVL
    SEP #$20
div_bytes:               ; two byte digits, each a 16 / 8 hardware divide
    .ACCU 8
    LDA.b D
    STA.w WRDIVB
    NOP                  ; (16 cycles)
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    LDA.w RDDIV
    STA.b Q+1
    LDA.w RDMPY          ; remainder : S0
    STA.w WRDIVH
    LDA.b S+0
    STA.w WRDIVL
    LDA.b D
    STA.w WRDIVB
    DEC.b J              ; (16 cycles) next j, d (d < 256 here)
    DEC.b D
    DEC.b D
    LDA.w RDDIV
    STA.b Q+0
    REP #$20
    .ACCU 16
    LDA.w RDMPY
    STA.w ARR,X          ; arr[j] = remainder
    DEX
    DEX
    BEQ group
    JMP inner

div_soft:
    .ACCU 16
    JSR divsoft
    STA.w ARR,X
    DEC.b J
    DEC.b D
    DEC.b D
    DEX
    DEX
    JMP inner            ; (j > 128 here, so the loop goes on)

group:                   ; s += carry + sum / 10000; carry = sum % 10000
    LDA #10000
    STA.b D
    LDA.b Q+0
    STA.b S+0
    LDA.b Q+2
    STA.b S+2
    JSR divsoft
    TAY
    LDA.b SUMS
    CLC
    ADC.b CARRY
    CLC
    ADC.b Q+0
    STA.b SUMS
    STY.b CARRY
    LDA.b I
    SEC
    SBC #14
    STA.b I
    BEQ +
    JMP outer
+   LDA.b SUMS
    RTS

; Q = S / D, A = S % D, for $FF < D < $8000. Preserves X.
divsoft:
    .ACCU 16
    LDA.b S+2
    CMP.b D
    BCC +
    XBA                  ; S3:S2 >= D: divide the high word first. D > 255,
    TAY                  ; so its quotient is a byte: remainder = S3,
    AND #$FF00           ; and only S2's 8 bits are shifted through
    STA.b N
    TYA
    AND #$00FF
    LDY #1
    CLC
    JSR div_bits
    LDY.b N
    BRA ++
+   LDY #0               ; else the high quotient word is 0, remainder S3:S2
++  STY.b Q+2
    LDY.b S+0
    STY.b N
    JSR div16
    LDY.b N
    STY.b Q+0
    RTS

; (A:N) / D, A < D: N = quotient, A = remainder. Each bit: 16 or 17 cycles.
; div_bits does Y * 8 bits of N, from carry clear.
div16:
    LDY #2
div_bits:
-   .REPT 8
    ROL.b N              ; 7  quotient bit in, dividend bit out
    ROL A                ; 2  into the remainder
    CMP.b D              ; 4
    BCC +                ; 3  carry = quotient bit
    SBC.b D              ; 4  (carry stays set)
+
    .ENDR
    DEY
    BNE -
    ROL.b N              ; the last quotient bit
    RTS

mul_wide:                ; any Q and arr[j]: eight products
    SEP #$20
    .ACCU 8
    LDA.b J
    STA.w WRMPYA         ; j
    LDA.b Q+0
    STA.w WRMPYB         ; q0 * j
    LDA.b Q+1            ; (wait)
    NOP
    NOP
    LDY.w RDMPY
    STA.w WRMPYB         ; q1 * j
    STY.b S+0            ; column 0
    LDA.b Q+2            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; q2 * j
    STY.b U+1            ; column 1
    LDA.b Q+3            ; (wait)
    LDY.w RDMPY
    STA.w WRMPYB         ; q3 * j
    STY.b S+2            ; column 2
    LDA.w ARR,X          ; (wait) a0
    LDY.w RDMPY
    STY.b U+3            ; column 3 (only its low byte counts)
    STA.w WRMPYA         ; a0
    LDA #$10
    STA.w WRMPYB         ; a0 * $10
    LDA #$27             ; (wait)
    NOP
    NOP
    LDY.w RDMPY
    STA.w WRMPYB         ; a0 * $27
    STY.b T0             ; column 0
    LDA.w ARR+1,X        ; (wait) a1
    LDY.w RDMPY
    STY.b T1             ; column 1
    STA.w WRMPYA         ; a1
    LDA #$10
    STA.w WRMPYB         ; a1 * $10
    LDA #$27             ; (wait)
    NOP
    NOP
    LDY.w RDMPY
    STA.w WRMPYB         ; a1 * $27
    STY.b T2             ; column 1
    REP #$20
    .ACCU 16
    LDA.b S+0            ; (wait) column 0
    CLC
    ADC.b T0
    STA.b S+0
    LDA.b U+1            ; column 1
    ADC.b T1
    ADC.b T2
    STA.b U+1
    LDA.w RDMPY          ; column 2
    ADC.b S+2
    STA.b S+2
    LDA.b S+0            ; S = columns 0, 2 + columns 1, 3 (U+0 = 0)
    ADC.b U+0
    STA.b S+0
    LDA.b S+2
    ADC.b U+2
    STA.b S+2
    JMP divide
.ENDS
