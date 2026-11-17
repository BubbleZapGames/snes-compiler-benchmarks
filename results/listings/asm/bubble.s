; Bubble sort 64 bytes, then fold them into a checksum.
; Hand-written reference: 8-bit A and X with ARR on the direct page. A carries
; arr[j] from one compare to the next, so a step that does not swap costs one
; load, and a swap leaves the larger value in A to keep bubbling.

.RAMSECTION "bubble data" SLOT 2 ORGA $0000 FORCE
    ARR   dsb 64
    LIMIT db                ; 63 - i: compares in this pass
.ENDS

.RAMSECTION "bubble vars" SLOT 2
    V     dw                ; LCG state, bench_init only
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
    XBA                     ; arr[i] = v >> 8
    SEP #$20
    .ACCU 8
    STA.w ARR,X
    REP #$20
    .ACCU 16
    INX
    CPX #64
    BNE -
    RTS

bench:
    .ACCU 16
    .INDEX 16
    SEP #$30
    .ACCU 8
    .INDEX 8
    LDA #63
    STA.b LIMIT
pass:
    LDX #0                  ; j
    LDA.b ARR               ; A = arr[0]
cmp:
    CMP.b ARR+1,X           ; 4  arr[j] vs arr[j+1]
    BCC less                ; 2
    BEQ step                ; 2  equal: nothing to do, A = arr[j+1]
    LDY.b ARR+1,X           ; 4  swap: the smaller one moves down
    STY.b ARR,X             ; 4
    STA.b ARR+1,X           ; 4  and A keeps the larger
step:
    INX                     ; 2
    CPX.b LIMIT             ; 3
    BNE cmp                 ; 3  => 28 cycles with a swap
    BRA endpass
less:
    LDA.b ARR+1,X           ; 4  no swap: carry arr[j+1] on
    INX                     ; 2
    CPX.b LIMIT             ; 3
    BNE cmp                 ; 3  => 19 cycles without
endpass:
    DEC.b LIMIT
    BNE pass

    REP #$20                ; s = (s << 1) ^ arr[i]
    .ACCU 16
    LDA #0
    LDX #0
-   ASL A                   ; 2  16-bit shift
    SEP #$20                ; 3
    .ACCU 8
    EOR.b ARR,X             ; 4  the byte only touches the low half
    REP #$20                ; 3
    .ACCU 16
    INX                     ; 2
    CPX #64                 ; 2
    BNE -                   ; 3
    REP #$10
    .INDEX 16
    RTS
.ENDS
