"""Toolchains (a compiler plus a fixed flag set) from toolchains.toml."""

import importlib
import tomllib
from dataclasses import dataclass, field

from scb import config


@dataclass
class Toolchain:
    id: str
    compiler: str
    language: str
    display: str
    version: str = ""
    flags: list = field(default_factory=list)
    redistributable: bool = True
    opts: dict = field(default_factory=dict)   # everything else in its table

    @property
    def adapter(self):
        return importlib.import_module(f"toolchains.{self.compiler}")

    def available(self):
        return self.adapter.available(self)

    def describe(self):
        """The provenance a run record stores for this toolchain."""
        info = {"compiler": self.compiler, "display": self.display,
                "language": self.language, "flags": self.flags}
        info.update(self.adapter.version(self))
        return info


KNOWN = {"compiler", "language", "display", "version", "flags", "redistributable"}


def load():
    data = tomllib.loads((config.ROOT / "toolchains.toml").read_text())
    out = {}
    for tid, t in data.items():
        out[tid] = Toolchain(
            id=tid, compiler=t["compiler"], language=t["language"],
            display=t.get("display", tid), version=str(t.get("version", "")),
            flags=list(t.get("flags", [])), redistributable=t.get("redistributable", True),
            opts={k: v for k, v in t.items() if k not in KNOWN})
    return out
