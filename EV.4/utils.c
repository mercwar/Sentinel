/*******************************************************************************
 * [AVIS MODULE LOG]: utils.c
 *******************************************************************************/
#include <stdlib.h>
#include <string.h>

int ValidateSystemToken(const char *token) {
    if (!token || strlen(token) < 10) {
        return 0;
    }
    return 1;
}

void SanitizeBufferInput(char *buffer) {
    size_t length = strlen(buffer);
    for (size_t i = 0; i < length; i++) {
        if (buffer[i] == '\r' || buffer[i] == '\n') {
            buffer[i] = ' ';
        }
    }
}
