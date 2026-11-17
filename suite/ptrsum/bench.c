/* Sum 512 bytes through a pointer argument. */
#include "bench.h"

#define N 512

unsigned char buf[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        buf[i] = (unsigned char)(v >> 8);
    }
}

u16 sum_bytes(const unsigned char *p, u16 n)
{
    u16 i, s = 0;
    for (i = 0; i < n; i++)
        s += p[i];
    return s;
}

u16 bench(void)
{
    return sum_bytes(buf, N);
}
