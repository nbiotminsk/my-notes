Установка:

`npm install -g @charmland/crush`
или
`winget install charmbracelet.crush`

Подключение своего провайдера OpenAI находиться по адресу:

`%USERPROFILE%\AppData\Local\crush\crush.json`

```
{
  "$schema": "https://charm.land/crush.json",
  "providers": {
    "ultimateai": {
      "type": "openai",
      "provider_id": "ultimateai",
      "base_url": "https://chat.ultimateai.org/v1",
      "api_key": "$OPENAI_API_KEY",
      "models": [
        {
          "id": "gpt-5",
          "name": "gpt-5",
          "default_max_tokens": 5000
        },
        {
          "id": "proger",
          "name": "proger",
          "default_max_tokens": 4000
        }
      ]
    }
  }
,"models":{"large":{"model":"proger","provider":"ultimateai"}}}
```