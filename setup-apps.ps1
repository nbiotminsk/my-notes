# Скрипт автоматической установки программ через winget
# Запуск: PowerShell -ExecutionPolicy Bypass -File setup-apps.ps1

param(
    [switch]$Silent = $false
)

# Включить UTF-8 для корректного отображения эмодзи
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Автоматическая установка программ" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Проверка запуска от имени администратора
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ ОШИБКА: Требуется запуск от имени администратора!" -ForegroundColor Red
    Write-Host "Перезапустите PowerShell от имени администратора и выполните команду:" -ForegroundColor Yellow
    Write-Host "PowerShell -ExecutionPolicy Bypass -File setup-apps.ps1" -ForegroundColor Yellow
    if (-not $Silent) { Read-Host "Нажмите Enter для выхода" }
    exit 1
}

Write-Host "✓ Запущено от имени администратора" -ForegroundColor Green
Write-Host ""

# Функция для проверки и установки winget
function Install-Winget {
    Write-Host "Проверка наличия winget..." -ForegroundColor Yellow
    
    try {
        $winget = Get-Command winget -ErrorAction Stop
        Write-Host "✓ winget уже установлен" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ winget не найден. Начинаю установку..." -ForegroundColor Red
    }

    try {
        Write-Host "Установка winget через Microsoft Store..." -ForegroundColor Yellow
        
        # Проверка наличия Microsoft Store
        if (Get-AppxPackage -Name Microsoft.WindowsStore) {
            Write-Host "Пытаемся установить App Installer из Microsoft Store..." -ForegroundColor Yellow
            Start-Process "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1" -Wait
            Start-Sleep 10
        }
        
        # Альтернативный способ установки
        Write-Host "Загрузка зависимостей..." -ForegroundColor Yellow
        
        $tempDir = $env:TEMP
        $vcLibsUrl = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
        $uiXamlUrl = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx"
        $wingetUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        
        # Загрузка файлов
        $vcLibsPath = Join-Path $tempDir "Microsoft.VCLibs.x64.14.00.Desktop.appx"
        $uiXamlPath = Join-Path $tempDir "Microsoft.UI.Xaml.2.7.x64.appx"
        $wingetPath = Join-Path $tempDir "Microsoft.DesktopAppInstaller.msixbundle"
        
        Invoke-WebRequest -Uri $vcLibsUrl -OutFile $vcLibsPath
        Invoke-WebRequest -Uri $uiXamlUrl -OutFile $uiXamlPath
        Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetPath
        
        # Установка пакетов
        Add-AppxPackage -Path $vcLibsPath
        Add-AppxPackage -Path $uiXamlPath
        Add-AppxPackage -Path $wingetPath
        
        # Очистка временных файлов
        Remove-Item $vcLibsPath -Force -ErrorAction SilentlyContinue
        Remove-Item $uiXamlPath -Force -ErrorAction SilentlyContinue
        Remove-Item $wingetPath -Force -ErrorAction SilentlyContinue
        
        Write-Host "✓ winget установлен успешно" -ForegroundColor Green
        Start-Sleep 5
        return $true
    }
    catch {
        Write-Host "❌ Не удалось установить winget: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Попробуйте установить его вручную из Microsoft Store" -ForegroundColor Yellow
        return $false
    }
}

# Функция установки приложения
function Install-App {
    param(
        [string]$AppId,
        [string]$AppName,
        [int]$Current,
        [int]$Total
    )
    
    Write-Host ""
    Write-Host "[$Current/$Total] Установка $AppName..." -ForegroundColor Yellow
    
    try {
        $result = winget install --id=$AppId --exact --silent --accept-package-agreements --accept-source-agreements
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ $AppName установлен успешно" -ForegroundColor Green
        }
        elseif ($LASTEXITCODE -eq -1978335189) {
            Write-Host "⚠️ $AppName уже установлен" -ForegroundColor Yellow
        }
        else {
            Write-Host "❌ Ошибка установки $AppName (код: $LASTEXITCODE)" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "❌ Ошибка установки $AppName : $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Start-Sleep 1
}

# Проверка и установка winget
if (-not (Install-Winget)) {
    if (-not $Silent) { Read-Host "Нажмите Enter для выхода" }
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "       Установка приложений" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Список приложений для установки
$apps = @(
    @{ Id = "Microsoft.VCRedist.2015+.x64"; Name = "Microsoft Visual C++ 2015-2022 Redistributable (x64)" },
    @{ Id = "Microsoft.VCRedist.2015+.x86"; Name = "Microsoft Visual C++ 2015-2022 Redistributable (x86)" },
    @{ Id = "Microsoft.DirectX"; Name = "Microsoft DirectX End-User Runtimes" },
    @{ Id = "Microsoft.DotNet.Framework.DeveloperPack_4"; Name = "Microsoft .NET Framework 4.8 Developer Pack" },
    @{ Id = "Git.Git"; Name = "Git" },
    @{ Id = "Google.Chrome"; Name = "Google Chrome" },
    @{ Id = "Microsoft.VisualStudioCode"; Name = "VS Code" },
    @{ Id = "Daum.PotPlayer"; Name = "PotPlayer" },
    @{ Id = "qBittorrent.qBittorrent"; Name = "qBittorrent" },
    @{ Id = "Wintoys.Wintoys"; Name = "WinToys" },
    @{ Id = "Lux-Delux.RyTuneX"; Name = "RyTuneX" },
    @{ Id = "GitHub.cli"; Name = "GitHub CLI" },
    @{ Id = "OpenJS.NodeJS"; Name = "Node.js" },
    @{ Id = "Microsoft.PowerShell"; Name = "PowerShell" },
    @{ Id = "EpicGames.EpicGamesLauncher"; Name = "Epic Games Launcher" },
    @{ Id = "Valve.Steam"; Name = "Steam" },
    @{ Id = "Obsidian.Obsidian"; Name = "Obsidian" },
    @{ Id = "Windscribe.Windscribe"; Name = "Windscribe VPN" },
    @{ Id = "Python.Python.3.12"; Name = "Python 3.12" }
)

# Установка приложений
$totalApps = $apps.Count
for ($i = 0; $i -lt $totalApps; $i++) {
    Install-App -AppId $apps[$i].Id -AppName $apps[$i].Name -Current ($i + 1) -Total $totalApps
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "       Обновление pip" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Установка .NET Framework 3.5 через DISM
Write-Host ""  
Write-Host "Установка .NET Framework 3.5..." -ForegroundColor Yellow
try {
    $dotNet35 = Get-WindowsOptionalFeature -Online -FeatureName NetFx3 -ErrorAction Stop
    if ($dotNet35.State -eq "Enabled") {
        Write-Host "✓ .NET Framework 3.5 уже установлен" -ForegroundColor Green
    } else {
        Write-Host "Установка .NET Framework 3.5 через DISM..." -ForegroundColor Yellow
        Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All -NoRestart
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ .NET Framework 3.5 установлен успешно" -ForegroundColor Green
        } else {
            Write-Host "❌ Ошибка установки .NET Framework 3.5" -ForegroundColor Red
        }
    }
}
catch {
    Write-Host "❌ Не удалось проверить статус .NET Framework 3.5: $($_.Exception.Message)" -ForegroundColor Red
}

# Обновление pip
try {
    $pythonPath = Get-Command python -ErrorAction Stop
    Write-Host "Обновление pip..." -ForegroundColor Yellow
    python -m pip install --upgrade pip
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ pip успешно обновлен" -ForegroundColor Green
    } else {
        Write-Host "❌ Ошибка обновления pip" -ForegroundColor Red
    }
}
catch {
    Write-Host "⚠️ Python не найден в PATH. Возможно, требуется перезагрузка" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "              ЗАВЕРШЕНО" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Установка завершена!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 РЕКОМЕНДАЦИИ:" -ForegroundColor Yellow
Write-Host "1. Перезагрузите компьютер для корректной работы всех программ"
Write-Host "2. Откройте новую сессию PowerShell для обновления PATH"
Write-Host "3. Настройте учетные записи в установленных программах"
Write-Host ""
Write-Host "🔧 ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ:" -ForegroundColor Yellow
Write-Host "- Git: git config --global user.name `"Ваше Имя`""
Write-Host "- Git: git config --global user.email `"your@email.com`""
Write-Host "- VS Code: установите нужные расширения"
Write-Host "- GitHub CLI: gh auth login"
Write-Host ""

if (-not $Silent) {
    Read-Host "Нажмите Enter для продолжения"
    
    $choice = Read-Host "Хотите просмотреть список установленных программ? (y/n)"
    if ($choice -eq "y" -or $choice -eq "Y") {
        Write-Host ""
        Write-Host "Список установленных программ через winget:" -ForegroundColor Yellow
        winget list
    }
    
    Write-Host ""
    Read-Host "Нажмите Enter для выхода"
}
