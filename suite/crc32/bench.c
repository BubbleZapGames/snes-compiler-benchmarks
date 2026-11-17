/* CRC-32/CKSUM (without the length) of 1024 bytes, a bit at a time: 32-bit
 * shifts and xors. The algorithm of c-bench-64's crc32.c, on generated input.
 * Returns the 32-bit CRC folded to 16 bits. */
#include "bench.h"
#include <stdint.h>

#define N 1024

unsigned char data[N];

void bench_init(void)
{
    u16 i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        data[i] = (unsigned char)(v >> 8);
    }
}

u16 bench(void)
{
    uint32_t crc = 0;
    u16 i;
    unsigned char j;

    for (i = 0; i < N; i++) {
        crc ^= (uint32_t)data[i] << 24;
        for (j = 8; j; j--) {
            if (crc & (uint32_t)0x80000000)
                crc = (crc << 1) ^ (uint32_t)0x04C11DB7;
            else
                crc <<= 1;
        }
    }
    crc ^= (uint32_t)0xFFFFFFFF;
    return (u16)(crc >> 16) ^ (u16)crc;
}
