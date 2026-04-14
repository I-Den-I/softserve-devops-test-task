@echo off
SETLOCAL EnableDelayedExpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this script as Administrator!
    pause
    exit /b 1
)

if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set "IP=127.0.0.1"
    set "DESC=Windows ARM detected"
) else (
    set "IP=192.168.56.10"
    set "DESC=Windows x64 detected"
)

set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"
set "ENTRIES=jenkins.local zabbix.local vault.local"

echo --- Configuring Hosts for %DESC% ---

for %%E in (%ENTRIES%) do (
    findstr /i "%%E" "%HOSTS_FILE%" >nul
    if !errorLevel! neq 0 (
        echo Adding %IP% %%E
        echo %IP%	%%E >> "%HOSTS_FILE%"
    ) else (
        echo [SKIP] %%E already exists.
    )
)

echo Done! Everything is ready for Vagrant.
pause