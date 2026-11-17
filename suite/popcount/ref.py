"""Reference result for popcount: Count the set bits in 256 bytes, one shift at a time."""
from scb.refs import lcg


def expected():
    return sum(bin(v >> 8).count("1") for v in lcg(256))
