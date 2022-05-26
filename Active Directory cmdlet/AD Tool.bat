@echo off
REM Author Sean Garnett II

REM TODO Add EIN Search capabilities

setlocal
color 0A

for /f "usebackq tokens=1,2 delims=,=- " %%i in (`wmic os get LocalDateTime /value`) do @if %%i==LocalDateTime (
     set fulldate=%%j
)

set "password="
set password=Password%fulldate:~4,4%

:nextUserName
set "userName="
set /p userName="Enter Username: "

if "%userName%"=="" (goto nextUserName)
if "%userName%"== "clear" (
cls
goto nextUserName
)
if "%userName%"== "cls" (
cls
goto nextUserName
)

for /f "tokens=1 delims= " %%i in ("%userName%") do set userName=%%i

if "%userName%" == "exit" (goto end)
if "%userName%" == "s" (goto search)
if "%userName%" == "search" (goto search)

:refresh
powershell "Get-ADUser %userName% -Properties * | select DisplayName, Title, Description, EmployeeID, Enabled, LockedOut, LastBadPasswordAttempt, badPwdCount, LastLogonDate, PasswordExpired, PasswordLastSet, AccountExpirationDate, entrustIGLastAuthDate, entrustIGLastFailedAuthDate, entrustIGTokenLoadDate"
if %ERRORLEVEL% NEQ 0 (
echo An Error Occurred, Error Level: %ERRORLEVEL%
echo:
goto search
)

:options
set "option="
echo Options: search, unlock, reset, next, refresh, manager, exit
set /p option=">"
if "%option%" == "" (goto options)
if "%option%" == "n" (goto nextUserName)
if "%option%" == "next" (goto nextUserName)
if "%option%" == "nxt" (goto nextUserName)
if "%option%" == "exit" (goto end)
if "%option%" == "u" (goto unlock)
if "%option%" == "un" (goto unlock)
if "%option%" == "unlock" (goto unlock)
if "%option%" == "reset" (goto reset)
if "%option%" == "refresh" (goto refresh)
if "%option%" == "m" (goto manager)
if "%option%" == "ma" (goto manager)
if "%option%" == "man" (goto manager)
if "%option%" == "manager" (goto manager)
if "%option%" == "mng" (goto manager)
if "%option%" == "s" (goto search)
if "%option%" == "search" (goto search)
if "%option%" == "clear" (
cls
goto options)
echo "%option%" is an invalid option
echo:
goto :options

:unlock
powershell "Unlock-ADAccount -Identity %userName%"
echo The account has been unlocked

if "%option%" == "unlock" (goto nextUserName)

:reset
set "confirm="
set /p confirm="Confirm: "
if "%confirm%" == "yes" (
powershell "Unlock-ADAccount -Identity %userName%"
powershell "Set-ADAccountPassword -Identity %userName% -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "%password%" -Force)"
powershell "Set-ADUser -Identity %userName% -ChangePasswordAtLogon $true"
echo Temporary Password: %password%
echo:
)

goto options

:manager
set "line="
set "managerName="
for /f "usebackq skip=3 tokens=* delims=,=- " %%i in (`powershell "Get-ADUser %userName% -Properties * | select Manager"`) do (
set line=%%i
)

for /f "tokens=1,2,3,4,5,6 delims==," %%i in ("%line%") do @if %%i==CN (
set managerName=%%j
)

if "%managerName%"== "" (
echo:
echo ----No Manager Found----
goto options
)
powershell "Get-ADuser -filter {SAMAccountName -like '%managerName%'} | select GivenName, Surname, SAMAccountName"

goto options

:search
set "searchName="
set /p searchName="Search Name: "
if "%searchName%" == "" (goto search)
if "%searchName%" == "next" (goto nextUserName)
if "%searchName%" == "exit" (goto end)
if "%searchName%" == "clear" (
cls
goto search
)
powershell "Get-ADuser -filter {DisplayName -like '*%searchName%*'} | select SAMAccountName"
goto nextUserName

:clear
cls


:end
endlocal
exit