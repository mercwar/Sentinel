; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_remote_log.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    ; Remote Handshake Metadata
    pulse_msg db "[BGIN] REMOTE_PULSE_ESTABLISHED", 10
    pulse_len equ $ - pulse_msg
    
    ; sockaddr_in structure for x86_64
    sockaddr:
        dw 2                ; AF_INET
        dw 0xDEB0           ; Port 45278 (C0DE in Little Endian)
        dd 0x0100007F       ; IP 127.0.0.1 (Local Loopback for Handshake)
        dq 0                ; Padding

section .text
    global _start

_start:
    ; 1. SOCKET: sys_socket(AF_INET, SOCK_STREAM, 0)
    mov rax, 41             ; syscall: socket
    mov rdi, 2              ; AF_INET
    mov rsi, 1              ; SOCK_STREAM
    xor rdx, rdx
    syscall
    mov r12, rax            ; Save Socket FD

    ; 2. CONNECT: sys_connect(fd, addr, addrlen)
    mov rax, 42             ; syscall: connect
    mov rdi, r12
    lea rsi, [rel sockaddr]
    mov rdx, 16
    syscall

    ; 3. TRANSMIT: sys_write(fd, pulse_msg, pulse_len)
    mov rax, 1              ; syscall: write
    mov rdi, r12
    lea rsi, [rel pulse_msg]
    mov rdx, pulse_len
    syscall

    ; 4. EXIT: Terminal Handshake
    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; Status 0
    syscall

; #!#
