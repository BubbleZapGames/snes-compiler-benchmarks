"""Build every (benchmark, toolchain) cell, time it and check its answer."""

import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
import os
from pathlib import Path

from scb import config, results, suite, toolchain
from scb.build import BuildError, git_commit
from scb.measure import RunError, measure

STUB = {"c": config.HARNESS / "c/stub.c", "r65": config.HARNESS / "r65/stub.r65",
        "asm": config.HARNESS / "asm/stub.asm"}


def short(err):
    lines = str(err).strip().splitlines()
    return "\n".join(lines[-12:]) if lines else repr(err)


def run_cell(tc, bench, expected, baseline):
    if tc.id in bench.unsupported:
        return {"status": "unsupported", "note": bench.unsupported[tc.id]}, None
    src = bench.source(tc.language)
    if src is None:
        return None, None
    work = config.BUILD / tc.id / bench.name
    try:
        b = tc.adapter.build(tc, src, work)
    except (BuildError, subprocess.TimeoutExpired, KeyError) as e:
        return {"status": "build_fail", "error": short(e)}, _listing(tc, work)
    try:
        cycles, value = measure(b)
    except RunError as e:
        return {"status": "run_fail", "error": short(e)}, _listing(tc, work)
    cell = {"status": "ok" if value == expected else "wrong", "cycles": cycles,
            "size": b.rom_bytes - baseline if baseline is not None else None,
            "value": value}
    return cell, _listing(tc, work)


def _listing(tc, work):
    """The adapter's listing, with machine-specific paths made repo-relative."""
    try:
        text = tc.adapter.listing(tc, work)
    except OSError:
        return None
    if text is None:
        return None
    for prefix in (str(config.ROOT) + "/", str(config.ROOT), str(Path.home()) + "/"):
        text = text.replace(prefix, "")
    return text


def stub_size(tc):
    try:
        return tc.adapter.build(tc, STUB[tc.language], config.BUILD / tc.id / "_stub").rom_bytes
    except (BuildError, subprocess.TimeoutExpired, KeyError) as e:
        print(f"[{tc.id}] stub build failed:\n{short(e)}", file=sys.stderr)
        return None


def run(bench_names=None, tc_ids=None, label=None, jobs=None):
    benches = suite.load()
    tcs = toolchain.load()
    bench_names = bench_names or list(benches)
    tc_ids = tc_ids or list(tcs)
    for name in bench_names:
        if name not in benches:
            sys.exit(f"unknown benchmark {name!r}; have {', '.join(benches)}")
    for tid in tc_ids:
        if tid not in tcs:
            sys.exit(f"unknown toolchain {tid!r}; have {', '.join(tcs)}")

    rec = results.new_record(results.latest(), label)
    rec["harness_commit"] = git_commit(config.ROOT)
    mesen = config.mesen_gdb()
    rec["emulator"] = {"name": "Mesen-GDB", "commit": git_commit(mesen.parent)}
    if not mesen.exists():
        sys.exit(f"mesen-gdb not found at {mesen}; run `python3 -m scb setup` or set MESEN_GDB")

    chosen = []
    for tid in tc_ids:
        tc = tcs[tid]
        if tc.available():
            chosen.append(tc)
        else:
            print(f"[{tid}] not installed, skipped (python3 -m scb setup)")
    expected = {n: benches[n].expected() for n in bench_names}
    for n in bench_names:
        rec["benchmarks"][n] = {"expected": expected[n]}

    jobs = jobs or max(1, (os.cpu_count() or 2) // 2)
    with ThreadPoolExecutor(jobs) as pool:
        baselines = dict(zip([t.id for t in chosen], pool.map(stub_size, chosen)))
        for tc in chosen:
            rec["toolchains"][tc.id] = tc.describe()
        measured = 0
        tasks = [(tc, benches[n]) for n in bench_names for tc in chosen]
        futures = [pool.submit(run_cell, tc, b, expected[b.name], baselines[tc.id])
                   for tc, b in tasks]
        for (tc, b), fut in zip(tasks, futures):
            cell, text = fut.result()
            if cell is None:
                continue
            results.set_cell(rec, b.name, tc.id, cell)
            measured += 1
            if text is not None:
                out = config.RESULTS / "listings" / tc.id / f"{b.name}.s"
                out.parent.mkdir(parents=True, exist_ok=True)
                out.write_text(text)
            print(line(b.name, tc.id, cell, expected[b.name]))
    if not measured:
        print("nothing measured; no run record written")
        return rec
    results.save(rec)
    print(f"\nwrote {config.RESULTS / 'runs' / (rec['run_id'] + '.json')} and latest.json")
    return rec


def line(bench, tid, cell, expected):
    s = cell["status"]
    if s in ("ok", "wrong"):
        mark = "ok" if s == "ok" else f"WRONG (got {cell['value']}, want {expected})"
        size = cell["size"] if cell["size"] is not None else "?"
        return f"{bench:10} {tid:8} {cell['cycles']:9} cycles {size:>6} bytes  {mark}"
    if s == "unsupported":
        return f"{bench:10} {tid:8} unsupported: {cell['note']}"
    first = cell.get("error", "").splitlines()
    return f"{bench:10} {tid:8} {s.upper()}: {first[-1] if first else ''}"
