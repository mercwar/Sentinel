@echo off
setlocal

echo.
echo ============================================
echo        AVIS REMOVABLE DRIVE SELECTOR
echo ============================================
echo.

set "SEL_DRIVE="

:: Detect first removable drive (DriveType=2)
for /f "usebackq delims=" %%D in (`
  powershell -NoProfile -Command ^
  "Get-WmiObject Win32_LogicalDisk -Filter 'DriveType=2' | Select-Object -ExpandProperty DeviceID | Select-Object -First 1"
`) do (
  if not "%%D"=="" set "SEL_DRIVE=%%D"
)

if defined SEL_DRIVE (
  echo Detected removable drive: %SEL_DRIVE%
  set /p "ANS=Use this drive? (Y/N): "
  if /I not "%ANS%"=="Y" set "SEL_DRIVE="
) else (
  echo No removable drive auto-detected.
)

if not defined SEL_DRIVE (
  echo.
  set /p "SEL_DRIVE=Enter drive letter manually (format X:): "
)

if "%SEL_DRIVE%"=="" (
  echo No drive selected.
  endlocal & goto :eof
)

if "%SEL_DRIVE:~-1%"=="\" set "SEL_DRIVE=%SEL_DRIVE:~0,-1%"

echo Selected drive: %SEL_DRIVE%

endlocal & set "AVIS_DRIVE=%SEL_DRIVE%"
goto :eof
