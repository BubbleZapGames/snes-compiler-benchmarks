"""Time one call of bench() in Mesen-GDB and read back its result."""

import re
import subprocess

from scb import config
from scb.build import BuildError


def measure(build, timeout_ms=120000):
    """CPU cycles from bench's first instruction through its return, and the result.

    The script breaks on bench, steps out with `finish`, then runs to done()
    and reads the stored result. Mesen's counter is CPU cycles, not master
    clocks, so ROM and WRAM wait states are not in it.
    """
    script = (f"break {build.bench:06X}\nrun\nregs\nfinish\nregs\n"
              f"break {build.done:06X}\nrun\nmem {build.result:06X} 2\nquit\n")
    path = build.rom.with_suffix(".script")
    path.write_text(script)
    try:
        p = subprocess.run([str(config.mesen_gdb()), str(build.rom), "--headless",
                            "--script", str(path), "--timeout", str(timeout_ms),
                            "--ram-init", "zeros"],
                           capture_output=True, text=True, timeout=600)
    except subprocess.TimeoutExpired as e:
        raise RunError("mesen-gdb did not finish") from e
    out = p.stdout + p.stderr
    # Each stop prints the state and `regs` prints it again, so the counter
    # reads: entry, entry, return, return, done.
    cycles = sorted({int(c) for c in re.findall(r"Cycles: (\d+)", out)})
    mem = re.search(rf"^{build.result:06X}: ([0-9A-F]{{2}}) ([0-9A-F]{{2}})", out, re.M)
    if len(cycles) < 3 or not mem:
        raise RunError(f"mesen-gdb did not report cycles/result:\n{out[-2000:]}")
    return cycles[1] - cycles[0], int(mem.group(2) + mem.group(1), 16)


class RunError(BuildError):
    pass
