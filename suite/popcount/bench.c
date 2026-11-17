/* Count the set bits in 256 bytes, one shift at a time. */
#include "bench.h"

#define N 256

unsigned char buf[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        buf[i] = (unsigned char)(v >> 8);
    }
}

u16 bench(void)
{
    u16 i, c = 0;
    unsigned char v;
    for (i = 0; i < N; i++) {
        v = buf[i];
        while (v) {
            c += v & 1;
            v >>= 1;
        }
    }
    return c;
}
