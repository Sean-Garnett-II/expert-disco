setlocal
@echo off
color A
cls
:NextUName
set /p uName="Enter Username: "
echo:
net user %uName% /domain | find "last" /I
net user %uName% /domain | find "expires" /I
powershell Get-ADUser %uName% -Properties * | find "EmployeeID" 
powershell Get-ADUser %uName% -Properties * | find "Enabled" 
powershell Get-ADUser %uName% -Properties * | find "LockedOut" 
powershell Get-ADUser %uName% -Properties * | find "LastBadPasswordAttempt"
@echo,
echo "ctr + c" to quit
@echo,
goto :NextUName