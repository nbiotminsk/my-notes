# Гайд: Установка и обновление CLI-инструментов

В этом руководстве собраны команды для установки и обновления ключевых утилит и AI-ассистентов через командную строку Windows. Все команды следует выполнять в **PowerShell, запущенном от имени администратора**.

---

### Часть 1: Системные менеджеры пакетов

Это основа для быстрой и удобной установки большинства программ.

#### Winget

`winget` — это официальный менеджер пакетов от Microsoft, встроенный в современные версии Windows. Если по какой-то причине его нет, установите его так:

```powershell
# Установка из App Installer
Add-AppxPackage -Register -Path (Get-AppxPackage -Name "Microsoft.DesktopAppInstaller").InstallLocation + '\AppxManifest.xml'
```

#### Chocolatey

`chocolatey` (или `choco`) — популярный альтернативный менеджер пакетов.

```powershell
# Установка Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### cURL

`curl` — утилита для передачи данных по URL, часто уже встроена в Windows. Если ее нет, проще всего установить через Chocolatey:

```powershell
choco install curl -y
```

--- 

### Часть 2: Среда выполнения Node.js

Node.js необходим для работы большинства современных CLI-инструментов, написанных на JavaScript.

```powershell
# Установка Node.js через Winget
winget install OpenJS.NodeJS

# ИЛИ через Chocolatey
choco install nodejs -y
```

--- 

### Часть 3: Установка AI-инструментов

Эти команды устанавливают AI-ассистентов глобально с помощью `npm` (который является частью Node.js).

#### Gemini CLI

```powershell
npm install -g @google/gemini-cli
```

#### Qwen Code CLI

```powershell
npm install -g @qwen-code/qwen-code
```

#### Charm Crush CLI

```powershell
# Через npm (рекомендуется, если установлен Node.js)
npm install -g @charmland/crush

# ИЛИ через Winget
winget install charmbracelet.crush
```

--- 

### Часть 4: Обновление инструментов

Регулярно обновляйте инструменты, чтобы получать новые функции и исправления.

#### Обновление Gemini CLI

```powershell
npm update -g @google/gemini-cli
```

#### Обновление Qwen Code CLI

```powershell
npm update -g @qwen-code/qwen-code
```

#### Обновление Charm Crush CLI

```powershell
# Если устанавливали через npm
npm install -g @charmland/crush

# Если устанавливали через Winget
winget upgrade charmbracelet.crush
```

#cli #windows #powershell #install #guide #winget #chocolatey #nodejs #gemini #qwen #crush
