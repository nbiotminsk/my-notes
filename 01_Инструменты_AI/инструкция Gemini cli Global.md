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
Add-Content $PROFILE "# Алиасы"
Add-Content $PROFILE "Set-Alias -Name gm -Value gemini-global"
```

### 4. Применение изменений

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

### `gm` (алиас)
Короткая команда для `gemini-global`:
```powershell
gm
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

## Дополнительные возможности профиля

Вы можете добавить в профиль и другие полезные функции:

```powershell
# Быстрый переход в папки проектов
function goto-projects { cd "D:\Projects" }
function goto-desktop { cd "C:\Users\$env:USERNAME\Desktop" }

# Информация о системе
function sys-info { 
    Write-Host "PowerShell: $($PSVersionTable.PSVersion)"
    Write-Host "OS: $(Get-ComputerInfo | Select-Object -ExpandProperty WindowsProductName)"
    Write-Host "User: $env:USERNAME"
    Write-Host "Path: $(Get-Location)"
}

# Очистка с приветствием
function cls-welcome {
    Clear-Host
    Write-Host "PowerShell готов к работе!" -ForegroundColor Green
    Write-Host "Используйте 'gemini-global' для запуска Gemini CLI" -ForegroundColor Yellow
}
```

---

**Создано:** $(Get-Date)
**Автор:** PowerShell Assistant
**Версия:** 1.0
