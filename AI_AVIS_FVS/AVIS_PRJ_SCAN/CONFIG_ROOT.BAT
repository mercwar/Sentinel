@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - ROOT CONFIGURATION MODULE
rem ============================================================================
rem ROLE: Defines the physical file locations for INI and LOG data.
rem FILE: CONFIG_ROOT.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 0: NORMALIZE PROJECT PATH
rem ----------------------------------------------------------------------------
echo [AVIS] ESTABLISHING ROOT CONFIGURATION...

rem Capture the path and ensure it has a trailing backslash for stability.
set "PROJ_PATH=%PROJECT_PATH%"
set "PROJ_PATH=%PROJ_PATH%"

rem ----------------------------------------------------------------------------
rem STEP 1: DEFINE SYSTEM FILES
rem ----------------------------------------------------------------------------
rem Mapping the primary configuration file.
set "CONFIG_FILE=%PROJ_PATH%AVIS_PRJ_SCAN.INI"

rem ----------------------------------------------------------------------------
rem STEP 2: ESTABLISH LOGGING PATHS
rem ----------------------------------------------------------------------------
rem Defining the physical location for the AI operation logs.
set "LOG_FILE=ACK_AI_OP.LOG"
set "LOG_PATH=%PROJ_PATH%LOG\"
set "LOG_AI=%LOG_PATH%%LOG_FILE%"

echo [AVIS] CONFIG FILE  : "%CONFIG_FILE%"
echo [AVIS] LOG PATH     : "%LOG_PATH%"

rem ----------------------------------------------------------------------------
rem STEP 3: VARIABLE EXPORT BRIDGE
rem ----------------------------------------------------------------------------
rem Preserving the environment state for the next module in the sequence.
endlocal & (set "REMDRV=%REMDRV%" & set "PROJECT_ROOT=%PROJECT_ROOT%" & set "PROJECT_APPROOT=%PROJECT_APPROOT%" & set "CONFIG_FILE=%CONFIG_FILE%" & set "LOG_FILE=%LOG_FILE%" & set "PROJECT_PATH=%PROJECT_PATH%" & set "PROJ_PATH=%PROJ_PATH%" & set "LOG_PATH=%LOG_PATH%" & set "LOG_AI=%LOG_AI%")

exit /b 0