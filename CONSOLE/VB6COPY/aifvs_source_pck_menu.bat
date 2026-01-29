@echo off
setlocal enabledelayedexpansion

:: FORCE ANCHOR APP ROOT (WORKS EVEN IF CALLED FROM ANYWHERE)
for %%A in ("%~f0") do set "APP_ROOT=%%~dpA"
set "APP_ROOT=%APP_ROOT:~0,-1%"



:menu
cls
echo ============================================
echo          AIFVS SOURCE PACK MENU
echo ============================================
echo App Home (Root): %APP_ROOT%
echo AVIS_DRIVE     : %AVIS_DRIVE%
echo ============================================
echo.
echo 1) Select removable drive
echo 2) Import VB6 project FROM AVIS_DRIVE -> App Home
echo 3) Export VB6 project FROM App Home -> AVIS_DRIVE
echo 4) Root Mode (App Folder)
echo 5) Exit
echo.
set /p "CH=Choose option (1-5): "

if "%CH%"=="1" (
  call "%APP_ROOT%\avis_rem_drv_selector.bat"
  pause
  goto :menu
)

if "%CH%"=="2" (
  if not defined AVIS_DRIVE (
    echo No AVIS_DRIVE selected. Choose option 1 first.
    pause
    goto :menu
  )
  call "%APP_ROOT%\avis_vb6_import.bat" "%AVIS_DRIVE%"
  pause
  goto :menu
)

if "%CH%"=="3" (
  if not defined AVIS_DRIVE (
    echo No AVIS_DRIVE selected. Choose option 1 first.
    pause
    goto :menu
  )
  call "%APP_ROOT%\avis_vb6_export.bat" "%AVIS_DRIVE%"
  pause
  goto :menu
)

if "%CH%"=="4" (
  call :root_mode
  goto :menu
)

if "%CH%"=="5" (
  endlocal & exit /b 0
)

goto :menu

:root_mode
cls
echo ============================================
echo          ROOT MODE (APP FOLDER)
echo ============================================
echo App Home: %APP_ROOT%
echo.
echo 1) List files in app root only
echo 2) List files in app folder recursively
echo 3) Copy VB6 files from app root to \root_stage
echo 4) Copy VB6 files recursively to \root_stage
echo 5) Return to main menu
echo.
set /p "RM=Choose option (1-5): "

if "%RM%"=="1" (
    pushd "%APP_ROOT%"
    echo --- Files in app root (%APP_ROOT%) ---
    dir /b .
    popd
    pause
    goto :eof
)

if "%RM%"=="2" (
    pushd "%APP_ROOT%"
    echo --- Files under app folder (recursive) ---
    dir /b /s .
    popd
    pause
    goto :eof
)

if "%RM%"=="3" (
    set "STAGE=%APP_ROOT%\root_stage"
    if exist "%STAGE%" rd /s /q "%STAGE%"
    mkdir "%STAGE%" >nul 2>&1
    for %%P in (*.vbp *.frm *.bas *.cls *.ctl *.pag *.dsr *.mak *.txt *.ini *.rc) do (
        if exist "%APP_ROOT%\%%P" copy /Y "%APP_ROOT%\%%P" "%STAGE%" >nul
    )
    echo Root-only VB6 files copied to: %STAGE%
    pause
    goto :eof
)

if "%RM%"=="4" (
    set "STAGE=%APP_ROOT%\root_stage"
    if exist "%STAGE%" rd /s /q "%STAGE%"
    mkdir "%STAGE%" >nul 2>&1
    pushd "%APP_ROOT%"
    for /f "delims=" %%F in ('dir /b /s *.vbp *.frm *.bas *.cls *.ctl *.pag *.dsr *.mak *.txt *.ini *.rc 2^>nul') do (
        set "SRC=%%~fF"
        set "REL=%%~pF"
        set "REL=!REL:%APP_ROOT%\=!"
        set "DESTDIR=%STAGE%\!REL!"
        if not exist "!DESTDIR!" mkdir "!DESTDIR!" >nul
        copy /Y "!SRC!" "!DESTDIR!%%~nxF" >nul
    )
    popd
    echo Recursive VB6 files copied to: %STAGE%
    pause
    goto :eof
)

goto :eof
