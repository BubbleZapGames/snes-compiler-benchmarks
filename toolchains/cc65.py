"""cc65 (cc65.github.io): 6502 code, run on the SNES in emulation mode."""

import re
import shutil

from scb import config
from scb.build import Build, fresh, git_commit, sh


def home(tc):
    return config.setting("cc65", "CC65", config.toolchains_dir() / "cc65")


def available(tc):
    return (home(tc) / "bin/cc65").exists() and (home(tc) / "lib/none.lib").exists()


def version(tc):
    return {"version": tc.version, "commit": git_commit(home(tc))}


def build(tc, src, work):
    cc65 = home(tc)
    w = fresh(work)
    for f in ("main.c", "done.c", "bench.h"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    bin_ = cc65 / "bin"
    cpu = tc.opts.get("cpu", "65sc02")
    objs = []
    for name in ("main", "bench", "done"):
        sh([bin_ / "cc65", *tc.flags, f"{name}.c", "-o", f"{name}.s"], w)
        sh([bin_ / "ca65", "--cpu", cpu, f"{name}.s", "-o", f"{name}.o"], w)
        objs.append(f"{name}.o")
    sh([bin_ / "ca65", "-I", cc65 / "asminc", config.HARNESS / "cc65/crt0.s",
        "-o", "crt0.o"], w)
    sh([bin_ / "ld65", "-C", config.HARNESS / "cc65/snes.cfg", "-m", "map.txt",
        "-Ln", "labels.txt", "-o", "rom.sfc", "crt0.o", *objs, cc65 / "lib/none.lib"], w)
    syms = {}
    for line in (w / "labels.txt").read_text().splitlines():
        _, addr, name = line.split()
        syms[name.lstrip(".")] = int(addr, 16)
    text = (w / "map.txt").read_text()
    seglist = text.split("Segment list:")[1].split("\n\n\n")[0]
    used = 0
    for m in re.finditer(r"^(\w+)\s+([0-9A-F]{6})\s+([0-9A-F]{6})\s+([0-9A-F]{6})",
                         seglist, re.M):
        if m.group(1) not in ("ZEROPAGE", "BSS", "HEADER", "VECTORS"):
            used += int(m.group(4), 16)
    return Build(w / "rom.sfc", syms["_bench"], syms["_done"], syms["_result"], used)


def listing(tc, work):
    path = work / "bench.s"
    return path.read_text(errors="replace") if path.exists() else None
