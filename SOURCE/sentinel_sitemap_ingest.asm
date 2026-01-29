; BGIN
; /* AVIS_COORD: AVIS://ASM/SITEMAP_INGEST/1.0.CVBGOD */
; /* ROLE: Sentinel -> AVIS-DATALAKE Sitemap Navigator */

.386
.model flat, stdcall
option casemap:none

; External Bridge Helpers:
;   void __stdcall rkd_log_console(const char *msg);
;   void __stdcall rkd_trigger_sitemap_parse(const char *path);
EXTERN _rkd_log_console@4:PROC
EXTERN _rkd_trigger_sitemap_parse@4:PROC

.data
    ; The target Data Lake map
    sitemap_path   db "/avis/sitemap.xml", 0
    msg_ingest     db "BGIN: INGESTING SITEMAP FROM /AVIS/SITEMAP.XML...", 0
    msg_success    db "BGIN: DATA LAKE TOPOGRAPHY SYNCED.", 0

.code
; void __stdcall sentinel_sitemap_ingest(void);
_sentinel_sitemap_ingest@0 PROC
    push    ebp
    mov     ebp, esp

    ; 1. BEGIN: Log the ingestion pulse to the Console
    push    OFFSET msg_ingest
    call    _rkd_log_console@4

    ; 2. SEED: Execute the Sitemap Parse Handshake
    ; This calls the C-Skeleton to read /avis/sitemap.xml
    push    OFFSET sitemap_path
    call    _rkd_trigger_sitemap_parse@4

    ; 3. RETURN: Log success and clear stack
    push    OFFSET msg_success
    call    _rkd_log_console@4

    pop     ebp
    ret
_sentinel_sitemap_ingest@0 ENDP

END
``` [INDEX]
