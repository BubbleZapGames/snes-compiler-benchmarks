; SNES LoROM startup, header and vectors for the WDC816CC small model,
; after STARTUP.ASM in WDC's Assembler/Linker manual. The linker places CODE
; at $8000, DATA in RAM at $1800 (image after the code), UDATA at $0200.

        CHIP    65816
        XREF    __main
        XREF    _ROM_BEG_DATA
        XREF    _BEG_DATA
        XREF    _END_DATA
        XREF    _BEG_UDATA
        XREF    _END_UDATA

        CODE
START:
        SEI
        CLC
        XCE                     ; native mode
        REP     #$30
        LONGA   ON
        LONGI   ON
        LDA     #$1FFF
        TCS                     ; stack at the top of low RAM
        LDA     #$0000
        TCD
        SEP     #$20
        LONGA   OFF
        LDA     #^_BEG_DATA
        PHA
        PLB                     ; DBR = bank of DATA ($00)
        REP     #$20
        LONGA   ON
        LDA     #_END_DATA-_BEG_DATA
        BEQ     ?SKIP
        DEC     A
        LDX     #<_ROM_BEG_DATA
        LDY     #<_BEG_DATA
        MVN     #^_ROM_BEG_DATA,#^_BEG_DATA
?SKIP:
        LDX     #_END_UDATA-_BEG_UDATA
        BEQ     ?DONE
        LDA     #0
        SEP     #$20
        LONGA   OFF
        LDY     #_BEG_UDATA
?LOOP:
        STA     |0,Y
        INY
        DEX
        BNE     ?LOOP
        REP     #$20
        LONGA   ON
?DONE:
        JSR     __main
?HANG:
        BRA     ?HANG
EMPTY:
        RTI
        ENDS

HEADER  SECTION OFFSET $FFC0
        DB      'SCB WDC              '   ; 21-byte title
        DB      $20                       ; LoROM, SlowROM
        DB      $00                       ; ROM only
        DB      $05                       ; 32 KB
        DB      $00                       ; no SRAM
        DB      $01                       ; North America
        DB      $00                       ; licensee
        DB      $00                       ; version
        DW      $FFFF,$0000               ; checksum complement, checksum
        ; native: unused, unused, COP, BRK, ABORT, NMI, unused, IRQ
        DW      0,0,EMPTY,EMPTY,EMPTY,EMPTY,0,EMPTY
        ; emulation: unused, unused, COP, unused, ABORT, NMI, RESET, IRQ/BRK
        DW      0,0,EMPTY,0,EMPTY,EMPTY,START,EMPTY
        ENDS
        END
