# AGENTS.md

## Project
Angular 21 standalone component app (no NgModules). TypeScript strict mode + Angular strict templates.

## Commands
```bash
cd src/Frontend
npm install        # Required before any other command
npm start          # Dev server at http://0.0.0.0:4200 (binds all interfaces)
npm test           # Vitest (not Karma/Jasmine)
npm run build      # Production build to dist/
```
- Package manager: **npm** (not yarn/pnpm)
- Test runner: **Vitest** with `vitest/globals` types

## Styling
- **Tailwind CSS v4**: uses `@import 'tailwindcss'` in `src/styles.css`, not `@tailwind` directives
- Component styles: `styleUrl` (single file) not `styleUrls`

## Code patterns
- Signals for reactive state (`signal()`, `computed()`)
- `bootstrapApplication()` for startup (no NgModule bootstrap)
- Lucide icons via `provideLucideIcons()` in `app.config.ts`; add icons to the provider array

## Formatting
- Prettier: 100 char width, single quotes
- HTML templates use Angular parser (`*.html` files are Angular templates, not plain HTML)

## Architecture
- Entry: `src/main.ts` → `src/app/app.ts` → routes in `src/app/app.routes.ts`
- Routes: `/login`, `/gallery`, `/card`, `/search`; default redirects to `/home` (404 unless added)

## Testing
- Spec files: `*.spec.ts` in same directory as source
- Test config: `tsconfig.spec.json` includes `vitest/globals` types