/* The factorials 0! to 15!, 20 times over, summed in 32 bits (wrapping): a
 * recursive function and 32-bit multiplies. The algorithm of c-bench-64's
 * fact.c, fewer iterations. Returns the 32-bit sum folded to 16 bits. */
#include "bench.h"
#include <stdint.h>

#define N_ITER 20
#define SIZE 16

uint32_t array[SIZE];

/* Set at run time, so no compiler can work the result out at compile time. */
u16 n_iter, size;

void bench_init(void)
{
    n_iter = N_ITER;
    size = SIZE;
}

uint32_t fact(u16 i)
{
    if (i > 1)
        return i * fact(i - 1);
    return 1;
}

u16 bench(void)
{
    u16 i, j;
    uint32_t res = 0;

    for (j = 0; j < size; j++)
        array[j] = 0;
    for (i = 0; i < n_iter; i++)
        for (j = 0; j < size; j++)
            array[j] += fact(j);
    for (j = 0; j < size; j++)
        res += array[j];
    return (u16)(res >> 16) ^ (u16)res;
}
