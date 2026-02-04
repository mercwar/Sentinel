@echo off
setlocal DisableDelayedExpansion
set "output_file=output.txt"

echo [AVIS BGIN] Paste your script below.
echo [INFO] Press ENTER after each line.
echo [INFO] Press CTRL+C then 'Y' when completely finished.
echo -------------------------------------------------------

:loop
set "user_input="

:: Read one line from stdin (empty lines allowed)
set /p "user_input="

:: If the user typed something (non-empty)
if defined user_input (
    setlocal EnableDelayedExpansion
    echo(!user_input!>>"%output_file%"
    endlocal
    echo [ACK: Saved]
) else (
    :: Preserve empty lines
    echo.>>"%output_file%"
    echo [ACK: Saved empty line]
)

goto loop


goto loop
