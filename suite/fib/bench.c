/* Naive recursive Fibonacci: call and stack-frame overhead. */
#include "bench.h"

void bench_init(void)
{
}

u16 fib(u16 n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

u16 bench(void)
{
    return fib(16);
}
