/* 16 frames of moving and bouncing 32 entities: an array of 9-byte structs. */
#include "bench.h"

#define N 32

struct entity {
    u16 x, y, vx, vy;
    unsigned char alive;
};

struct entity ents[N];

void bench_init(void)
{
    u16 i;
    for (i = 0; i < N; i++) {
        ents[i].x = (i << 3) - i;
        ents[i].y = (i << 2) + i;
        ents[i].vx = (i & 3) + 1;
        ents[i].vy = (i & 1) + 2;
        ents[i].alive = (i & 3) != 0;
    }
}

u16 bench(void)
{
    u16 f, i, s = 0;
    for (f = 0; f < 16; f++) {
        for (i = 0; i < N; i++) {
            if (ents[i].alive) {
                ents[i].x += ents[i].vx;
                if (ents[i].x > 240)
                    ents[i].vx = 0 - ents[i].vx;
                ents[i].y += ents[i].vy;
                if (ents[i].y > 200)
                    ents[i].vy = 0 - ents[i].vy;
            }
        }
    }
    for (i = 0; i < N; i++)
        s += ents[i].x + ents[i].y;
    return s;
}
