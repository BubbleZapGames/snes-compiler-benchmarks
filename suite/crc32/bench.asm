; CRC-32/CKSUM of 1024 bytes, a bit at a time: 32-bit shifts and xors (after c-bench-64's crc32.c).
; Hand-written reference: one 16-bit half of the CRC is in A, the other in direct
; page, and applying the polynomial swaps which half A holds, so the eight unrolled
; bit steps of a byte run as two interleaved chains, one per state.

.RAMSECTION "crc32 dp" SLOT 2 ORGA $0000 FORCE
    LO   dw              ; CRC bits 15..0
    HI   dw              ; CRC bits 31..16
.ENDS

.RAMSECTION "crc32 data" SLOT 2
    DATA dsb 1024
.ENDS

; One bit step, crc = crc << 1, ^ $04C11DB7 if the old bit 31 was set.
; STEP_H: A = hi, LO current. 12 cycles to SAME (state H), or 25 falling through
; into the next step in state L. STEP_L is the mirror image.
.MACRO STEP_H ARGS SAME
    ASL.b LO
    ROL A
    BCC SAME
    EOR #$04C1
    STA.b HI
    LDA.b LO
    EOR #$1DB7
.ENDM

.MACRO STEP_L ARGS SAME
    ASL A
    ROL.b HI
    BCC SAME
    EOR #$1DB7
    STA.b LO
    LDA.b HI
    EOR #$04C1
.ENDM

; After a byte, with the CRC half that A holds stored back: crc ^= data[i] << 24
; and on to bit 1 of the next byte, in state H.
.MACRO NEXT_BYTE
    INX
    CPX #1024
    BEQ finish
    LDA.w DATA-1,X       ; data[i] is the high byte of this word
    AND #$FF00
    EOR.b HI
    JMP h1
.ENDM

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #1               ; v
    LDX #0
-   STA.b HI             ; v = v*5 + $3619
    ASL A
    ASL A
    CLC
    ADC.b HI
    CLC
    ADC #$3619
    XBA                  ; data[i] = v >> 8
    SEP #$20
    .ACCU 8
    STA.w DATA,X
    REP #$20
    .ACCU 16
    XBA
    INX
    CPX #1024
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    STZ.b LO
    STZ.b HI
    LDX #0
    LDA.w DATA-1         ; crc = data[0] << 24
    AND #$FF00
                         ; chain 1: a step in state H that applies the polynomial
h1: STEP_H h2            ; falls into the next step in state L, and the other way
l2: STEP_L l3            ; round; a step that does not branches to the next step
h3: STEP_H h4            ; of chain 2
l4: STEP_L l5
h5: STEP_H h6
l6: STEP_L l7
h7: STEP_H h8
l8: ASL A
    ROL.b HI
    JMP end_l
l1: STEP_L l2            ; chain 2
h2: STEP_H h3
l3: STEP_L l4
h4: STEP_H h5
l5: STEP_L l6
h6: STEP_H h7
l7: STEP_L l8
h8: ASL.b LO
    ROL A
    BCC end_h
    EOR #$04C1
    STA.b HI
    LDA.b LO
    EOR #$1DB7
    STA.b LO
    NEXT_BYTE
end_l:
    BCC +
    EOR #$1DB7
    STA.b LO
    LDA.b HI
    EOR #$04C1
end_h:
    STA.b HI
    NEXT_BYTE
+   STA.b LO
    NEXT_BYTE

finish:
    LDA.b HI             ; (~crc >> 16) ^ (~crc & $FFFF) = hi ^ lo
    EOR.b LO
    RTS
.ENDS
