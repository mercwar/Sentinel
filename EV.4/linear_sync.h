/*******************************************************************************
 * [AVIS MODULE LOG]: linear_sync.h
 *******************************************************************************/
#ifndef LINEAR_SYNC_H
#define LINEAR_SYNC_H

#include <stddef.h>

struct MemoryStruct {
    char *memory;
    size_t size;
};

#define MAX_HEADER_READ_BUDGET 16384
#define MAX_JSON_PAYLOAD_BUDGET 32768

size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp);
char* ReadLocalHeaderFile(const char *filename);

#endif
