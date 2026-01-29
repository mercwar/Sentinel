@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - TEMPORARY CONFIGURATION MODULE
rem ============================================================================
rem ROLE: Generates a backup/temporary config file with current system headers.
rem FILE: TMP_CONFIG.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 6: PREPARE TEMP CONFIG FILE
rem ----------------------------------------------------------------------------
echo [AVIS] GENERATING TEMPORARY CONFIG...

(
    echo ; ============================================
    echo ; AVIS PROJECT SCAN CONFIG
    echo ; Generated: %DATE% %TIME%
    echo ; ============================================
    echo REMDRV=%REMDRV%
    echo PROJECT_ROOT=%PROJECT_ROOT%
    echo PROJECT_APPROOT=%PROJECT_APPROOT%
    echo.
) > "%CONFIG_FILE%.bak"

echo [AVIS] STATUS        : BACKUP CREATED (.BAK)

rem ----------------------------------------------------------------------------
rem STEP 7: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal & (set "REMDRV=%REMDRV%" & set "PROJECT_ROOT=%PROJECT_ROOT%" & set "PROJECT_APPROOT=%PROJECT_APPROOT%" & set "CONFIG_FILE=%CONFIG_FILE%" & set "LOG_FILE=%LOG_FILE%" & set "PROJECT_PATH=%PROJECT_PATH%" & set "PROJ_PATH=%PROJ_PATH%" & set "LOG_PATH=%LOG_PATH%" & set "LOG_AI=%LOG_AI%")

exit /b 0