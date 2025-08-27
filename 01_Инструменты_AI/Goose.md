![[Pasted image 20250825184829.png]]
Что делает этот сервер:

MCP Server Filesystem предоставляет безопасный доступ к файловой системе для AI-агентов (как Goose), позволяя:
•  Читать файлы и директории
•  Создавать и редактировать файлы
•  Управлять файловой структурой проекта
•  Всё это с контролем доступа только к указанной директории

```
npm install -g @modelcontextprotocol/server-filesystem
```


Ниже — краткая инструкция, как установить и использовать Goose CLI вместе с MCP Server Filesystem, чтобы Goose получил безопасный доступ к файловой системе проекта.

1) Установка Goose CLI
- macOS (Homebrew):
brew tap block/goose
brew install goose
- npm (если доступно как пакет):
npm install -g goose-cli
- Проверка:
goose --version

2) Установка MCP Server Filesystem
- Глобально через npm:
npm install -g @modelcontextprotocol/server-filesystem
- Проверка:
mcp-filesystem --help
Примечание: имя бинаря может быть mcp-filesystem или mcp-server-filesystem. Уточните через npx -y @modelcontextprotocol/server-filesystem --help, если команда не находится.

3) Запуск MCP Server Filesystem
- Определите корневую директорию, к которой Goose должен иметь доступ, например текущую папку проекта:
mcp-filesystem --root ./your-project
Опции, которые часто полезны:
-–root <path> корневая директория (обязательная)
--readOnly режим только чтение (опционально)
--allowWrite разрешить запись (если нужно редактирование)
--port <number> порт (если сервер поднимается по TCP)
По умолчанию многие MCP-сервера используют stdio. Если доступен флаг --stdio, можно запустить:
mcp-filesystem --root ./your-project --stdio

4) Подключение MCP-сервера в Goose
Есть два распространённых способа:

- Через конфиг Goose (рекомендуется)
Создайте/обновите файл конфигурации Goose, например ~/.config/goose/config.json:
```
{
"mcpServers": [
{
"name": "filesystem",
"command": "mcp-filesystem",
"args": ["--root", "/absolute/path/to/your-project", "--stdio"]
}
]
}
```
Затем запустите Goose:
goose
Goose поднимет MCP-сервер как дочерний процесс и получит инструменты чтения/записи файлов в пределах указанной директории.

- Через внешний процесс (если сервер слушает по TCP/WS)
1) Запустите сервер отдельно с портом:
mcp-filesystem --root ./your-project --port 8765
2) В конфиге Goose укажите подключение по сети (схема зависит от версии Goose; может быть что-то вроде):
```
{
"mcpServers": [
{
"name": "filesystem",
"transport": "tcp",
"host": "127.0.0.1",
"port": 8765
}
]
}
```

3) Использование в Goose
- Откройте Goose в папке проекта или укажите проект, к которому вы дали доступ в --root.
- Попросите Goose:
- Прочитать файл: “Открой файл README.md”
- Создать файл: “Создай src/index.ts с базовым шаблоном”
- Отредактировать: “Добавь раздел ‘Установка’ в README.md”
Все операции будут ограничены корневой директорией, указанной в --root.

6) Советы по безопасности и отладке
- Всегда указывайте минимально необходимую директорию через --root.
- Если нужна только проверка, используйте --readOnly.
- Посмотрите логи Goose и MCP-сервера при проблемах: добавьте флаг --verbose или аналогичный, если доступен.
- Проверьте, что переменная PATH содержит папку с глобальными npm бинарями (npm bin -g), чтобы goose и mcp-filesystem находились из терминала.

Коротко: установите Goose и @modelcontextprotocol/server-filesystem, запустите файловый MCP-сервер с --root на ваш проект и подключите его в конфиге Goose через stdio или TCP. После этого Goose сможет читать/создавать/редактировать файлы строго в пределах указанной директории.

#cli #ai #filesystem
