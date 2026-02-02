; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_pulse_eraser.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    target0 db "../v1.04/asm_install.sh", 0
    target1 db "./bin/bgin_mem_scan.o", 0
    erase_msg db "[BGIN] TRACE PURGED: SYSTEM CLEANED", 10

section .text
    global _start         ; THE ANCHOR

_start:
    ; 1. PURGE: sys_unlink(target0) - Remove the Toolchain
    mov rax, 87           ; syscall: unlink
    lea rdi, [rel target0]
    syscall

    ; 2. PURGE: sys_unlink(target1) - Remove Object Residue
    mov rax, 87
    lea rdi, [rel target1]
    syscall

    ; 3. NOTIFY: Final bit-perfect status to Outbox
    mov rax, 1            ; syscall: write
    mov rdi, 1
    lea rsi, [rel erase_msg]
    mov rdx, 36
    syscall

    ; 4. EXIT: Handshake Complete
    mov rax, 60
    xor rdi, rdi
    syscall

; #!#
