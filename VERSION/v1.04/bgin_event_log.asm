; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_event_log.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    log_file db ".sentinel_pulse.log", 0
    log_msg  db "[BGIN] PULSE_EVENT_RECORDED", 10
    msg_len  equ $ - log_msg
    O_WRONLY equ 1
    O_APPEND equ 1024
    O_CREAT  equ 64

section .text
    global _start

_start:
    ; 1. OPEN: sys_open(log_file, O_WRONLY|O_APPEND|O_CREAT, 0644)
    mov rax, 2                  ; syscall: open
    lea rdi, [rel log_file]
    mov rsi, O_WRONLY | O_APPEND | O_CREAT
    mov rdx, 0644               ; Permissions
    syscall
    mov r12, rax                ; Save File Descriptor

    ; 2. RECORD: sys_write(fd, log_msg, msg_len)
    mov rax, 1                  ; syscall: write
    mov rdi, r12
    lea rsi, [rel log_msg]
    mov rdx, msg_len
    syscall

    ; 3. CLOSE: sys_close(fd)
    mov rax, 3                  ; syscall: close
    mov rdi, r12
    syscall

    ; 4. EXIT
    mov rax, 60
    xor rdi, rdi
    syscall

; #!#
