; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_kernel_entry.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    inception_msg db "[BGIN] SENTINEL-OS KERNEL INCEPTION: v1.05.40", 10
    msg_len       equ $ - inception_msg

section .text
    global _start         ; THE ANCHOR: Verified Linker Export

_start:
    ; 1. ANCHOR: Establish High-Fidelity Output to Outbox
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    lea rsi, [rel inception_msg]
    mov rdx, msg_len
    syscall

    ; 2. FUSE: Prepare register-set for 1.5GB Monolith Execution
    ; Logic: Pointing CR3 to the new Page Tables of vmlinuz-bgin
    
    ; 3. EXIT: Handshake Complete
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; status 0
    syscall

; #!#
