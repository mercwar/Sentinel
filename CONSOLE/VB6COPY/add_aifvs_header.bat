@echo off
setlocal

rem -------------------------
rem Usage check
rem -------------------------
if "%~1"=="" (
  echo Usage: %~nx0 path\to\file
  exit /b 1
)

set "TARGET=%~1"
if not exist "%TARGET%" (
  echo ERROR: target file not found: %TARGET%
  exit /b 1
)

rem -------------------------
rem Skip if header already present
rem -------------------------
findstr /M /C:"AIFVS-ARTIFACT" "%TARGET%" >nul 2>&1
if not errorlevel 1 (
  echo AIFVS header already present in "%TARGET%". No changes made.
  exit /b 0
)

rem -------------------------
rem Generate GUID
rem -------------------------
for /f "usebackq delims=" %%G in (`powershell -NoProfile -Command "[guid]::NewGuid().ToString()"`) do set "GUID=%%G"

rem -------------------------
rem Determine comment style
rem -------------------------
set "EXT=%~x1"
set "FNAME=%~nx1"
set "HDR_PREFIX="
set "HDR_SUFFIX="

rem Normalize extension to lower-case (simple)
for %%L in (%EXT%) do set "EXT_LC=%%~L"
set "EXT_LC=%EXT_LC:~0,4%"

rem Choose comment style
if /I "%EXT%"==".bat"  set "STYLE=bat"
if /I "%EXT%"==".cmd"  set "STYLE=bat"
if /I "%EXT%"==".vbp"  set "STYLE=vb"
if /I "%EXT%"==".frm"  set "STYLE=vb"
if /I "%EXT%"==".bas"  set "STYLE=vb"
if /I "%EXT%"==".cls"  set "STYLE=vb"
if not defined STYLE set "STYLE=cblock"

rem -------------------------
rem Prepare temp file
rem -------------------------
set "TMP=%TEMP%\aifvs_hdr_%RANDOM%_%RANDOM%.tmp"
if exist "%TMP%" del /f /q "%TMP%" >nul 2>&1

rem -------------------------
rem Write header according to style
rem -------------------------
if "%STYLE%"=="bat" (
  >> "%TMP%" echo :: AIFVS-ARTIFACT:
  >> "%TMP%" echo :: file=aifvs:%FNAME%
  >> "%TMP%" echo :: id=%GUID%
  >> "%TMP%" echo :: name=CyborgDatalake-Packager
  >> "%TMP%" echo :: version=0.1
  >> "%TMP%" echo :: description=Pack VB6 project into AIFVS package and register by GUID
  >> "%TMP%" echo :: author=Demon
  >> "%TMP%" echo :: created=%DATE% %TIME%
  >> "%TMP%" echo :: tags=packaging,upload,vb6
  >> "%TMP%" echo :: capabilities=package,encode,split,register
  >> "%TMP%" echo :: notes=Keep this header at the top of the file for AIFVS ingestion.
  >> "%TMP%" echo.
) else if "%STYLE%"=="vb" (
  >> "%TMP%" echo ' AIFVS-ARTIFACT: file=aifvs:%FNAME%; id=%GUID%; name=CyborgDatalake-Packager; version=0.1; tags=vb6,packaging; capabilities=package,register
  >> "%TMP%" echo.
) else (
  >> "%TMP%" echo /* AIFVS-ARTIFACT:
  >> "%TMP%" echo    file=aifvs:%FNAME%;
  >> "%TMP%" echo    id=%GUID%;
  >> "%TMP%" echo    name=CyborgDatalake-Packager;
  >> "%TMP%" echo    version=0.1;
  >> "%TMP%" echo    description=Pack VB6 project into AIFVS package and register by GUID;
  >> "%TMP%" echo    author=Demon;
  >> "%TMP%" echo    created=%DATE% %TIME%;
  >> "%TMP%" echo    tags=packaging,upload,vb6;
  >> "%TMP%" echo    capabilities=package,encode,split,register;
  >> "%TMP%" echo    notes=Keep this header at the top of the file for AIFVS ingestion.
  >> "%TMP%" echo */
  >> "%TMP%" echo.
)

rem -------------------------
rem Append original file contents
rem -------------------------
type "%TARGET%" >> "%TMP%"

rem -------------------------
rem Replace original file atomically
rem -------------------------
move /Y "%TMP%" "%TARGET%" >nul 2>&1
if errorlevel 1 (
  echo ERROR: failed to write header to "%TARGET%".
  if exist "%TMP%" del /f /q "%TMP%" >nul 2>&1
  exit /b 1
)

echo AIFVS header inserted into "%TARGET%".
exit /b 0
