/* u8 x u8 dot product over 64 elements: the multiply routine. */
#define N 64

unsigned char a[N];
unsigned char b[N];

void bench_init(void)
{
    unsigned int i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        a[i] = (unsigned char)(v >> 8);
        b[i] = (unsigned char)v;
    }
}

unsigned int bench(void)
{
    unsigned int i, s = 0;
    for (i = 0; i < N; i++)
        s += (unsigned int)a[i] * b[i];
    return s;
}
