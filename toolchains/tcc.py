"""tcc-65816 and 816-opt from PVSnesLib (github.com/alekmaul/pvsneslib)."""

import shutil

from scb import config, wla
from scb.build import Build, fresh, git_commit, sh


def home(tc):
    return config.setting("pvsneslib", "PVSNESLIB", config.toolchains_dir() / "pvsneslib")


def available(tc):
    return (home(tc) / "pvsneslib/lib/LoROM_SlowROM").is_dir()


def version(tc):
    return {"version": tc.version, "commit": git_commit(home(tc))}


HEADER = {"HIROMDEF": "", "FASTROMDEF": "", "ROMTITLE": "SCB TCC",
          "CARTRIDGETYPE": "00", "ROMSIZE": "08", "SRAMSIZE": "00",
          "COUNTRY": "01", "LICENSEECODE": "00", "VERSION": "00",
          "ROMBANKS": "8", "ROMBANKSIZE": "8000", "ROMMODE": "LOROM",
          "ROMSPEED": "SLOWROM"}


def build(tc, src, work):
    pvs = home(tc)
    w = fresh(work)
    for f in ("main.c", "done.c", "bench.h"):
        shutil.copy(config.HARNESS / "c" / f, w / f)
    shutil.copy(src, w / "bench.c")
    hdr = (pvs / "devkitsnes/include/hdr.asm.in").read_text()
    for key, val in HEADER.items():
        hdr = hdr.replace(f"@{key}@", val)
    (w / "hdr.asm").write_text(hdr)
    bin_ = pvs / "devkitsnes/bin"
    objs = []
    for name in ("main", "bench", "done"):
        sh([bin_ / "816-tcc", f"-I{pvs}/pvsneslib/include", f"-I{pvs}/devkitsnes/include",
            *tc.flags, "-c", f"{name}.c", "-o", f"{name}.ps"], w)
        sh([pvs / "devkitsnes/tools/816-opt", "-i", f"{name}.ps", "-o", f"{name}.asm"], w)
        sh([bin_ / "wla-65816", "-d", "-s", "-x", "-o", f"{name}.obj", f"{name}.asm"], w)
        objs.append(f"{name}.obj")
    libdir = pvs / "pvsneslib/lib/LoROM_SlowROM"
    libs = sorted(str(p) for p in libdir.glob("*.obj"))
    (w / "linkfile").write_text("[objects]\n" + "\n".join(objs + libs) + "\n")
    log = sh([bin_ / "wlalink", "-d", "-s", "-v", "-A", "-c", "-L", libdir,
              "linkfile", "rom.sfc"], w)
    syms = wla.symbols(w / "rom.sym")
    return Build(w / "rom.sfc", syms["bench"], syms["done"], syms["result"], wla.rom_used(log))


def listing(tc, work):
    path = work / "bench.asm"
    return path.read_text(errors="replace") if path.exists() else None
