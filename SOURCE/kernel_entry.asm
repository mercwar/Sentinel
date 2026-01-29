; BGIN
; /* AVIS_COORD: AVIS://ASM/PULSE/1.1.CVBGOD */
; /* ROLE: Layer-0 Hardware Heartbeat / Kernel Entry */
; /* SEED: 0xDEADBEEF */

[bits 32]
[extern _rkd_c_boundary_handler] ; The C-Skeleton Hook

global _start
_start:
    ; 1. BEGIN: Establish the Pulse
    mov eax, 0xDEADBEEF      ; Anchor the Seed

    ; 2. SEED: Push the Pulse to the C Boundary
    push eax                 ; Pass pulse as argument
    call _rkd_c_boundary_handler

    ; 3. RETURN: Halt if the boundary returns
    jmp $

; AVIS_GUIDE: This entry point ensures the Monolith boots with 0xDEADBEEF
