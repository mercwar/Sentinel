; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_boot.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    boot_msg db "[BGIN] BOOTING SENTINEL OS: vmlinuz-bgin", 10, 0
    msg_len  equ $ - boot_msg

section .text
    global _start         ; THE ANCHOR: Absolute Authority

_start:
    ; 1. ANCHOR: Transmit Boot Handshake to Outbox
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    lea rsi, [rel boot_msg]
    mov rdx, msg_len
    syscall

    ; 2. JUMP: Pivot execution to the fused 1.5GB Monolith
    ; Logic: Point RDI to the fused entry-vector in bin/vmlinuz-bgin

    ; 3. EXIT: Handshake Complete (Or pivot to Kernel)
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; status 0
    syscall

; #!#
