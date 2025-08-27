
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



Вот минимальный пример лендинг-страницы на Jekyll: с простым layout, секциями hero/benefits/cta, базовым SEO и стилями. Скопируйте файлы в чистый jekyll new проект и запустите bundle exec jekyll serve.

_config.yml
title: "My Product"
description: "Простой лендинг на Jekyll"
url: "https://example.com"
theme: minima
author:
name: "Ваша Компания"
plugins:
- jekyll-seo-tag
# Минимальные настройки навигации (для темы minima можно скрыть меню)
minima:
skin: classic

Gemfile (добавьте плагины)
source "https://rubygems.org"
gem "jekyll", "~> 4.3"
gem "minima", "~> 2.5"
gem "webrick", "~> 1.8" # для локального сервера на Ruby 3
group :jekyll_plugins do
gem "jekyll-seo-tag"
gem "jekyll-sitemap"
gem "jekyll-feed"
end

_includes/head.html (расширим head темы minima SEO-тегом, если не используете кастомную тему)
{% if site.theme %}{% endif %}
{% seo %}
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">

_layouts/landing.html
---
# Кастомный макет для лендинга
---
<!doctype html>
<html lang="ru">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
{% include head.html %}
<title>{{ page.title | default: site.title }}</title>
</head>
<body>
<header class="site-header">
<div class="container">
<a class="logo" href="{{ '/' | relative_url }}">{{ site.title }}</a>
<nav class="nav">
<a href="#features">Функции</a>
<a href="#pricing">Цены</a>
<a href="#faq">FAQ</a>
</nav>
<a class="btn btn-primary small" href="#cta">Начать</a>
</div>
</header>

<main>
<section class="hero">
<div class="container">
<h1>{{ page.hero_title }}</h1>
<p class="lead">{{ page.hero_subtitle }}</p>
<div class="hero-cta">
<a class="btn btn-primary" href="#cta">{{ page.primary_cta_text }}</a>
<a class="btn btn-secondary" href="{{ page.secondary_cta_link | default: '#features' }}">{{ page.secondary_cta_text }}</a>
</div>
{% if page.hero_image %}
<img class="hero-img" src="{{ page.hero_image | relative_url }}" alt="{{ page.hero_title }}">
{% endif %}
</div>
</section>

<section id="features" class="features">
<div class="container grid-3">
{% for feature in page.features %}
<div class="card">
{% if feature.icon %}<div class="icon">{{ feature.icon }}</div>{% endif %}
<h3>{{ feature.title }}</h3>
<p>{{ feature.text }}</p>
</div>
{% endfor %}
</div>
</section>

<section class="social-proof">
<div class="container">
<p class="kpi">Более 10 000 пользователей • Оценка 4.9/5</p>
<div class="logos">
<img src="{{ '/assets/img/logo1.svg' | relative_url }}" alt="Логотип 1">
<img src="{{ '/assets/img/logo2.svg' | relative_url }}" alt="Логотип 2">
<img src="{{ '/assets/img/logo3.svg' | relative_url }}" alt="Логотип 3">
</div>
</div>
</section>

<section id="pricing" class="pricing">
<div class="container grid-3">
{% for plan in page.pricing %}
<div class="card">
<h3>{{ plan.name }}</h3>
<p class="price">{{ plan.price }}</p>
<ul>
{% for item in plan.features %}
<li>{{ item }}</li>
{% endfor %}
</ul>
<a href="#cta" class="btn btn-primary">{{ plan.cta | default: 'Выбрать' }}</a>
</div>
{% endfor %}
</div>
</section>

<section id="faq" class="faq">
<div class="container">
<h2>Частые вопросы</h2>
{% for q in page.faq %}
<details>
<summary>{{ q.q }}</summary>
<p>{{ q.a }}</p>
</details>
{% endfor %}
</div>
</section>

<section id="cta" class="cta">
<div class="container">
<h2>{{ page.cta_title }}</h2>
<p>{{ page.cta_text }}</p>
<form name="signup" method="post" action="https://formspree.io/f/your-id">
<input type="email" name="email" placeholder="Ваш email" required>
<button class="btn btn-primary" type="submit">{{ page.cta_button | default: 'Получить доступ' }}</button>
</form>
<small class="note">Мы не шлем спам. Отписка в один клик.</small>
</div>
</section>
</main>

<footer class="site-footer">
<div class="container">
<p>© {{ site.time | date: '%Y' }} {{ site.author.name }} • <a href="/privacy/">Политика конфиденциальности</a></p>
</div>
</footer>
</body>
</html>

index.md (главная — лендинг с фронт-маттером)
---
layout: landing
title: "My Product — решает вашу задачу за минуты"
hero_title: "Запускайте проекты в 3 раза быстрее"
hero_subtitle: "Небольшой подзаголовок, который усиливает главное обещание."
primary_cta_text: "Попробовать бесплатно"
secondary_cta_text: "Смотреть возможности"
secondary_cta_link: "#features"
hero_image: /assets/img/hero.png
features:
- icon: "⚡"
title: "Быстро"
text: "Мгновенная установка и готовые шаблоны."
- icon: "🔒"
title: "Безопасно"
text: "Хостинг на GitHub Pages и HTTPS из коробки."
- icon: "🧩"
title: "Гибко"
text: "Легко настраивается под ваши задачи."
pricing:
- name: "Free"
price: "$0"
features: ["1 проект", "Базовые блоки", "Email-поддержка"]
cta: "Начать"
- name: "Pro"
price: "$9/мес"
features: ["Неограниченно проектов", "A/B тесты", "Приоритетная поддержка"]
cta: "Оформить"
- name: "Team"
price: "$29/мес"
features: ["Командная работа", "Роли и доступы", "SLA"]
cta: "Связаться"
faq:
- q: "Как опробовать?"
a: "Нажмите «Попробовать бесплатно» и оставьте email."
- q: "Можно на GitHub Pages?"
a: "Да, проект статический — отлично работает на GitHub Pages."
cta_title: "Готовы начать?"
cta_text: "Подпишитесь и получите доступ к шаблонам и гайдам."
cta_button: "Получить доступ"
---

assets/css/main.css (простой стиль, адаптив)
:root {
--bg: #0b1020;
--card: #121933;
--text: #e6e9f2;
--muted: #a8b0c2;
--primary: #4f7cff;
--primary-700: #3a5ed0;
--border: #243056;
}
* { box-sizing: border-box; }
html, body { margin: 0; padding: 0; background: var(--bg); color: var(--text); font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; }
a { color: var(--text); text-decoration: none; }
.container { max-width: 1100px; margin: 0 auto; padding: 0 20px; }
.site-header, .site-footer { border-bottom: 1px solid var(--border); }
.site-footer { border-top: 1px solid var(--border); border-bottom: none; padding: 24px 0; text-align: center; color: var(--muted); }
.site-header .container { display: flex; align-items: center; gap: 20px; padding: 16px 0; }
.logo { font-weight: 700; letter-spacing: .2px; }
.nav { display: flex; gap: 16px; margin-left: auto; }
.btn { display: inline-block; padding: 12px 18px; border-radius: 10px; font-weight: 600; border: 1px solid transparent; }
.btn.small { padding: 8px 12px; font-size: 14px; }
.btn-primary { background: var(--primary); color: #fff; }
.btn-primary:hover { background: var(--primary-700); }
.btn-secondary { background: transparent; border-color: var(--border); color: var(--text); }
.hero { padding: 64px 0; text-align: center; }
.hero .lead { color: var(--muted); max-width: 720px; margin: 12px auto 24px; font-size: 18px; }
.hero-img { max-width: 860px; width: 100%; display: block; margin: 28px auto 0; border-radius: 12px; border: 1px solid var(--border); }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
.card { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 20px; }
.features, .pricing, .faq, .cta, .social-proof { padding: 56px 0; }
.features .icon { font-size: 28px; margin-bottom: 8px; }
.price { font-size: 28px; font-weight: 700; margin: 6px 0 10px; }
.kpi { text-align: center; color: var(--muted); margin-bottom: 16px; }
.logos { display: flex; gap: 24px; justify-content: center; align-items: center; opacity: .9; }
.faq details { background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 12px 16px; margin: 10px 0; }
.cta form { display: flex; gap: 10px; justify-content: center; margin-top: 14px; }
.cta input { padding: 12px 14px; border-radius: 10px; border: 1px solid var(--border); background: #0e1530; color: var(--text); min-width: 260px; }
@media (max-width: 900px) { .grid-3 { grid-template-columns: 1fr; } .nav { display:none; } .hero { padding: 40px 0; } }

Дополнительно:
- Положите изображения в assets/img/.
- Для GitHub Pages используйте github-pages совместимые плагины или удалите неподдерживаемые.
- Хотите репозиторий-шаблон на GitHub с этим кодом? Скажу, создам структуру и дам ссылку/архив.

#cms #static-site-generator #ruby

См. также: [[Разработка и программирование/CMS для .md.md]]

