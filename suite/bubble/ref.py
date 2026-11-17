"""Reference result for bubble: Bubble sort 64 bytes, then fold them into a checksum."""
from scb.refs import lcg


def expected():
    s = 0
    for b in sorted(v >> 8 for v in lcg(64)):
        s = ((s << 1) ^ b) & 0xFFFF
    return s
