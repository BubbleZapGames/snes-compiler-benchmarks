;;; SNES LoROM header and vectors for the Calypsi build. cstartup.o supplies the
;;; emulation-mode reset vector ($FFFC) and switches to native mode itself.

              .section snes_header, root
              .ascii  "SCB CALYPSI          "  ; 21-byte title
              .byte   0x20                     ; LoROM, SlowROM
              .byte   0x00                     ; ROM only
              .byte   0x05                     ; 32 KB
              .byte   0x00                     ; no SRAM
              .byte   0x01                     ; North America
              .byte   0x00                     ; licensee
              .byte   0x00                     ; version
              .word   0xffff, 0x0000           ; checksum complement, checksum

              .section snes_vectors, root
              ; native: unused, unused, COP, BRK, ABORT, NMI, unused, IRQ
              .word   0, 0, empty_handler, empty_handler, empty_handler, empty_handler, 0, empty_handler
              ; emulation: unused, unused, COP, unused, ABORT, NMI
              .word   0, 0, empty_handler, 0, empty_handler, empty_handler

              .section snes_irq, root
              .word   empty_handler              ; emulation IRQ/BRK

              .section code
empty_handler:
              rti
