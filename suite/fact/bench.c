/* The factorials 0! to 15!, 20 times over, summed in 32 bits (wrapping): a
 * recursive function and 32-bit multiplies. The algorithm of c-bench-64's
 * fact.c, fewer iterations. Returns the 32-bit sum folded to 16 bits. */
#include <stdint.h>

#define N_ITER 20
#define SIZE 16

uint32_t array[SIZE];

/* Set at run time, so no compiler can work the result out at compile time. */
unsigned int n_iter, size;

void bench_init(void)
{
    n_iter = N_ITER;
    size = SIZE;
}

uint32_t fact(unsigned int i)
{
    uint32_t r;

    if (i > 1) {
        r = fact(i - 1);
        return i * r;
    }
    return 1;
}

unsigned int bench(void)
{
    unsigned int i, j;
    uint32_t res = 0;

    for (j = 0; j < size; j++)
        array[j] = 0;
    for (i = 0; i < n_iter; i++)
        for (j = 0; j < size; j++)
            array[j] += fact(j);
    for (j = 0; j < size; j++)
        res += array[j];
    return (unsigned int)(res >> 16) ^ (unsigned int)res;
}
