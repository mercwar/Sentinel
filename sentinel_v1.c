/* AVIS_FILE_NAME: sentinel_v1.c */
/* AVIS_SIG: MERC  \xff */

#include <stdio.h>

int main() {
    // We use a hex escape string to keep GitHub from freaking out about UTF-16
    // This looks like text to GitHub, but compiles to the exact binary you need.
    const char *avis_sig = "MERC  \xff";

    FILE *f = fopen("Beacon/mercwar_discovery.bin", "wb");
    if (f == NULL) return 1;

    // We write exactly 7 bytes: M, E, R, C, space, space, 0xFF
    fwrite(avis_sig, 1, 7, f);
    fclose(f);

    printf("BASH: [ACK] AVIS: mercwar_discovery.bin materialized via hex-escape.\n");
    return 0;
}
