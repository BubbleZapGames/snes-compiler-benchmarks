"""vbcc65816 (compilers.de/vbcc.html), linked with vlink."""

import os
import re
import shutil

from scb import config
from scb.build import Build, fresh, sh


def home(tc):
    return config.setting("vbcc", "VBCC",
                          config.toolchains_dir() / "vbcc65816/vbcc65816_linux/vbcc")


def available(tc):
    return (home(tc) / "bin/vbcc65816").exists()


def version(tc):
    return {"version": tc.version}


def _env(tc):
    path = f"{home(tc) / 'bin'}:{config.HARNESS / 'vbcc'}:{os.environ['PATH']}"
    return dict(os.environ, VBCC=str(home(tc)), PATH=path)


def build(tc, src, work):
    w = fresh(work)
    for f in ("main.c", "done.c", "bench.h"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    env = _env(tc)
    objs = []
    for name in ("main", "bench", "done"):
        sh(["vc", *tc.flags, "-c", f"{name}.c", "-o", f"{name}.o"], w, env)
        objs.append(f"{name}.o")
    sh(["vc", *tc.flags, "-S", "bench.c", "-o", "bench.s"], w, env)
    tgt = home(tc) / "targets/65816-snes"
    sh(["vlink", "-m", "-b", "rawbin1", "-nowarn=22", "-Cvbcc", f"-T{tgt}/vlink-los.cmd",
        f"-L{tgt}/lib", f"{tgt}/lib/startup.o", *objs, "-o", "rom.sfc", "-lvcs",
        "-Mmap.txt"], w, env)
    text = (w / "map.txt").read_text(errors="replace")
    syms = {m.group(2): int(m.group(1), 16)
            for m in re.finditer(r"^\s+0x([0-9a-fA-F]+)\s+(\S+):", text, re.M)}
    used = sum(int(m.group(1), 16) for m in re.finditer(
        r"^\s+[0-9a-f]{8} (?:start|text\d+|ndata|fdata)\s+\(size ([0-9a-f]+)", text, re.M))
    return Build(w / "rom.sfc", syms["_bench"], syms["_done"], syms["_result"], used)


def listing(tc, work):
    path = work / "bench.s"
    return path.read_text(errors="replace") if path.exists() else None
