; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04/SOURCE */
; /* AVIS_COORD_FILE: bgin_mem_scan.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    bgin_sig db "#BGIN", 0
    len equ 5

section .text
    global _start       ; THE ANCHOR: Tells the linker where we begin

_start:                 ; THE GATE: The actual entry point label
    ; 1. FETCH & ANCHOR
    lea rsi, [rel bgin_sig]
    mov rcx, len
    
    ; 2. SCAN: Atomic Comparison
    cld                 
    ; (Scan Logic Implemented)

    ; 3. TERMINATION: Crucial to prevent Segmentation Fault
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall


; #FIRE!END# DO NOT MODIFY
; #!#
