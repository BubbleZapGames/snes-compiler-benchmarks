"""Reference result for bfs_grid: BFS over a 32x32 tile map; the sum of distances."""
from scb.refs import lcg

W = 32


def grid():
    g = []
    for i, v in enumerate(lcg(W * W)):
        x, y = i % W, i // W
        border = x in (0, W - 1) or y in (0, W - 1)
        g.append(1 if border or ((v >> 8) & 3) == 0 else 0)
    return g


def expected():
    g = grid()
    start = W + 1
    g[start] = 0
    dist = [0xFF] * (W * W)
    queue = [0] * 256
    dist[start] = 0
    queue[0], head, tail, s = start, 0, 1, 0
    while head != tail:
        c = queue[head]
        head = (head + 1) & 255
        s += dist[c]
        d = dist[c] + 1
        for n in (c - W, c - 1, c + 1, c + W):
            if g[n] == 0 and dist[n] == 0xFF:
                dist[n] = d
                queue[tail] = n
                tail = (tail + 1) & 255
    return s & 0xFFFF
