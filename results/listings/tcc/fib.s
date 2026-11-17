.include "hdr.asm"
.accu 16
.index 16
.16bit
.define __fib_locals 2

.SECTION ".bench_inittext_0x0" SUPERFREE

.define __bench_init_ret 0
bench_init:
rtl
.ENDS

.SECTION ".fibtext_0x1" SUPERFREE

.define __fib_ret 1
fib:
.ifgr __fib_locals 0
tsa
sec
sbc #__fib_locals
tas
.endif
lda 3 + __fib_locals + 1,s
cmp.w #2
bcs __local_0
sta.b tcc__r0
bra __local_1
__local_0:
sta.b tcc__r0
dec.b tcc__r0
pei (tcc__r0)
jsr.l fib
pla
lda 3 + __fib_locals + 1,s
sta.b tcc__r1
dec.b tcc__r1
dec.b tcc__r1
pei (tcc__r1)
lda.b tcc__r0
sta 0 + __fib_locals + 1,s
jsr.l fib
pla
lda -2 + __fib_locals + 1,s
clc
adc.b tcc__r0
sta.b tcc__r0
__local_1:
__local_2:
.ifgr __fib_locals 0
tsa
clc
adc #__fib_locals
tas
.endif
rtl
.ENDS

.SECTION ".benchtext_0x2" SUPERFREE

.define __bench_ret 1
bench:
pea.w 16
jsr.l fib
pla
__local_3:
rtl
.ENDS
.RAMSECTION "ram{WLA_FILENAME}.data" APPENDTO "globram.data"

.ENDS

.SECTION "{WLA_FILENAME}.data" APPENDTO "glob.data"

.ENDS

.SECTION ".rodata" SUPERFREE

.ENDS

.RAMSECTION ".bss" BANK $7e SLOT 2
.ENDS
