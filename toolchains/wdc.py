"""WDCTools WDC816CC (wdc65xx.com/WDCTools), run under Wine.

Small memory model (-MS). The compiler runs its own post-pass optimizer
(WDC816OP) under -SOP, then the assembler. harness/wdc/snes.asm provides
the startup code, header and vectors, after STARTUP.ASM in WDC's manual.
"""

import os
import re
import shutil
from pathlib import Path

from scb import config
from scb.build import Build, fresh, sh
from toolchains.calypsi import hex_to_lorom


def home(tc):
    return config.setting("wdc_tools", "WDC_TOOLS", Path.home() / ".wine/drive_c/wdc/Tools")


def available(tc):
    return (home(tc) / "bin/WDC816CC.exe").exists() and shutil.which("wine") is not None


def version(tc):
    return {"version": tc.version}


def _run(tc, tool, args, cwd):
    env = dict(os.environ, WINEDEBUG="-all", WDC_LIB=_winpath(home(tc) / "lib"),
               WDC_INC_65816=_winpath(home(tc) / "include"))
    return sh(["wine", home(tc) / "bin" / tool, *args], cwd, env, timeout=180)


def _winpath(path):
    """Wine maps the Unix root to Z:."""
    return "Z:" + str(path).replace("/", "\\")


def build(tc, src, work):
    w = fresh(work)
    for f in ("main.c", "done.c"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    shutil.copy(config.HARNESS / "wdc/snes.asm", w / "snes.asm")
    for name in ("main", "bench", "done"):
        _run(tc, "WDC816CC.exe", [*tc.flags, f"{name}.c"], w)
    # the same compile, stopped at the (optimised) assembly, for the listing
    shutil.copy(w / "bench.c", w / "listing.c")
    _run(tc, "WDC816CC.exe", [*tc.flags, "-A", "listing.c"], w)
    _run(tc, "WDC816AS.exe", ["snes.asm"], w)
    log = _run(tc, "WDCLN.exe", ["-HI", "-T", "-C8000", "-D1800,", "-U0200",
                                 "snes.obj", "main.obj", "bench.obj", "done.obj",
                                 f"-L{tc.opts.get('library', 'CS')}", "-Orom.hex"], w)
    (w / "rom.sfc").write_bytes(hex_to_lorom(w / "rom.hex"))
    syms = {m.group(2): int(m.group(1), 16) for m in re.finditer(
        r"^\s+([0-9a-fA-F]{8}) (\S+)$", (w / "rom.map").read_text(errors="replace"), re.M)}
    used = 0
    for m in re.finditer(r"^(\w+)\s+([0-9A-F]{6})\s+([0-9A-F]{6}|-+)\s+([0-9A-F]+)H",
                         log, re.M):
        if m.group(3).startswith("-") or m.group(1).lower() == "header":
            continue
        used += int(m.group(4), 16)
    return Build(w / "rom.sfc", syms["__bench"], syms["__done"], syms["__result"], used)


def listing(tc, work):
    path = work / "listing.asm"
    return path.read_text(errors="replace") if path.exists() else None
