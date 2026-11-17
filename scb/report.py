"""Markdown tables from a run record."""

from scb import results, toolchain


def markdown(rec, tcs=None):
    if tcs is None:
        # toolchains.toml order; anything only the record knows goes last
        order = list(toolchain.load())
        tcs = sorted(rec["toolchains"], key=lambda t: order.index(t) if t in order else len(order))
    benches = list(rec["cells"])
    lines = [f"Run `{rec['run_id']}`. Each cell shows the value and its ratio to the "
             "best result in its row (1.00x = best).", ""]
    for metric, title in (("cycles", "CPU cycles per call"), ("size", "ROM bytes over the stub")):
        lines += [f"### {title}", "", "| benchmark | " + " | ".join(tcs) + " |",
                  "|---|" + "---:|" * len(tcs)]
        for b in benches:
            best = results.best_in_row(rec, b, metric, tcs)
            cells = []
            for tc in tcs:
                cell = rec["cells"][b].get(tc)
                v = results.value(rec, b, tc, metric)
                if v is not None:
                    cells.append(f"{v:,} ({v / best:.2f}x)")
                elif cell is None:
                    cells.append("-")
                else:
                    cells.append(cell["status"].replace("_", " "))
            lines.append(f"| {b} | " + " | ".join(cells) + " |")
        geo = []
        for tc in tcs:
            g, n, total = results.score(rec, tc, metric, tcs)
            geo.append(f"{g:.2f}x ({n}/{total})" if g else "-")
        lines += ["| **geomean vs best** | " + " | ".join(geo) + " |", ""]
    return "\n".join(lines)
