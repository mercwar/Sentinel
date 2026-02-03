@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================================
rem AVIS PROJECT SCAN - CONFIGURATION LOADER & SYNC (SECTION-AWARE VERSION)
rem ROLE: Reads the INI file and auto-creates the physical directory structure.
rem FILE: LOAD_CONFIG.BAT
rem ============================================================================
echo [AVIS] PROBING %CONFIG_FILE% ...

set "TargetSection=[DIR]"
set "Flag="

rem STEP 1: READ INI LINE-BY-LINE WITH SECTION SUPPORT
for /f "usebackq eol=; tokens=1,* delims==" %%a in ("%CONFIG_FILE%") do (

    rem SECTION HEADER DETECTION
    if "%%b"=="" (
        if /i "%%a"=="%TargetSection%" (
            set "Flag=Y"
        ) else (
            set "Flag="
        )
    ) else (

        rem PROCESS ONLY INSIDE [DIR]
        if defined Flag (

            rem Split key=value
            for /f "tokens=1,* delims==" %%c in ("%%a=%%b") do (
                set "Key=%%c"
                set "Value=%%d"

                rem Only process keys that start with DIR_
echo !Key! | findstr /R /I "^DIR_" >nul
if not errorlevel 1 (
    if not exist "!Value!" (
        echo [AVIS] BUILDING      : !Value!
        mkdir "!Value!" 2>nul
    ) else (
        echo [AVIS] NO BUILDING   : !Value!
    )
    set "!Key!=!Value!"
)

            )
        )
    )
)



echo [AVIS] STATUS        : STRUCTURE SYNCHRONIZED
echo.

rem STEP 2: EXPORT VARIABLES BACK TO CALLER
endlocal &     set "PRJ_DRV_KEY=%PRJ_DRV_KEY%" &     set "PRJ_DIR_KEY=%PRJ_DIR_KEY%" &     set "PRJ_ROOT_KEY=%PRJ_ROOT_KEY%" &     set "PRJ_APP_KEY=%PRJ_APP_KEY%" &     set "REMDRV=%REMDRV%" &     set "PROJECT_ROOT=%PROJECT_ROOT%" &     set "PROJECT_APPROOT=%PROJECT_APPROOT%" &     set "CONFIG_FILE=%CONFIG_FILE%" &     set "LOG_FILE=%LOG_FILE%" &     set "PROJECT_PATH=%PROJECT_PATH%" &     set "PROJ_PATH=%PROJ_PATH%" &     set "LOG_PATH=%LOG_PATH%" &     set "LOG_AI=%LOG_AI%"


exit /b 0