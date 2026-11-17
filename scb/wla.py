"""WLA-DX helpers shared by the adapters that link with wlalink."""

import re
from pathlib import Path


def rom_used(link_output):
    """ROM bytes in use, from `wlalink -v`'s per-bank free-space report."""
    used = 0
    for free in re.findall(r"ROM bank \d+ \((\d+) bytes", link_output):
        used += 0x8000 - int(free)
    return used


def symbols(sym_file):
    """Label addresses from a wlalink `-S`/`-s` symbol file."""
    syms = {}
    section = None
    for line in Path(sym_file).read_text(errors="replace").splitlines():
        line = line.strip()
        if line.startswith("["):
            section = line
            continue
        # "00:8030 bench" (wlalink -S) or "00008030 bench" (wlalink -s)
        m = re.match(r"([0-9a-fA-F]{2}:[0-9a-fA-F]{4}|[0-9a-fA-F]{8})\s+(\S+)$", line)
        if section in (None, "[labels]") and m:
            syms.setdefault(m.group(2), int(m.group(1).replace(":", ""), 16))
    return syms
