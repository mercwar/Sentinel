; #BGIN
; /* AVIS_COORD_DIR: VERSION/v1.04 */
; /* AVIS_COORD_FILE: bgin_monitor.asm */
; /* AVIS_ROLE: ASM_MONITOR_v1.04.18 */

section .rodata
    pat_ignore db "#BGIN", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 16-byte aligned pattern

section .text
    global immune_match_sse42

immune_match_sse42:
    ; 1. FETCH: RDI = input buffer, RSI = buffer length
    movdqa xmm1, [rel pat_ignore] ; Load 16-byte protocol signature

.sse_loop:
    movdqu xmm0, [rdi]            ; Load 16 bytes of the stream
    
    ; 2. PCMPISTRI: Packed Compare Implicit Length Strings
    ; Scans for protocol header #BGIN within the 16-byte window
    pcmpistri xmm1, xmm0, 0x0C    ; Equal Ordered mode
    
    jc .match_found               ; Carry Flag set if match detected
    
    inc rdi                       ; Slide window
    dec rsi
    cmp rsi, 16
    jge .sse_loop                 ; Continue until EOB (End of Batch)

    xor eax, eax                  ; Return 0 (No Violation)
    ret

.match_found:
    mov eax, 1                    ; Return 1 (Protocol Handshake Active)
    ret

; #!#
