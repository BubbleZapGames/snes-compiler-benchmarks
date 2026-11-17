"""JCC816 (github.com/Iacon1/JCC816): a C compiler for the 65816, written in Java.

It compiles every translation unit of a program together and links the
result with cc65's cl65, so the cc65 build `scb setup` makes is a dependency.
"""

import os
import re
import shutil

from scb import config
from scb.build import Build, BuildError, fresh, git_commit, sh
from toolchains import cc65


def home(tc):
    return config.setting("jcc816", "JCC816", config.toolchains_dir() / "JCC816")


def available(tc):
    return ((home(tc) / "JCC816.jar").exists() and shutil.which("java") is not None
            and (cc65.home(tc) / "bin/cl65").exists())


def version(tc):
    return {"version": tc.version, "commit": git_commit(home(tc))}


def build(tc, src, work):
    w = fresh(work)
    for f in ("main.c", "done.c", "bench.h"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    shutil.copy(config.HARNESS / "jcc816/header.xml", w / "header.xml")
    env = dict(os.environ, CC65_BIN=str(cc65.home(tc) / "bin"),
               PATH=f"{config.HARNESS / 'jcc816'}{os.pathsep}{os.environ['PATH']}")
    out = sh(["java", "-jar", home(tc) / "JCC816.jar", *tc.flags,
              "-l", "rom.sfc", "header.xml", "main.c", "bench.c", "done.c"], w, env=env)
    # JCC816 reports errors on stdout and still exits 0.
    if "Error" in out or "Exception" in out or not (w / "labels.txt").exists():
        raise BuildError(out.strip()[-3000:])
    syms = {}
    for line in (w / "labels.txt").read_text().splitlines():
        _, addr, name = line.split()
        syms[name.lstrip(".")] = int(addr, 16)
    # Globals are equates in its assembly, not labels.
    m = re.search(r"^result\s*=\s*\$([0-9a-fA-F]+)", (w / "rom.asm").read_text(), re.M)
    if not m:
        raise BuildError("no `result` in rom.asm")
    text = (w / "map.txt").read_text()
    seglist = text.split("Segment list:")[1].split("\n\n\n")[0]
    used = 0
    for s in re.finditer(r"^(\w+)\s+([0-9A-F]{6})\s+([0-9A-F]{6})\s+([0-9A-F]{6})",
                         seglist, re.M):
        if s.group(1) not in ("ZEROPAGE", "HEADER", "VECTORS", "LVECTORS"):
            used += int(s.group(4), 16)
    return Build(w / "rom.sfc", syms["bench"], syms["done"], int(m.group(1), 16), used)


def listing(tc, work):
    path = work / "rom.asm"
    if not path.exists():
        return None
    # The whole program is one file; drop the empty inline-asm markers the
    # standard library leaves behind.
    text = re.sub(r"(?m)^; @asm\n; @endasm\n", "", path.read_text(errors="replace"))
    return text
