; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_mem_scan.asm */
; /* AVIS_ROLE: AI_AVIS_FVS_V1.03_HEAVY_BOT_SOURCE */

section .data
    bgin_sig  db "#BGIN", 0
    traff_sig db "AI_AVIS_FVS_V1.03_HEAVY_TRAFFIC_ACTIVE", 10, 0
    sig_len   equ $ - traff_sig

section .text
    global _start         ; Absolute Linker Export (Fixes ld warning)

_start:
    ; 1. ANCHOR: Establish FVS V1.03 Heavy-Bot Outbox Pulse
    mov rax, 1            ; sys_write (RAX 1)
    mov rdi, 1            ; stdout (RDI 1)
    lea rsi, [rel traff_sig]
    mov rdx, sig_len
    syscall

    ; 2. TERMINATION: Hardware-Level Handshake (Fixes Segfault)
    ; Without this, the program crashes into adjacent memory.
    mov rax, 60           ; sys_exit (RAX 60)
    xor rdi, rdi          ; Exit Code 0 (RDI 0)
    syscall

; #!#
