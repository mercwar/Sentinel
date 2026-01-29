:: FIX: Robust method to create a literal Escape character using keystroke simulation
for /F "tokens=1 delims=#" %%a in ('"prompt #$E# & echo on & for %%b in (1) do rem"') do set "e=%%a"
chcp 65001 >nul
cls


@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Robust Escape definition
for /f %%A in ('echo prompt $E^| cmd') do set "e=%%A"

chcp 65001 >nul
cls



echo.
echo   %e%[38;5;244m╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║    %e%[38;5;255mPROJ: AVIS PROJECT SCAN                                   %e%[38;5;244m║
echo   ║    %e%[38;5;255mARCH: SHINE ARCHITECTURE                                  %e%[38;5;244m║
echo   ║    %e%[38;5;255mAUTH: CVBGOD                                              %e%[38;5;244m║
echo   ║    %e%[38;5;255mCORE: VER 1.06                                            %e%[38;5;244m║
echo   ║    %e%[38;5;255mDATE: 01/27/2026                                          %e%[38;5;244m║
echo   ║    %e%[38;5;240mCOPY: © MERCWAR FFF * ALL RIGHTS RESERVED *               %e%[38;5;244m║
echo   ║                                                              ║
echo   ║    %e%[38;5;239m   [::::::::::::::::::::::::::::::::::::::]               %e%[38;5;244m║
echo   ║            %e%[38;5;255mINITIALIZING AI SCAN SEQUENCE...                  %e%[38;5;244m║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝%e%[0m
echo.


timeout /t 3 >nul
cls

echo.
echo.
echo   %e%[38;5;239m┌────────────────────────────────────────────────────────────┐
echo   │                                                            │
echo   │           %e%[38;5;255mS H I N E   A R C H I T E C T U R E%e%[38;5;239m              │
echo   │                                                            │
echo   └────────────────────────────────────────────────────────────┘%e%[0m
echo.
echo       %e%[38;5;244m ██████╗ ██╗   ██╗██████╗  ██████╗  ██████╗ ██████╗
echo        ██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔═══██╗██╔══██╗
echo        ██║      ██║   ██║██████╔╝██║  ███╗██║   ██║██║  ██║
echo        ██║      ╚██╗ ██╔╝██╔══██╗██║   ██║██║   ██║██║  ██║
echo        ╚██████╗  ╚████╔╝ ██████╔╝╚██████╔╝╚██████╔╝██████╔╝
echo         ╚═════╝   ╚═══╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ %e%[0m
echo.
echo   %e%[38;5;239m┌────────────────────────────────────────────────────────────┐
echo   │                     %e%[38;5;255mDESIGNED BY CVBGOD%e%[38;5;239m                     │
echo   └────────────────────────────────────────────────────────────┘%e%[0m
ECHO  © 2026 CVBGOD
echo.
timeout /t 5 >nul
rem ============================================================================
rem AVIS PROJECT SCAN — USER MODE SELECTION
rem ============================================================================

rem ============================================================================
rem AVIS PROJECT SCAN - MASTER CONTROLLER (DEMO VERSION)
rem ============================================================================
rem ROLE: Main Entry Point. Detects hardware and anchors the AI project path.
rem FILE: AVIS_PRJ_SCAN.BAT
rem VERSION: 1.06 - SHINE ARCHITECTURE
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 1: HARDWARE DETECTION
rem ----------------------------------------------------------------------------
echo [AVIS] INITIALIZING HARDWARE DETECTION...
call "%~dp0AVIS_PRJ_SCAN\AVIS_REM_DRV.BAT"

if errorlevel 1 (
    echo [AVIS] CRITICAL ERROR: Removable drive detection failed.
    PAUSE
    exit /b 1
)

rem ----------------------------------------------------------------------------
rem STEP 2: PROJECT ANCHORING
rem ----------------------------------------------------------------------------
echo [AVIS] ANCHORING PROJECT TO DETECTED DRIVE...

rem Establishing the root directory on the detected removable drive.
set "PROJECT_ROOT=%REMDRV%\htdocs\robo-knight\AI_AVIS_FVS\"
cd /d "%PROJECT_ROOT%"
set "PROJECT_APPROOT=AVIS_PRJ_SCAN\"

echo [AVIS] PROJECT ROOT : %PROJECT_ROOT%

rem Define the full application path for module calls.
set "PROJECT_PATH=%PROJECT_ROOT%%PROJECT_APPROOT%"

echo [AVIS] APP PATH     : %PROJECT_PATH%
echo.

rem ----------------------------------------------------------------------------
rem STEP 3: SYSTEM INI
rem ----------------------------------------------------------------------------

echo.
echo [AVIS] SELECT MODE:
echo        1. CONTINUE WITH SCAN
echo        2. OPEN CONFIGURATION FILE
echo.

set /p AVIS_MODE=[AVIS] ENTER CHOICE (1/2): 

if "%AVIS_MODE%"=="2" (
    echo [AVIS] OPENING CONFIGURATION IN NOTEPAD...
    start notepad "%PROJECT_PATH%AVIS_PRJ_SCAN.INI"
    echo [AVIS] CONFIG OPENED. CLOSE NOTEPAD AND RE-RUN THE SCAN.
    pause
    exit /b 0
)

if not "%AVIS_MODE%"=="1" (
    echo [AVIS] INVALID SELECTION.
    pause
    exit /b 1
)

echo [AVIS] CONTINUING WITH SCAN...
echo.

rem ----------------------------------------------------------------------------
rem STEP 4: SYSTEM EXECUTION
rem ----------------------------------------------------------------------------
echo [AVIS] VERIFYING EXECUTION CORE...

rem Verifies existence of the executor core before passing control.
if exist "%PROJECT_PATH%AVIS_PRJ_SCAN_EXEC.BAT" (
    echo [AVIS] EXECUTING PROJECT SCAN SEQUENCE...
    call "%PROJECT_PATH%AVIS_PRJ_SCAN_EXEC.BAT"
) else (
    echo [AVIS] SHINE_ERROR: Executor core missing at %PROJECT_PATH%
    pause
)

rem ----------------------------------------------------------------------------
rem STEP 5: EXIT & CLEANUP
rem ----------------------------------------------------------------------------
echo.
echo [AVIS] SCAN SEQUENCE COMPLETE.
echo [AVIS] I AM CVBGOD, AND I HAVE GIVEN IT TO YOU HEHEMM, ... LITTLE BOTS :)
rem timeout /t 3 >nul
PAUSE
endlocal
exit /b 0