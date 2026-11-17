"""Run records, the merged latest view, and the scoring maths.

A run record (schema 1) is a complete picture: cells a partial run did not
measure are carried over from the previous record, with `measured_in`
naming the run that measured them. `latest.json` is a copy of the newest
record.
"""

import copy
import json
import math
from datetime import datetime, timezone

from scb import config

SCHEMA = 1
OK = "ok"
STATUSES = ("ok", "wrong", "build_fail", "run_fail", "unsupported")


def runs_dir():
    return config.RESULTS / "runs"


def load_runs():
    """Every run record, oldest first."""
    if not runs_dir().exists():
        return []
    runs = [json.loads(p.read_text()) for p in sorted(runs_dir().glob("*.json"))]
    return sorted(runs, key=lambda r: r["date"])


def latest():
    path = config.RESULTS / "latest.json"
    return json.loads(path.read_text()) if path.exists() else None


def new_record(prev, label=None, now=None):
    now = now or datetime.now(timezone.utc)
    run_id = now.strftime("%Y-%m-%d-%H%M%S")
    rec = {"schema": SCHEMA, "run_id": run_id,
           "date": now.strftime("%Y-%m-%dT%H:%M:%SZ"), "label": label,
           "harness_commit": None, "emulator": None,
           "toolchains": {}, "benchmarks": {}, "cells": {}}
    if prev:
        rec["toolchains"] = copy.deepcopy(prev.get("toolchains", {}))
        rec["benchmarks"] = copy.deepcopy(prev.get("benchmarks", {}))
        for bench, row in prev.get("cells", {}).items():
            for tc, cell in row.items():
                cell = dict(cell)
                cell.setdefault("measured_in", prev["run_id"])
                rec["cells"].setdefault(bench, {})[tc] = cell
    return rec


def set_cell(rec, bench, tc, cell):
    """Record a cell this run measured (it carries no `measured_in`)."""
    rec["cells"].setdefault(bench, {})[tc] = {k: v for k, v in cell.items()
                                              if k != "measured_in"}


def save(rec):
    runs_dir().mkdir(parents=True, exist_ok=True)
    text = json.dumps(rec, indent=1, sort_keys=False) + "\n"
    (runs_dir() / f"{rec['run_id']}.json").write_text(text)
    (config.RESULTS / "latest.json").write_text(text)


# --- scoring ---------------------------------------------------------------

def value(rec, bench, tc, metric):
    """The metric for an ok cell, else None."""
    cell = rec["cells"].get(bench, {}).get(tc)
    if not cell or cell.get("status") != OK:
        return None
    return cell.get(metric)


def best_in_row(rec, bench, metric, tcs):
    vals = [v for tc in tcs if (v := value(rec, bench, tc, metric))]
    return min(vals) if vals else None


def geomean(xs):
    xs = [x for x in xs if x]
    return math.exp(sum(math.log(x) for x in xs) / len(xs)) if xs else None


def score(rec, tc, metric, tcs, benches=None):
    """Geomean of cell / best-in-row over the benchmarks where `tc` is ok.

    Returns (geomean, covered, total). The best in each row is taken over
    `tcs`, the toolchains on display.
    """
    benches = list(benches or rec["cells"])
    ratios = []
    for b in benches:
        v = value(rec, b, tc, metric)
        best = best_in_row(rec, b, metric, tcs)
        if v and best:
            ratios.append(v / best)
    return geomean(ratios), len(ratios), len(benches)


def ratio_vs(rec, tc, base, metric, benches=None):
    """Geomean of tc / base over the benchmarks where both are ok."""
    ratios = []
    for b in benches or rec["cells"]:
        v, bv = value(rec, b, tc, metric), value(rec, b, base, metric)
        if v and bv:
            ratios.append(v / bv)
    return geomean(ratios), len(ratios)
