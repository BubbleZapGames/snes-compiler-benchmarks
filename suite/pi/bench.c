/* 56 digits of pi from the Rabinowitz-Wagon spigot over 196 terms: 32-bit
 * multiplies, divides and remainders by 16-bit values. The algorithm of
 * c-bench-64's pi.c, smaller. Returns the sum of the 4-digit groups. */
#include <stdint.h>

#define SCALE 10000
#define ARRINIT 2000
#define TERMS 196

unsigned int arr[TERMS + 1];

void bench_init(void)
{
}

unsigned int bench(void)
{
    unsigned int i, j, d, carry = 0, s = 0;
    uint32_t sum;

    for (i = 0; i <= TERMS; i++)
        arr[i] = ARRINIT;
    for (i = TERMS; i > 0; i -= 14) {
        sum = 0;
        for (j = i; j > 0; j--) {
            d = j * 2 - 1;
            sum = sum * j + (uint32_t)SCALE * arr[j];
            arr[j] = (unsigned int)(sum % d);
            sum /= d;
        }
        s += carry + (unsigned int)(sum / SCALE);   /* the next four digits */
        carry = (unsigned int)(sum % SCALE);
    }
    return s;
}
