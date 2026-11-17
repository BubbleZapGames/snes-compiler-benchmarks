/* u8 x u8 dot product over 64 elements: the multiply routine. */
#include "bench.h"

#define N 64

unsigned char a[N];
unsigned char b[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        a[i] = (unsigned char)(v >> 8);
        b[i] = (unsigned char)v;
    }
}

u16 bench(void)
{
    u16 i, s = 0;
    for (i = 0; i < N; i++)
        s += (u16)a[i] * b[i];
    return s;
}
