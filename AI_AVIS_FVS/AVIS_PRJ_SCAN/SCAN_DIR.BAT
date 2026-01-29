@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - RECURSIVE DIRECTORY SCANNER
rem ============================================================================
rem ROLE: Scans the project root for subdirectories and updates the system map.
rem FILE: SCAN_DIR.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 8: RECURSIVE DIRECTORY SCAN (PROJECT ROOT)
rem ----------------------------------------------------------------------------
echo [AVIS] SCANNING DIRECTORY STRUCTURE...

rem === LIST DIRECTORIES ===
rem Iterates through the project root and logs each found path.
for /d /r "%PROJECT_ROOT%" %%D in (*) do (
    echo [DIR] %%D >> "%LOG_AI%"
    echo DIR_%%~nD=%%D >> "%CONFIG_FILE%.tmp"
)

rem Append a newline to the log for cleaner formatting.
echo. >> "%LOG_AI%"

echo [AVIS] STATUS        : DIRECTORY MAP UPDATED

rem ----------------------------------------------------------------------------
rem STEP 9: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal & (set "REMDRV=%REMDRV%" & set "PROJECT_ROOT=%PROJECT_ROOT%" & set "PROJECT_APPROOT=%PROJECT_APPROOT%" & set "CONFIG_FILE=%CONFIG_FILE%" & set "LOG_FILE=%LOG_FILE%" & set "PROJECT_PATH=%PROJECT_PATH%" & set "PROJ_PATH=%PROJ_PATH%" & set "LOG_PATH=%LOG_PATH%" & set "LOG_AI=%LOG_AI%")

exit /b 0