; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_obfuscate.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    bgin_key dq 0x33435642474F4433 ; "3CVBGOD3" Obfuscation Key
    msg_len  equ 64

section .text
    global _start

_start:
    ; 1. FETCH: RDI = Pointer to current Inbox Page
    ; 2. LOAD:  RAX = 64-bit Obfuscation Key
    mov rax, [rel bgin_key]
    
    ; 3. LOOP: Process 8-byte chunks (Bit-Perfect Transformation)
    mov rcx, msg_len / 8
.pulse_loop:
    xor [rdi], rax             ; Apply XOR cipher to memory segment
    add rdi, 8
    loop .pulse_loop

    ; 4. TERMINATE:
    mov rax, 60                ; sys_exit
    xor rdi, rdi
    syscall

; #!#
