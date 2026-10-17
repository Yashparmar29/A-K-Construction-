@echo off
setlocal
echo =============================================
echo   Building AWS Elastic Beanstalk Bundle
echo =============================================
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0package-for-aws-eb.ps1"
pause
