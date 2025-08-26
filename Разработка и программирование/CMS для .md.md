
Ниже — популярные CMS/движки и генераторы сайтов, которые умеют работать с Markdown (.md) как с источником контента:

Статические генераторы (Markdown — основной формат)
- Jekyll — классика, GitHub Pages, Liquid-шаблоны.
- Hugo — очень быстрый, удобные таксономии, множество тем.
- Eleventy (11ty) — гибкий, JavaScript-стек, простая структура.
- Gatsby — React‑основа, плагин gatsby-transformer-remark/MDX.
- Next.js/Nuxt/Analog — как SSG/ISR, поддержка MD/MDX через плагины.
- Docusaurus — документация/блоги, MD/MDX из коробки.
- MkDocs — документация, простой YAML-конфиг, много тем.
- Astro — компоненты + Markdown/MDX, быстро рендерит статические страницы.

Классические CMS/Headless CMS с поддержкой Markdown
- Ghost — блог/CMS, контент в Markdown (есть визуальный редактор).
- Netlify CMS / Decap CMS — headless-админка к репозиторию, хранит контент в .md.
- Strapi — headless; через плагины/поля для Markdown (хранит как текст/MD).
- Directus — headless поверх БД; Markdown-поля поддерживаются.
- KeystoneJS — headless, есть поля для Markdown/MDX.
- Contentful/Sanity — headless; Markdown через rich text/плагины/конвертеры.
- Git-based CMS: TinaCMS, Forestry (устар.), CloudCannon — правка .md прямо в репо.

Плагины/модули для популярных CMS
- WordPress — плагины для Markdown (Jetpack Markdown, WP Markdown Editor) или хранение в файлах через headless/SSG связки (например, WP как API + фронт на Gatsby/Next).
- Drupal — модуль Markdown.
- Grav — файловая CMS, хранит страницы как .md в файловой системе (очень подходит).
- Statamic — файловая CMS на Laravel, контент в Markdown/YAML.
- Kirby — файловая CMS, хранит контент в текстовых файлах, поддерживает Markdown.
- October CMS — можно использовать Markdown-поля в страницах/компонентах.

Если хотите именно хранить страницы сайта как .md на диске без базы:
- Grav, Statamic, Kirby — удобные файловые CMS с админкой.
- Jekyll/Hugo/Eleventy/Astro — статика из .md, деплой на любой хостинг, очень быстрые.

Быстрый выбор:
- Нужен сайт/блог без БД, просто .md → Hugo или Jekyll.
- Нужна админка редакторам, но хранить .md в Git → Decap CMS (Netlify CMS) + Hugo/Jekyll/Eleventy.
- Нужна файловая CMS с панелью и плагинами → Grav или Statamic.
- Нужен React/компоненты + Markdown/MDX → Next.js или Astro.

Скажите, какие требования по хостингу, админке и динамике (статический/динамический сайт), — подберу точнее.
