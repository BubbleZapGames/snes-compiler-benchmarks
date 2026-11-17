"""Reference result for crc32: CRC-32/CKSUM (no length) folded to 16 bits."""
from scb.refs import lcg


def crc32_cksum(data):
    crc = 0
    for b in data:
        crc ^= b << 24
        for _ in range(8):
            crc = ((crc << 1) ^ 0x04C11DB7) if crc & 0x80000000 else (crc << 1)
            crc &= 0xFFFFFFFF
    return crc ^ 0xFFFFFFFF


def expected():
    # CRC-32/POSIX check value (catalogue of CRC algorithms): "123456789" -> 0x765E7680
    assert crc32_cksum(b"123456789") == 0x765E7680
    crc = crc32_cksum([v >> 8 for v in lcg(1024)])
    return (crc >> 16) ^ (crc & 0xFFFF)
