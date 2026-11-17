; Bitwise CRC-16/CCITT-FALSE over 256 bytes.
; Hand-written reference: the CRC lives in 16-bit A and the shift-and-xor
; steps are unrolled. Bytes are folded in two at a time: buf[i+1] lands in the
; low half, which no step reads until the eight steps for buf[i] have moved it
; up, so it is the same 2048 steps as the byte loop. X is 8-bit and wraps.

.RAMSECTION "crc16 data" SLOT 2 ALIGN 256   ; so BUF,X never crosses a page
    BUF dsb 256
    V   dw                  ; LCG state, bench_init only
.ENDS

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #1
    STA.w V
    LDX #0
-   LDA.w V                 ; v = v*5 + $3619
    ASL A
    ASL A
    CLC
    ADC.w V
    CLC
    ADC #$3619
    STA.w V
    XBA                     ; buf[i] = v >> 8
    SEP #$20
    .ACCU 8
    STA.w BUF,X
    REP #$20
    .ACCU 16
    INX
    CPX #256
    BNE -
    RTS

; One CRC step: shift left, and xor in the polynomial if bit 15 fell out.
; 5 cycles when it did not, 7 when it did.
.MACRO CRC_BIT
    ASL A
    BCC +
    EOR #$1021
+
.ENDM

bench:
    .ACCU 16
    .INDEX 16
    SEP #$10
    .INDEX 8
    LDA #$FFFF              ; crc
    LDX #0                  ; i
-   XBA                     ; 3  crc ^= buf[i] << 8 | buf[i+1]
    EOR.w BUF,X             ; 5
    XBA                     ; 3
    CRC_BIT                 ; buf[i]
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT                 ; buf[i+1]
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    CRC_BIT
    INX                     ; 2
    INX                     ; 2
    BNE -                   ; 3  128 pairs
    REP #$10
    .INDEX 16
    RTS
.ENDS
