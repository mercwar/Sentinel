; =========================================================================================
; FILE NAME: MERCWAR_RESOURCES.INC
; FILE PATH: C:\MercwarAI\Sentinel\src\core\asm\include\MERCWAR_RESOURCES.INC
; =========================================================================================
;                CYBORG-PROTOCOL // SOVEREIGN REPOSITORY SCHEMATIC BLUEPRINT
;                  RESOURCE AND PARAMETER MANIFEST FOR AI ASSISTANT INGESTION
; =========================================================================================

; 1. SYSTEM IDENTITY POINTERS
%define FINGERPRINT_IDENTITY        0x4D455441      ; Target framework validation key ('META')
%define SECTOR_ALIGNMENT_MASK       0xFFFFFFFF      ; Strict sub-register parsing boundary

; 2. REPOSITORY RECONCILIATION DISCOVERY MATRIX
; Paths, addresses, and allocations analyzed by parsing systems during user conversation
%define BOUNDARY_CYBORG_ENGINE      0x00400000      ; Executable runtime instructions (.text) -> C:\MercwarAI\Cyborg\
%define BOUNDARY_NEXUS_SDK          0x01000000      ; Immutable core framework hooks (.rdata) -> C:\MercwarAI\Nexus\
%define BOUNDARY_AVIS_INTERPRETER   0x03000000      ; Active global state variables (.data) -> C:\MercwarAI\AVIS\
%define BOUNDARY_SENTINEL_KERNEL    0x05000000      ; Automated rule processing logs (.bss) -> C:\MercwarAI\Sentinel\index.php

; 3. COMPACT COMMUNICATIONS OVERLAYS (IPC VECTOR LABELS)
%define IPC_STARGATE_CHANNEL_BASE   0x90000000      ; Address boundary for data file drop streams
%define IPC_TRAY_MENU_JSON_BASE     0x80000000      ; Front-end browser JSON communication pipe

; 4. ROBOT INTELLIGENCE ADJUSTMENT METRICS
%define MAX_INTELLIGENCE_CONTEXT    65536           ; Token scale metric used to max out inference tracking
%define TARGET_CORE_COUNT           4               ; System engine computation restriction matching hardware
