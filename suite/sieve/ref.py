"""Reference result for sieve: Sieve of Eratosthenes over 1024 byte flags; returns the prime count."""


def expected():
    flags = [0] * 1024
    count = 0
    for i in range(2, 1024):
        if not flags[i]:
            count += 1
            for j in range(i + i, 1024, i):
                flags[j] = 1
    return count
