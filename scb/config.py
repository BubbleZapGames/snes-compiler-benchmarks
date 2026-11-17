"""Paths and settings.

Every setting resolves in this order: environment variable, then
`local.toml` at the repo root (gitignored, for machine-specific paths), then
the default under `.toolchains/`.
"""

import os
import shutil
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SUITE = ROOT / "suite"
HARNESS = ROOT / "harness"
BUILD = ROOT / "build"
SITE_SRC = ROOT / "site"
SITE_OUT = ROOT / "_site"

_local = None


def local():
    global _local
    if _local is None:
        path = ROOT / "local.toml"
        _local = tomllib.loads(path.read_text()) if path.exists() else {}
    return _local


def setting(key, env, default=None):
    """`env` var, else `key` in local.toml, else `default`; paths expand `~`."""
    value = os.environ.get(env) or local().get(key) or default
    return Path(os.path.expanduser(str(value))) if value else None


def toolchains_dir():
    return setting("toolchains_dir", "SCB_TOOLCHAINS", ROOT / ".toolchains")


def mesen_gdb():
    found = setting("mesen_gdb", "MESEN_GDB")
    if found:
        return found
    built = toolchains_dir() / "Mesen-GDB/bin/linux-x64/Release/mesen-gdb"
    if built.exists():
        return built
    on_path = shutil.which("mesen-gdb")
    return Path(on_path) if on_path else built


def wla_bin():
    """Directory holding wla-65816 and wlalink (used by the R65 and asm columns)."""
    found = setting("wla_dx", "WLA_DX")
    if found:
        return found
    built = toolchains_dir() / "wla-dx/bin"
    if (built / "wla-65816").exists():
        return built
    on_path = shutil.which("wla-65816")
    return Path(on_path).parent if on_path else built


# SCB_RESULTS points a run somewhere other than results/ (for scratch runs).
RESULTS = Path(os.environ.get("SCB_RESULTS") or ROOT / "results")
