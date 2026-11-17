; 16 frames of moving and bouncing 32 entities: an array of 9-byte structs.
; Hand-written reference: the direct page register walks the array, so each
; field is a direct-page operand of the current entity, and the carry is
; known clear at every add, so no CLC is needed in the frame loop.

.DEFINE N 32
.DEFINE ESIZE 9

.ENUM 0                 ; struct entity
    E_X     dw
    E_Y     dw
    E_VX    dw
    E_VY    dw
    E_ALIVE db
.ENDE

.RAMSECTION "entities data" SLOT 2
    ENTS   dsb N*ESIZE
    FRAMES dw
    TMP    dw           ; bench_init only
.ENDS

.SECTION "entities bench"
bench_init:
    .ACCU 16
    .INDEX 16
    LDX #0              ; X = i*9
    LDY #0              ; Y = i
-   STY.w TMP
    TYA                 ; x = (i << 3) - i
    ASL A
    ASL A
    ASL A
    SEC
    SBC.w TMP
    STA.w ENTS+E_X,X
    TYA                 ; y = (i << 2) + i
    ASL A
    ASL A
    CLC
    ADC.w TMP
    STA.w ENTS+E_Y,X
    TYA                 ; vx = (i & 3) + 1
    AND #3
    INC A
    STA.w ENTS+E_VX,X
    TYA                 ; vy = (i & 1) + 2
    AND #1
    INC A
    INC A
    STA.w ENTS+E_VY,X
    TYA                 ; alive = (i & 3) != 0
    AND #3
    BEQ +
    LDA #1
+   SEP #$20
    .ACCU 8
    STA.w ENTS+E_ALIVE,X
    REP #$20
    .ACCU 16
    TXA
    CLC
    ADC #ESIZE
    TAX
    INY
    CPY #N
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    SEP #$10            ; 8-bit X/Y: Y counts entities, X tests alive
    .INDEX 8
    LDA #16
    STA.w FRAMES
frame:
    LDA #ENTS
    TCD                 ; D = &ents[0]
    LDY #N
    CLC
ent:                    ; C = 0 here on every path
    LDX.b E_ALIVE       ; 4
    BEQ next            ; 2/3
    LDA.b E_X           ; 5   x += vx
    ADC.b E_VX          ; 5
    STA.b E_X           ; 5
    CMP #241            ; 3   x > 240?
    BCS bounce_x        ; 2
move_y:                 ; C = 0
    LDA.b E_Y           ; 5   y += vy
    ADC.b E_VY          ; 5
    STA.b E_Y           ; 5
    CMP #201            ; 3   y > 200?
    BCS bounce_y        ; 2
next:                   ; C = 0
    TDC                 ; 2   D = &ents[i+1]
    ADC #ESIZE          ; 3
    TCD                 ; 2
    DEY                 ; 2
    BNE ent             ; 3
    DEC.w FRAMES
    BNE frame
    BRA sum

bounce_x:               ; C = 1 from the CMP
    LDA #0              ; vx = 0 - vx
    SBC.b E_VX
    STA.b E_VX
    CLC
    BRA move_y
bounce_y:               ; C = 1 from the CMP
    LDA #0              ; vy = 0 - vy
    SBC.b E_VY
    STA.b E_VY
    CLC
    BRA next

sum:
    REP #$10
    .INDEX 16
    LDA #0
    TCD                 ; D = $0000 again
    TAY                 ; Y = s
    LDX #(N-1)*ESIZE
-   TYA                 ; s += x + y
    CLC
    ADC.w ENTS+E_X,X
    CLC
    ADC.w ENTS+E_Y,X
    TAY
    TXA
    SEC
    SBC #ESIZE
    TAX
    BPL -
    TYA
    RTS
.ENDS
