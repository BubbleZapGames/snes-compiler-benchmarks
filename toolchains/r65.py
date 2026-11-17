"""R65 (github.com/BubbleZapGames/R65), built with WLA-DX."""

import os
import re
import shutil
import subprocess
import sys

from scb import config, wla
from scb.build import Build, fresh, sh

def home(tc):
    return config.setting("r65", "R65", config.toolchains_dir() / f"r65-{tc.version}")


def available(tc):
    return (home(tc) / "r65/compiler/main.py").exists() and (config.wla_bin() / "wlalink").exists()


def version(tc):
    h = home(tc)
    p = subprocess.run(["git", "-C", str(h), "describe", "--tags", "--always"],
                       capture_output=True, text=True)
    c = subprocess.run(["git", "-C", str(h), "rev-parse", "--short=8", "HEAD"],
                       capture_output=True, text=True)
    return {"version": p.stdout.strip() or tc.version, "commit": c.stdout.strip() or None}


def build(tc, src, work):
    """`scratch_regs = true` adds stdlib/scratch_regs.r65 as FixedStack's DP pool."""
    w = fresh(work)
    repo = home(tc)
    main = (config.HARNESS / "r65/main.r65").read_text()
    if tc.opts.get("scratch_regs"):
        main = main.replace('include!("lib/math.r65")\n',
                            'include!("lib/math.r65")\ninclude!("lib/scratch_regs.r65")\n')
    (w / "main.r65").write_text(main)
    shutil.copy(src, w / "bench.r65")
    # the whole stdlib is available; a benchmark include!s what it uses (lib/U32.r65)
    (w / "lib").mkdir()
    for lib in (repo / "stdlib").glob("*.r65"):
        shutil.copy(lib, w / "lib" / lib.name)
    env = dict(os.environ, PYTHONPATH=str(repo))
    sh([sys.executable, "-m", "r65.compiler.main", "main.r65", "-o", "main.asm", *tc.flags],
       w, env)
    bin_ = config.wla_bin()
    sh([bin_ / "wla-65816", "-o", "main.o", "main.asm"], w)
    (w / "link.txt").write_text("[objects]\nmain.o\n")
    log = sh([bin_ / "wlalink", "-v", "-S", "link.txt", "rom.sfc"], w)
    syms = wla.symbols(w / "rom.sym")
    return Build(w / "rom.sfc", syms["bench"], syms["done"], syms["RESULT"], wla.rom_used(log))


def listing(tc, work):
    """bench_init and bench (with their local labels), cut from the whole-program asm."""
    path = work / "main.asm"
    if not path.exists():
        return None
    lines = path.read_text().splitlines()
    out, keep = [], False
    for line in lines:
        m = re.match(r"^([A-Za-z_][A-Za-z0-9_]*):", line)
        if m and "__L" not in m.group(1):
            keep = m.group(1) in ("bench_init", "bench") or (
                keep and m.group(1).startswith("bench"))
        if keep:
            out.append(line)
    return "\n".join(out).strip() + "\n"
