@echo off
SETLOCAL

:: Change this to your new portal address
SET NEW_PORTAL=your.new.portal.com

:: Registry path for GlobalProtect
SET REG_PATH="HKLM\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup"

:: Update the portal address
REG ADD %REG_PATH% /v Portal /t REG_SZ /d %NEW_PORTAL% /f

:: Optional: Restart GlobalProtect service to apply changes
net stop PanGPS
net start PanGPS

echo GlobalProtect portal updated to: %NEW_PORTAL%
ENDLOCAL
pause
