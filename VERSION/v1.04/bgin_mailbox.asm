; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_mailbox.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    inbox_key  dq 0xC0DEB011      ; CVBGOD Inbound Key
    outbot_key dq 0xC0DEB022      ; Bot Outbound Key
    shm_size   equ 4096           ; 4KB Atomic Page

section .text
    global _start

_start:
    ; 1. SHMGET: Initialize Shared Memory for Inbox
    mov rax, 29                  ; sys_shmget
    mov rdi, [rel inbox_key]     ; Key for CVBGOD Inbox
    mov rsi, shm_size            ; Page Size
    mov rdx, 0666                ; Permissions
    syscall                      ; returns RAX = shmid

    ; 2. SHMAT: Attach to Process Address Space
    mov rdi, rax                 ; shmid
    mov rax, 30                  ; sys_shmat
    xor rsi, rsi                 ; NULL addr
    xor rdx, rdx                 ; No flags
    syscall                      ; RAX = pointer to Inbox

    ; 3. ATOMIC HANDSHAKE: Read/Write Pulse
    ; CVBGOD Writes to Outbot, Bots Read from Inbox
    mov rbx, [rax]               ; Fetch latest Bot message
    lock xchg [rax], rbx         ; Atomic exchange for bit-perfect delivery

    ; 4. EXIT: 
    mov rax, 60                  ; sys_exit
    xor rdi, rdi                 ; status 0
    syscall

; #!#
