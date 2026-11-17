/* llvm-mos linker script for a 32 KB SNES LoROM, after the SDK's eater
 * platform. The CPU stays in emulation mode (llvm-mos emits 6502-family code):
 * zero page holds the imaginary registers, page 1 the hardware stack, and
 * the soft stack grows down from $1F00. */

__rc0 = 0xe0;
INCLUDE imag-regs.ld
ASSERT(__rc31 == 0xff, "Inconsistent zero page map.")

MEMORY {
  zp  : ORIGIN = 0x00,   LENGTH = 0xe0
  ram : ORIGIN = 0x200,  LENGTH = 0x1f00 - 0x200
  rom : ORIGIN = 0x8000, LENGTH = 0x7fc0
}

REGION_ALIAS("c_readonly", rom)
REGION_ALIAS("c_writeable", ram)

SECTIONS { INCLUDE c.ld }

__stack = 0x1f00;

/* rom, then the SNES header ($FFC0) and the vectors ($FFE0). */
OUTPUT_FORMAT {
  FULL(rom)
  /* "SCB LLVM-MOS         " (21 bytes) */
  BYTE(0x53) BYTE(0x43) BYTE(0x42) BYTE(0x20) BYTE(0x4c) BYTE(0x4c) BYTE(0x56)
  BYTE(0x4d) BYTE(0x2d) BYTE(0x4d) BYTE(0x4f) BYTE(0x53) BYTE(0x20) BYTE(0x20)
  BYTE(0x20) BYTE(0x20) BYTE(0x20) BYTE(0x20) BYTE(0x20) BYTE(0x20) BYTE(0x20)
  BYTE(0x20)            /* LoROM, SlowROM */
  BYTE(0x00)            /* ROM only */
  BYTE(0x05)            /* 32 KB */
  BYTE(0x00)            /* no SRAM */
  BYTE(0x01)            /* North America */
  BYTE(0x00)            /* licensee */
  BYTE(0x00)            /* version */
  SHORT(0xffff) SHORT(0x0000)
  /* native: unused, unused, COP, BRK, ABORT, NMI, unused, IRQ */
  SHORT(0) SHORT(0) SHORT(snes_rti) SHORT(snes_rti) SHORT(snes_rti) SHORT(snes_rti) SHORT(0) SHORT(snes_rti)
  /* emulation: unused, unused, COP, unused, ABORT, NMI, RESET, IRQ/BRK */
  SHORT(0) SHORT(0) SHORT(snes_rti) SHORT(0) SHORT(snes_rti) SHORT(snes_rti) SHORT(snes_reset) SHORT(snes_rti)
}
