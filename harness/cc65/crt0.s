; cc65 startup for a SNES LoROM. cc65 emits 6502 code, so the CPU stays in
; emulation mode (8-bit registers, stack in page 1, DBR = D = 0) and
; absolute addresses reach low RAM, the I/O registers and bank-0 ROM.

        .export         _exit
        .export         __STARTUP__ : absolute = 1
        .import         zerobss, copydata, _main
        .import         __STACKSTART__

        .include        "zeropage.inc"

        .segment        "STARTUP"

reset:  sei
        cld
        ldx     #$FF
        txs
        lda     #<__STACKSTART__
        ldx     #>__STACKSTART__
        sta     c_sp
        stx     c_sp+1
        jsr     zerobss
        jsr     copydata
        jsr     _main
_exit:  jmp     _exit

nmi:
irq:    rti

        .segment        "HEADER"
        .byte   "R65 BENCH CC65       "         ; 21-byte title
        .byte   $20                             ; LoROM, SlowROM
        .byte   $00                             ; ROM only
        .byte   $05                             ; 32 KB
        .byte   $00                             ; no SRAM
        .byte   $01                             ; North America
        .byte   $00                             ; licensee
        .byte   $00                             ; version
        .word   $FFFF, $0000                    ; checksum complement, checksum

        .segment        "VECTORS"
        ; native mode (unused: the CPU never leaves emulation mode)
        .word   0, 0, irq, irq, irq, nmi, 0, irq
        ; emulation mode
        .word   0, 0, irq, 0, irq, nmi, reset, irq
