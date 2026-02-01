; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_verify.asm */
; /* AVIS_ROLE: Bit-Perfect_Verifier_v1.04.19 */

section .data
    filename db "avis-gen.json", 0
    bgin_sig db "#BGIN"

section .bss
    buffer resb 5

section .text
    global _start

_start:
    ; 1. OPEN: rax = 2 (sys_open), rdi = filename, rsi = 0 (O_RDONLY)
    mov rax, 2
    mov rdi, filename
    xor rsi, rsi
    syscall

    ; 2. READ: rax = 0 (sys_read), rdi = fd, rsi = buffer, rdx = 5
    mov rdi, rax        ; Save fd
    mov rax, 0
    mov rsi, buffer
    mov rdx, 5
    syscall

    ; 3. VALIDATE: Compare buffer to "#BGIN"
    mov esi, buffer
    mov edi, bgin_sig
    mov ecx, 5
    repe cmpsb
    jne .error

.success:
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall

.error:
    mov rax, 60         ; sys_exit
    mov rdi, 1          ; status 1
    syscall

; #!#
