/* Sieve of Eratosthenes over 1024 byte flags; returns the prime count. */
#define N 1024

unsigned char flags[N];

void bench_init(void)
{
}

unsigned int bench(void)
{
    unsigned int i, j, count = 0;
    for (i = 0; i < N; i++)
        flags[i] = 0;
    for (i = 2; i < N; i++) {
        if (flags[i] == 0) {
            count++;
            for (j = i + i; j < N; j += i)
                flags[j] = 1;
        }
    }
    return count;
}
