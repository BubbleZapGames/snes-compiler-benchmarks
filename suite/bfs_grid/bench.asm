; Breadth-first search over a 32x32 tile map, as in enemy pathfinding: a
; distance map from one start cell, with a 256-entry ring-buffer queue.
; Returns the sum of distances over the cells reached.
;
; Hand-written reference. visit() is expanded in place four times. With the
; cell c in X, a neighbour is GRID+k,X and DIST+k,X for k = -32, -1, 1, 32,
; so no neighbour index is computed unless the cell is queued. The tests run
; with an 8-bit accumulator, the queue tail lives in Y as a byte offset, and
; head, s and d live in the direct page. The arrays start at $0100, not
; $0000, so GRID-32 does not wrap below the bank.

.RAMSECTION "bfs dp" SLOT 2 ORGA $0000 FORCE
    HEAD dw                 ; queue head, a byte offset
    S    dw                 ; sum of distances (v in bench_init)
    D    db                 ; distance of the cells being queued
.ENDS

.RAMSECTION "bfs arrays" SLOT 2 ORGA $0100 FORCE
    GRID  dsb 1024          ; 0 = floor, 1 = wall; the border is wall
    DIST  dsb 1024          ; $FF = not reached
    QUEUE dsw 256
    START dw
.ENDS

; Visit neighbour c+\1 of the cell c in X. A 8-bit; Y = tail byte offset.
.MACRO VISIT
    LDA.w GRID+(\1),X       ; wall?
    BNE +
    LDA.w DIST+(\1),X
    INC A                   ; $FF + 1 = 0: not reached yet
    BNE +
    LDA.b D
    STA.w DIST+(\1),X       ; dist[n] = d
    REP #$21                ; A 16-bit, C = 0
    .ACCU 16
    TXA
    ADC #(\1)&$FFFF         ; n = c + k
    STA.w QUEUE,Y           ; queue[tail] = n
    SEP #$20
    .ACCU 8
    INY                     ; tail = (tail + 1) & 255
    INY
    CPY #512
    BNE +
    LDY #0
+
.ENDM

.SECTION "bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDA #1
    STA.b S                 ; v = 1
    LDX #0
-   LDA.b S                 ; v = v * 5 + $3619
    ASL A
    ASL A
    CLC
    ADC.b S
    CLC
    ADC #$3619
    STA.b S
    XBA
    AND #$0003              ; (v >> 8) & 3 == 0: wall
    BEQ wall
    TXA
    AND #$001F              ; x == 0 or x == 31: wall
    BEQ wall
    CMP #$001F
    BEQ wall
    CPX #32                 ; y == 0: wall
    BCC wall
    CPX #1024-32            ; y == 31: wall
    BCS wall
    LDA #0
    BRA +
wall:
    LDA #1
+   SEP #$20
    .ACCU 8
    STA.w GRID,X
    REP #$20
    .ACCU 16
    INX
    CPX #1024
    BNE -
    LDA #33
    STA.w START
    TAX
    SEP #$20
    .ACCU 8
    STZ.w GRID,X            ; the start is floor
    REP #$20
    .ACCU 16
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDX #1024-32            ; dist[0..1023] = $FF, 32 bytes a pass
-   LDA #$FFFF
    STA.w DIST+0,X
    STA.w DIST+2,X
    STA.w DIST+4,X
    STA.w DIST+6,X
    STA.w DIST+8,X
    STA.w DIST+10,X
    STA.w DIST+12,X
    STA.w DIST+14,X
    STA.w DIST+16,X
    STA.w DIST+18,X
    STA.w DIST+20,X
    STA.w DIST+22,X
    STA.w DIST+24,X
    STA.w DIST+26,X
    STA.w DIST+28,X
    STA.w DIST+30,X
    TXA
    SEC
    SBC #32
    TAX
    BPL -

    LDX.w START
    TXA
    STA.w QUEUE             ; queue[0] = start
    STZ.b HEAD
    STZ.b S
    LDY #2                  ; tail = 1
    SEP #$20
    .ACCU 8
    STZ.w DIST,X            ; dist[start] = 0

loop:                       ; A 8-bit; the queue is not empty
    LDX.b HEAD
    REP #$20
    .ACCU 16
    LDA.w QUEUE,X           ; c = queue[head]
    INX                     ; head = (head + 1) & 255
    INX
    CPX #512
    BNE +
    LDX #0
+   STX.b HEAD
    TAX
    SEP #$21                ; A 8-bit, C = 1
    .ACCU 8
    LDA.w DIST,X            ; d = dist[c] + 1 (no carry: a queued cell has dist < 255)
    ADC #0
    STA.b D
    DEC A                   ; s += dist[c] (C = 0 from the ADC)
    ADC.b S
    STA.b S
    BCC +
    INC.b S+1
+   VISIT -32
    VISIT -1
    VISIT 1
    VISIT 32
    CPY.b HEAD              ; head == tail: done
    BEQ finished
    JMP loop

finished:
    REP #$20
    .ACCU 16
    LDA.b S
    RTS
.ENDS
