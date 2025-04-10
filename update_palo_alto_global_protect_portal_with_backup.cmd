@echo off
SETLOCAL

:: New portal address
SET NEW_PORTAL=your.new.portal.com

:: Registry path
SET REG_PATH="HKLM\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup"

:: Backup existing portal
FOR /F "tokens=3*" %%A IN ('REG QUERY %REG_PATH% /v Portal 2^>nul') DO (
    SET EXISTING_PORTAL=%%A
)

IF DEFINED EXISTING_PORTAL (
    ECHO Existing portal: %EXISTING_PORTAL%
    ECHO Backing up to: %TEMP%\gp_portal_backup.txt
    ECHO %EXISTING_PORTAL% > "%TEMP%\gp_portal_backup.txt"
) ELSE (
    ECHO No existing portal found.
)

:: Set new portal
REG ADD %REG_PATH% /v Portal /t REG_SZ /d %NEW_PORTAL% /f

:: Restart GlobalProtect
net stop PanGPS
net start PanGPS

ECHO GlobalProtect portal changed to: %NEW_PORTAL%
ENDLOCAL
pause
