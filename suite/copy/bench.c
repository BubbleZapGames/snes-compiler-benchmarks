/* Byte-at-a-time copy of 1024 bytes. */
#include "bench.h"

#define N 1024

unsigned char src[N];
unsigned char dst[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        src[i] = (unsigned char)(v >> 8);
    }
}

u16 bench(void)
{
    u16 i;
    for (i = 0; i < N; i++)
        dst[i] = src[i];
    return dst[0] + dst[511] + dst[1023];
}
