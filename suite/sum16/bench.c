/* Sum a 256-entry u16 array. */
#include "bench.h"

#define N 256

u16 data[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        data[i] = v;
    }
}

u16 bench(void)
{
    u16 i, s = 0;
    for (i = 0; i < N; i++)
        s += data[i];
    return s;
}
