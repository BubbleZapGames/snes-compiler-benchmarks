; Naive recursive Fibonacci: call and stack-frame overhead.
; Hand-written reference: n travels in X and fib(n) returns in A. Every call
; returns X unchanged and the carry clear, so a caller needs neither to save
; n across its first call nor to CLC before adding the two results.

.SECTION "fib bench"
bench_init:
    RTS

bench:
    .ACCU 16
    .INDEX 16
    LDX #16
    JSR fib
    RTS

; fib: X = n. Returns A = fib(n), X = n, C = 0.
fib:
    CPX #2              ; 3   C = (n >= 2)
    BCS +               ; 2/3
    TXA                 ; 2   fib(0) = 0, fib(1) = 1; C = 0 from the CPX
    RTS                 ; 6
+   DEX                 ; 2
    JSR fib             ; 6   A = fib(n-1), X = n-1
    PHA                 ; 4   keep fib(n-1) on the stack
    DEX                 ; 2
    JSR fib             ; 6   A = fib(n-2), X = n-2, C = 0
    ADC 1,S             ; 5   + fib(n-1); no overflow, so C stays 0
    PLY                 ; 5   drop the saved fib(n-1)
    INX                 ; 2   X = n again
    INX                 ; 2
    RTS                 ; 6
.ENDS
