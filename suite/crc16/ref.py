"""Reference result for crc16: Bitwise CRC-16/CCITT-FALSE over 256 bytes."""
from scb.refs import lcg


def expected():
    crc = 0xFFFF
    for v in lcg(256):
        crc ^= (v >> 8) << 8
        for _ in range(8):
            crc = ((crc << 1) ^ 0x1021) if crc & 0x8000 else (crc << 1)
            crc &= 0xFFFF
    return crc
