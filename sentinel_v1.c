/* * PROJECT: AVIS-2026 | SENTINEL PROBE v1.1
 * ARCH: x86_64 | OWNER: Joseph Michael Catalano (CVBGOD)
 * ROLE: XML Dispatcher & Handshake Validator
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_BUF 1024
#define SIGNATURE "BGIN 0xDEADBEEF 1.1.CVBGOD"

int verify_binary(const char *filepath) {
    FILE *file = fopen(filepath, "r");
    if (!file) {
        printf("[BGIN ERROR] Object Access Denied: %s\n", filepath);
        return 0;
    }

    char line[MAX_BUF];
    int found = 0;
    while (fgets(line, sizeof(line), file)) {
        if (strstr(line, SIGNATURE)) {
            found = 1;
            break;
        }
    }
    fclose(file);
    return found;
}

void dispatch_from_xml(const char *xml_path, const char *node_id) {
    // In a full build, use an XML library. For Tron-speed, we scan the text.
    FILE *xml = fopen(xml_path, "r");
    if (!xml) return;

    char line[MAX_BUF];
    char search_tag[64];
    sprintf(search_tag, "id=\"%s\"", node_id);

    while (fgets(line, sizeof(line), xml)) {
        if (strstr(line, search_tag)) {
            // Look for the binary path in the next lines
            while (fgets(line, sizeof(line), xml)) {
                if (strstr(line, "path=\"")) {
                    char *start = strstr(line, "path=\"") + 6;
                    char *end = strstr(start, "\"");
                    *end = '\0';
                    
                    printf("[AVIS DISPATCH] Executing: %s\n", start);
                    system(start); // Fires the EXE
                    break;
                }
            }
            break;
        }
    }
    fclose(xml);
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: ./sentinel_v1 <target_bin> <beacon_xml> [node_id]\n");
        return 1;
    }

    const char *target = argv[1];
    const char *beacon = argv[2];
    const char *node = (argc == 4) ? argv[3] : "DISCOVERY";

    if (verify_binary(target)) {
        printf("[BGIN SUCCESS] Object Verified: %s\n", target);
        dispatch_from_xml(beacon, node);
        return 0;
    } else {
        printf("[BGIN FAIL] Object Unlawful. System Lockdown.\n");
        return 1;
    }
}
