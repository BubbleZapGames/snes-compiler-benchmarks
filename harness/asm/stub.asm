; Empty benchmark: the size baseline.
.SECTION "bench"
bench_init:
    RTS

bench:
    .ACCU 16
    LDA #$0000
    RTS
.ENDS
