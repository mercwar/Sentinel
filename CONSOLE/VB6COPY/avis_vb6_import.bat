@echo off
setlocal enabledelayedexpansion

:: Anchor app home (self-root)
set "APP_ROOT=%~dp0"
for %%A in ("%APP_ROOT%") do set "APP_ROOT=%%~fA"
set "APP_ROOT=%APP_ROOT:~0,-1%"

:: VB6 file patterns
set "VB6PATS=*.vbp *.frm *.bas *.cls *.ctl *.pag *.dsr *.mak *.txt *.ini *.rc"

echo.
echo ============================================
echo              AVIS VB6 IMPORT
echo ============================================
echo.

if "%~1"=="" (
  echo ERROR: No source drive passed in.
  echo Usage: avis_vb6_import.bat X:
  endlocal & exit /b 1
)

set "SRC_DRIVE=%~1"
if "%SRC_DRIVE:~-1%"=="\" set "SRC_DRIVE=%SRC_DRIVE:~0,-1%"

:: Validate removable drive
if not exist "%SRC_DRIVE%\" (
  echo ERROR: Drive %SRC_DRIVE% is not accessible.
  echo Insert the drive and try again.
  pause
  endlocal & exit /b 1
)

echo Source drive: %SRC_DRIVE%
echo App home    : %APP_ROOT%
echo.

echo 1) Root only on %SRC_DRIVE% (no subfolders)
echo 2) Recursive from %SRC_DRIVE% (include subfolders)
set /p "MODE=Choose mode (1/2): "

set "OUT_DIR=%APP_ROOT%\avis_vb6_import"

if exist "%OUT_DIR%" rd /s /q "%OUT_DIR%"
mkdir "%OUT_DIR%" >nul 2>&1

if "%MODE%"=="1" (
  for %%P in (%VB6PATS%) do (
    for %%F in ("%SRC_DRIVE%\%%P") do (
      if exist "%%~fF" (
        copy /Y "%%~fF" "%OUT_DIR%\" >nul
        echo IMPORT_ROOT: %%~fF
      )
    )
  )
) else if "%MODE%"=="2" (
  for %%P in (%VB6PATS%) do (
    for /f "delims=" %%F in ('dir /b /s "%SRC_DRIVE%\%%P" 2^>nul') do (
      set "SRC=%%~fF"
      set "REL=%%~pF"
      set "REL=!REL:~3!"  :: strip X:\
      set "DESTDIR=%OUT_DIR%\!REL!"
      if not exist "!DESTDIR!" mkdir "!DESTDIR!" >nul 2>&1
      copy /Y "!SRC!" "!DESTDIR!%%~nxF" >nul
      echo IMPORT_RECURSE: !SRC! ^> !DESTDIR!%%~nxF
    )
  )
) else (
  echo Invalid mode.
  endlocal & exit /b 1
)

echo.
echo Import complete.
echo Files stored in: %OUT_DIR%
echo.
endlocal & exit /b 0
