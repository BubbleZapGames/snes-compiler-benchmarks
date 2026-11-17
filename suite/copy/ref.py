"""Reference result for copy: Byte-at-a-time copy of 1024 bytes."""
from scb.refs import lcg


def expected():
    src = [v >> 8 for v in lcg(1024)]
    return (src[0] + src[511] + src[1023]) & 0xFFFF
