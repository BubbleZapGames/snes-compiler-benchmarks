"""Reference result for fib: Naive recursive Fibonacci: call and stack-frame overhead."""


def expected():
    a, b = 0, 1
    for _ in range(16):
        a, b = b, a + b
    return a
