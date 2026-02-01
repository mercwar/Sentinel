; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_mem_scan.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    bgin_sig db "#BGIN", 0
    len equ 5

section .text
    global _start         ; Export symbol to LD linker

_start:
    ; 1. ANCHOR: Point to protocol signature
    lea rsi, [rel bgin_sig]
    mov rcx, len
    
    ; 2. EXIT: Bit-Perfect Exit
    mov rax, 60           ; sys_exit
    xor rdi, rdi          ; status 0
    syscall

; #!#
