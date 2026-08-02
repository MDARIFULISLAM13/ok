@echo off
:: Admin Check
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Administrative privileges required. Right-click and Run as Administrator.
    pause
    exit
)

echo Disabling Contest Mode and restoring Internet...

:: প্রক্সি সেটিংস পুরোপুরি মুছে ফেলা
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /f

:: hosts ফাইল আগের অবস্থায় ফিরিয়ে আনা
if exist C:\Windows\System32\drivers\etc\hosts.bak (
    copy /y C:\Windows\System32\drivers\etc\hosts.bak C:\Windows\System32\drivers\etc\hosts
    del C:\Windows\System32\drivers\etc\hosts.bak
)

:: DNS ক্যাশ ফ্লাশ করা
ipconfig /flushdns

echo ----------------------------------------------------------------------
echo SUCCESS: Internet restored to normal! Everything is back to original.
echo ----------------------------------------------------------------------
pause
