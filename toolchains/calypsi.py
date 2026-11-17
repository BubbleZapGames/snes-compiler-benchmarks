"""Calypsi 65816 (calypsi.cc), small code and data models, SNES runtime library.

The linker writes Intel hex. The adapter turns that into a 32 KB LoROM
image and reads symbols and section sizes from the linker's list file.
"""

import re
import shutil

from scb import config
from scb.build import Build, BuildError, fresh, sh


def home(tc):
    pin = f"calypsi-65816-{tc.version}"
    return config.setting("calypsi", "CALYPSI",
                          config.toolchains_dir() / pin / "usr/local/lib" / pin)


def available(tc):
    return (home(tc) / "bin/cc65816").exists()


def version(tc):
    out = sh([home(tc) / "bin/cc65816", "--version"], config.ROOT)
    m = re.search(r"version (\S+)", out)
    return {"version": m.group(1) if m else tc.version}


def _library(tc):
    """clib-<code model>c-<data model>d-snes.a, e.g. clib-sc-sd-snes.a."""
    flags = tc.flags
    code = flags[flags.index("--code-model") + 1][0] if "--code-model" in flags else "s"
    data = flags[flags.index("--data-model") + 1][0] if "--data-model" in flags else "s"
    suffix = "-snes-noppu" if "--no-ppu-mul" in flags else "-snes"
    return home(tc) / "lib" / f"clib-{code}c-{data}d{suffix}.a"


def build(tc, src, work):
    w = fresh(work)
    for f in ("main.c", "done.c"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    bin_ = home(tc) / "bin"
    objs = []
    for name in ("main", "bench", "done"):
        sh([bin_ / "cc65816", *tc.flags, f"{name}.c", "-o", f"{name}.o",
            "--list-file", f"{name}.lst"], w)
        objs.append(f"{name}.o")
    sh([bin_ / "as65816", config.HARNESS / "calypsi/snes.s", "-o", "snes.o"], w)
    sh([bin_ / "ln65816", "--target", "SNES", *objs, "snes.o",
        config.HARNESS / "calypsi/snes.scm", _library(tc), "-o", "rom.elf",
        "--output-format", "intel-hex", "--rtattr", "exit=simplified",
        "--list-file", "rom.lst", "--cross-reference"], w)
    (w / "rom.sfc").write_bytes(hex_to_lorom(w / "rom.hex"))
    lst = (w / "rom.lst").read_text(errors="replace")
    syms = {m.group(1): int(m.group(2), 16)
            for m in re.finditer(r"^\s+(\w+) = ([0-9a-fA-F]{6})\s*$", lst, re.M)}
    summary = lst.split("Sections summary")[1].split("Placement rules")[0]
    used = sum(int(m.group(1), 16) for m in re.finditer(
        r"^\w+\s+[0-9a-f]{6}-[0-9a-f]{6}\s+([0-9a-f]{6})\s+ROM\s", summary, re.M))
    return Build(w / "rom.sfc", syms["bench"], syms["done"], syms["result"], used)


def hex_to_lorom(path, size=0x8000):
    """Intel hex (bank $00 $8000-$FFFF) to a LoROM image."""
    rom = bytearray(size)
    upper = 0
    for line in path.read_text().splitlines():
        if not line.startswith(":"):
            continue
        raw = bytes.fromhex(line[1:].strip())
        count, addr, kind, data = raw[0], (raw[1] << 8) | raw[2], raw[3], raw[4:4 + raw[0]]
        if kind == 4:
            upper = (data[0] << 8) | data[1]
        elif kind == 0:
            full = (upper << 16) | addr
            if not (0x8000 <= full and full + count <= 0x10000):
                raise BuildError(f"hex record outside bank $00 ROM: ${full:06X}")
            rom[full - 0x8000:full - 0x8000 + count] = data
    return bytes(rom)


def listing(tc, work):
    path = work / "bench.lst"
    return path.read_text(errors="replace") if path.exists() else None
