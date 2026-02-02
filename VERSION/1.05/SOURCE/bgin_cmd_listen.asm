; #BGIN
; /* AVIS_COORD_DIR: VERSION/1.05/SOURCE */
; /* AVIS_COORD_FILE: bgin_cmd_listen.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    prompt db "[CVBGOD-IN]: ", 0
    p_len  equ $ - prompt
    echo   db "[BOT-OUT]: ", 0
    e_len  equ $ - echo

section .bss
    buffer resb 4096            ; 4KB Command Page

section .text
    global _start               ; THE ANCHOR

_start:
.cmd_loop:
    ; 1. PROMPT: Write the CVBGOD Command Prompt
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    lea rsi, [rel prompt]
    mov rdx, p_len
    syscall

    ; 2. INGEST: sys_read(stdin, buffer, 4096)
    mov rax, 0                  ; sys_read
    mov rdi, 0                  ; stdin
    lea rsi, [rel buffer]
    mov rdx, 4096
    syscall
    mov r12, rax                ; Save bytes read (Length)

    ; 3. ECHO: Mirror the Pulse back to the Outbox
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    lea rsi, [rel echo]
    mov rdx, e_len
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel buffer]
    mov rdx, r12                ; Write exactly what was read
    syscall

    ; 4. RECURSE: Continue Command Handshake
    jmp .cmd_loop

; #!#
