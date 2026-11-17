; Sum 512 bytes through a pointer argument.
; Hand-written reference: sum_bytes takes p in a direct-page pointer and n in Y,
; adds bytes with an 8-bit ADC (p),Y and counts the carries out in X.

.RAMSECTION "ptrsum dp" SLOT 2 ORGA $0000 FORCE
    PTR  dw              ; sum_bytes argument p (direct page)
    TMP  dw              ; sum_bytes scratch (direct page)
.ENDS

.RAMSECTION "ptrsum data" SLOT 2
    BUF  dsb 512
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
    CPX #512
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDA #BUF
    STA.b PTR
    LDY #512
    JSR sum_bytes        ; A = sum_bytes(buf, 512)
    RTS

; sum_bytes: return in A the sum of the n bytes at p.
; In: PTR = p (bank DBR), Y = n, A/X/Y 16-bit. Out: A 16-bit. Clobbers X, PTR, TMP.
;
; The low byte of the sum stays in an 8-bit A. A carry out is counted in X and
; not cleared, so it also adds 1 to the next byte; that makes the true sum
; A + 255*X + C at every step, which saves a CLC on every carry.
sum_bytes:
    .ACCU 16
    .INDEX 16
    DEC.b PTR            ; (PTR),Y for Y = n..1 reads p[n-1]..p[0]
    LDX #0
    TYA
    BEQ @done            ; n = 0: A = 0
    LSR A                ; C = n is odd
    LDA #0               ; 16-bit clear: B stays 0 for the result
    SEP #$20
    .ACCU 8
    BCC @pair            ; C = 0 going in
    CLC
    BRA @odd             ; odd n: enter at the second copy
@pair:                   ; two bytes per pass; 13 cycles per byte on average
    ADC (PTR),Y          ; 6
    BCC +                ; 3, or 2 + INX 2 on a carry
    INX
+   DEY                  ; 2
@odd:
    ADC (PTR),Y
    BCC +
    INX
+   DEY
    BNE @pair            ; 3 per pair
    REP #$20             ; C survives REP
    .ACCU 16
    ADC #0               ; A = lo + C (B = 0, cannot carry)
    STX.b TMP
    SEC
    SBC.b TMP            ; lo + C - X
    STA.b TMP
    TXA
    XBA
    AND #$FF00           ; 256*X
    CLC
    ADC.b TMP            ; lo + C + 255*X
@done:
    RTS
.ENDS
