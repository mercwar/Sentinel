; @ #[avis] begin template asm @;
; @ PROTOCOL: BGIN.AVIS-GEN.V2.00 @;
; @ avis_coord_dir: /VERSION/2.0/AI/bgin-avis
; @ avis_coord_file: sentinel_v2.asm

section .text
    global _start
_start:
    ;# STAGE 3 MAGIC BYTES
    db 0x4D, 0x5A, 0x53, 0x45, 0x4E, 0x54, 0x49, 0x4E, 0x45, 0x4C
    times 64-($-$$) db 0x90
    #BGIN
    mov rax, 0xBE614
    mov rdi, 0xF17E6E3
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall
    #!#
#FIRE!END# DO NOT MODIFY
#!# RECOVERY_SIG_MATCHED
