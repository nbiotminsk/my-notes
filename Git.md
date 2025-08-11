# Git команды для работы с заметками

## 🚀 Первоначальная настройка Git

### Установка Git
Скачайте и установите Git с официального сайта: https://git-scm.com/download/win

### Настройка пользователя (ОБЯЗАТЕЛЬНО)
Перед началом работы настройте ваше имя и email:
```bash
# Настройка имени пользователя
git config --global user.name "Ваше Имя"

# Настройка email
git config --global user.email "your.email@gmail.com"

# Проверка настроек
git config --global user.name
git config --global user.email
```

### Дополнительные настройки
```bash
# Настройка редактора по умолчанию
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "notepad"      # Блокнот

# Настройка цветного вывода
git config --global color.ui auto

# Настройка автоматического переноса строк (для Windows)
git config --global core.autocrlf true
```

## 🎯 Начало работы с репозиторием

### Вариант 1: Создание нового репозитория с нуля
```bash
# 1. Создать папку для проекта
mkdir my-notes
cd my-notes

# 2. Инициализировать Git репозиторий
git init

# 3. Создать файл README.md
echo "# Мои заметки" > README.md

# 4. Добавить файлы в staging
git add .

# 5. Создать первый коммит
git commit -m "Первый коммит: инициализация репозитория"

# 6. Добавить удаленный репозиторий (создайте репо на GitHub сначала)
git remote add origin https://github.com/USERNAME/REPOSITORY.git

# 7. Отправить на GitHub
git push -u origin master
```

### Вариант 2: Клонирование существующего репозитория
```bash
# Клонировать репозиторий в текущую папку
git clone https://github.com/USERNAME/REPOSITORY.git

# Клонировать в конкретную папку
git clone https://github.com/USERNAME/REPOSITORY.git my-notes

# Перейти в папку репозитория
cd my-notes
```

### Вариант 3: Подключение локальной папки к существующему GitHub репозиторию
```bash
# 1. Перейти в папку с файлами
cd D:\Obsidian\Notes

# 2. Инициализировать Git
git init

# 3. Добавить удаленный репозиторий
git remote add origin https://github.com/USERNAME/REPOSITORY.git

# 4. Получить данные с удаленного репозитория
git fetch origin

# 5. Создать и переключиться на главную ветку
git checkout -b master origin/master

# ИЛИ если хотите сохранить локальные файлы:
# git add .
# git commit -m "Добавлены локальные файлы"
# git pull origin master --allow-unrelated-histories
```

## Основные команды для ежедневной работы

### 📋 Проверка статуса
```bash
git status
```
Показывает текущее состояние репозитория - какие файлы изменены, добавлены или удалены.

### ➕ Добавление файлов
```bash
# Добавить конкретный файл
git add "Новая заметка.md"

# Добавить все изменения
git add .

# Добавить все файлы определенного типа
git add *.md
```

### 💾 Создание коммита
```bash
# Коммит с сообщением
git commit -m "Добавлена новая заметка о Git"

# Добавить все изменения и сразу закоммитить
git commit -am "Обновлены существующие заметки"
```

### 🔄 Синхронизация с GitHub

#### Отправка изменений на GitHub
```bash
git push origin master
```

#### Получение изменений с GitHub
```bash
git pull origin master
```

#### Загрузка изменений без слияния
```bash
git fetch origin
```

## 📚 Работа с историей

### Просмотр истории коммитов
```bash
# Краткая история
git log --oneline

# Подробная история
git log

# История конкретного файла
git log -- "Git команды.md"
```

### Просмотр изменений
```bash
# Показать изменения в рабочей директории
git diff

# Показать изменения в конкретном файле
git diff "Git команды.md"

# Показать изменения между коммитами
git diff HEAD~1 HEAD
```

## 🌿 Работа с ветками

### Просмотр веток
```bash
# Локальные ветки
git branch

# Все ветки (включая удаленные)
git branch -a
```

### Создание и переключение веток
```bash
# Создать новую ветку
git branch new-feature

# Переключиться на ветку
git checkout new-feature

# Создать и сразу переключиться
git checkout -b new-feature
```

### Слияние веток
```bash
# Переключиться на главную ветку
git checkout master

# Влить изменения из другой ветки
git merge new-feature
```

## 🚨 Полезные команды для восстановления

### Отмена изменений
```bash
# Отменить изменения в файле (до добавления в staging)
git checkout -- "filename.md"

# Убрать файл из staging area
git reset HEAD "filename.md"

# Отменить последний коммит (сохранив изменения)
git reset --soft HEAD~1

# Жесткая отмена последнего коммита (ОСТОРОЖНО!)
git reset --hard HEAD~1
```

## 📁 Работа с .gitignore

Файл `.gitignore` уже настроен и исключает:
- Папку `.obsidian/` (настройки Obsidian)
- Временные файлы (`*.tmp`, `*.temp`)
- Системные файлы (`.DS_Store`, `Thumbs.db`)

### Добавление новых исключений
Редактируйте файл `.gitignore` и добавьте:
```
# Исключить конкретный файл
secret.txt

# Исключить все файлы определенного типа
*.log

# Исключить папку
private/
```

## 🔧 Настройка Git (если нужно)

### Настройка имени и email
```bash
git config --global user.name "Ваше Имя"
git config --global user.email "your.email@example.com"
```

### Настройка редактора по умолчанию
```bash
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "notepad"      # Блокнот
```

## 🚀 Быстрый рабочий процесс

### Ежедневное сохранение заметок
```bash
# 1. Проверить изменения
git status

# 2. Добавить новые/измененные файлы
git add .

# 3. Создать коммит
git commit -m "Обновлены заметки $(Get-Date -Format 'dd.MM.yyyy')"

# 4. Отправить на GitHub
git push origin master
```

### PowerShell функция для быстрого сохранения
Добавьте в ваш PowerShell профиль:
```powershell
function Save-Notes {
    param($Message = "Обновлены заметки $(Get-Date -Format 'dd.MM.yyyy HH:mm')")
    
    git add .
    git commit -m $Message
    git push origin master
}
```

Использование: `Save-Notes` или `Save-Notes "Добавлена заметка о PowerShell"`

## 🆘 Помощь

### Получение справки
```bash
# Общая справка
git help

# Справка по конкретной команде
git help commit
git help push
```

### Полезные алиасы
```bash
# Настройка коротких команд
git config --global alias.st status
git config --global alias.co checkout  
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
```

После настройки можно использовать:
- `git st` вместо `git status`
- `git co master` вместо `git checkout master`
- `git br` вместо `git branch`

---

*Этот файл является частью репозитория заметок. Редактируйте и дополняйте по мере изучения Git!*
