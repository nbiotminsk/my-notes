Что это
- Фреймворк от Microsoft для мультиагентных систем: несколько LLM‑агентов общаются друг с другом, вызывают инструменты (запуск кода, shell, веб‑поиск), привлекают человека «в цикле», пока задача не решена.
- Поддерживает разные модели: OpenAI/Azure, локальные через OpenAI‑совместимые эндпойнты (например, Ollama с Qwen Code), vLLM и др.
- Типовые роли: пользователь‑прокси (UserProxyAgent), ассистент‑программист (AssistantAgent), планировщик, рецензент, тестировщик; менеджер группы координирует диалог.

Установка
- pip install pyautogen
- Нужен API‑ключ для выбранной модели или локальный эндпойнт.

Пример 1. Минимальный «пользователь ↔ кодер» с автозапуском Python‑кода
- Ассистент пишет код, UserProxy извлекает блоки кода и запускает их в рабочей папке.

```
import os
from autogen import AssistantAgent, UserProxyAgent

# Модель (пример с OpenAI; подставьте свой ключ и модель)
llm_config = {
    "config_list": [{
        "model": "gpt-4o-mini",
        "api_key": os.getenv("OPENAI_API_KEY"),
    }],
    "temperature": 0,
}

assistant = AssistantAgent(name="coder", llm_config=llm_config)

user = UserProxyAgent(
    name="user",
    # Автовыполнение кода из ответов агента (без Docker для простоты)
    code_execution_config={"work_dir": "autogen_work", "use_docker": False},
)

user.initiate_chat(
    assistant,
    message=(
        "Напиши Python-скрипт primes.py с функцией is_prime(n) и демонстрацией: "
        "выведи все простые до 100. Запусти код и покажи вывод."
    ),
)
```

Пример 2. Та же схема, но с локальной моделью (Ollama + Qwen Code)
- Удобно для оффлайна/экономии. Запустите: ollama run qwen2.5-coder:7b

```
import os
from autogen import AssistantAgent, UserProxyAgent

llm_config = {
    "config_list": [{
        "model": "qwen2.5-coder:7b",
        "base_url": "http://localhost:11434/v1",  # OpenAI-совместимый сервер Ollama
        "api_key": "ollama",                      # заглушка
    }],
    "temperature": 0,
}

assistant = AssistantAgent(name="coder", llm_config=llm_config)
user = UserProxyAgent(
    name="user",
    code_execution_config={"work_dir": "autogen_local", "use_docker": False},
)

user.initiate_chat(
    assistant,
    message=(
        "Создай script.py, который парсит JSON-файл data.json и печатает сумму поля value."
        " Сгенерируй пример data.json, запусти код."
    ),
)
```

Пример 3. Небольшая команда: планировщик → кодер → тестировщик → ревьюер
- Менеджер группы координирует цикл до прохождения тестов.

```
from autogen import AssistantAgent, UserProxyAgent, GroupChat, GroupChatManager

llm = {
    "config_list": [{
        "model": "gpt-4o-mini",
        "api_key": os.getenv("OPENAI_API_KEY"),
    }],
    "temperature": 0,
}

planner = AssistantAgent(
    name="planner",
    system_message="Ты планировщик: разбивай задачу на шаги и делегируй.",
    llm_config=llm,
)
coder = AssistantAgent(
    name="coder",
    system_message="Ты Python-разработчик. Пиши чистый код и инструкции по запуску.",
    llm_config=llm,
)
tester = AssistantAgent(
    name="tester",
    system_message="Ты тестировщик. Пиши pytest-тесты и запускай их.",
    llm_config=llm,
)
reviewer = AssistantAgent(
    name="reviewer",
    system_message="Ты код-ревьюер. Предлагай улучшения и проверяй стиль.",
    llm_config=llm,
)

user = UserProxyAgent(
    name="user",
    code_execution_config={"work_dir": "autogen_team", "use_docker": False},
)

groupchat = GroupChat(
    agents=[user, planner, coder, tester, reviewer],
    messages=[],
    max_round=12,
)
manager = GroupChatManager(groupchat=groupchat, llm_config=llm)

user.initiate_chat(
    manager,
    message=(
        "Сделайте модуль fib.py с функцией fib(n) (итеративно, O(n)), "
        "и тесты test_fib.py на pytest. Запустите тесты и добейтесь зелёного прогона."
    ),
)
```

Пример 4. Генерация фронта (React) + проверка линтером/тестами
- Тот же UserProxy может запускать shell-команды (npm, eslint, vitest) в рабочей папке.

```
from autogen import AssistantAgent, UserProxyAgent

llm = {"config_list": [{"model": "gpt-4o-mini", "api_key": os.getenv("OPENAI_API_KEY")}], "temperature": 0}
assistant = AssistantAgent(name="react-dev", llm_config=llm)
user = UserProxyAgent(
    name="user",
    code_execution_config={"work_dir": "autogen_react", "use_docker": False},
)

user.initiate_chat(
    assistant,
    message=(
        "Инициализируй Vite+React проект, создай компонент <TodoList />, "
        "добавь ESLint+Prettier, напиши простые тесты (Vitest) и запусти их."
        " Покажи вывод команд. Используй npm."
    ),
)
```

Практические советы
- Для кода ставьте temperature=0 и ограничивайте max_round, чтобы избежать «болтанки».
- Включайте песочницу: code_execution_config.use_docker=True для изоляции окружения.
- Для локальных LLM используйте OpenAI‑совместимые эндпойнты (Ollama/vLLM) и указывайте base_url.
- Ясно задавайте роли через system_message у агентов: это сильно влияет на координацию.
- Старайтесь формулировать цель, критерии готовности (Definition of Done) и артефакты на выходе (файлы, тесты, метрики).