"""Hand-written WLA-DX assembly: the reference column."""

import shutil

from scb import config, wla
from scb.build import Build, fresh, sh


def available(tc):
    return (config.wla_bin() / "wlalink").exists()


def version(tc):
    return {"version": "WLA-DX"}


def build(tc, src, work):
    w = fresh(work)
    shutil.copy(config.HARNESS / "asm/main.asm", w / "main.asm")
    shutil.copy(src, w / "bench.asm")
    bin_ = config.wla_bin()
    sh([bin_ / "wla-65816", "-o", "main.o", "main.asm"], w)
    (w / "link.txt").write_text("[objects]\nmain.o\n")
    log = sh([bin_ / "wlalink", "-v", "-S", "link.txt", "rom.sfc"], w)
    syms = wla.symbols(w / "rom.sym")
    return Build(w / "rom.sfc", syms["bench"], syms["done"], syms["RESULT"], wla.rom_used(log))


def listing(tc, work):
    path = work / "bench.asm"
    return path.read_text() if path.exists() else None
