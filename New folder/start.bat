@echo off
:: Admin Check
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Administrative privileges required. Right-click and Run as Administrator.
    pause
    exit
)

echo Setting up Ultra-Safe Contest Mode for CodeRoj...
echo Allowing CodeRoj, Google Fonts, common CSS/JS CDNs, Bootstrap, and standard web infrastructure assets...

:: hosts ফাইলের ব্যাকআপ নেওয়া
if not exist C:\Windows\System32\drivers\etc\hosts.bak (
    copy /y C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.bak
)

:: ফেক প্রক্সি সেট করে পুরো ইন্টারনেট ব্লক করা
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:8080" /f

:: বিশ্বজুড়ে ব্যবহৃত সমস্ত কমন CDN, Font, Image, এবং JS লাইব্রেরি অ্যালাউ করা হলো
set "exceptions=*.coderoj.com;*cdnjs.cloudflare.com;*jsdelivr.net;*unpkg.com;*fonts.googleapis.com;*fonts.gstatic.com;*ajax.googleapis.com;*ajax.aspnetcdn.com;*bootstrapcdn.com;*fonticons.com;*fontawesome.com;*gitcdn.github.io;*code.jquery.com;*giscus.app;*twimg.com;*cloudinary.com;*aws.amazon.com;*supabase.co;*firebaseapp.com;*googleusercontent.com;*gstatic.com;<local>"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%exceptions%" /f

:: DNS ক্যাশ ফ্লাশ করা
ipconfig /flushdns

echo ----------------------------------------------------------------------
echo SUCCESS: Contest Mode Active!
echo CodeRoj and all standard styling/CDN layers will work flawlessly.
echo Google Search, OpenAI, and VS Code AI are fully BLOCKED.
echo ----------------------------------------------------------------------
pause
