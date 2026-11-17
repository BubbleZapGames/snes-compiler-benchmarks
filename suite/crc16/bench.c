/* Bitwise CRC-16/CCITT-FALSE over 256 bytes. */
#define N 256

unsigned char buf[N];

void bench_init(void)
{
    unsigned int i, v = 1;
    for (i = 0; i < N; i++) {
        v = (v << 2) + v + 0x3619;
        buf[i] = (unsigned char)(v >> 8);
    }
}

unsigned int bench(void)
{
    unsigned int i, crc = 0xFFFF;
    unsigned char b;
    for (i = 0; i < N; i++) {
        crc ^= (unsigned int)buf[i] << 8;
        for (b = 0; b < 8; b++) {
            if (crc & 0x8000)
                crc = (crc << 1) ^ 0x1021;
            else
                crc <<= 1;
        }
    }
    return crc;
}
