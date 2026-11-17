"""Reference result for sieve_bit: the number of primes up to 2*8000 + 1."""

SIZE = 8000


def expected():
    limit = 2 * SIZE + 1
    is_prime = [True] * (limit + 1)
    is_prime[0] = is_prime[1] = False
    for p in range(2, int(limit ** 0.5) + 1):
        if is_prime[p]:
            for q in range(p * p, limit + 1, p):
                is_prime[q] = False
    return sum(is_prime)
