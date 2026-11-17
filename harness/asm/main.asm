; Driver for hand-written assembly benchmarks (WLA-DX 65816), the same
; shape as harness/c/main.c.
;
; bench.asm defines bench_init and bench in SECTIONs of its own. Both are
; called with JSR in native mode with A, X and Y 16-bit, D = $0000 and
; DBR = $00. Both return with RTS. bench returns its u16 result in A, with
; A 16-bit. Either may clobber any register and any RAM below $1F00. Its
; own variables go in RAMSECTIONs in slot 2 (low RAM, $0000-$1EFF).

.65816

.MEMORYMAP
    DEFAULTSLOT 0
    SLOTSIZE $8000
    SLOT 0 $8000
    SLOT 1 $2000 SIZE $E000     ; WRAM bank $7E ($2000-$FFFF)
    SLOT 2 $0000 SIZE $2000     ; low RAM, visible from bank $00
.ENDME

.ROMBANKMAP
    BANKSTOTAL 8
    BANKSIZE $8000
    BANKS 8
.ENDRO

.RAMSECTION "harness" SLOT 2 FORCE ORGA $1F00
    RESULT dsw 1
.ENDS

.BANK 0 SLOT 0
.ORG 0

.SECTION "driver" FORCE
reset:
    SEI
    CLC
    XCE
    REP #$30
    .ACCU 16
    .INDEX 16
    LDA #$1EFF
    TCS
    LDA #$0000
    TCD
    SEP #$20
    .ACCU 8
    PHA
    PLB                         ; DBR = $00
    STZ $4200                   ; NMITIMEN = 0: no NMI or timer IRQ
    REP #$30
    .ACCU 16
    JSR bench_init
    REP #$30
    JSR bench
    .ACCU 16
    STA.W RESULT
    JSR done
forever:
    BRA forever

done:
    NOP
    RTS

empty_handler:
    RTI
.ENDS

.INCLUDE "bench.asm"

.SNESHEADER
    ID "SNES"
    NAME "SCB ASM              "
    LOROM
    SLOWROM
    CARTRIDGETYPE $00
    ROMSIZE $08
    SRAMSIZE $00
    COUNTRY $01
    LICENSEECODE $00
    VERSION $00
.ENDSNES

.SNESNATIVEVECTOR
    COP empty_handler
    BRK empty_handler
    ABORT empty_handler
    NMI empty_handler
    IRQ empty_handler
.ENDNATIVEVECTOR

.SNESEMUVECTOR
    COP empty_handler
    ABORT empty_handler
    NMI empty_handler
    RESET reset
    IRQBRK empty_handler
.ENDEMUVECTOR
