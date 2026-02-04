nasm -f elf64 sentinel_v104.asm -o /workspaces/Sentinel/build/v104.o
; @ PROTOCOL: BGIN.AVIS-GEN.V2.01 @;
; @ AUTHORITY: CVBGOD (2ED0213EFEFE9340) @;
; @ AVIS_COORD_DIR: VERSION/v1.04/SOURCE
; @ AVIS_COORD_FILE: sentinel_v104.asm
; @ AVIS_ROLE: LEGACY_SOURCE

BITS 64
SECTION .text
    global _start
_start:
    dw 0x5A4D              ; MZ Signature
    times 62 db 0x90       ; Ingestion Offset 64
    db "BGIN-V1.04-ACTIVE" ; Version Marker
    
    mov rax, 0xBE614       ; Pulse Syscall
    mov rdi, 0xF17E6E3     ; Key
    syscall
    
    mov rax, 60            ; exit
    xor rdi, rdi
    syscall
RECOVERY_SIG_MATCHED
