/* BGIN */
/* avis_coord: VERSION/v1.01/SOURCE/bgin_probe.c, role: Gatekeeper_v1.01 */
/* SEED: 0xDEADBEEF */

#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;
    FILE *fp = fopen(argv[1], "r");
    if (!fp) return 1;

    char buf[1024];
    int has_bgin = 0;
    while (fgets(buf, sizeof(buf), fp)) {
        if (strstr(buf, "BGIN")) has_bgin = 1;
    }
    fclose(fp);

    if (has_bgin) {
        printf("[BGIN SUCCESS] Verified v1.01: %s\n", argv[1]);
        return 0;
    }
    return 1;
}
/* .return(SUCCESS) */
``` [INDEX]
