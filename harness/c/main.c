/* Shared driver for every C toolchain. bench() lives in its own translation
 * unit so no compiler can inline it here; the harness breaks on bench's
 * entry, steps out of it, and reads the cycle counter on both sides. */

extern void bench_init(void);
extern unsigned int bench(void);
extern void done(void);

unsigned int result;

int main(void)
{
    /* NMITIMEN = 0: no NMI or timer IRQ can land inside the timed call. */
    *(volatile unsigned char *)0x4200 = 0;
    bench_init();
    result = bench();
    done();
    for (;;) {
    }
    return 0;
}
