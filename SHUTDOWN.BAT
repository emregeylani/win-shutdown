@echo off
setlocal

REM Windows timed shutdown script using decimal hours
REM Author: Emre Geylani (github.com/emregeylani)

REM Ask user for delay in hours (can be decimal)
set /p HOURS=After how many hours should the PC shut down? (You can enter decimal values, e.g: 0.5. Leave empty to cancel): 

REM If user just presses Enter, cancel
if "%HOURS%"=="" (
    echo No value entered. Shutdown scheduling canceled.
    shutdown.exe -a
    timeout /t 5 >nul
    exit /b
)

REM Convert decimal hours to seconds using PowerShell: SECONDS = HOURS * 3600 (rounded to int)
for /f "usebackq delims=" %%S in (`powershell -Command "[int](%HOURS% * 3600)"`) do set SECONDS=%%S

echo.
echo The system will shut down in %HOURS% hour(s). ^(%SECONDS% seconds^)
shutdown.exe -s -t %SECONDS%

echo.
timeout /t 5 >nul
exit
