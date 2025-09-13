
Ниже — основные команды и примеры для работы с Google AI (Gemini) через официальный gemini-cli (Node.js-пакет @google/generative-ai):

Установка и настройка
- Установка CLI глобально:
npm install -g @google/generative-ai

- Проверка версии:
gemini --version

- Входной ключ API (переменная окружения):
export GOOGLE_API_KEY="ВАШ_КЛЮЧ"
# Windows (PowerShell):
setx GOOGLE_API_KEY "ВАШ_КЛЮЧ"

Базовые команды
- Справка по всем командам:
gemini --help

- Справка по конкретной команде:
gemini chat --help

Чат и генерация текста
- Запуск интерактивного чата с моделью:
gemini chat
# Опции:
# -m, --model <имя> (например, gemini-1.5-flash, gemini-1.5-pro)
# -s, --system <текст> системное сообщение
# -p, --prompt <текст> стартовый промпт
# --json вывод в JSON
# --max-output-tokens <n> ограничение токенов
# --temperature <0..2> креативность

Пример:
gemini chat -m gemini-1.5-flash -s "Ты помощник." -p "Придумай слоган для кофейни"

- Одноразовая генерация текста (без сессии):
gemini generate -m gemini-1.5-pro -p "Суммируй эту новость: …" --max-output-tokens 512

Файлы и мультимодальность
- Загрузка файла в контекст:
gemini upload ./doc.pdf --mime application/pdf
# Выводит fileId, который можно использовать в промпте

- Список загруженных файлов:
gemini files list

- Просмотр метаданных файла:
gemini files get <fileId>

- Удаление файла:
gemini files delete <fileId>

- Генерация с учетом файла:
gemini generate -m gemini-1.5-pro -p "Извлеки ключевые тезисы из файла" --file <fileId>

- Мультимодальный ввод (картинки, аудио, видео):
gemini generate -m gemini-1.5-pro -p "Опиши изображение" --image ./photo.jpg
gemini generate -m gemini-1.5-pro -p "Расшифруй аудио" --audio ./speech.wav
gemini generate -m gemini-1.5-pro -p "Опиши видео" --video ./clip.mp4

История и сессии (Чекпоинты)
- В CLI нет флага `--checkpointing`, но его роль выполняет механизм сессий. Он позволяет сохранять и загружать историю диалога.
- Сохранение/загрузка истории чата:
gemini chat --session save --name my-session
gemini chat --session load --name my-session
gemini chat --session list
gemini chat --session delete --name my-session

Параметры генерации
- Общие тюнинговые параметры:
--temperature 0.2 более детерминированный вывод
--top-p 0.9
--top-k 40
--max-output-tokens 1024
--safety off|standard управление фильтрами (если доступно)

Модели
- Просмотр доступных моделей:
gemini models list

- Указание модели в командах:
-m gemini-1.5-flash
-m gemini-1.5-pro
-m gemini-1.5-pro-exp-0801 (пример экспериментальной)

Примеры сценариев
- Переформулировать текст из файла:
fid=$(gemini upload notes.txt --mime text/plain | jq -r '.fileId')
gemini generate -m gemini-1.5-flash --file "$fid" -p "Перефразируй кратко"

- Извлечь таблицу из PDF в CSV:
fid=$(gemini upload report.pdf --mime application/pdf | jq -r '.fileId')
gemini generate -m gemini-1.5-pro --file "$fid" -p "Извлеки таблицы и верни CSV"

Подсказки
- Храните GOOGLE_API_KEY в .env и грузите через direnv или dotenv.
- Для больших файлов используйте upload и затем --file, чтобы не передавать сырой контент в командной строке.
- При ошибках 429/ quota уменьшайте max-output-tokens и temperature, повторяйте запрос позже.

Примечание: Набор команд и параметры могут отличаться в зависимости от версии CLI. Используйте gemini --help и gemini <cmd> --help для актуальной справки.
