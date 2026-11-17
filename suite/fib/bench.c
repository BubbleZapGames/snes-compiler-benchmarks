/* Naive recursive Fibonacci: call and stack-frame overhead. */
void bench_init(void)
{
}

unsigned int fib(unsigned int n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

unsigned int bench(void)
{
    return fib(16);
}
