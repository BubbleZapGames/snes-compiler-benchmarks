/* Naive recursive Fibonacci: call and stack-frame overhead. */
void bench_init(void)
{
}

unsigned int fib(unsigned int n)
{
    unsigned int a, b;

    if (n < 2)
        return n;
    a = fib(n - 1);
    b = fib(n - 2);
    return a + b;
}

unsigned int bench(void)
{
    return fib(16);
}
