; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_signal.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    msg_exit db 10, "[BGIN] SIGNAL DETECTED: TERMINATING BIT-PERFECTLY", 10
    msg_len  equ $ - msg_exit

section .text
    global _start

; --- THE HANDSHAKER CALLBACK ---
signal_handler:
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; stdout
    lea rsi, [rel msg_exit]
    mov rdx, msg_len
    syscall
    
    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; status 0
    syscall

_start:
    ; 1. CONSTRUCT: sigaction structure on stack (aligned to 16 bytes)
    sub rsp, 152            ; Size of struct sigaction (Linux x86_64)
    lea r15, [rel signal_handler]
    mov [rsp], r15          ; Set handler address

    ; 2. REGISTER: sys_rt_sigaction(sig, act, oact, sigsetsize)
    mov rax, 13             ; syscall: rt_sigaction
    mov rdi, 2              ; SIGINT (Interrupt from keyboard)
    mov rsi, rsp            ; pointer to act
    xor rdx, rdx            ; oact = NULL
    mov r10, 8              ; sigsetsize = 8 bytes
    syscall

    ; 3. PERSIST: Infinite loop to keep listener active
.pulse_wait:
    jmp .pulse_wait

; #!#
