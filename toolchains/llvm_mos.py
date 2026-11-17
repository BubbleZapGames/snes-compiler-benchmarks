"""llvm-mos (github.com/llvm-mos/llvm-mos), from the llvm-mos SDK.

llvm-mos emits 6502-family code (its w65816 CPU adds instructions, not the
16-bit modes), so it runs in emulation mode, like cc65. harness/llvm-mos holds
a LoROM linker script and reset stub, after the SDK's eater platform.

The SDK links with LTO by default. Only bench.c is compiled with LTO, so
bench() stays a call from a separate unit like on every other toolchain.
"""

import re
import shutil
import subprocess

from scb import config
from scb.build import Build, fresh, sh

HARNESS_FUNCS = {"main", "done", "_start", "snes_reset", "snes_rti"}


def home(tc):
    return config.setting("llvm_mos", "LLVM_MOS",
                          config.toolchains_dir() / f"llvm-mos-{tc.version}" / "llvm-mos")


def available(tc):
    return (home(tc) / "bin/clang").exists()


def version(tc):
    out = sh([home(tc) / "bin/clang", "--version"], config.ROOT)
    m = re.search(r"llvm-mos ([0-9a-f]{7,})", out) or re.search(r"llvm-mos/llvm-mos ([0-9a-f]+)", out)
    return {"version": tc.version, "commit": m.group(1)[:8] if m else None}


def _cc(tc):
    return [home(tc) / "bin/clang", "--config", "mos-common.cfg", *tc.flags]


def build(tc, src, work):
    w = fresh(work)
    for f in ("main.c", "done.c", "bench.h"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    cc = _cc(tc)
    sh([*cc, "-c", "bench.c", "-o", "bench.o"], w)
    for name in ("main", "done"):
        sh([*cc, "-fno-lto", "-c", f"{name}.c", "-o", f"{name}.o"], w)
    sh([*cc, "-c", config.HARNESS / "llvm-mos/snes.s", "-o", "snes.o"], w)
    sh([*cc, "-T", config.HARNESS / "llvm-mos/snes.ld", "main.o", "bench.o", "done.o",
        "snes.o", "-o", "rom.sfc", "-Wl,-Map,map.txt"], w)
    nm = sh([home(tc) / "bin/llvm-nm", "rom.sfc.elf"], w)
    syms = {}
    for line in nm.splitlines():
        parts = line.split()
        if len(parts) == 3:
            syms[parts[2]] = int(parts[0], 16)
    # ROM bytes: every output section whose load address is in the ROM
    used = 0
    for m in re.finditer(r"^\s+([0-9a-f]+)\s+([0-9a-f]+)\s+([0-9a-f]+)\s+\d+ \.\S+$",
                         (w / "map.txt").read_text(), re.M):
        lma, size = int(m.group(2), 16), int(m.group(3), 16)
        if 0x8000 <= lma < 0x10000:
            used += size
    return Build(w / "rom.sfc", syms["bench"], syms["done"], syms["result"], used)


def listing(tc, work):
    """The linked code of bench's unit (after LTO), disassembled."""
    elf = work / "rom.sfc.elf"
    if not elf.exists():
        return None
    out = subprocess.run([str(home(tc) / "bin/llvm-objdump"), "-d", "--no-show-raw-insn",
                          "--print-imm-hex", str(elf)], capture_output=True, text=True).stdout
    blocks, keep = [], False
    for line in out.splitlines():
        m = re.match(r"^[0-9a-f]+ <(.+)>:$", line)
        if m:
            name = m.group(1)
            keep = name not in HARNESS_FUNCS and not name.startswith("__")
            if keep:
                blocks.append(f"{name}:")
            continue
        if keep and line.strip():
            blocks.append(re.sub(r"^\s*[0-9a-f]+:\s*", "\t", line))
        elif keep:
            blocks.append("")
    return "\n".join(blocks).strip() + "\n"
