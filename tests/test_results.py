"""Scoring maths and partial-run merging in scb.results."""

import math
from datetime import datetime, timezone

from scb import results


def rec(cells, run_id="r1"):
    return {"run_id": run_id, "toolchains": {}, "benchmarks": {}, "cells": cells}


def ok(cycles, size=10):
    return {"status": "ok", "cycles": cycles, "size": size, "value": 1}


def test_best_in_row_ignores_cells_that_are_not_ok():
    r = rec({"a": {"x": ok(100), "y": {"status": "wrong", "cycles": 5, "value": 0},
                   "z": ok(300)}})
    assert results.best_in_row(r, "a", "cycles", ["x", "y", "z"]) == 100


def test_score_is_geomean_of_ratio_to_best_over_the_toolchains_ok_rows():
    r = rec({"a": {"x": ok(100), "y": ok(200)},
             "b": {"x": ok(400), "y": ok(100)},
             "c": {"x": {"status": "unsupported"}, "y": ok(50)}})
    g, covered, total = results.score(r, "x", "cycles", ["x", "y"])
    assert (covered, total) == (2, 3)
    assert math.isclose(g, math.sqrt(1.0 * 4.0))
    g, covered, _ = results.score(r, "y", "cycles", ["x", "y"])
    assert covered == 3 and math.isclose(g, (2.0 * 1.0 * 1.0) ** (1 / 3))


def test_best_is_taken_over_the_displayed_toolchains_only():
    r = rec({"a": {"x": ok(100), "y": ok(200), "fast": ok(10)}})
    g, _, _ = results.score(r, "y", "cycles", ["x", "y"])
    assert math.isclose(g, 2.0)


def test_ratio_vs_uses_rows_where_both_are_ok():
    r = rec({"a": {"x": ok(100), "y": ok(50)},
             "b": {"x": ok(100), "y": {"status": "build_fail"}}})
    assert results.ratio_vs(r, "y", "x", "cycles") == (0.5, 1)


def test_partial_run_carries_cells_over_with_provenance():
    prev = rec({"a": {"x": ok(100), "y": ok(200)}}, run_id="old")
    prev["toolchains"] = {"x": {"compiler": "x"}, "y": {"compiler": "y"}}
    new = results.new_record(prev, now=datetime(2026, 1, 2, 3, 4, 5, tzinfo=timezone.utc))
    results.set_cell(new, "a", "x", ok(90))
    assert new["run_id"] == "2026-01-02-030405"
    assert new["cells"]["a"]["x"] == ok(90)                 # measured now: no provenance
    assert new["cells"]["a"]["y"]["measured_in"] == "old"   # carried over
    assert new["toolchains"]["y"] == {"compiler": "y"}
    assert "measured_in" not in prev["cells"]["a"]["y"]      # previous record untouched


def test_provenance_survives_a_second_carry():
    first = rec({"a": {"y": ok(200)}}, run_id="first")
    second = results.new_record(first)
    second["run_id"] = "second"
    third = results.new_record(second)
    assert third["cells"]["a"]["y"]["measured_in"] == "first"
