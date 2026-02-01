; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04/SOURCE */
; /* AVIS_COORD_FILE: bgin_mem_scan.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    bgin_sig db "#BGIN", 0
    len equ 5

section .text
    global bgin_verify_mem

bgin_verify_mem:
    ; 1. FETCH: rdi = pointer to stream buffer
    ; 2. ANCHOR: rsi = pointer to protocol signature
    lea rsi, [rel bgin_sig]
    mov rcx, len
    
    ; 3. SCAN: Compare string bits
    cld                 ; Clear direction flag for forward scan
    repz cmpsb          ; Repeat compare while equal
    
    ; 4. HANDSHAKE: Set return status
    sete al             ; AL = 1 if match, 0 if violation
    movzx eax, al       ; Return 32-bit status
    ret

; #!#
