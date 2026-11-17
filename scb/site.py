"""Generate the static site in _site/ from results/ and suite/.

Every page uses relative links, so the same output works under the GitHub
Pages project path and from a local `python3 -m http.server`.
"""

import html
import json
import math
import shutil

from scb import config, highlight, results, suite, toolchain

E = html.escape
METRICS = (("cycles", "CPU cycles", "CPU cycles per call"),
           ("size", "Code size", "ROM bytes over the stub"))
RAMP_STEPS = 12          # heat-map steps; colours live in style.css (--s0..--s11)
STATUS_TEXT = {"wrong": "wrong answer", "build_fail": "build failed",
               "run_fail": "crashed", "unsupported": "unsupported"}
STATUS_TONE = {"wrong": "bad", "build_fail": "bad", "run_fail": "bad", "unsupported": "quiet"}
KIND_CHIP = {"6502": ("6502", "6502-family code in emulation mode: a baseline, not a 65816 compiler"),
             "reference": ("ref", "hand-written by a person: the reference, not a compiler")}
GROUPS = [("kernel", "Kernels", "Small loops that show how a compiler handles the basics: indexing, shifts, compares, calls."),
          ("workload", "Workloads", "Jobs a SNES game actually does."),
          ("c-bench-64", "From c-bench-64",
           "The algorithms of c-bench-64, the benchmark set the 6502's C compilers are compared on: 32-bit arithmetic and a bit array.")]


def ramp_step(ratio):
    """1× is step 0, 8× and worse the last step (log scale)."""
    if not ratio:
        return None
    t = min(1.0, math.log2(max(ratio, 1.0)) / 3.0)
    return round(t * (RAMP_STEPS - 1))


def fmt_ratio(r):
    return f"{r:.2f}×"


def kind(tcs, tid):
    tc = tcs.get(tid)
    return tc.opts.get("kind", "65816") if tc else "65816"


def chip(tcs, tid):
    k = KIND_CHIP.get(kind(tcs, tid))
    return f' <span class="chip" title="{E(k[1])}">{E(k[0])}</span>' if k else ""


# --- page frame ------------------------------------------------------------

NAV = [("", "Leaderboard"), ("bench/", "Benchmarks"), ("toolchains/", "Toolchains"),
       ("history/", "History"), ("method/", "Method"), ("data/", "Data")]

FONTS = ("https://fonts.googleapis.com/css2?family=Chakra+Petch:wght@600;700"
         "&family=IBM+Plex+Mono:wght@400;500&family=IBM+Plex+Sans:wght@400;500;600&display=swap")

# A 65816 in its 40-pin DIP, drawn small: the brand mark and the favicon.
CHIP_SVG = ('<svg class="mark" viewBox="0 0 24 24" aria-hidden="true">'
            '<rect x="6" y="2.5" width="12" height="19" rx="1.5"/>'
            '<path d="M6 6.5H3M6 10H3M6 13.5H3M6 17H3M18 6.5h3M18 10h3M18 13.5h3M18 17h3"/>'
            '<circle cx="9.2" cy="5.6" r="1"/></svg>')
FAVICON = ("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' "
           "fill='none' stroke='%235847c9' stroke-width='2'%3E%3Crect x='6' y='2.5' width='12' height='19' rx='1.5'/%3E"
           "%3Cpath d='M6 7H3M6 12H3M6 17H3M18 7h3M18 12h3M18 17h3'/%3E%3C/svg%3E")


def page(title, body, depth, active, description=""):
    up = "../" * depth
    nav = "".join(
        f'<a href="{up}{href}"{" aria-current=page" if href == active else ""}>{E(name)}</a>'
        for href, name in NAV)
    full_title = "SNES Compiler Benchmarks" if not title else f"{title} · SNES Compiler Benchmarks"
    desc = description or "CPU cycles and code size of 65816 compilers on the same programs, measured on an emulated SNES."
    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>{E(full_title)}</title>
<meta name="description" content="{E(desc)}">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="{FONTS}">
<link rel="stylesheet" href="{up}style.css">
<link rel="icon" href="{FAVICON}">
<script>try{{var t=localStorage.getItem("scb-theme");if(t)document.documentElement.dataset.theme=t}}catch(e){{}}</script>
</head>
<body>
<header class="site"><div class="wrap">
  <a class="brand" href="{up}">{CHIP_SVG}<span>SNES Compiler<br>Benchmarks</span></a>
  <nav aria-label="Site">{nav}</nav>
  <button class="theme" type="button" hidden>Dark</button>
</div></header>
<main class="wrap">
{body}
</main>
<footer class="site"><div class="wrap">
  <p>65816 compilers, the same programs, one emulated SNES. Sources, flags and raw data on
  <a href="https://github.com/BubbleZapGames/snes-compiler-benchmarks">GitHub</a>. MIT licensed.</p>
</div></footer>
<script src="{up}app.js"></script>
</body>
</html>
"""


def write(rel, text):
    path = config.SITE_OUT / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)


# --- shared pieces ---------------------------------------------------------

def tc_label(tcs, tid):
    tc = tcs.get(tid)
    return tc.display if tc else tid


def cell_status(rec, bench, tid):
    cell = rec["cells"].get(bench, {}).get(tid)
    return cell.get("status") if cell else None


def pill(status, text=None):
    return (f'<span class="pill {STATUS_TONE.get(status, "quiet")}">'
            f'{E(text or STATUS_TEXT.get(status, status))}</span>')


def bars(rows):
    """Ranked horizontal bars in HTML.
    rows: dicts with label, href, value (None for a failed cell), text, title, kind, status."""
    vals = [r["value"] for r in rows if r["value"] is not None]
    top = max(vals) if vals else 1
    out = ['<ol class="bars">']
    for r in rows:
        name = f'<a href="{r["href"]}">{E(r["label"])}</a>' if r.get("href") else E(r["label"])
        name += r.get("chip", "")
        k = f' k-{r["kind"]}' if r.get("kind") not in (None, "65816") else ""
        if r["value"] is None:
            out.append(f'<li class="none{k}"><span class="bl">{name}</span>'
                       f'<span class="bt">{pill(r.get("status", "unsupported"), r["text"])}</span></li>')
            continue
        frac = max(0.005, r["value"] / top)
        out.append(f'<li class="{k.strip()}" title="{E(r.get("title", ""))}"><span class="bl">{name}</span>'
                   f'<span class="bt"><span class="bar" style="width:calc((100% - 9rem) * {frac:.4f})"></span>'
                   f'<span class="bv">{E(r["text"])}</span></span></li>')
    out.append("</ol>")
    return "\n".join(out)


def facts(items):
    return '<dl class="facts">' + "".join(
        f'<div><dt>{E(k)}</dt><dd>{v}</dd></div>' for k, v in items) + "</dl>"


# --- leaderboard -----------------------------------------------------------

def board_tcs(rec, tcs, benches):
    """Toolchains on the leaderboard. A reference toolchain (hand-written asm)
    joins once it covers every benchmark."""
    out = []
    for tid in tcs:
        if tid not in rec["toolchains"]:
            continue
        has = [b for b in benches if cell_status(rec, b, tid) is not None]
        if not has:
            continue
        if tcs[tid].opts.get("reference") and len(has) < len(benches):
            continue
        out.append(tid)
    return out


def scored(rec, tcs, benches, shown, metric):
    out = []
    for t in shown:
        g, n, total = results.score(rec, t, metric, shown, benches)
        out.append((g if g else math.inf, t, n, total))
    return sorted(out)


def board(rec, tcs, benches, shown, metric, title, unit):
    rows = []
    for g, t, n, total in scored(rec, tcs, benches, shown, metric):
        base = {"label": tc_label(tcs, t), "href": f"toolchains/#{t}", "kind": kind(tcs, t),
                "chip": chip(tcs, t)}
        if g == math.inf:
            rows.append({**base, "value": None, "text": "no results"})
            continue
        cover = "" if n == total else f" · {n}/{total}"
        rows.append({**base, "value": g, "text": f"{fmt_ratio(g)}{cover}",
                     "title": f"{tc_label(tcs, t)}: geomean {fmt_ratio(g)} of the best, over {n} of {total} benchmarks"})
    return f"""<section class="board" data-metric="{metric}">
  <h2>{E(title)}</h2>
  <p class="sub">{E(unit[0].upper() + unit[1:])}, divided by the best result for each benchmark, then averaged (geometric mean). <strong>1.00× is best.</strong></p>
  {bars(rows)}
  <p class="cov-note note" aria-live="polite"></p>
</section>"""


def heat_table(rec, tcs, benches, shown, metric, caption):
    head = "".join(
        f'<th scope="col" data-tc="{E(t)}" class="k-{kind(tcs, t)}"><button type="button" class="sort" '
        f'title="Sort by {E(tc_label(tcs, t))}">{E(t)}</button></th>' for t in shown)
    rows = []
    for b in benches:
        best = results.best_in_row(rec, b, metric, shown)
        cells = []
        for t in shown:
            v = results.value(rec, b, t, metric)
            st = cell_status(rec, b, t)
            if v is not None:
                r = v / best
                cells.append(f'<td data-v="{v}" class="h s{ramp_step(r)}" '
                             f'title="{E(tc_label(tcs, t))}, {E(b)}: {v:,} ({fmt_ratio(r)} of the best)">'
                             f'<span class="r">{fmt_ratio(r)}</span><span class="v">{v:,}</span></td>')
            elif st:
                cells.append(f'<td class="st">{pill(st)}</td>')
            else:
                cells.append('<td class="st"><span class="muted">–</span></td>')
        rows.append(f'<tr><th scope="row"><a href="bench/{E(b)}/">{E(b)}</a></th>{"".join(cells)}</tr>')
    return f"""<div class="table-wrap" data-metric="{metric}"><table class="heat" data-metric="{metric}">
<caption>{E(caption)}</caption>
<thead><tr><th scope="col">benchmark</th>{head}</tr></thead>
<tbody>{"".join(rows)}</tbody>
</table></div>"""


def legend():
    swatches = "".join(f'<span class="sw s{i}"></span>' for i in range(RAMP_STEPS))
    return (f'<div class="legend" aria-hidden="true"><span>1× best</span>'
            f'<span class="ramp">{swatches}</span><span>8× or worse</span></div>')


def index_page(rec, tcs, benches):
    shown = board_tcs(rec, tcs, benches)
    payload = {"toolchains": shown, "labels": {t: tc_label(tcs, t) for t in shown},
               "kinds": {t: kind(tcs, t) for t in shown},
               "languages": {t: tcs[t].language for t in shown}, "benches": list(benches),
               "statuses": {b: {t: cell_status(rec, b, t) for t in shown} for b in benches},
               "values": {m: {b: {t: results.value(rec, b, t, m) for t in shown} for b in benches}
                          for m, _, _ in METRICS}}
    lead = next(((g, t) for g, t, _, _ in scored(rec, tcs, benches, shown, "cycles")
                 if kind(tcs, t) == "65816" and g != math.inf), None)
    attempted = [c for row in rec["cells"].values() for t, c in row.items()
                 if t in shown and c.get("status") != "unsupported"]
    correct = sum(1 for c in attempted if c.get("status") == "ok")
    options = "".join(f'<option value="{E(t)}">{E(tc_label(tcs, t))}</option>' for t in shown)
    boards = "".join(board(rec, tcs, benches, shown, m, t, u) for m, t, u in METRICS)
    refs = [t for t in shown if kind(tcs, t) == "reference"]
    ref_note = ""
    if refs:
        wins = sum(1 for b in benches
                   if results.value(rec, b, refs[0], "cycles") == results.best_in_row(rec, b, "cycles", shown))
        ref_note = (f'<p class="ref-note">The hand-written assembly is the best on {wins} of {len(benches)} benchmarks '
                    f'for cycles, so a compiler\'s cycles ratio reads as how many times slower its code is than '
                    f'code written by hand. Choose C above to compare the C compilers only.</p>')
    tables = "".join(heat_table(rec, tcs, benches, shown, m, f"{t}: each cell over the best in its row")
                     for m, t, _ in METRICS)
    body = f"""
<section class="hero">
  <p class="eyebrow">Run {E(rec["date"][:10])} · Mesen-GDB, CPU cycles</p>
  <h1>Which compiler writes the fastest SNES code?</h1>
  <p class="lede">Every compiler builds the same programs into a SNES ROM. Each call to <code>bench()</code> is timed in CPU cycles on an emulated console and its answer checked against a reference. A wrong answer counts as a failure, never as a time.</p>
  {facts([
      ("Fastest 65816 compiler", f'<span id="fact-fastest">{E(tc_label(tcs, lead[1]))} <span class="muted">{fmt_ratio(lead[0])}</span></span>' if lead else "–"),
      ("Benchmarks", str(len(benches))),
      ("Toolchains", f'<span id="fact-toolchains">{len(shown)}</span>'),
      ("Correct answers", f'<span id="fact-correct">{correct} of {len(attempted)}</span>'),
  ])}
</section>

<div class="controls">
  <div class="seg" role="radiogroup" aria-label="Language" hidden>
    <span class="seg-label">Language</span>
    <button type="button" role="radio" aria-checked="true" data-lang="">All</button>
    <button type="button" role="radio" aria-checked="false" data-lang="c">C</button>
  </div>
  <label for="baseline">Compare against</label>
  <select id="baseline" disabled>
    <option value="">the best in each row</option>{options}
  </select>
  <p class="note">Every ratio divides a result by the best one for that benchmark. Pick a toolchain to divide by its results instead.</p>
</div>

{ref_note}
<div class="boards">{boards}</div>

<section class="matrix">
  <div class="matrix-head">
    <div>
      <h2>Every benchmark</h2>
      <p class="sub">Each cell over the best result in its row, with the raw number underneath. Click a toolchain to sort by it.</p>
    </div>
    <div class="tabs" role="tablist" aria-label="Metric" hidden>
      <button type="button" role="tab" aria-selected="true" data-metric="cycles">CPU cycles</button>
      <button type="button" role="tab" aria-selected="false" data-metric="size">Code size</button>
    </div>
  </div>
  {legend()}
  {tables}
</section>
<script type="application/json" id="board-data">{json.dumps(payload)}</script>
"""
    write("index.html", page("", body, 0, ""))


# --- benchmark pages -------------------------------------------------------

LANG_NAME = {"c": "C", "r65": "R65", "asm": "Assembly"}


def bench_page(rec, tcs, b):
    present = [t for t in tcs if t in rec["toolchains"] and cell_status(rec, b.name, t)]
    expected = rec["benchmarks"].get(b.name, {}).get("expected")
    charts, winners = [], {}
    for metric, title, unit in METRICS:
        oks = sorted((results.value(rec, b.name, t, metric), t) for t in present
                     if results.value(rec, b.name, t, metric) is not None)
        best = oks[0][0] if oks else None
        winners[metric] = [t for v, t in oks if v == best]
        rows = [{"label": tc_label(tcs, t), "href": f"../../toolchains/#{t}", "value": v,
                 "kind": kind(tcs, t), "chip": chip(tcs, t),
                 "text": f"{v:,} · {fmt_ratio(v / best)}", "title": f"{tc_label(tcs, t)}: {v:,} {unit}"}
                for v, t in oks]
        for t in present:
            st = cell_status(rec, b.name, t)
            if st != "ok":
                cell = rec["cells"][b.name][t]
                text = STATUS_TEXT.get(st, st)
                if st == "wrong":
                    text += f": returned {cell.get('value')}, expected {expected}"
                elif cell.get("note"):
                    text += f": {cell['note']}"
                rows.append({"label": tc_label(tcs, t), "href": f"../../toolchains/#{t}", "value": None,
                             "kind": kind(tcs, t), "chip": chip(tcs, t), "text": text, "status": st})
        charts.append(f'<section><h2>{E(title)}</h2><p class="sub">{E(unit[0].upper() + unit[1:])}. '
                      f'Lower is better.</p>{bars(rows)}</section>')

    sources = []
    for lang in ("c", "r65", "asm"):
        p = b.source(lang)
        if p:
            sources.append((LANG_NAME[lang], p.name, highlight.source(p.read_text())))
    ref = b.dir / "ref.py"
    sources.append(("Reference", "ref.py", highlight.source(ref.read_text(), python=True)))
    src_html = "".join(
        f'<details class="src"{" open" if i == 0 else ""}><summary>{E(name)} <code>{E(fname)}</code></summary>'
        f'<pre class="code">{code}</pre></details>'
        for i, (name, fname, code) in enumerate(sources))

    listings = []
    for t in present:
        path = config.RESULTS / "listings" / t / f"{b.name}.s"
        if not path.exists():
            continue
        cyc, size = results.value(rec, b.name, t, "cycles"), results.value(rec, b.name, t, "size")
        st = cell_status(rec, b.name, t)
        stat = (f'{cyc:,} cycles · {size:,} bytes' if cyc is not None
                else STATUS_TEXT.get(st, st))
        listings.append(
            f'<details class="src"><summary>{E(tc_label(tcs, t))}{chip(tcs, t)}'
            f'<span class="sum-stat">{E(stat)}</span></summary>'
            f'<pre class="code asm">{highlight.asm(path.read_text(errors="replace"))}</pre></details>')
    group = dict((g, n) for g, n, _ in GROUPS).get(b.category, b.category)
    tags = "".join(f'<li>{E(t)}</li>' for t in b.tags)
    win = lambda m: " · ".join(tc_label(tcs, t) for t in winners.get(m, [])) or "–"
    body = f"""
<p class="crumb"><a href="../">Benchmarks</a> / {E(group)}</p>
<h1 class="mono-title">{E(b.name)}</h1>
<p class="lede">{E(b.description)}</p>
<ul class="tags">{tags}</ul>
{facts([("Expected result", f"<code>{expected}</code>"), ("Fewest cycles", E(win("cycles"))),
        ("Smallest code", E(win("size"))), ("Run", f'<code>{E(rec["run_id"])}</code>')])}
<div class="two">{"".join(charts)}</div>
<section><h2>Sources</h2>
<p class="sub">The same algorithm, integer widths and data layout in every language. All C compilers build the same <code>bench.c</code>.</p>
{src_html}</section>
<section><h2>Generated assembly</h2>
<p class="sub">What each toolchain emitted for the benchmark's own code. Runtime helpers the linker pulls in are not shown.</p>
{"".join(listings) or '<p class="muted">No listings for this run.</p>'}</section>
"""
    write(f"bench/{b.name}/index.html", page(b.name, body, 2, "bench/", b.description))


def bench_index(rec, tcs, benches):
    shown = board_tcs(rec, tcs, benches)
    sections = []
    for key, name, blurb in GROUPS:
        members = [b for b in benches.values() if b.category == key]
        if not members:
            continue
        rows = []
        for b in members:
            best = results.best_in_row(rec, b.name, "cycles", shown)
            win = [t for t in shown if results.value(rec, b.name, t, "cycles") == best]
            fails = [t for t in shown if cell_status(rec, b.name, t) in ("wrong", "run_fail", "build_fail")]
            fail_txt = f' <span class="pill bad">{len(fails)} failed</span>' if fails else ""
            rows.append(f'<li><a class="bname" href="{E(b.name)}/">{E(b.name)}</a>'
                        f'<p class="bdesc">{E(b.description)}</p>'
                        f'<p class="bwin"><span class="lbl">Fewest cycles</span> '
                        f'{E(" · ".join(tc_label(tcs, t) for t in win))}{fail_txt}</p></li>')
        sections.append(f"""<section>
<h2>{E(name)} <span class="count">{len(members)}</span></h2>
<p class="sub">{E(blurb)}</p>
<ul class="bench-list">{"".join(rows)}</ul>
</section>""")
    body = f"""
<h1>Benchmarks</h1>
<p class="lede">Programs of a few dozen lines, each written once per language. They show how a compiler handles loops, calls, arithmetic and data, not how fast a finished game runs.</p>
{"".join(sections)}
"""
    write("bench/index.html", page("Benchmarks", body, 1, "bench/"))


# --- toolchains ------------------------------------------------------------

KIND_TEXT = {"65816": "65816 compiler", "6502": "6502 baseline", "reference": "reference"}


def toolchains_page(rec, tcs):
    cards = []
    for tid, tc in tcs.items():
        info = rec["toolchains"].get(tid, {})
        ver = info.get("version") or tc.version
        commit = info.get("commit")
        k = kind(tcs, tid)
        chips = f'<span class="chip k-{k}">{E(KIND_TEXT[k])}</span>'
        if not tc.redistributable:
            chips += '<span class="chip">measured locally</span>'
        rows = [("Home", f'<a href="{E(tc.opts["url"])}">{E(tc.opts["url"].split("//")[-1].rstrip("/"))}</a>'
                 if tc.opts.get("url") else ""),
                ("Version", E(ver) + (f" <code>{E(commit)}</code>" if commit else "")),
                ("Flags", f"<code>{E(' '.join(tc.flags))}</code>" if tc.flags else "–"),
                ("Data", E(tc.opts.get("placement", ""))),
                ("License", E(tc.opts.get("license", "")))]
        notes = "".join(f"<li>{E(n)}</li>" for n in tc.opts.get("notes", []))
        dl = "".join(f"<dt>{k}</dt><dd>{v}</dd>" for k, v in rows if v)
        cards.append(f'<article class="card" id="{E(tid)}"><header><h2>{E(tc.display)}</h2>'
                     f'<code class="tid">{E(tid)}</code></header><div class="chips">{chips}</div>'
                     f'<dl>{dl}</dl>{f"<ul>{notes}</ul>" if notes else ""}</article>')
    body = f"""
<h1>Toolchains</h1>
<p class="lede">A toolchain is a compiler plus a fixed set of flags. Each is pinned to a release, and every run records the exact version.</p>
<div class="cards">{"".join(cards)}</div>
"""
    write("toolchains/index.html", page("Toolchains", body, 1, "toolchains/"))


# --- history ---------------------------------------------------------------

def history_page(runs, tcs):
    """Per toolchain, the geomean of its cycles over the benchmarks it passed in
    every run it appears in, so adding a benchmark does not move the line."""
    series = {}
    for tid in {t for r in runs for t in r["toolchains"]}:
        present = [r for r in runs if tid in r["toolchains"]]
        common = None
        for r in present:
            oks = {b for b, row in r["cells"].items()
                   if (row.get(tid) or {}).get("status") == "ok"}
            common = oks if common is None else common & oks
        if not common:
            continue
        for r in present:
            vals = [r["cells"][b][tid]["cycles"] for b in sorted(common)]
            g = math.exp(sum(math.log(v) for v in vals) / len(vals))
            series.setdefault(tid, []).append((r, g, len(vals)))
    order = [t for t in tcs if t in series] + [t for t in series if t not in tcs]
    charts = []
    for tid in order:
        pts = series[tid]
        change = ""
        if len(pts) > 1:
            d = pts[-1][1] / pts[0][1] - 1
            change = (f'<span class="delta {"good" if d < -0.005 else "same" if abs(d) <= 0.005 else "worse"}">'
                      f'{"−" if d < 0 else "+"}{abs(d) * 100:.0f}%</span>')
        charts.append(f'<figure class="mini"><figcaption>{E(tc_label(tcs, tid))}{change}</figcaption>'
                      f'{mini_line(pts, runs)}</figure>')
    head = "".join(f"<th scope='col'>{E(t)}</th>" for t in order)
    rows = []
    for r in runs:
        cells = []
        for tid in order:
            hit = next((x for x in series[tid] if x[0] is r), None)
            cells.append(f"<td>{hit[1]:,.0f}<span class='muted'> ({hit[2]})</span></td>" if hit else "<td>–</td>")
        label = r.get("label") or ""
        rows.append(f"<tr><th scope='row'><a href='../data/runs/{E(r['run_id'])}.json'>{E(r['run_id'])}</a>"
                    f"<div class='muted small'>{E(label)}</div></th>{''.join(cells)}</tr>")
    body = f"""
<h1>History</h1>
<p class="lede">Each toolchain's geometric-mean CPU cycles, run by run, over the benchmarks it passed in every run, so adding a benchmark does not move its line. Each chart has its own scale. Lower is better.</p>
<div class="minis">{"".join(charts)}</div>
<h2>Every run</h2>
<p class="sub">Geomean cycles, with the number of benchmarks it covers in brackets. Versions are in each run record.</p>
<div class="table-wrap"><table class="list num">
<thead><tr><th scope="col">run</th>{head}</tr></thead>
<tbody>{"".join(rows)}</tbody></table></div>
"""
    write("history/index.html", page("History", body, 1, "history/"))


def mini_line(points, runs):
    """A one-series line, x = run order, y from 0 to the max."""
    w, h, pad_l, pad_r, pad_t, pad_b = 280, 112, 10, 62, 14, 22
    n = len(runs)
    idx = {r["run_id"]: i for i, r in enumerate(runs)}
    top = max(g for _, g, _ in points) * 1.15

    def x(i):
        return pad_l + (w - pad_l - pad_r) * (i / max(1, n - 1))

    def y(v):
        return pad_t + (h - pad_t - pad_b) * (1 - v / top)
    pts = [(x(idx[r["run_id"]]), y(g), r, g) for r, g, _ in points]
    path = " ".join(f"{'M' if i == 0 else 'L'}{px:.1f},{py:.1f}" for i, (px, py, _, _) in enumerate(pts))
    area = (f"M{pts[0][0]:.1f},{h - pad_b} " + " ".join(f"L{px:.1f},{py:.1f}" for px, py, _, _ in pts)
            + f" L{pts[-1][0]:.1f},{h - pad_b} Z") if len(pts) > 1 else ""
    dots = "".join(f'<circle cx="{px:.1f}" cy="{py:.1f}" r="4"><title>{E(r["run_id"])}: {g:,.0f} cycles</title></circle>'
                   for px, py, r, g in pts)
    lx, ly, _, lg = pts[-1]
    ticks = "".join(f'<text class="tick" x="{x(i):.1f}" y="{h - 6}" text-anchor="{"start" if i == 0 else "end" if i == n - 1 else "middle"}">{E(r["date"][:10])}</text>'
                    for i, r in enumerate(runs) if i in (0, n - 1))
    return (f'<svg viewBox="0 0 {w} {h}" role="img" aria-label="geomean cycles per run">'
            f'<line class="base" x1="{pad_l}" x2="{w - pad_r}" y1="{h - pad_b}" y2="{h - pad_b}"/>'
            f'<path class="area" d="{area}"/><path class="series" d="{path}"/>{dots}'
            f'<text class="end" x="{lx + 8:.1f}" y="{ly + 4:.1f}">{lg:,.0f}</text>{ticks}</svg>')


# --- method and data -------------------------------------------------------

METHOD = """
<h1>Method</h1>
<section class="prose">
<h2>What is measured</h2>
<ul>
<li><strong>CPU cycles</strong> from the first instruction of <code>bench()</code> through its return. Mesen-GDB breaks on entry, steps out with <code>finish</code>, and reads its cycle counter both times. The counter counts CPU cycles, not master clocks, so SlowROM/FastROM and WRAM wait states are not included.</li>
<li><strong>Code size</strong>: the ROM bytes a benchmark adds over an empty <code>bench()</code> built by the same toolchain. That covers the benchmark's code and constants and any runtime helpers the linker pulls in for it.</li>
<li><strong>Correctness</strong>: <code>bench()</code> returns a 16-bit checksum that the runner reads back and compares with a Python reference. A wrong answer is shown as a failure and never as a time.</li>
</ul>
<h2>Fixed conditions</h2>
<ul>
<li>NMIs and timer IRQs are off (<code>NMITIMEN = 0</code>) before the call, and RAM starts zeroed.</li>
<li><code>bench()</code>, <code>bench_init()</code> and the driver are separate translation units (or <code>#[inline(never)]</code> in R65), so no compiler can inline the timed call into its caller. Inside a benchmark, every compiler inlines what it chooses.</li>
<li>Each compiler's globals go where it puts them by default, which changes addressing modes. Each toolchain's placement is on the <a href="../toolchains/">toolchains</a> page.</li>
<li>Inputs come from a shared 16-bit LCG (<code>v = v·5 + 0x3619</code>), which every source and the reference reproduce.</li>
</ul>
<h2>The sources</h2>
<p>Every implementation of a benchmark uses the same algorithm, integer widths, data sizes and memory layout, written the way a competent user of that language would write it. Compiled sources contain no inline assembly. All C compilers build the same <code>bench.c</code>; they differ only in flags and harness glue (startup code, linker configuration). A source may not drive the SNES multiply/divide registers by hand. A compiler or runtime library that uses them on its own gets the credit.</p>
<h2>The hand-written assembly</h2>
<p>The assembly column is the reference: what a careful 65816 programmer writes by hand. It keeps the same algorithm, inputs, data sizes, array placement and result as the C and R65 versions. Everything the CPU and the SNES offer is fair, as it is for a compiler: processor-width changes, direct-page variables, <code>MVN</code>, the hardware multiplier and divider, unrolling. A different algorithm is not: no lookup-table popcount or CRC, no closed form, and no timed work moved into <code>bench_init()</code>. Its striped bar marks it as a reference, not a compiler; the fastest-compiler figure ignores it.</p>
<h2>Where the programs come from</h2>
<p>The kernels are our own. <code>crc32</code>, <code>pi</code>, <code>fact</code> and <code>sieve_bit</code> use the algorithms of <a href="https://github.com/thred/c-bench-64">c-bench-64</a>, the benchmark set the 6502's C compilers are compared on. They are smaller, to keep each run short, and written fresh: the C uses <code>uint32_t</code>, not <code>long</code> (which is 16 bits in tcc-65816), and the CRC reads generated bytes, not a Commodore 64 ROM. At c-bench-64's own sizes the algorithms give its published answers.</p>
<h2>Reading the ratios</h2>
<p>A ratio divides a result by the best result for the same benchmark among the toolchains on display, so 1.00× is the fastest (or smallest). A toolchain's score is the geometric mean of its ratios over the benchmarks it passed, with its coverage shown when it missed any. No compiler is the default baseline; the leaderboard can be re-based on any toolchain.</p>
<h2>Caveats</h2>
<ul>
<li>These are small kernels. They show code generation in loops and calls, not the speed of whole games.</li>
<li>cc65 and llvm-mos generate 6502-family code. It runs in emulation mode with 8-bit registers, so they are baselines, not 65816 compilers.</li>
<li><code>bench()</code> must not be computable at compile time: its sizes come from data <code>bench_init()</code> writes at run time. A folded result would show as a near-zero cycle count.</li>
<li>Toolchains that cannot be fetched automatically (WDCTools) are measured locally, and their results are committed like any other run.</li>
</ul>
<h2>Disclosure</h2>
<p>The maintainers of this suite also develop the R65 compiler. To keep that from tilting the results, everything is public: the sources, the harness, every toolchain's flags, and every run record. Compiler authors are invited to send pull requests with better flags or more idiomatic sources for their compiler.</p>
</section>
"""


def data_page(runs):
    out = config.SITE_OUT / "data"
    (out / "runs").mkdir(parents=True, exist_ok=True)
    shutil.copy(config.RESULTS / "latest.json", out / "latest.json")
    for p in sorted((config.RESULTS / "runs").glob("*.json")):
        shutil.copy(p, out / "runs" / p.name)
    items = "".join(f'<li><a href="runs/{E(r["run_id"])}.json"><code>{E(r["run_id"])}</code></a> '
                    f'<span class="muted">{E(r.get("label") or "")}</span></li>' for r in reversed(runs))
    body = f"""
<h1>Data</h1>
<p class="lede">Every number on this site comes from these files. A run record holds each toolchain's version and flags, the emulator commit, and every cell's status, cycles, size and returned value. Cells a partial run did not measure carry a <code>measured_in</code> field naming the run that did.</p>
<ul class="runs"><li><a href="latest.json"><code>latest.json</code></a> <span class="muted">the run the leaderboard shows</span></li></ul>
<h2>Run records</h2>
<ul class="runs">{items}</ul>
"""
    write("data/index.html", page("Data", body, 1, "data/"))


def build():
    rec = results.latest()
    if not rec:
        raise SystemExit("no results yet: python3 -m scb run")
    runs = results.load_runs()
    tcs = toolchain.load()
    benches = {n: b for n, b in suite.load().items() if n in rec["cells"]}
    # empty _site/ in place, so a server running inside it keeps working
    config.SITE_OUT.mkdir(parents=True, exist_ok=True)
    for child in config.SITE_OUT.iterdir():
        if child.is_dir():
            shutil.rmtree(child)
        else:
            child.unlink()
    for asset in ("style.css", "app.js"):
        shutil.copy(config.SITE_SRC / asset, config.SITE_OUT / asset)
    (config.SITE_OUT / ".nojekyll").write_text("")
    index_page(rec, tcs, benches)
    bench_index(rec, tcs, benches)
    for b in benches.values():
        bench_page(rec, tcs, b)
    toolchains_page(rec, tcs)
    history_page(runs, tcs)
    write("method/index.html", page("Method", METHOD, 1, "method/"))
    data_page(runs)
    print(f"wrote {config.SITE_OUT}")
