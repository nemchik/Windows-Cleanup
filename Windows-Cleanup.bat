@echo off
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ADMINISTRATOR PRIVILEGES REQUIRED
    echo Right click on the script and select "Run as administrator".
    pause
    exit /b 1
)
@echo on

echo Checking and restoring system image health
dism /Online /Cleanup-Image /CheckHealth
dism /Online /Cleanup-Image /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth 

echo Running system file checker
sfc /scannow

echo Cleaning up system components
dism /Online /Cleanup-Image /AnalyzeComponentStore
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
dism /Online /Cleanup-Image /StartComponentCleanup

echo Removing superseded updates
dism /Online /Cleanup-Image /SpSuperseded

echo Running disk cleanup
cleanmgr /VERYLOWDISK
cleanmgr /SETUP
cleanmgr /AUTOCLEAN

pause
