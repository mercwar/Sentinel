/* AVIS_FILE_NAME: sentinel_v1.c */
#include <stdio.h>

int main() {
    // Exact AVIS signature: MERC  ÿ
    unsigned char avis_sig[] = {0x4D, 0x45, 0x52, 0x43, 0x20, 0x20, 0xFF};

    FILE *f = fopen("Beacon/mercwar_discovery.bin", "wb");
    if (f == NULL) return 1;

    // Writing raw bytes directly ensures no encoding interference at runtime
    fwrite(avis_sig, 1, sizeof(avis_sig), f);
    fclose(f);

    printf("BASH: [ACK] AVIS: Binary locked. Transcoding blocked via .gitattributes.\n");
    return 0;
}
