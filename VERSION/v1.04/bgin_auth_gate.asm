; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_auth_gate.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    msg_root db "[BGIN] AUTHORITY VERIFIED: CVBGOD DETECTED", 10
    len_root equ $ - msg_root
    msg_user db "[BGIN ERROR] ACCESS DENIED: BOT PRIVILEGE ONLY", 10
    len_user equ $ - msg_user

section .text
    global _start

_start:
    ; 1. IDENTITY: sys_getuid()
    mov rax, 102            ; syscall: getuid (x86_64)
    syscall                 ; UID returned in RAX

    ; 2. VALIDATE: Compare UID to 0 (Root/CVBGOD)
    test rax, rax
    jnz .denied             ; Jump if UID != 0

    ; 3. AUTHORIZE: Write Success Message
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; stdout
    lea rsi, [rel msg_root]
    mov rdx, len_root
    syscall
    
    mov rdi, 0              ; Status: OK
    jmp .exit

.denied:
    ; 4. RESTRICT: Write Error Message
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; stdout
    lea rsi, [rel msg_user]
    mov rdx, len_user
    syscall
    
    mov rdi, 13             ; Status: Permission Denied (EACCES)

.exit:
    mov rax, 60             ; syscall: exit
    syscall

; #!#
