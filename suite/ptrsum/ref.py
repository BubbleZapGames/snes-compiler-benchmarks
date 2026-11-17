"""Reference result for ptrsum: Sum 512 bytes through a pointer argument."""
from scb.refs import lcg


def expected():
    return sum(v >> 8 for v in lcg(512)) & 0xFFFF
