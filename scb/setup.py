"""Fetch and build every redistributable toolchain, plus Mesen-GDB, into .toolchains/.

Each step is skipped once its output exists, so rerunning is cheap. WDCTools
cannot be fetched (it is a Windows installer). Install it under Wine and the
`wdc` column appears.

    python3 -m scb setup                 # everything
    python3 -m scb setup calypsi tcc     # some steps
"""

import os
import shutil
import subprocess
import sys
import zipfile
from urllib.request import urlopen

from scb import config, toolchain

R65_REPO = "https://github.com/BubbleZapGames/R65"
MESEN_REPO = "https://github.com/BubbleZapGames/Mesen-GDB"
WLA_REPO = "https://github.com/vhelin/wla-dx"
WLA_TAG = "v10.7"
CC65_REPO = "https://github.com/cc65/cc65"
PVS_REPO = "https://github.com/alekmaul/pvsneslib"
VBCC_URL = "http://www.ibaug.de/vbcc/vbcc65816_r2.zip"
LLVM_MOS_URL = "https://github.com/llvm-mos/llvm-mos-sdk/releases/download/{v}/llvm-mos-linux.tar.xz"
CALYPSI_URL = ("https://github.com/hth313/Calypsi-tool-chains/releases/download/"
               "{v}/calypsi-65816-{v}.deb")


def run(cmd, cwd=None, env=None):
    print("  $", " ".join(map(str, cmd)))
    subprocess.run([str(c) for c in cmd], cwd=cwd, env=env, check=True)


def jobs():
    return str(os.cpu_count() or 2)


def download(url, dest):
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists():
        return dest
    print(f"  downloading {url}")
    with urlopen(url) as r, open(dest.with_suffix(".part"), "wb") as f:
        shutil.copyfileobj(r, f)
    dest.with_suffix(".part").rename(dest)
    return dest


def clone(repo, dest, ref=None):
    if dest.exists():
        return
    cmd = ["git", "clone", "--depth", "1"]
    if ref:
        cmd += ["--branch", ref]
    run(cmd + [repo, dest])


def step_r65(tc_dir, tcs):
    for tag in sorted({t.version for t in tcs.values() if t.compiler == "r65"}):
        clone(R65_REPO, tc_dir / f"r65-{tag}", tag)


def step_wla(tc_dir, tcs):
    if (config.wla_bin() / "wlalink").exists():
        return
    src = tc_dir / "wla-dx-src"
    clone(WLA_REPO, src, WLA_TAG)
    build = src / "build"
    build.mkdir(exist_ok=True)
    run(["cmake", "..", f"-DCMAKE_INSTALL_PREFIX={tc_dir / 'wla-dx'}"], build)
    run(["cmake", "--build", ".", "--config", "Release", "-j", jobs()], build)
    run(["cmake", "--install", "."], build)


def step_mesen(tc_dir, tcs):
    if config.mesen_gdb().exists():
        return
    src = tc_dir / "Mesen-GDB"
    clone(MESEN_REPO, src)
    run(["make", "-j", jobs()], src)


def step_vbcc(tc_dir, tcs):
    from toolchains import vbcc
    tc = next(t for t in tcs.values() if t.compiler == "vbcc")
    if vbcc.available(tc):
        return
    z = download(VBCC_URL, tc_dir / "dl/vbcc65816_r2.zip")
    with zipfile.ZipFile(z) as f:
        f.extractall(tc_dir)
    for p in (tc_dir / "vbcc65816").rglob("bin/*"):
        p.chmod(p.stat().st_mode | 0o111)


def step_calypsi(tc_dir, tcs):
    from toolchains import calypsi
    for tc in tcs.values():
        if tc.compiler != "calypsi" or calypsi.available(tc):
            continue
        deb = download(CALYPSI_URL.format(v=tc.version),
                       tc_dir / f"dl/calypsi-65816-{tc.version}.deb")
        # dpkg-deb -x unpacks without installing (no root needed)
        run(["dpkg-deb", "-x", deb, tc_dir / f"calypsi-65816-{tc.version}"])


def step_llvm_mos(tc_dir, tcs):
    from toolchains import llvm_mos
    for tc in tcs.values():
        if tc.compiler != "llvm_mos" or llvm_mos.available(tc):
            continue
        tar = download(LLVM_MOS_URL.format(v=tc.version),
                       tc_dir / f"dl/llvm-mos-linux-{tc.version}.tar.xz")
        dest = tc_dir / f"llvm-mos-{tc.version}"
        dest.mkdir(parents=True, exist_ok=True)
        run(["tar", "-xJf", tar, "-C", dest])


def step_cc65(tc_dir, tcs):
    from toolchains import cc65
    tc = next(t for t in tcs.values() if t.compiler == "cc65")
    if cc65.available(tc):
        return
    ref = None if tc.version == "master" else tc.version
    clone(CC65_REPO, cc65.home(tc), ref)
    run(["make", "-C", cc65.home(tc), "-j", jobs(), "bin"])
    run(["make", "-C", cc65.home(tc), "-j", jobs(), "lib", "TARGETS=none"])


def step_tcc(tc_dir, tcs):
    from toolchains import tcc
    tc = next(t for t in tcs.values() if t.compiler == "tcc")
    if tcc.available(tc):
        return
    home = tcc.home(tc)
    clone(PVS_REPO, home, tc.version)
    run(["git", "submodule", "update", "--init", "--depth", "1",
         "compiler/tcc", "compiler/wla-dx"], home)
    env = dict(os.environ, PVSNESLIB_HOME=str(home))
    for target in ("compiler", "tools"):
        run(["make", "-C", home / target], env=env)
        run(["make", "-C", home / target, "install"], env=env)
    run(["make", "-C", home / "pvsneslib"], env=env)


STEPS = {"r65": step_r65, "wla": step_wla, "mesen": step_mesen, "vbcc": step_vbcc,
         "calypsi": step_calypsi, "llvm_mos": step_llvm_mos, "cc65": step_cc65, "tcc": step_tcc}


def setup(only=None):
    tc_dir = config.toolchains_dir()
    tc_dir.mkdir(parents=True, exist_ok=True)
    tcs = toolchain.load()
    for name in only or STEPS:
        if name not in STEPS:
            sys.exit(f"unknown step {name!r}; have {', '.join(STEPS)}")
        print(f"[{name}]")
        STEPS[name](tc_dir, tcs)
    print("\ntoolchains:")
    for tid, tc in tcs.items():
        state = "ready" if tc.available() else "missing"
        hint = " (install WDCTools under Wine)" if tc.compiler == "wdc" and state == "missing" else ""
        print(f"  {tid:9} {state}{hint}")


if __name__ == "__main__":
    setup(sys.argv[1:])
