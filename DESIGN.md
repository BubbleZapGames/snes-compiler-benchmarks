# snes-compiler-benchmarks — design

Status: **reviewed 2026-11-17** (decisions in §14). Implementation follows
the slices in §13.

## 1. Purpose

This repo has two jobs:

1. **A performance test suite for 65816 compilers.** It builds the same
   small programs with every compiler, runs them on an emulated SNES, and
   checks each answer. It records CPU cycles and code size. Compiler
   authors can run it locally to catch regressions and compare against
   other compilers.
2. **A public benchmark website** on GitHub Pages, built from the
   committed results. It shows a leaderboard, a page per benchmark with
   each compiler's source and generated assembly, the toolchain versions
   and flags, the method, and history over time.

It grows out of the R65 repo's `c-compiler-bench` branch (`bench/`, 10
kernels, R65 vs vbcc / tcc-65816 / cc65). That harness becomes compiler
neutral here: R65 is one entrant, not the subject.

### Non-goals

- Whole-game performance. These are kernels and small SNES workloads.
  They show how each compiler handles loops, calls and data access, not
  how fast a finished game runs.
- Judging compile speed, diagnostics or language features.
- Hosting or redistributing compilers whose licenses forbid it.

## 2. Principles

- **Correctness gates every number.** A cell counts only if `bench()`
  returns the value the Python reference computes. A wrong answer shows as
  a failure, not as a time.
- **Same program, idiomatic spelling.** Every implementation of a
  benchmark uses the same algorithm, integer widths, data sizes and memory
  layout. Each one is written the way a competent user of that language
  would write it. No inline assembly goes into compiled sources.
- **One C source for every C compiler.** C toolchains differ only in flags
  and in the harness glue (startup code, linker config), never in
  `bench.c`.
- **Reproducible.** Every run records the exact compiler versions or
  commits, the flags, the emulator commit and the harness commit.
  Measurements are deterministic, so one run per cell is enough.
- **Neutral by construction.** Ratios compare against the best result in
  each row, not against a house compiler (§9). The maintainers also
  develop R65, and the site says so on the methodology page. Sources,
  flags and raw data are all public, and compiler authors are invited to
  PR better flags or more idiomatic sources.

## 3. What is measured

| Metric | Definition | v1 |
|---|---|---|
| `cycles` | CPU cycles from `bench`'s first instruction through its `RTS`/`RTL`. Mesen-GDB breaks on entry and runs `finish`. | yes |
| `size` | ROM bytes the benchmark adds over an empty stub built by the same toolchain (code, constant data, runtime helpers the linker pulls in) | yes |
| `status` | `ok` · `wrong` · `build_fail` · `run_fail` (timeout or no return) · `unsupported` (for example, recursion under an ABI that forbids it) | yes |
| `mclk` | Master clocks for the same span, which include SlowROM/FastROM and WRAM wait states | v2 (§11) |
| `ram` | Static RAM the benchmark reserves (BSS/DP), from the map file | v2 |

Fixed conditions for every run:

- NMIs and timer IRQs are off (`NMITIMEN = 0`).
- RAM starts zeroed (`--ram-init zeros`), so uninitialised reads give the
  same result every time. The sources must still initialise their own
  data.
- `bench`, `bench_init` and the driver are in separate translation units,
  or `#[inline(never)]` in R65, so no compiler can inline the timed
  function into its caller. Inside `bench`, each compiler inlines what it
  likes.
- Each compiler's globals go where it puts them by default. Each toolchain
  page records that placement, because it changes addressing modes.

## 4. The benchmark contract

Every benchmark is a directory under `suite/`:

```
suite/sieve/
  bench.toml      name, category, tags, one-line description, notes
  ref.py          def expected() -> int   (the Python reference, u16 result)
  bench.c         C99, shared by every C toolchain
  bench.r65       R65
  bench.asm       optional hand-written reference (WLA-DX 65816)
```

Each implementation provides the same three symbols:

| Symbol | Role |
|---|---|
| `bench_init()` | Untimed setup: fills tables and builds inputs. It may be empty. |
| `bench() -> u16` | The timed work. It returns a checksum of its result. |
| global data | Whatever the benchmark needs, at the language's default placement unless `bench.toml` says otherwise |

The harness driver for each language (`harness/<lang>/`) provides the
other two:

```c
unsigned int result;            /* the runner reads this back */
int main(void) {
    *(volatile unsigned char *)0x4200 = 0;
    bench_init();
    result = bench();
    done();                     /* breakpoint target; separate TU */
    for (;;) {}
}
```

`bench()` must not be computable at compile time: whatever decides how
much work it does comes from data `bench_init()` writes at run time. The
rule came from `fact`, whose result llvm-mos `-O3` folded into a constant
(10 cycles) when its sizes were literals. `fib`, `sieve`, `sieve_bit`,
`pi` and `lz4` still have constant inputs; no compiler folds them today, and
a folded cell shows as a near-zero cycle count.

Inputs are generated, not stored. Most kernels use the shared 16-bit LCG
`v = v*5 + 0x3619`, which `ref.py` and every source reproduce, so no
benchmark needs a large data blob.

**Hand-written assembly** (`bench.asm`) is the reference a careful 65816
programmer would write. It keeps the same algorithm, inputs, data sizes,
array placement (low RAM) and result as the other versions. Anything the CPU
and the SNES offer is fair, as it is for a compiler: register and
processor-width choices, direct-page variables, `MVN`/`MVP`, the hardware
multiplier and divider, unrolling. A different algorithm is not fair: a
lookup-table popcount or CRC, a closed form, or a constant answer. Moving
timed work into `bench_init()` is not fair either. The driver
(`harness/asm/main.asm`) calls both routines with `JSR` in native mode, with
A, X and Y 16-bit, D = 0 and DBR = 0. `bench` returns its result in a 16-bit A.

A toolchain that cannot express a benchmark marks the cell `unsupported`,
with a reason in `bench.toml`
(`unsupported = { "r65-fs" = "FixedStack ABI rejects recursion" }`). It is
not left blank.

## 5. The suite

Each benchmark is at most about 100 lines per language. The suite comes
in two tiers.

### Tier A — kernels (ported from `c-compiler-bench`)

| name | exercises |
|---|---|
| `sum16` | 16-bit accumulate over a u16 array |
| `sieve` | byte-array stores, nested loops, a 16-bit index |
| `bubble` | compare-and-swap, the 8-bit loop bound vs C's int promotion |
| `crc16` | shifts, xor, branches on a bit |
| `copy` | byte copy loop (`LDA abs,X / STA abs,X` territory) |
| `entities` | array of structs, conditional field updates |
| `fib` | recursion and call/return cost |
| `popcount` | an inner bit loop over bytes |
| `dot` | 8×8 multiply-accumulate (which multiply routine each compiler reaches for) |
| `ptrsum` | summing through a pointer |

### c-bench-64 — 32-bit arithmetic and bit arrays

`crc32`, `pi`, `fact` and `sieve_bit` use the algorithms of
[c-bench-64](https://github.com/thred/c-bench-64), the benchmark set the
6502's C compilers are compared on. They were chosen after reviewing
`snes-studio.pages.dev/speed`, which also uses c-bench-64. They cover what
the kernels lack: 32-bit shifts, multiplies, divides and remainders, and a
bit-per-flag array. c-bench-64 has no license, so the sources here are
written fresh:
- sizes are smaller, so each run stays within seconds of emulated time;
- the C uses `uint32_t` (tcc-65816's `long` is 16 bits);
- R65 uses stdlib `U32`, or a pair of `u16` halves where `U32` has no
  shift or xor (`crc32`).

Each `ref.py` reproduces c-bench-64's published answer at its original
size. `crc8`, `crc16` and `sieve` overlap the kernels and are left out.

### Tier B — SNES-shaped workloads

`lz4` is in the suite (added at the user's request in the first pass). It
decodes a 375-byte LZ4 block from ROM into 1024 bytes and returns their
byte sum. `suite/lz4/make_data.py` generates the input and the tables in
both sources. The input covers extended literal and match lengths,
overlapping copies and a final literal-only sequence.

The rest are candidates. A later pass picks about 5.

| name | exercises |
|---|---|
| `oam_build` | metasprite list → 544-byte OAM shadow, including the high-table bit packing |
| `tilemap_row` | copying a column/row of a 64×64 map into a VRAM staging buffer with attribute bits |
| `fixed_physics` | 8.8 fixed-point velocity/gravity/clamp over N objects |
| `aabb` | O(n²) box overlap tests, signed 16-bit compares |
| `rle_decode` | byte-stream decompression, simpler than `lz4` |
| `state_dispatch` | `switch` over a dense enum: jump table vs compare chain |
| `itoa10` | u16 → decimal, the cost of divide-by-10 |
| `math32` | u32 add/shift/compare chains (the 16-bit-register penalty) |
| `far_table` | reading a constant table in another ROM bank (long addressing, DBR handling) |
| `calls` | many small calls with 1–3 arguments (each ABI's call overhead) |
| `rotate_lut` | sin/cos LUT and signed 8×8 multiply (rotating points) |
| `bfs_grid` | breadth-first search on a 32×32 tile grid with a ring-buffer queue |

The hardware multiply/divide registers (`$4202`/`$4204`) are not off
limits. A compiler or runtime that uses them on its own gets the credit.
A source may not write them by hand, because that would be inline
hardware access standing in for codegen.

## 6. Toolchains

A **toolchain** is a compiler plus a fixed flag set. One compiler can
appear as several toolchains, for example vbcc with and without unrolling.
Toolchains are declared in `toolchains.toml`:

```toml
[vbcc-nu]
display  = "vbcc65816 -O3 -speed, no unroll"
compiler = "vbcc"             # adapter module: toolchains/vbcc.py
language = "c"
version  = "r2"               # the pin `scb setup` fetches
flags    = ["+snes-los", "-O3", "-speed", "-unroll-size=0"]

[wdc]
compiler = "wdc"
language = "c"
redistributable = false       # CI cannot fetch it; results come from local runs
```

Each adapter (`toolchains/<compiler>.py`) implements:

```python
def available(cfg) -> bool                     # is the toolchain installed?
def version(cfg) -> dict                       # {"version": ..., "commit": ...}
def build(cfg, src: Path, work: Path) -> Build # ROM, symbols, ROM bytes used
def listing(cfg, work: Path) -> str            # assembly emitted for bench's TU
```

`Build` holds `rom`, the `bench`/`done`/`result` addresses and
`rom_bytes`. The adapter owns everything compiler specific: startup code,
linker config and map-file parsing. The runner owns nothing compiler
specific.

### Initial entrants

| compiler | language | pin | how `scb setup` obtains it |
|---|---|---|---|
| R65 (Default ABI, FixedStack ABI) | R65 | latest release tag (`v0.4.0`) | `git clone --branch <tag>`; `R65=<checkout>` overrides |
| [vbcc65816](http://www.compilers.de/vbcc.html) (`-O3 -speed`, and the no-unroll variant) | C | release 2 | public zip from compilers.de's download area |
| tcc-65816 + 816-opt ([PVSnesLib](https://github.com/alekmaul/pvsneslib)) | C | release `4.7.1` | clone at the tag and build |
| [cc65](https://cc65.github.io/) (`-Oirs --cpu 65sc02`) | C | a recorded master commit (V2.19 dates from 2020) | clone and build; a 6502 baseline run in emulation mode, labelled as such |
| [Calypsi](https://www.calypsi.cc/) 65816 (`--target SNES -O2 --speed`) | C | `5.18` | the GitHub release `.deb`, unpacked without root; free for hobby use |
| [WDCTools](https://wdc65xx.com/WDCTools) WDC816CC | C | `3.49` | not fetched: a Windows installer, run under Wine; local-only |
| [llvm-mos](https://github.com/llvm-mos/llvm-mos) (`-mcpu=mosw65816 -O3`) | C | SDK `v23.4.0` | the SDK's Linux release; 6502-family code in emulation mode, a baseline like cc65. Only `bench.c` gets the SDK's default LTO, so `bench()` stays a call from a separate unit |
| hand-written assembly | asm | in repo | the "careful assembly programmer" reference |
| ORCA/C | C | | considered: needs a SNES runtime shim |

Considered and left out: Oscar64 and KickC (6502 only), SDCC (no 65816
port).

## 7. Measurement harness

Runs use Mesen-GDB headless with a generated script:

```
break <bench>; run; regs; finish; regs; break <done>; run; mem <result> 2; quit
```

- Cycles are the counter difference between entry and return. The result
  is read from `result` after `done` is hit.
- A 20 s emulated timeout makes a non-terminating build `run_fail`.
- Mesen-GDB is an external dependency (`MESEN_GDB=<binary>`), pinned by
  commit in each run's record. `setup` can clone and build it from
  `BubbleZapGames/Mesen-GDB`.
- The emulator is deterministic, so each cell runs once. A `--check`
  mode runs every cell twice and fails on any difference, which guards
  against nondeterminism creeping into the harness.

## 8. CLI

The CLI is pure Python 3.11+ (for `tomllib`), with no third-party
dependencies.

```sh
python3 -m scb setup                    # fetch/build the redistributable toolchains + Mesen-GDB
python3 -m scb list                     # benchmarks × toolchains, with availability
python3 -m scb run                      # every available toolchain, every benchmark
python3 -m scb run -b sieve fib -t r65 vbcc
python3 -m scb run --label "r65 master" --toolchain-override r65.path=~/R65
python3 -m scb report                   # results → markdown tables in the terminal
python3 -m scb site                     # results → _site/ (static HTML)
```

A partial run (`-b`/`-t`) merges into a new run record built on the
previous one. Unchanged cells carry over, and their provenance still
points at the run that measured them.

## 9. Results data

```
results/
  runs/2026-11-17-a1b2c3.json   one record per `scb run` (append-only)
  latest.json                   merged view the site renders (generated)
  listings/<toolchain>/<bench>.s  emitted asm for the latest cell (committed)
```

Run record schema (`schema: 1`):

```json
{
  "schema": 1,
  "run_id": "2026-11-17-a1b2c3",
  "date": "2026-11-17T14:02:00Z",
  "harness_commit": "…",
  "emulator": {"name": "Mesen-GDB", "commit": "…"},
  "toolchains": {
    "vbcc": {"compiler": "vbcc", "version": "r2", "flags": ["+snes-los", "-O3", "-speed"]},
    "r65":  {"compiler": "r65", "commit": "8879d366", "flags": ["-O2", "--cfg", "snes"]}
  },
  "cells": {
    "sieve": {
      "expected": 172,
      "vbcc": {"status": "ok", "cycles": 146739, "size": 224, "value": 172},
      "r65":  {"status": "ok", "cycles": 144021, "size": 91,  "value": 172, "measured_in": "2026-11-16-ffee00"}
    }
  }
}
```

**Normalisation.** The leaderboard shows each toolchain's geometric mean of
`cell / best-in-row` over the benchmarks where that toolchain is `ok`, and
it shows the coverage (`9/10`) beside it. Visitors can pick any toolchain
as the baseline instead, with a client-side toggle. There is no
privileged default compiler.

## 10. Website

The site generator is `scb site` → `_site/`: static HTML, CSS and inline
SVG charts. It has no framework and no CDN, plus one small vanilla JS file
for table sorting and the baseline toggle. The site works with JS off,
showing the best-in-row view.

| page | content |
|---|---|
| `/` | Leaderboard: geomean cycles and size, a ranked bar chart, a per-benchmark heat-map table, the last run date and versions |
| `/bench/<name>/` | Description and what it exercises. Source tabs (C · R65 · asm · reference `ref.py`). Bar chart of cycles and size per toolchain. The emitted assembly of `bench` per toolchain, side by side or tabbed. |
| `/toolchains/` | Each toolchain's version, flags, data placement, license and caveats (cc65 = 6502 baseline, vbcc's `vcpr6502` shim, and so on) |
| `/history/` | Geomean per toolchain across runs: an R65-master-style trend line per compiler, with each point linked to its run record |
| `/method/` | §2, §3 and §7 in prose, plus caveats and the maintainers' disclosure |
| `/data/` | Raw `latest.json` and run records, for anyone who wants to reanalyse |

The hand-written assembly column sits on the leaderboard once it covers
the Tier A kernels (S4). Until then it appears only on the benchmark pages.

It supports light and dark themes (`prefers-color-scheme`) and reads at
phone width. Assembly listings are syntax-highlighted at build time, not
in the browser.

## 11. CI and hosting

| workflow | trigger | does |
|---|---|---|
| `site.yml` | push to `main` touching `results/`, `suite/`, `site/` or `scb/` | `scb site` → `actions/upload-pages-artifact` → `actions/deploy-pages`. It needs no compilers. |
| `verify.yml` | PRs, weekly | builds Mesen-GDB and the redistributable toolchains (cached), runs them, and fails if any `ok` cell changes value or the cycles differ from the committed record for the same versions |

The site is served at `https://bubblezapgames.github.io/snes-compiler-benchmarks/`
from the `BubbleZapGames/snes-compiler-benchmarks` repo, with Pages set to
build from GitHub Actions. There is no custom domain yet.

Toolchains that cannot be fetched (WDCTools) are measured
locally. Their run records are committed like any other, and the site
marks them "measured locally". CI never needs their binaries.

v2 (`mclk`): add a master-clock readout to Mesen-GDB's `regs` output. The
Mesen core tracks it, so this is a Mesen-GDB change. Then report `mclk`
next to `cycles`. Until then the method page says the counter does not
include memory wait states.

## 12. Repo layout

```
snes-compiler-benchmarks/
  README.md  DESIGN.md  LICENSE
  toolchains.toml
  scb/                  runner package: cli, run, measure (Mesen-GDB), results, report, site
  toolchains/           one adapter per compiler: r65 vbcc tcc cc65 calypsi wdc asm
  harness/
    c/  main.c done.c stub.c
    r65/ main.r65 stub.r65
    asm/ main.asm stub.asm
    cc65/ crt0.s snes.cfg
    vbcc/ vcpr6502
    calypsi/ snes.scm …
    wdc/ snes.asm
  suite/<name>/         bench.toml ref.py bench.c bench.r65 [bench.asm]
  results/              runs/ latest.json listings/
  site/                 templates, style.css, app.js
  .github/workflows/    site.yml verify.yml
  build/ .toolchains/ _site/  (gitignored; .toolchains/ holds fetched compilers)
```

## 13. Implementation slices (after review)

1. **S1 — port and get parity.** Move the 10 kernels, the harness and the
   four adapters out of `c-compiler-bench`. `scb run` must reproduce that
   branch's numbers exactly for the same compiler commits.
2. **S2 — results schema and history.** Write run records and
   `latest.json`. Import the 2026-10-18 `c-compiler-bench` results as the
   first historical run, flagged "imported, no listings".
3. **S3 — website and the Pages workflow.** Leaderboard, benchmark pages,
   toolchains, method, data. History once there are at least two runs.
4. **S4 — hand-assembly references** for the Tier A kernels.
5. **S5 — Tier B workloads**, about 5 more (after `lz4`).
6. **S6 — `verify.yml`** and further entrants. Calypsi and WDC moved into
   the first pass at the user's request.
7. **S7 — `mclk`** after the Mesen-GDB readout lands.

## 14. Decisions (2026-11-17)

1. **Hosting.** GitHub Pages under `BubbleZapGames`. No custom domain yet.
2. **License.** MIT.
3. **vbcc.** Its numbers and its generated assembly are published.
4. **Hand-written assembly.** It is on the leaderboard (once it covers
   Tier A).
5. **R65 pin.** The published column tracks the latest R65 release tag.
6. **Entrants.** R65, vbcc65816, PVSnesLib's tcc-65816, cc65, Calypsi and
   WDCTools are all in the first pass.
