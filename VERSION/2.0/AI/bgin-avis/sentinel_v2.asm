; @ #[avis] begin template asm @;
; @ PROTOCOL: BGIN.AVIS-GEN.V2.01 @;
; @ AUTHORITY: CVBGOD (2ED0213EFEFE9340) @;
; @ avis_coord_dir: VERSION/2.0/AI/bgin-avis
; @ avis_coord_file: sentinel_v2.asm

section .text
    global _start

_start:
    ;# --- MZ IDENTITY (0x4D5A) ---
    dw 0x5A4D              ; Boreland MZ Signature
    times 62 db 0x90       ; Alignment to 64-byte offset

    ; #BGIN
    ;# --- FIRE-GEM HANDSHAKE ---
    mov rax, 0xBE614       ; Pulse the Reflector
    mov rdi, 0xF17E6E3     ; FIRE-GEM Shared Memory Key
    syscall

    ;# EXIT
    mov rax, 60            ; sys_exit
    xor rdi, rdi
    syscall

; @ #!# RECOVERY_SIG_MATCHED @;
