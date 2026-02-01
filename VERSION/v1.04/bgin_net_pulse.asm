; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_net_pulse.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    ; Protocol Constants for x86_64 Linux
    AF_INET   equ 2
    SOCK_STREAM equ 1
    PORT      equ 0xDEB0        ; Port 45278 (C0DE in Little Endian)
    INADDR_ANY equ 0

    sockaddr:
        dw AF_INET              ; sin_family
        dw PORT                 ; sin_port
        dd INADDR_ANY           ; sin_addr
        dq 0                    ; padding

section .text
    global _start

_start:
    ; 1. SOCKET: sys_socket(2, 1, 0)
    mov rax, 41                 ; syscall: socket
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    xor rdx, rdx
    syscall
    mov r12, rax                ; Save socket FD in r12

    ; 2. BIND: sys_bind(sockfd, sockaddr, addrlen)
    mov rax, 49                 ; syscall: bind
    mov rdi, r12
    lea rsi, [rel sockaddr]
    mov rdx, 16
    syscall

    ; 3. LISTEN: sys_listen(sockfd, backlog)
    mov rax, 50                 ; syscall: listen
    mov rdi, r12
    mov rsi, 5
    syscall

    ; 4. ACCEPT: sys_accept(sockfd, NULL, NULL)
    ; Ready to ingest CVBGOD command pulse
    mov rax, 43                 ; syscall: accept
    mov rdi, r12
    xor rsi, rsi
    xor rdx, rdx
    syscall

    ; 5. EXIT (for testing)
    mov rax, 60
    xor rdi, rdi
    syscall

; #!#
