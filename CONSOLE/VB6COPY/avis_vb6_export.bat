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
echo              AVIS VB6 EXPORT
echo ============================================
echo.

if "%~1"=="" (
  echo ERROR: No destination drive passed in.
  echo Usage: avis_vb6_export.bat X:
  endlocal & exit /b 1
)

set "DEST_DRIVE=%~1"
if "%DEST_DRIVE:~-1%"=="\" set "DEST_DRIVE=%DEST_DRIVE:~0,-1%"

:: Validate removable drive
if not exist "%DEST_DRIVE%\" (
  echo ERROR: Drive %DEST_DRIVE% is not accessible.
  echo Insert the drive and try again.
  pause
  endlocal & exit /b 1
)

echo App home       : %APP_ROOT%
echo Destination drv: %DEST_DRIVE%
echo.

echo 1) Export root of app folder only
echo 2) Export app folder recursively (include subfolders)
set /p "MODE=Choose mode (1/2): "

if "%MODE%"=="1" (
  for %%P in (%VB6PATS%) do (
    for %%F in ("%APP_ROOT%\%%P") do (
      if exist "%%~fF" (
        copy /Y "%%~fF" "%DEST_DRIVE%\" >nul
        echo EXPORT_ROOT: %%~fF ^> %DEST_DRIVE%\
      )
    )
  )
) else if "%MODE%"=="2" (
  pushd "%APP_ROOT%"
  for %%P in (%VB6PATS%) do (
    for /f "delims=" %%F in ('dir /b /s "%%P" 2^>nul') do (
      set "SRC=%%~fF"
      set "REL=%%~pF"
      set "REL=!REL:%APP_ROOT%\=!"
      set "DESTDIR=%DEST_DRIVE%\!REL!"
      if not exist "!DESTDIR!" mkdir "!DESTDIR!" >nul 2>&1
      copy /Y "!SRC!" "!DESTDIR!%%~nxF" >nul
      echo EXPORT_RECURSE: !SRC! ^> !DESTDIR!%%~nxF
    )
  )
  popd
) else (
  echo Invalid mode.
  endlocal & exit /b 1
)

echo.
echo Export complete.
echo.
endlocal & exit /b 0
