"""Reference result for sum16: Sum a 256-entry u16 array."""
from scb.refs import lcg


def expected():
    return sum(lcg(256)) & 0xFFFF
