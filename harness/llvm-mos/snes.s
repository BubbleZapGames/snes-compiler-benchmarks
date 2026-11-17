; Reset into llvm-mos's _start in emulation mode: interrupts off, binary
; mode, hardware stack at the top of page 1.
.section .text.snes_reset,"ax",@progbits
.globl snes_reset
snes_reset:
  sei
  cld
  ldx #$ff
  txs
  jmp _start

.section .text.snes_rti,"ax",@progbits
.globl snes_rti
snes_rti:
  rti
