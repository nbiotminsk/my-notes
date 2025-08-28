# Настройка PowerShell профиля для Gemini CLI


## Что такое PowerShell профиль?

  

PowerShell профиль - это специальный скрипт, который автоматически выполняется при каждом запуске PowerShell. Он позволяет настроить персональную среду, создать функции, алиасы и переменные.


## Проблема с Gemini CLI

  

Gemini CLI по умолчанию работает в sandbox режиме, что ограничивает его возможности:

- Может создавать файлы только в текущей директории

- Не может работать с файлами в других папках системы

- Ограниченный доступ к системным ресурсам

  

## Решение

  

### 1. Проверка существования профиля

  

```powershell

Test-Path $PROFILE

```

  

Если возвращает `False` - профиля не существует.

  

### 2. Создание профиля (если не существует)

  

```powershell

New-Item -Type File -Path $PROFILE -Force

```

  

### 3. Добавление функций в профиль

  

```powershell

Add-Content $PROFILE "# Функции для работы с Gemini CLI"

Add-Content $PROFILE "function gemini-global { gemini --sandbox=false }"

Add-Content $PROFILE "function gemini-dir { param([string]`$path) cd `$path; gemini }"

Add-Content $PROFILE ""

Add-Content $PROFILE "# Алиас (gg вместо gm, так как gm занят Get-Member)"

Add-Content $PROFILE "Set-Alias -Name gg -Value gemini-global"

```

  

### 4. Добавление дополнительных функций

  

```powershell

Add-Content $PROFILE "`n# Дополнительные функции для удобства"

Add-Content $PROFILE "function goto-desktop { cd `"C:\Users\`$env:USERNAME\Desktop`" }"

Add-Content $PROFILE "function gemini-status { Write-Host `"Gemini CLI версия: `$(gemini --version)`"; Write-Host `"Путь к профилю: `$PROFILE`" }"

```

  

### 5. Применение изменений

  

```powershell

. $PROFILE

```

  

## Полезные функции

  

После настройки у вас будет доступно:

  

### `gemini-global`

Запускает Gemini CLI без ограничений sandbox:

```powershell

gemini-global

```

  

### `gemini-dir`

Переходит в указанную папку и запускает Gemini CLI:

```powershell

gemini-dir "D:\Projects\MyProject"

```

  

### `gg` (алиас)

Короткая команда для `gemini-global`:

```powershell

gg

```

  

### `goto-desktop`

Быстрый переход на рабочий стол:

```powershell

goto-desktop

```

  

### `gemini-status`

Показывает информацию о Gemini CLI и профиле:

```powershell

gemini-status

```

  

## Полная настройка одной командой

  

Вы можете настроить все сразу, выполнив эти команды:

  

```powershell

# Создание профиля (если не существует)

if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }

  

# Добавление всех функций

@"

# Функции для работы с Gemini CLI

function gemini-global { gemini --sandbox=false }

function gemini-dir { param([string]`$path) cd `$path; gemini }

  

# Алиас

Set-Alias -Name gg -Value gemini-global

  

# Дополнительные функции для удобства

function goto-desktop { cd "C:\Users\`$env:USERNAME\Desktop" }

function gemini-status {

    Write-Host "Gemini CLI версия: `$(gemini --version)" -ForegroundColor Green

    Write-Host "Путь к профилю: `$PROFILE" -ForegroundColor Yellow

    Write-Host "Доступные команды: gemini-global, gg, gemini-dir, goto-desktop" -ForegroundColor Cyan

}

"@ | Set-Content $PROFILE

  

# Применение изменений

. $PROFILE

```

  

## Дополнительные настройки

  

### Просмотр содержимого профиля

```powershell

Get-Content $PROFILE

```

  

### Редактирование профиля

```powershell

notepad $PROFILE

```

  

### Расположение профиля

```powershell

echo $PROFILE

```

  

Обычно находится в:

`C:\Users\[Имя_пользователя]\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

  

## Безопасность

  

⚠️ **Важно**: Отключение sandbox режима снимает ограничения безопасности. Используйте осторожно:

  

- ✅ Безопасно для личных проектов

- ✅ Безопасно для разработки

- ⚠️ Осторожно при работе с важными системными файлами

- ❌ Не рекомендуется в продакшн среде

  

## Альтернативные способы

  

### 1. Временное отключение sandbox

```powershell

gemini --sandbox=false

```

  

### 2. Работа в конкретной папке

```powershell

cd "C:\YourProject"

gemini

```

  

### 3. Включение дополнительных директорий

```powershell

gemini --include-directories "D:\Projects,C:\Development"

```

  

## Устранение проблем

  

### Если функции не работают

1. Перезапустите PowerShell

2. Выполните: `. $PROFILE`

3. Проверьте политику выполнения: `Get-ExecutionPolicy`

  

### Если ошибка выполнения политики

```powershell

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

```

  

### Проверка установки Gemini CLI

```powershell

gemini --version

npm list -g | Select-String gemini

```

  

### Если алиас не работает

Проверьте, не занят ли алиас системной командой:

```powershell

Get-Alias gg -ErrorAction SilentlyContinue

```

  

## Примеры использования

  

### Быстрый запуск Gemini без ограничений

```powershell

gg

```

  

### Запуск Gemini в конкретной папке проекта

```powershell

gemini-dir "D:\MyProject"

```

  

### Переход на рабочий стол и запуск Gemini

```powershell

goto-desktop

gg

```

  

### Проверка статуса

```powershell

gemini-status

```

  

## Дополнительные возможности

  

Вы можете добавить в профиль и другие полезные функции:

  

```powershell

# Быстрый переход в папки проектов

function goto-projects { cd "D:\Projects" }

function goto-docs { cd "C:\Users\$env:USERNAME\Documents" }

  

# Информация о системе

function sys-info {

    Write-Host "PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Green

    Write-Host "OS: $([System.Environment]::OSVersion.VersionString)" -ForegroundColor Yellow

    Write-Host "User: $env:USERNAME" -ForegroundColor Cyan

    Write-Host "Path: $(Get-Location)" -ForegroundColor Magenta

}

  

# Очистка с приветствием

function cls-welcome {

    Clear-Host

    Write-Host "PowerShell готов к работе!" -ForegroundColor Green

    Write-Host "Используйте 'gg' для запуска Gemini CLI без ограничений" -ForegroundColor Yellow

}

  

# Быстрое открытие проводника в текущей папке

function explorer-here { explorer . }

Set-Alias -Name ex -Value explorer-here

```

  

---

  

**Создано:** 28.08.2025

**Автор:** PowerShell Assistant  

**Версия:** 1.1 (исправлен конфликт алиаса)

  

## Быстрая справка

  

| Команда | Описание |

|---------|----------|

| `gg` | Запуск Gemini CLI без sandbox |

| `gemini-global` | То же самое (полная команда) |

| `gemini-dir "путь"` | Переход в папку и запуск Gemini |

| `goto-desktop` | Переход на рабочий стол |

| `gemini-status` | Информация о Gemini и профиле |