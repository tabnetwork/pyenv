# If failed, administrator set-executionpolicy remotesigned in powershell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

pyenv install --list
$pythonVersion = Read-Host -Prompt "Please select your python version"
Write-Host "Excute pyenv rehash when the python installation is successful"
Start-Sleep -Seconds 10
if ( $pythonVersion -eq $null ) { $pythonVersion = "3.8.10" ;}

$pythonUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion.exe"
$pythonDownloadPath = "C:\Users\$env:UserName\Downloads\python-$pythonVersion.exe"
$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pythonInstallDir = "$currentDir\pyenv-win\versions\$pythonVersion"
New-Item $pythonInstallDir -ItemType Directory -ea 0
Write-Host ""
Write-Host "Create directory successfully"
Write-Host "Downloading python $pythonVersion, wait a moment please"

if (Test-Path -Path $pythonDownloadPath -PathType Leaf) { Del $pythonDownloadPath ;}
(New-Object Net.WebClient).DownloadFile($pythonUrl, $pythonDownloadPath)
& $pythonDownloadPath InstallAllUsers=1 PrependPath=0 Include_test=0 TargetDir=$pythonInstallDir
if ($LASTEXITCODE -ne 0) {
    throw "The python installer at '$pythonDownloadPath' exited with error code '$LASTEXITCODE'"
}
