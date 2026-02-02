; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_bot_relay.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    relay_sig db "[BGIN] BOT_RELAY_V1.05_ACTIVE", 10, 0
    sig_len   equ $ - relay_sig

section .text
    global _start

_start:
    ; 1. PULSE: Write Relay Status to Outbox
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [rel relay_sig]
    mov rdx, sig_len
    syscall

    ; 2. TERMINATION: Zero-Void Handshake
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall

; #!#
