"""Reference result for entities: 16 frames of moving and bouncing 32 entities: an array of 9-byte structs."""


def expected():
    ents = [[(i << 3) - i, (i << 2) + i, (i & 3) + 1, (i & 1) + 2, (i & 3) != 0]
            for i in range(32)]
    for _ in range(16):
        for e in ents:
            if e[4]:
                e[0] = (e[0] + e[2]) & 0xFFFF
                if e[0] > 240:
                    e[2] = (-e[2]) & 0xFFFF
                e[1] = (e[1] + e[3]) & 0xFFFF
                if e[1] > 200:
                    e[3] = (-e[3]) & 0xFFFF
    return sum(e[0] + e[1] for e in ents) & 0xFFFF
