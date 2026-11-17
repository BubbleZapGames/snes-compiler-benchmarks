# snes-compiler-benchmarks

A performance test suite for 65816 compilers, and the benchmark website
built from its results: **https://bubblezapgames.github.io/snes-compiler-benchmarks/**

Each benchmark is one small program written once per language (C, R65,
and hand-written assembly) with the same algorithm and data layout. Every
toolchain builds it into a SNES LoROM. Mesen-GDB times one call of
`bench()` in CPU cycles, and the returned checksum is checked against a
Python reference. Code size is the ROM a benchmark adds over an empty stub
built by the same toolchain.

| toolchain | compiler | pin |
|---|---|---|
| `r65`, `r65-fs` | [R65](https://github.com/BubbleZapGames/R65), Default and FixedStack ABIs | v0.4.0 |
| `vbcc`, `vbcc-nu` | [vbcc65816](http://www.compilers.de/vbcc.html), with and without unrolling | r2 |
| `calypsi` | [Calypsi 65816](https://www.calypsi.cc/) | 5.18 |
| `wdc` | [WDCTools](https://wdc65xx.com/WDCTools) WDC816CC, under Wine | 3.49 |
| `llvm-mos` | [llvm-mos](https://github.com/llvm-mos/llvm-mos), a 6502 baseline | SDK v23.4.0 |
| `tcc` | tcc-65816 + 816-opt from [PVSnesLib](https://github.com/alekmaul/pvsneslib) | 4.7.1 |
| `cc65` | [cc65](https://cc65.github.io/), a 6502 baseline | master |
| `asm` | hand-written WLA-DX assembly | |

## Quick start

Python 3.11+ (stdlib only), git, make, cmake and a C/C++ compiler; `wine`
for the `wdc` column.

```sh
python3 -m scb setup        # fetch and build every toolchain + Mesen-GDB into .toolchains/
python3 -m scb list         # what is installed, what the suite holds
python3 -m scb run          # build, time and check everything -> results/
python3 -m scb run -b lz4 -t r65 vbcc   # some cells; the rest carry over
python3 -m scb report       # markdown tables of the latest run
python3 -m scb site         # the website -> _site/
```

Machine-specific paths go in a gitignored `local.toml` (or environment
variables): `mesen_gdb`/`MESEN_GDB`, `wla_dx`/`WLA_DX`, `r65`/`R65`,
`vbcc`/`VBCC`, `calypsi`/`CALYPSI`, `llvm_mos`/`LLVM_MOS`, `wdc_tools`/`WDC_TOOLS`,
`toolchains_dir`/`SCB_TOOLCHAINS`. WDCTools is a Windows installer and is
not fetched: install it under Wine.

## Layout

```
suite/<name>/      bench.toml ref.py bench.c bench.r65 [bench.asm]
harness/           drivers and startup code per language/compiler
toolchains/        one adapter per compiler (build, symbols, size, listing)
toolchains.toml    toolchains: compiler + pinned version + flags
scb/               runner, results, report, site generator
results/           run records (runs/), latest.json, listings/
site/              stylesheet and script for the website
```

[DESIGN.md](DESIGN.md) has the method, the benchmark contract and the
results schema. Compiler authors: pull requests with better flags or more
idiomatic sources are welcome.

MIT licensed; see [LICENSE](LICENSE).
