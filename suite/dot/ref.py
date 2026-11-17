"""Reference result for dot: u8 x u8 dot product over 64 elements: the multiply routine."""
from scb.refs import lcg


def expected():
    vs = lcg(64)
    return sum((v >> 8) * (v & 0xFF) for v in vs) & 0xFFFF
