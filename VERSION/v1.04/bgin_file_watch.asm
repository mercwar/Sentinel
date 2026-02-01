; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_file_watch.asm */
; /* AVIS_ROLE: ASM_SOURCE_FILE */

section .data
    watch_path db ".", 0          ; Watch current directory
    IN_MODIFY  equ 0x00000002     ; Event: File was modified

section .text
    global _start

_start:
    ; 1. INIT: sys_inotify_init()
    mov rax, 253                 ; syscall: inotify_init
    syscall
    mov r12, rax                 ; Store inotify FD in r12

    ; 2. WATCH: sys_inotify_add_watch(fd, path, mask)
    mov rax, 254                 ; syscall: inotify_add_watch
    mov rdi, r12                 ; fd
    lea rsi, [rel watch_path]    ; "." (Archipelago Root)
    mov rdx, IN_MODIFY           ; Watch for modifications
    syscall

    ; 3. LISTEN: sys_read(fd, buffer, size)
    ; This call blocks until a file in the DIR is modified.
    ; Real-world CVBGOD bots use this to trigger auto-re-ingestion.
    mov rax, 0                   ; syscall: read
    mov rdi, r12
    sub rsp, 1024                ; Allocate 1KB buffer on stack
    mov rsi, rsp
    mov rdx, 1024
    syscall

    ; 4. EXIT: Return Success once modification is detected
    mov rax, 60
    xor rdi, rdi
    syscall

; #!#
