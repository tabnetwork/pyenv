@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    

echo "Start configure windows pyenv environment variables"

Powershell.exe -executionpolicy Bypass -Command " pwd | select-string .*:.* " > cwd1.txt
Powershell.exe -executionpolicy Bypass -Command " gc cwd1.txt | where {$_ -ne ''} " > cwd2.txt
set /p PARENT=< cwd2.txt
del cwd1.txt
del cwd2.txt

set PATH=%PARENT%\pyenv-win\bin;%PARENT%\pyenv-win\shims;%PATH%;

C:\Windows\System32\reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%PATH%" /f

echo "End configure windows pyenv environment variables"

@pause

