/* Sum 512 bytes through a pointer argument. */
#define N 512

unsigned char buf[N];

void bench_init(void)
{
    unsigned int i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        buf[i] = (unsigned char)(v >> 8);
    }
}

unsigned int sum_bytes(const unsigned char *p, unsigned int n)
{
    unsigned int i, s = 0;
    for (i = 0; i < n; i++)
        s += p[i];
    return s;
}

unsigned int bench(void)
{
    return sum_bytes(buf, N);
}
