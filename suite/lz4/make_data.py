"""The lz4 benchmark's input: a 1024-byte buffer and its LZ4 block encoding.

    python3 suite/lz4/make_data.py          # print the compressed size
    python3 suite/lz4/make_data.py --write  # rewrite the tables in bench.c and bench.r65

The buffer mixes what SNES data looks like: tilemap rows that repeat with
small changes, text, noise that stays literal, and long runs of one byte
(matches whose offset is shorter than their length). It exercises every
part of the format: extended literal and match lengths, overlapping copies,
and a final literal-only sequence.
"""

import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SIZE = 1024


def lcg(n, v=1):
    out = []
    for _ in range(n):
        v = (v * 5 + 0x3619) & 0xFFFF
        out.append(v)
    return out


def original():
    data = bytearray()
    noise = iter(v >> 8 for v in lcg(4096))
    text = b"SNES COMPILER BENCHMARKS: LZ4 BLOCK DECODE. "
    row = bytes((0x20 + (i % 8)) for i in range(32))
    rnd = iter(lcg(4096, 7))
    n = 0
    while len(data) < SIZE:
        for k in range(3):                       # tilemap rows, two tiles changed per row
            r = bytearray(row)
            r[next(rnd) % 32] = 0x40 + n % 16
            r[next(rnd) % 32] = 0x50 + k
            data += r
        data += bytes(next(noise) for _ in range(5 + n * 4))   # literals, growing past 15
        cut = next(rnd) % 24
        data += text[cut:cut + 12 + n % 9]       # a piece of the text
        data += bytes([0x00]) * (8 + n * 9)      # a run: offset 1, growing past 19
        n += 1
    return bytes(data[:SIZE])


def compress(src):
    """Greedy LZ4 block compressor (format rules: the last 5 bytes are literals,
    and no match starts within the last 12 bytes)."""
    n = len(src)
    out = bytearray()
    lit_start = 0
    i = 0
    limit = n - 12

    def length_bytes(extra):
        bs = bytearray()
        while extra >= 255:
            bs.append(255)
            extra -= 255
        bs.append(extra)
        return bs

    while i < limit:
        best_len, best_off = 0, 0
        for j in range(max(0, i - 65535), i):
            k = 0
            while i + k < n - 5 and src[j + k] == src[i + k]:
                k += 1
            if k > best_len:
                best_len, best_off = k, i - j
        if best_len < 4:
            i += 1
            continue
        lits = src[lit_start:i]
        ml = best_len - 4
        out.append((min(len(lits), 15) << 4) | min(ml, 15))
        if len(lits) >= 15:
            out += length_bytes(len(lits) - 15)
        out += lits
        out += bytes([best_off & 0xFF, best_off >> 8])
        if ml >= 15:
            out += length_bytes(ml - 15)
        i += best_len
        lit_start = i
    lits = src[lit_start:]
    out.append(min(len(lits), 15) << 4)
    if len(lits) >= 15:
        out += length_bytes(len(lits) - 15)
    out += lits
    return bytes(out)


def decompress(block):
    out = bytearray()
    i = 0
    while True:
        tok = block[i]; i += 1
        n = tok >> 4
        if n == 15:
            while True:
                b = block[i]; i += 1; n += b
                if b != 255:
                    break
        out += block[i:i + n]; i += n
        if i >= len(block):
            return bytes(out)
        off = block[i] | (block[i + 1] << 8); i += 2
        n = tok & 15
        if n == 15:
            while True:
                b = block[i]; i += 1; n += b
                if b != 255:
                    break
        for _ in range(n + 4):
            out.append(out[-off])


def table(block, indent, per_line=16):
    rows = []
    for k in range(0, len(block), per_line):
        rows.append(indent + ", ".join(f"0x{b:02X}" for b in block[k:k + per_line]) + ",")
    return "\n".join(rows)


def write():
    src = original()
    block = compress(src)
    assert decompress(block) == src
    c = HERE / "bench.c"
    text = c.read_text()
    text = re.sub(r"#define LZ_N \d+", f"#define LZ_N {len(block)}", text)
    text = re.sub(r"(/\* begin data \*/\n).*?(    /\* end data \*/)",
                  lambda m: m.group(1) + table(block, "    ") + "\n" + m.group(2), text, flags=re.S)
    c.write_text(text)
    r = HERE / "bench.r65"
    text = r.read_text()
    text = re.sub(r"\[u8; \d+\] = \[", f"[u8; {len(block)}] = [", text, count=1)
    text = re.sub(r"const LZ_N: u16 = \d+;", f"const LZ_N: u16 = {len(block)};", text)
    text = re.sub(r"(// begin data\n).*?(    // end data)",
                  lambda m: m.group(1) + table(block, "    ") + "\n" + m.group(2), text, flags=re.S)
    r.write_text(text)


if __name__ == "__main__":
    src = original()
    block = compress(src)
    assert decompress(block) == src
    print(f"{len(src)} bytes -> {len(block)} bytes")
    if "--write" in sys.argv:
        write()
        print("rewrote bench.c and bench.r65")
