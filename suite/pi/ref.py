"""Reference result for pi: the spigot's 4-digit groups, summed, checked
against pi computed independently (Machin's formula)."""

TERMS = 196


def spigot_groups():
    arr = [2000] * (TERMS + 1)
    carry, groups = 0, []
    for i in range(TERMS, 0, -14):
        s = 0
        for j in range(i, 0, -1):
            d = 2 * j - 1
            s = s * j + 10000 * arr[j]
            assert s < 1 << 32                  # fits the 32-bit sum
            arr[j] = s % d
            s //= d
        groups.append(carry + s // 10000)
        carry = s % 10000
    return groups


def pi_digits(n):
    """The first n decimal digits of pi, 3 included (Machin, integer arithmetic)."""
    scale = 10 ** (n + 10)

    def arctan_inv(x):
        total, term, k, sign = 0, scale // x, 1, 1
        while term:
            total += sign * (term // k)
            term //= x * x
            k += 2
            sign = -sign
        return total
    pi = 4 * (4 * arctan_inv(5) - arctan_inv(239))
    return str(pi // 10 ** 10)[:n]


def expected():
    groups = spigot_groups()
    assert "".join(f"{g:04d}" for g in groups) == pi_digits(4 * len(groups))
    return sum(groups) & 0xFFFF
