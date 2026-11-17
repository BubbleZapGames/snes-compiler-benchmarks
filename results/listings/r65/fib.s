bench_init:
    .ACCU 8
    .INDEX 16
NOP
    RTS

; ----------------------------------------------------------------------------
; fib
; Source: build/r65/fib/bench.r65:7
;   included from main.r65:13
; 
; Parameters:
;   n: u16
; 
; Returns: u16
; 
; ----------------------------------------------------------------------------
bench:
    .ACCU 8
    .INDEX 16
    PEA $10  ; Push u16 immediate
    JSR fib
    .ACCU 16
    PLX  ; Pop pushed arg bytes
    RTS

; ----------------------------------------------------------------------------
; done
; Source: main.r65:18
; 
; ----------------------------------------------------------------------------
