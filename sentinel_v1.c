/* AVIS_FILE_NAME: sentinel_v1.c */
/* AVIS_STATUS: NORMAL_ASCII_ENCODING */

#include <stdio.h>

int main() {
    // We define the signature as standard integers to keep the file ASCII safe.
    // 77, 69, 82, 67 = MERC
    // 32, 32 = Spaces
    // 255 = The 0xFF byte (The Kill Signal)
    unsigned char sig[7];
    sig[0] = 77;  // M
    sig[1] = 69;  // E
    sig[2] = 82;  // R
    sig[3] = 67;  // C
    sig[4] = 32;  // Space
    sig[5] = 32;  // Space
    sig[6] = 255; // 0xFF (ÿ) - Pure math, no encoding errors

    FILE *f = fopen("Beacon/mercwar_discovery.bin", "wb");
    if (f == NULL) return 1;

    fwrite(sig, 1, 7, f);
    fclose(f);

    printf("BASH: [ACK] AVIS: mercwar_discovery.bin dropped via ASCII-safe math.\n");
    return 0;
}
