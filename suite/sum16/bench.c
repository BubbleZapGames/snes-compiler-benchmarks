/* Sum a 256-entry u16 array. */
#define N 256

unsigned int data[N];

void bench_init(void)
{
    unsigned int i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        data[i] = v;
    }
}

unsigned int bench(void)
{
    unsigned int i, s = 0;
    for (i = 0; i < N; i++)
        s += data[i];
    return s;
}
