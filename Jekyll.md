
Ниже — простой путь, как начать пользоваться Jekyll и быстро сделать свою страницу.

1) Что такое Jekyll
- Статический генератор сайтов: из Markdown/HTML и шаблонов делает готовый сайт.
- Идеален для личных страниц, блога, документации.
- Легко деплоится на GitHub Pages.

2) Установка
Требования:
- Ruby (рекомендуется 3.x) и RubyGems
- Bundler (gem install bundler)
- Git
- Node.js не обязателен, но полезен для сборки ассетов в некоторых темах

Шаги:
- macOS: brew install ruby; затем добавьте путь к ruby в PATH, перезайдите в терминал
- Linux (Ubuntu): sudo apt update && sudo apt install ruby-full build-essential zlib1g-dev
- Windows: или WSL (рекомендуется) с Ubuntu и установкой как выше, или RubyInstaller для Windows

Установите Jekyll:
- gem install jekyll bundler
Проверьте:
- jekyll -v

3) Создание нового сайта
- jekyll new my-site
- cd my-site
- bundle exec jekyll serve
- Откройте http://localhost:4000

Структура проекта (минимум):
- _config.yml — настройки сайта (title, url, theme и т.д.)
- index.md / index.html — главная
- _posts/ — посты блога (формат YYYY-MM-DD-title.md)
- _layouts/ — шаблоны
- _includes/ — кусочки шаблонов
- assets/ или css/ — стили и скрипты
- pages (произвольно) — другие страницы .md/.html

4) Быстро настроить персональную страницу
- В _config.yml задайте:
- title, description, url, author
- theme: minima (или другая тема)
- Отредактируйте index.md — сделайте краткую визитку.
- Добавьте страницу About: создайте about.md с front matter:
---
layout: page
title: "Обо мне"
permalink: /about/
---
Текст страницы...
- Создайте пост (опционально) в _posts/2025-01-01-hello.md:
---
layout: post
title: "Привет, Jekyll"
---
Содержимое поста.

5) Темы и дизайн
- Быстрый старт: используйте встроенную тему minima (по умолчанию).
- Найти темы: https://jekyllthemes.io, https://jamstackthemes.dev/ssg/jekyll/
- Установка темы через Gem:
- В Gemfile добавьте gem "minima" (или другую тему)
- В _config.yml: theme: minima
- bundle install
- Кастомизация:
- Создайте свои файлы в _layouts, _includes, assets — Jekyll переопределит файлы темы с тем же путем.
- Подключите собственный css в _includes/head.html или через настройки темы.

6) Локальная разработка
- Запуск: bundle exec jekyll serve
- Автообновление при изменениях: включено по умолчанию
- Режим черновиков: bundle exec jekyll serve --drafts (черновики в _drafts/)
- Сборка для продакшена: JEKYLL_ENV=production bundle exec jekyll build (в _site)

7) Публикация на GitHub Pages (самый простой способ)
Вариант А: репозиторий username.github.io (для персонального сайта):
- Создайте публичный репозиторий с именем ваш_логин.github.io
- Залейте туда файлы Jekyll (не папку _site).
- В Settings → Pages убедитесь, что публикация из ветки main (или master).
- Ограничения: GitHub Pages поддерживает ограниченный набор плагинов. Используйте github-pages gem:
- В Gemfile:
gem "github-pages", group: :jekyll_plugins
- В _config.yml убедитесь, что нет неподдерживаемых плагинов.
- bundle update github-pages
Вариант Б: деплой собранного _site на любой хостинг (Netlify, Vercel, S3, VPS)
- На Netlify: подключите репозиторий, билд-команда: bundle exec jekyll build, publish directory: _site
- На Vercel: аналогично через билд-скрипт
- На S3/CloudFront: залейте содержимое _site

8) Плагины
- Добавляйте в Gemfile и _config.yml в раздел plugins: [jekyll-sitemap, jekyll-feed, jekyll-seo-tag]
- Пример:
plugins:
- jekyll-seo-tag
- jekyll-sitemap
- jekyll-feed
- Вставьте в head: {% seo %} (в layout), чтобы работало SEO-тегирование
- На GitHub Pages используйте только поддерживаемые плагины (список в доке github-pages)

9) Контент в Markdown
- Фронт-маттер в начале файла между --- управляет макетом, заголовком, URL:
---
layout: page
title: "Портфолио"
permalink: /portfolio/
---
- Ссылки, изображения, код — обычный Markdown. Медиа кладите в assets/img или uploads.

10) Частые проблемы
- Не находится jekyll командой: проверьте PATH к ruby/gems, перезапустите терминал.
- Конфликт версий на Windows: предпочтительно WSL.
- Ошибки сборки темы: bundle update, убедитесь в совместимости Ruby/Jekyll.
- GitHub Pages показывает старую версию: проверьте Actions/Pages build logs, очистите кэш браузера.

11) Минимальный чек-лист
- Установили Ruby, Bundler, Jekyll
- jekyll new my-site && cd my-site
- Настроили _config.yml, index.md
- Локально проверили: bundle exec jekyll serve
- Выбрали тему/кастомизировали
- Задеплоили на GitHub Pages или Netlify

Нужен пример репозитория-шаблона с уже настроенными страницами и SEO? Скажу, какую тему выбрать под ваши цели и соберу пример _config.yml.



