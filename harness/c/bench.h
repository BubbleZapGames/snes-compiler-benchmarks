/* The suite's 16-bit unsigned type. C only promises that int has at least 16
 * bits, and the benchmarks rely on 16-bit wraparound. u16 is unsigned int
 * where int is 16 bits, which is every entrant but JCC816 (24-bit int), and
 * uint16_t elsewhere. Using uint16_t everywhere is not neutral: some
 * compilers make it unsigned short and compile short worse than int. */
#ifndef BENCH_H
#define BENCH_H
#include <limits.h>
#if defined(UINT_MAX) && UINT_MAX > 0xFFFF
#include <stdint.h>
typedef uint16_t u16;
#else
typedef unsigned int u16;
#endif
#endif
