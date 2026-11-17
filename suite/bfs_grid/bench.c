/* Breadth-first search over a 32x32 tile map, as in enemy pathfinding: a
 * distance map from one start cell, with a 256-entry ring-buffer queue.
 * Returns the sum of distances over the cells reached. */
#define W 32
#define QN 256

unsigned char grid[W * W];     /* 0 = floor, 1 = wall; the border is wall */
unsigned char dist[W * W];     /* 0xFF = not reached */
unsigned int queue[QN];
unsigned int start, tail;

void bench_init(void)
{
    unsigned int i, x, y, v = 1;
    for (i = 0; i < W * W; i++) {
        v = (v << 2) + v + 0x3619;
        x = i & (W - 1);
        y = i >> 5;
        if (x == 0 || x == W - 1 || y == 0 || y == W - 1 || ((v >> 8) & 3) == 0)
            grid[i] = 1;
        else
            grid[i] = 0;
    }
    start = W + 1;
    grid[start] = 0;
}

void visit(unsigned int n, unsigned char d)
{
    if (grid[n] == 0 && dist[n] == 0xFF) {
        dist[n] = d;
        queue[tail] = n;
        tail = (tail + 1) & (QN - 1);
    }
}

unsigned int bench(void)
{
    unsigned int i, c, head, s = 0;
    unsigned char d;
    for (i = 0; i < W * W; i++)
        dist[i] = 0xFF;
    dist[start] = 0;
    queue[0] = start;
    head = 0;
    tail = 1;
    while (head != tail) {
        c = queue[head];
        head = (head + 1) & (QN - 1);
        s += dist[c];
        d = dist[c] + 1;
        visit(c - W, d);
        visit(c - 1, d);
        visit(c + 1, d);
        visit(c + W, d);
    }
    return s;
}
