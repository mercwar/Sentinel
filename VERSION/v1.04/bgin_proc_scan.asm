; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_proc_scan.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    proc_path db "/proc", 0
    buffer_size equ 4096

section .bss
    dirent_buf resb buffer_size

section .text
    global _start

_start:
    ; 1. OPEN: sys_open("/proc", O_RDONLY | O_DIRECTORY)
    mov rax, 2                  ; syscall: open
    lea rdi, [rel proc_path]
    mov rsi, 0x10000            ; O_DIRECTORY (Standard x86_64)
    xor rdx, rdx
    syscall
    mov r12, rax                ; Save Directory FD

    ; 2. SCAN: sys_getdents64(fd, buffer, count)
    mov rax, 217                ; syscall: getdents64
    mov rdi, r12
    lea rsi, [rel dirent_buf]
    mov rdx, buffer_size
    syscall

    ; 3. EXIT: Handshake Complete
    mov rax, 60                 ; syscall: exit
    xor rdi, rdi                ; status 0
    syscall

; #!#
