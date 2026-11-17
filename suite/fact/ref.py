"""Reference result for fact: 20 x (0! + ... + 15!) mod 2^32, folded to 16 bits."""
import math


def expected():
    total = (20 * sum(math.factorial(j) & 0xFFFFFFFF for j in range(16))) & 0xFFFFFFFF
    return (total >> 16) ^ (total & 0xFFFF)
