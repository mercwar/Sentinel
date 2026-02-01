; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_random.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .bss
    entropy_buf resb 8          ; Buffer for 64-bit random key

section .text
    global _start

_start:
    ; 1. GENERATE: sys_getrandom(buf, buflen, flags)
    ; RAX = 318 (x86_64)
    mov rax, 318                ; syscall: getrandom
    lea rdi, [rel entropy_buf]  ; Destination buffer
    mov rsi, 8                  ; Request 8 bytes (64 bits)
    xor rdx, rdx                ; GRND_NONBLOCK = 0 (Wait for entropy)
    syscall

    ; 2. VALIDATE: Ensure RAX returns 8 (bytes read)
    cmp rax, 8
    jne .violation

    ; 3. TRANSFER: Load entropy into R13 for session masking
    mov r13, [rel entropy_buf]

    ; 4. EXIT: Bit-Perfect Handshake Complete
    mov rax, 60                 ; sys_exit
    xor rdi, rdi                ; Status 0
    syscall

.violation:
    mov rax, 60
    mov rdi, 1                  ; Status 1: Entropy Void
    syscall

; #!#
