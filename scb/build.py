"""What every adapter shares: the Build record, errors and subprocess plumbing."""

import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path


class BuildError(Exception):
    pass


@dataclass
class Build:
    rom: Path
    bench: int       # address of bench()
    done: int        # address of done(), hit after the result is stored
    result: int      # address of the u16 the driver stores bench()'s value in
    rom_bytes: int   # ROM bytes in use (the runner subtracts the stub's)


def sh(cmd, cwd, env=None, timeout=300):
    p = subprocess.run([str(c) for c in cmd], cwd=cwd, env=env, capture_output=True,
                       text=True, timeout=timeout)
    if p.returncode != 0:
        raise BuildError(f"{' '.join(map(str, cmd))}\n{p.stdout}{p.stderr}".strip())
    return p.stdout + p.stderr


def fresh(path):
    shutil.rmtree(path, ignore_errors=True)
    path.mkdir(parents=True)
    return path


def git_commit(path):
    try:
        p = subprocess.run(["git", "-C", str(path), "rev-parse", "--short=8", "HEAD"],
                           capture_output=True, text=True)
        return p.stdout.strip() or None
    except OSError:
        return None
