"""python3 -m scb {setup,list,run,report,site}"""

import argparse
import sys


def main():
    ap = argparse.ArgumentParser(prog="python3 -m scb",
                                 description="SNES 65816 compiler benchmarks")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("setup", help="fetch and build the toolchains and Mesen-GDB")
    p.add_argument("only", nargs="*", help="steps to run (default: all)")

    sub.add_parser("list", help="benchmarks and toolchains, with availability")

    p = sub.add_parser("run", help="build, time and check benchmarks")
    p.add_argument("-b", "--bench", nargs="+")
    p.add_argument("-t", "--toolchain", nargs="+")
    p.add_argument("--label", help="a note stored with the run record")
    p.add_argument("-j", "--jobs", type=int)

    p = sub.add_parser("report", help="markdown tables from results/latest.json")
    p.add_argument("-t", "--toolchain", nargs="+")

    sub.add_parser("site", help="generate the static site into _site/")

    args = ap.parse_args()
    if args.cmd == "setup":
        from scb import setup
        setup.setup(args.only)
    elif args.cmd == "list":
        from scb import suite, toolchain
        for tid, tc in toolchain.load().items():
            state = "installed" if tc.available() else "missing"
            print(f"{tid:9} {state:9} {tc.display}")
        print()
        for name, b in suite.load().items():
            langs = [lang for lang in ("c", "r65", "asm") if b.source(lang)]
            print(f"{name:10} {'/'.join(langs):10} {b.description}")
    elif args.cmd == "run":
        from scb import run
        run.run(args.bench, args.toolchain, args.label, args.jobs)
    elif args.cmd == "report":
        from scb import report, results
        rec = results.latest()
        if not rec:
            sys.exit("no results yet: python3 -m scb run")
        print(report.markdown(rec, args.toolchain))
    elif args.cmd == "site":
        from scb import site
        site.build()
