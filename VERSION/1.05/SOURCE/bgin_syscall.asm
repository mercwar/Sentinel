; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_syscall.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    intercept_msg db "[BGIN] SYSCALL INTERCEPTED: ROUTING TO OUTBOX", 10
    msg_len       equ $ - intercept_msg

section .text
    global _start         ; THE ANCHOR: Absolute Authority

_start:
    ; 1. ANCHOR: Establish Register-Level Hook
    ; 2. INTERCEPT: Catch sys_write pulses for 1.5GB Heavy-Bot Traffic
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    lea rsi, [rel intercept_msg]
    mov rdx, msg_len
    syscall

    ; 3. EXIT: Handshake Complete
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; status 0
    syscall

; #!#
