@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ========================================
echo    Автоматическая установка программ
echo ========================================
echo.

:: Проверка запуска от имени администратора
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Запущено от имени администратора
) else (
    echo ❌ ОШИБКА: Требуется запуск от имени администратора!
    echo Перезапустите скрипт, нажав правой кнопкой мыши и выбрав "Запуск от имени администратора"
    pause
    exit /b 1
)

echo.

:: Проверка наличия winget
echo Проверка наличия winget...
where winget >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ winget уже установлен
    goto :install_apps
) else (
    echo ❌ winget не найден. Начинаю установку...
    goto :install_winget
)

:install_winget
echo.
echo Установка winget...
echo Загружаю Microsoft.VCLibs...
powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile 'Microsoft.VCLibs.x64.14.00.Desktop.appx'"
if exist Microsoft.VCLibs.x64.14.00.Desktop.appx (
    powershell -Command "Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx"
    del Microsoft.VCLibs.x64.14.00.Desktop.appx
)

echo Загружаю Microsoft.UI.Xaml...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx' -OutFile 'Microsoft.UI.Xaml.2.7.x64.appx'"
if exist Microsoft.UI.Xaml.2.7.x64.appx (
    powershell -Command "Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx"
    del Microsoft.UI.Xaml.2.7.x64.appx
)

echo Загружаю App Installer (winget)...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -OutFile 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'"
if exist Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle (
    powershell -Command "Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    del Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    echo ✓ winget установлен успешно
    echo Перезагружаю переменные окружения...
    timeout /t 5 >nul
) else (
    echo ❌ Не удалось загрузить winget. Попробуйте установить его вручную из Microsoft Store
    pause
    exit /b 1
)

:install_apps
echo.
echo ========================================
echo       Установка приложений
echo ========================================
echo.

:: Листок приложений для установки
set "apps[0]=Microsoft.VCRedist.2015+.x64"
set "apps[1]=Microsoft.VCRedist.2015+.x86"
set "apps[2]=Microsoft.DirectX"
set "apps[3]=Microsoft.DotNet.Framework.DeveloperPack_4"
set "apps[4]=Git.Git"
set "apps[5]=Google.Chrome"
set "apps[6]=Microsoft.VisualStudioCode"
set "apps[7]=Daum.PotPlayer"
set "apps[8]=qBittorrent.qBittorrent"
set "apps[9]=Wintoys.Wintoys"
set "apps[10]=Lux-Delux.RyTuneX"
set "apps[11]=GitHub.cli"
set "apps[12]=OpenJS.NodeJS"
set "apps[13]=Microsoft.PowerShell"
set "apps[14]=EpicGames.EpicGamesLauncher"
set "apps[15]=Valve.Steam"
set "apps[16]=Obsidian.Obsidian"
set "apps[17]=Windscribe.Windscribe"
set "apps[18]=Python.Python.3.12"

set "names[0]=Microsoft Visual C++ 2015-2022 Redistributable (x64)"
set "names[1]=Microsoft Visual C++ 2015-2022 Redistributable (x86)"
set "names[2]=Microsoft DirectX End-User Runtimes"
set "names[3]=Microsoft .NET Framework 4.8 Developer Pack"
set "names[4]=Git"
set "names[5]=Google Chrome"
set "names[6]=VS Code"
set "names[7]=PotPlayer"
set "names[8]=qBittorrent"
set "names[9]=WinToys"
set "names[10]=RyTuneX"
set "names[11]=GitHub CLI"
set "names[12]=Node.js"
set "names[13]=PowerShell"
set "names[14]=Epic Games Launcher"
set "names[15]=Steam"
set "names[16]=Obsidian"
set "names[17]=Windscribe VPN"
set "names[18]=Python 3.12"

:: Установка каждого приложения
for /L %%i in (0,1,18) do (
    echo.
    echo [%%i/18] Установка !names[%%i]!...
    winget install --id=!apps[%%i]! --exact --silent --accept-package-agreements --accept-source-agreements
    if !errorLevel! == 0 (
        echo ✓ !names[%%i]! установлен успешно
    ) else (
        if !errorLevel! == -1978335189 (
            echo ⚠️ !names[%%i]! уже установлен
        ) else (
            echo ❌ Ошибка установки !names[%%i]! ^(код: !errorLevel!^)
        )
    )
    timeout /t 2 >nul
)

echo.
echo ========================================
echo       Установка .NET Framework 3.5
echo ========================================
echo.

:: Установка .NET Framework 3.5 через DISM
echo Установка .NET Framework 3.5...
dism /online /get-featureinfo /featurename:NetFx3 >nul 2>&1
if !errorLevel! == 0 (
    echo ✓ .NET Framework 3.5 уже установлен
) else (
    echo Установка .NET Framework 3.5 через DISM...
    dism /online /enable-feature /featurename:NetFx3 /all /norestart
    if !errorLevel! == 0 (
        echo ✓ .NET Framework 3.5 установлен успешно
    ) else (
        echo ❌ Ошибка установки .NET Framework 3.5
    )
)

echo.
echo ========================================
echo       Обновление pip
echo ========================================
echo.

:: Проверка и обновление pip
where python >nul 2>&1
if %errorLevel% == 0 (
    echo Обновление pip...
    python -m pip install --upgrade pip
    if %errorLevel% == 0 (
        echo ✓ pip успешно обновлен
    ) else (
        echo ❌ Ошибка обновления pip
    )
) else (
    echo ⚠️ Python не найден в PATH. Возможно, требуется перезагрузка или добавление в PATH вручную
)

echo.
echo ========================================
echo              ЗАВЕРШЕНО
echo ========================================
echo.
echo Установка завершена!
echo.
echo 📋 РЕКОМЕНДАЦИИ:
echo 1. Перезагрузите компьютер для корректной работы всех программ
echo 2. Откройте новую сессию PowerShell/командной строки для обновления PATH
echo 3. Настройте учетные записи в установленных программах
echo.
echo 🔧 ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ:
echo - Git: git config --global user.name "Ваше Имя"
echo - Git: git config --global user.email "your@email.com"
echo - VS Code: установите нужные расширения
echo - GitHub CLI: gh auth login
echo.

pause
echo.
echo Хотите просмотреть список установленных программ? (y/n)
set /p choice="Ваш выбор: "
if /i "%choice%"=="y" (
    echo.
    echo Список установленных программ через winget:
    winget list
)

echo.
echo Нажмите любую клавишу для выхода...
pause >nul
