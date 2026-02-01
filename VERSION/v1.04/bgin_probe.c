#BGIN
/* AVIS_COORD: VERSION/v1.04/SOURCE/bgin_probe.c */
/* AVIS_ROLE: Validator_v1.04 */
/* PULSE: 0xDEADBEEF */

#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("[BGIN ERROR] NO TARGET SPECIFIED.\n");
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        printf("[BGIN ERROR] FAILED TO OPEN %s\n", argv[1]);
        return 1;
    }

    char buf[1024];
    int valid = 0;
    while (fgets(buf, sizeof(buf), fp)) {
        if (strstr(buf, "#BGIN")) valid = 1;
    }
    fclose(fp);

    if (valid) {
        printf("[BGIN SUCCESS] %s VERIFIED v1.03\n", argv[1]);
        return 0;
    } else {
        printf("[BGIN FAIL] %s CORRUPTED OR LEGACY\n", argv[1]);
        return 1;
    }
}
#!#