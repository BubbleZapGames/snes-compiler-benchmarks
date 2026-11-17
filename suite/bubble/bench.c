/* Bubble sort 64 bytes, then fold them into a checksum. */
#include "bench.h"

#define N 64

unsigned char arr[N];

void bench_init(void)
{
    u16 v = 1;
    unsigned char i;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        arr[i] = (unsigned char)(v >> 8);
    }
}

u16 bench(void)
{
    unsigned char i, j, t;
    u16 s = 0;
    for (i = 0; i < N - 1; i++) {
        for (j = 0; j < N - 1 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                t = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = t;
            }
        }
    }
    for (i = 0; i < N; i++)
        s = (s << 1) ^ arr[i];
    return s;
}
