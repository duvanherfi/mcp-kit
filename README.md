# mcp-kit

Los servidores MCP que uso para programar con IA, listos para copiar.

Si llegaste por el «comenta MCP» de [@duvanh.dev](https://duvanh.dev): esto es
lo que prometí.

## Qué es un MCP, en una frase

Es el enchufe entre la IA y tus herramientas. Sin él, la IA solo ve lo que le
pegas en el chat. Con él, puede leer tus issues de GitHub, consultar tu base de
datos o abrir el navegador, y volver con el dato.

## Los 5 que tengo conectados

| Servidor | Para qué lo uso | Necesita |
|---|---|---|
| **GitHub** | Leer issues y PR, revisar código y abrir ramas sin salir del editor | Un token de GitHub |
| **Postgres** | Preguntar a la base en español: «¿qué cliente compró más?» | La URL de la base (solo lectura) |
| **Playwright** | Que la IA abra la web, haga clic y compruebe que algo funciona | Node |
| **Chrome DevTools** | Leer la consola, la red y el rendimiento de una página real | Node y Chrome |
| **Sentry** | Traer el error real (traza, contexto) en vez de describírselo | Cuenta de Sentry (inicia sesión al conectar) |

## Instalar en Claude Code

Un comando por servidor. Elige los que quieras:

```bash
# GitHub — crea el token en github.com/settings/tokens y expórtalo antes
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer $GITHUB_PERSONAL_ACCESS_TOKEN"

# Postgres — en modo solo lectura (mira postgres/solo-lectura.sql)
claude mcp add postgres -e DATABASE_URI="postgresql://ia_lectura:CLAVE@localhost:5432/mi_base" \
  -- uvx --with "mcp<2" postgres-mcp --access-mode=restricted

# Playwright
claude mcp add playwright -- npx @playwright/mcp@latest

# Chrome DevTools
claude mcp add chrome-devtools -- npx chrome-devtools-mcp@latest

# Sentry — al usarlo por primera vez, /mcp te pide iniciar sesión
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

Comprueba que están con `claude mcp list`, o dentro de Claude Code con `/mcp`.

¿Prefieres un archivo? [`claude-code/.mcp.json`](claude-code/.mcp.json) va en
la raíz de tu proyecto y lee las claves de tus variables de entorno.

## Instalar en Cursor

Copia [`cursor/mcp.json`](cursor/mcp.json) a `~/.cursor/mcp.json` (para todos
tus proyectos) o a `.cursor/mcp.json` (solo uno), y cambia los valores
`PON_AQUI_…` por los tuyos.

## Cuatro reglas para no llevarte un susto

1. **La base, siempre en solo lectura.** Usa `--access-mode=restricted` **y**
   un usuario de Postgres que solo pueda leer
   ([`postgres/solo-lectura.sql`](postgres/solo-lectura.sql)). Las dos cosas:
   si una falla, queda la otra.
2. **Ningún token en el repo.** Van en variables de entorno. Si copias el
   archivo de Cursor con tus claves dentro, no lo subas a git.
3. **El `--with "mcp<2"` de Postgres no sobra.** `postgres-mcp` aún no
   funciona con la versión 2 del SDK de MCP: sin esa parte, `uvx` instala la
   nueva y el servidor no arranca (probado en octubre de 2026).
4. **Empieza con uno.** Conecta el que más uses, mira qué le pide la IA y
   luego añade el siguiente.

## De dónde sale cada uno

- GitHub: [github/github-mcp-server](https://github.com/github/github-mcp-server)
- Postgres: [crystaldba/postgres-mcp](https://github.com/crystaldba/postgres-mcp)
- Playwright: [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp)
- Chrome DevTools: [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- Sentry: [getsentry/sentry-mcp](https://github.com/getsentry/sentry-mcp)

---

Más comandos y trucos para devs en [duvanh.dev](https://duvanh.dev) y en
[@duvanh.dev](https://www.instagram.com/duvanh.dev) (Instagram y TikTok).
Si te sirvió, dale una ⭐.
