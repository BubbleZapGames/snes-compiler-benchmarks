; LZ4 block decode of a 375-byte ROM block into 1024 bytes, then a byte sum of the output.
; Hand-written reference: X walks the block and Y the output as addresses, so literal
; runs and matches are both MVN copies. MVN moves one byte at a time, upward, so a
; match that overlaps its own output (offset < length) repeats bytes exactly as the
; C byte loop does. The sum adds bytes in 8-bit A and counts carries in Y.

.DEFINE LZ_N 375
.DEFINE OUT_N 1024

.RAMSECTION "lz4 dp" SLOT 2 ORGA $0000 FORCE
    TOK  dw             ; current token
    SRC  dw             ; match source address
    SAVE dw             ; block pointer across a match copy
    LEN  dw             ; scratch
.ENDS

.RAMSECTION "lz4 data" SLOT 2
    OUT dsb OUT_N
.ENDS

.SECTION "lz4 table"
LZ:
; begin data
    .db $81, $20, $21, $22, $23, $24, $50, $26, $27, $08, $00, $1A, $25, $08, $00, $1B
    .db $40, $10, $00, $02, $20, $00, $2C, $40, $51, $28, $00, $09, $38, $00, $12, $52
    .db $48, $00, $13, $40, $50, $00, $F3, $03, $36, $44, $8D, $F9, $16, $42, $45, $4E
    .db $43, $48, $4D, $41, $52, $4B, $53, $3A, $20, $00, $01, $00, $0F, $71, $00, $01
    .db $16, $50, $81, $00, $16, $41, $91, $00, $1E, $51, $69, $00, $19, $41, $B1, $00
    .db $10, $41, $B9, $00, $1B, $52, $C1, $00, $95, $A6, $76, $86, $D7, $69, $45, $92
    .db $13, $99, $7A, $00, $35, $4C, $5A, $34, $7E, $00, $05, $08, $00, $02, $F8, $00
    .db $1C, $42, $00, $01, $1F, $50, $10, $01, $01, $14, $42, $20, $01, $18, $51, $30
    .db $01, $2F, $42, $52, $10, $01, $09, $D6, $37, $4A, $A9, $83, $C6, $18, $B2, $B2
    .db $B0, $AA, $8C, $F2, $F1, $06, $01, $0F, $8C, $00, $02, $06, $95, $00, $1F, $43
    .db $5D, $01, $04, $01, $A5, $01, $11, $50, $AD, $01, $16, $51, $AD, $01, $1F, $43
    .db $8D, $01, $06, $00, $DD, $01, $18, $43, $DD, $01, $11, $52, $E5, $01, $FF, $05
    .db $EB, $D1, $4F, $C3, $08, $5F, $16, $A4, $6C, $52, $D1, $4F, $C2, $04, $4E, $C0
    .db $F9, $45, $52, $20, $A4, $01, $01, $0F, $08, $00, $08, $1F, $44, $00, $02, $05
    .db $19, $50, $48, $02, $1A, $51, $58, $02, $1A, $44, $68, $02, $1F, $52, $78, $02
    .db $03, $F8, $0A, $44, $25, $26, $27, $13, $99, $34, $3A, $5A, $FC, $25, $F3, $F6
    .db $05, $51, $CF, $41, $7F, $B4, $BA, $D9, $76, $88, $E0, $99, $CA, $01, $4F, $42
    .db $4C, $4F, $43, $A8, $00, $10, $0B, $E9, $01, $09, $E9, $02, $10, $45, $F1, $02
    .db $1F, $50, $C9, $02, $02, $4F, $51, $27, $20, $45, $84, $01, $09, $02, $31, $03
    .db $16, $52, $31, $03, $F9, $0B, $45, $37, $4B, $AE, $9E, $4D, $B8, $CF, $42, $84
    .db $CB, $2F, $23, $E8, $C0, $FA, $1C, $C6, $14, $9D, $4A, $A8, $82, $C3, $07, $5C
    .db $B2, $00, $4F, $4B, $20, $44, $45, $B6, $00, $19, $0F, $BF, $00, $00, $2F, $46
    .db $50, $80, $03, $0A, $12, $51, $C8, $03, $1F, $46, $A0, $03, $02, $18, $46, $E8
    .db $03, $50, $23, $24, $25, $26, $52
; end data
.ENDS

.SECTION "lz4 bench"
bench_init:
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDX #LZ             ; X = &lz[i]
    LDY #OUT            ; Y = &out[o]
seq:
    LDA.w $0000,X       ; 6   token (and the byte after it)
    INX                 ; 2
    AND #$00FF          ; 3
    STA.b TOK           ; 4
    CMP #$10            ; 3   no literals?
    BCC match           ; 2
    LSR A               ; 8   n = tok >> 4
    LSR A
    LSR A
    LSR A
    CMP #15             ; 3
    BNE +               ; 3
    JSR read_len        ;     n = 15 + extension bytes
+   DEC A               ; 2   MVN moves A+1 bytes
    MVN $00,$00         ; 7n  out[o..] = lz[i..]; X, Y advance by n
match:
    CPX #LZ+LZ_N        ; 3   the last sequence has no match
    BCS sum             ; 2
    TYA                 ; 2
    SEC                 ; 2
    SBC.w $0000,X       ; 6   A = &out[o - off]
    STA.b SRC           ; 4
    INX                 ; 2
    INX                 ; 2
    LDA.b TOK           ; 4
    AND #$000F          ; 3   n = match length - 4
    CMP #15             ; 3
    BNE +               ; 3   C = 0
    JSR read_len        ;     n = 15 + extension bytes, C = 0
+   ADC #3              ; 3   MVN moves A+1 = n+4 bytes
    STX.b SAVE          ; 4
    LDX.b SRC           ; 4
    MVN $00,$00         ; 7n  out[o..] = out[o-off..], byte by byte, upward
    LDX.b SAVE          ; 4
    BRA seq             ; 3

; Extended length: A = 15, X -> the length bytes. Adds bytes up to and
; including the first one that is not 255. Returns A = n, X past them, C = 0.
read_len:
-   STA.b LEN           ; n so far
    LDA.w $0000,X       ; b
    INX
    AND #$00FF
    CMP #255
    BNE +
    LDA.b LEN           ; b = 255: n += 255 (C = 1 from the CMP)
    ADC #254
    BRA -
+   ADC.b LEN           ; C = 0 from the CMP: n += b
    RTS

sum:                    ; Y = &out[o]
    TYA
    SEC
    SBC #OUT
    TAX                 ; X = o
    LDY #0              ; Y = high byte of s (the carries)
    LSR A               ; C = o odd
    SEP #$20
    .ACCU 8
    LDA #0              ; A = low byte of s
    BCC +
    LDA.w OUT-1,X       ; odd o: take the last byte first
    DEX
+   CPX #0
    BEQ total
    CLC
pair:                   ; two bytes per pass, downward
    ADC.w OUT-1,X       ; 5
    BCS carry1          ; 2
add2:
    ADC.w OUT-2,X       ; 5
    BCS carry2          ; 2
next:
    DEX                 ; 2
    DEX                 ; 2
    BNE pair            ; 3
total:
    STA.b LEN           ; s = Y:A
    TYA
    XBA
    LDA.b LEN
    REP #$20
    .ACCU 16
    RTS

    .ACCU 8
carry1:
    INY
    CLC
    BRA add2
carry2:
    INY
    CLC
    BRA next
.ENDS
