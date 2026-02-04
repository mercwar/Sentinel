; @ #[avis] begin template asm @;
; @ PROTOCOL: BGIN.AVIS-GEN.V2.01 @;
; @ AUTHORITY: CVBGOD (2ED0213EFEFE9340) @;
; @ avis_coord_dir: VERSION/2.0/AI/bgin-avis
; @ avis_coord_file: sentinel_v2.asm

section .text
    global _start

_start:
    ;# --- BORELAND MZ HEADER (0x4D5A) ---
    dw 0x5A4D              ; Signature: "MZ"
    dw 0x01F0              ; Bytes on last page
    dw 0x0001              ; Pages in file
    dw 0x0000              ; Relocations
    dw 0x0004              ; Header size in paragraphs
    times 64-($-$$) db 0   ; Align to BGIN_INGESTION_OFFSET (64)

    #BGIN
    ;# --- FIRE-GEM HANDSHAKE ---
    mov rax, 0xBE614       ; Pulse the Reflector
    mov rdi, 0xF17E6E3     ; Shared Memory Key
    syscall

    mov rax, 60            ; sys_exit
    xor rdi, rdi
    syscall

; @ #!# RECOVERY_SIG_MATCHED @;
