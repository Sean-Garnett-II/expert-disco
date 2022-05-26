setlocal
@echo off
set /p uName="Enter Username: "
net user %uName% /domain | find "last" /I
net user %uName% /domain | find "expires"
pause