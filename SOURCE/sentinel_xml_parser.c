/* BGIN */
/* AVIS_COORD: AVIS://C/SPEC/XML_PARSER/1.0.CVBGOD */
/* ROLE: Bridges ASM Sitemap Ingest to the SIL Console Surface */

#include <stdio.h>
#include <string.h>

/* Hook to the SIL Console Adapter */
extern void __stdcall sentinel_console_write(const char *msg);

/* 
 * rkd_trigger_sitemap_parse
 * This is the function called by _sentinel_sitemap_ingest@0 in ASM.
 */
void __stdcall rkd_trigger_sitemap_parse(const char *path) {
    FILE *fp;
    char line[1024];
    char log_buf[2048];

    // 1. BEGIN: Attempt to open the map provided by ASM
    fp = fopen(path, "r");
    if (!fp) {
        sentinel_console_write("[BGIN ERROR] Sitemap Not Found. Ingestion Aborted.");
        return;
    }

    sentinel_console_write("[BGIN] XML PARSER INITIALIZED. CRAWLING NODES...");

    // 2. PARSE: Iterate through the XML and extract <loc> tags
    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, "<loc>")) {
            // AVIS_GUIDE: Isolate the URL node
            sprintf(log_buf, "AVIS_COORD_DISCOVERED: %s", line);
            
            // 3. LOG: Commit discovery to the SIL (console_copy.txt)
            sentinel_console_write(log_buf);
        }
    }

    fclose(fp);
    sentinel_console_write("[BGIN] SITEMAP INGESTION COMPLETE. .return(1)");
}
``` [INDEX]
