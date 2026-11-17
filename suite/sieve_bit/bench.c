/* Sieve of Eratosthenes over the odd numbers with one bit per flag, through a
 * bit-mask table: the primes up to 16001. The algorithm of c-bench-64's
 * sieve_bit.c, smaller. Returns the prime count. */
#define SIZE 8000

unsigned char flags[SIZE / 8 + 1];

static const unsigned char bitv[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };

void bench_init(void)
{
}

unsigned char check_flag(unsigned int idx)
{
    return flags[idx / 8] & bitv[idx & 7];
}

void clear_flag(unsigned int idx)
{
    flags[idx / 8] &= ~bitv[idx & 7];
}

unsigned int bench(void)
{
    unsigned int i, prime, k, count = 1;    /* 2 is prime */

    for (i = 0; i < SIZE / 8 + 1; i++)
        flags[i] = 0xff;
    for (i = 0; i < SIZE; i++) {
        if (check_flag(i)) {                /* flag i stands for 2i + 3 */
            prime = i + i + 3;
            for (k = i + prime; k < SIZE; k += prime)
                clear_flag(k);
            count++;
        }
    }
    return count;
}
