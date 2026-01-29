@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - RECURSIVE FILE SCANNER
rem ============================================================================
rem ROLE: Scans the project root for all files and logs their full paths.
rem FILE: SCAN_FILE.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 9: RECURSIVE FILE SCAN (PROJECT ROOT)
rem ----------------------------------------------------------------------------
echo [AVIS] SCANNING PROJECT FILES...

rem === LIST FILES ===
rem Iterates through the project root and logs every file found.
rem Synchronized to match the [DIR] format used in the directory scan.
for /r "%PROJECT_ROOT%" %%F in (*) do (
    echo [FILE] %%F >> "%LOG_AI%"
)

rem Append a newline to the log for cleaner formatting.
rem echo. >> "%LOG_AI%"
echo [AVIS] STATUS        : FILE LOG UPDATED

rem ----------------------------------------------------------------------------
rem STEP 10: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
endlocal & (set "REMDRV=%REMDRV%" & set "PROJECT_ROOT=%PROJECT_ROOT%" & set "PROJECT_APPROOT=%PROJECT_APPROOT%" & set "CONFIG_FILE=%CONFIG_FILE%" & set "LOG_FILE=%LOG_FILE%" & set "PROJECT_PATH=%PROJECT_PATH%" & set "PROJ_PATH=%PROJ_PATH%" & set "LOG_PATH=%LOG_PATH%" & set "LOG_AI=%LOG_AI%")

exit /b 0