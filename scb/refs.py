"""Helpers shared by the suite's ref.py files."""


def lcg(n):
    """The suite's input generator: v = v*5 + 0x3619 (mod 2^16), from v = 1."""
    v, out = 1, []
    for _ in range(n):
        v = (v * 5 + 0x3619) & 0xFFFF
        out.append(v)
    return out
