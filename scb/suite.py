"""Benchmarks: one directory per benchmark under suite/."""

import importlib.util
import tomllib
from dataclasses import dataclass, field
from pathlib import Path

from scb import config

SOURCE = {"c": "bench.c", "r65": "bench.r65", "asm": "bench.asm"}


@dataclass
class Benchmark:
    name: str
    dir: Path
    description: str
    category: str
    tags: list = field(default_factory=list)
    unsupported: dict = field(default_factory=dict)   # toolchain id -> reason

    def source(self, language):
        path = self.dir / SOURCE[language]
        return path if path.exists() else None

    def expected(self):
        spec = importlib.util.spec_from_file_location(f"ref_{self.name}", self.dir / "ref.py")
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        return mod.expected() & 0xFFFF


ORDER = ["sieve", "bubble", "crc16", "copy", "entities", "fib", "popcount",
         "dot", "ptrsum", "lz4", "bfs_grid", "crc32", "pi", "fact", "sieve_bit"]


def load():
    benches = {}
    for d in sorted(config.SUITE.iterdir()):
        meta_path = d / "bench.toml"
        if not meta_path.exists():
            continue
        meta = tomllib.loads(meta_path.read_text())
        benches[d.name] = Benchmark(
            name=d.name, dir=d, description=meta.get("description", ""),
            category=meta.get("category", "kernel"), tags=meta.get("tags", []),
            unsupported=meta.get("unsupported", {}))
    rank = {n: i for i, n in enumerate(ORDER)}
    return dict(sorted(benches.items(), key=lambda kv: (rank.get(kv[0], len(ORDER)), kv[0])))
