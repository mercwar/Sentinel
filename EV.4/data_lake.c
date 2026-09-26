/*******************************************************************************
 * [AVIS MODULE LOG]: data_lake.c
 *******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "data_lake.h"
#include "config.h"

void ConstructDataLakePath(char *out_buffer, size_t max_len, const char *filename) {
    time_t t = time(NULL);
    struct tm tm_info;
    localtime_s(&tm_info, &t);

    snprintf(out_buffer, max_len, "%s\\dl\\%04d\\%02d\\%02d\\%s",
             LOCAL_PERSISTENCE_ROOT,
             tm_info.tm_year + 1900,
             tm_info.tm_mon + 1,
             tm_info.tm_mday,
             filename);
}

int WritePayloadToDataLake(const char *payload, const char *target_filename) {
    char full_path[512];
    ConstructDataLakePath(full_path, sizeof(full_path), target_filename);

    FILE *file = fopen(full_path, "w");
    if (!file) return 0;

    fprintf(file, "%s", payload);
    fclose(file);
    return 1;
}
