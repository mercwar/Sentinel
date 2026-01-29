@echo off
setlocal EnableExtensions

rem ============================================================================
rem AVIS PROJECT SCAN - CONFIGURATION LOADER & SYNC
rem ============================================================================
rem ROLE: Reads the INI file and auto-creates the physical directory structure.
rem FILE: LOAD_CONFIG.BAT
rem ============================================================================

rem ----------------------------------------------------------------------------
rem STEP 5: LOAD CONFIG AND AUTO-CREATE DIRECTORIES
rem ----------------------------------------------------------------------------
if exist "%CONFIG_FILE%" (
    echo [AVIS] PROBING INI AND SYNCHRONIZING DIRECTORIES...
    
    rem 'usebackq' allows the loop to read the file even if the path contains spaces.
    for /f "usebackq tokens=1,2 delims==" %%A in ("%CONFIG_FILE%") do (
        
        rem Capture the path and variable name.
        set "VAR_NAME=%%A"
        set "VAR_PATH=%%B"
        
        rem Logic: If the variable starts with 'DIR_', treat it as a directory to create.
        echo "%%A" | findstr /I "DIR_" >nul
        if not errorlevel 1 (
            if not exist "%%B" (
                echo [AVIS] BUILDING      : %%B
                mkdir "%%B" 2>nul
            )
        )
        
        rem Set the variable globally within this local scope.
        set "%%A=%%B"
    )
    echo [AVIS] STATUS        : STRUCTURE SYNCHRONIZED
    echo.
) else (
    echo [AVIS] CRITICAL ERROR: CONFIG_FILE NOT FOUND AT %CONFIG_FILE%
)

rem ----------------------------------------------------------------------------
rem STEP 6: VARIABLE EXPORT BRIDGE (THE PROTECTED BRIDGE)
rem ----------------------------------------------------------------------------
rem Ensuring all detected paths and system variables survive the endlocal command.
endlocal & (set "REMDRV=%REMDRV%" & set "PROJECT_ROOT=%PROJECT_ROOT%" & set "PROJECT_APPROOT=%PROJECT_APPROOT%" & set "CONFIG_FILE=%CONFIG_FILE%" & set "LOG_FILE=%LOG_FILE%" & set "PROJECT_PATH=%PROJECT_PATH%" & set "PROJ_PATH=%PROJ_PATH%" & set "LOG_PATH=%LOG_PATH%" & set "LOG_AI=%LOG_AI%")

exit /b 0