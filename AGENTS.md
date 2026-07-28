# AGENTS.md — PokeGallery

## Project Overview

PokeGallery is a fanart gallery platform where users can upload, browse, and interact with Pokémon fanart. Each Pokémon has a dedicated gallery page showing community-submitted artwork.

**Domain**: FeliGallery.kity.dev
**Status**: Early-stage / Active development
**Purpose**: Portfolio project demonstrating full-stack skills

## Architecture

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Angular    │────▶│   Nginx      │────▶│  ASP.NET     │
│   (SPA)      │     │  (static +   │     │  Minimal API │
│              │◀────│   proxy)     │◀────│              │
└──────────────┘     └──────────────┘     └──────┬───────┘
                                                  │
                           ┌──────────────────────┤
                           │                      │
                    ┌──────▼───────┐      ┌───────▼──────┐
                    │  SQL Server  │      │ Cloudflare   │
                    │   2022       │      │ R2 (S3)      │
                    │              │      │              │
                    │  - Users     │      │  - fanarts/  │
                    │  - Fanarts   │      │  - avatars/  │
                    │  - Likes     │      │  - thumbs/   │
                    │  - Comments  │      │              │
                    │  - Follows   │      │              │
                    └──────────────┘      └──────────────┘
```

**Deployment**: Podman containers on RackNerd VPS with Caddy reverse proxy (TLS termination).

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Angular 21 (standalone components), TypeScript 5.9, Tailwind CSS v4, Lucide icons |
| Backend | ASP.NET 8.0 Minimal API, C#, Dapper ORM |
| Database | SQL Server 2022 |
| Auth | JWT Bearer tokens (HMAC-SHA256) |
| Storage | Cloudflare R2 (S3-compatible) |
| Containers | Podman / Podman Compose |
| CI/CD | GitHub Actions → GHCR → SSH deploy to VPS |
| Testing | Vitest (frontend), xUnit (backend) |

## How to Run Locally

### Prerequisites
- .NET 8.0 SDK
- Node.js 24+ (LTS)
- SQL Server (local or Docker)

### Frontend
```bash
cd src/Frontend
npm install        # Required first
npm start          # Dev server at http://0.0.0.0:4200
npm test           # Run tests with Vitest
npm run build      # Production build to dist/
```

### Backend
```bash
cd src/Backend
dotnet restore
dotnet run         # API at http://localhost:5062
```

### Database
- Connection string in `src/Backend/appsettings.Development.json`
- Schema and seed data in `deploy/sql/init.sql`
- Seed Pokémon data in `docs/SQLScripts/SeedPokemons.sql`

### Proxy Configuration
Frontend proxies `/api/*` requests to backend at `http://localhost:5062` (configured in `src/Frontend/proxy.conf.json`).

## Project Structure

```
Gallery/
├── AGENTS.md                    # This file
├── PLAN.md                      # Task backlog and roadmap
├── compose.yml                  # Podman Compose for production
│
├── .github/workflows/
│   ├── publish-images.yml       # Manual: build & push Docker images
│   └── deploy-vps.yml           # Auto: build, push, deploy on master push
│
├── deploy/sql/
│   └── init.sql                 # Database schema + seed data
│
├── docs/SQLScripts/
│   ├── SeedPokemons.sql         # 151 Gen I Pokémon data
│   └── SeedTypesPrototype.sql   # Type definitions
│
└── src/
    ├── Backend/                 # ASP.NET 8.0 Minimal API
    │   ├── Program.cs           # Entry point + endpoint definitions
    │   ├── Models/              # POCOs (PokeCard, Login, TokenResponse)
    │   ├── Services/            # Business logic (PokemonService, LoginService)
    │   └── Dockerfile           # Multi-stage build
    │
    ├── Frontend/                # Angular 21 Standalone App
    │   ├── src/app/
    │   │   ├── app.ts           # Root component
    │   │   ├── app.routes.ts    # Route definitions
    │   │   ├── app.config.ts    # Providers (router, HTTP, icons)
    │   │   ├── login/           # Login page
    │   │   ├── gallery/         # Pokémon gallery grid
    │   │   ├── card/            # Pokémon card component
    │   │   ├── header/          # Navigation header
    │   │   ├── guards/          # Route guards (auth-guard.ts)
    │   │   ├── interceptors/    # HTTP interceptors (auth-interceptor.ts)
    │   │   └── shared/          # Services (PokemonService, LoginService, SearchService)
    │   ├── proxy.conf.json      # Dev proxy: /api → localhost:5062
    │   └── Dockerfile           # Multi-stage build
    │
    └── DB/                      # SQL Server Data Tools project
```

## General Conventions

### Code Style
- **Prettier**: 100 char width, single quotes
- **Language**: TypeScript strict mode, Angular strict templates
- **Naming**: camelCase for variables/functions, PascalCase for classes/components
- **Spanish**: UI text in Spanish (labels, buttons, placeholders)
- **English**: Code, comments, and AGENTS.md files in English

### Angular Patterns
- **Standalone components only** — no NgModules
- **Signals for state**: `signal()`, `computed()`, `effect()`
- **Functional guards/interceptors**: `CanActivateFn`, `HttpInterceptorFn`
- **Modern control flow**: `@if`, `@for`, `@switch` (not `*ngIf`, `*ngFor`)
- **inject() preferred** over constructor injection for new code
- **Single file styles**: `styleUrl` (singular), not `styleUrls`

### Backend Patterns
- **Minimal API**: Routes defined in `Program.cs` with `app.MapGet()`, `app.MapPost()`
- **Services as Transient**: Registered with `builder.Services.AddTransient<T>()`
- **Dapper for data access**: Raw SQL strings with `QueryAsync<T>()`
- **Scoped DB connection**: One `SqlConnection` per request

### Database Patterns
- **Idempotent migrations**: Use `IF OBJECT_ID IS NULL` checks
- **MERGE for seed data**: Prevents duplicate inserts
- **No foreign keys in DDL**: Relationships exist conceptually
- **Spanish names**: Table/column names in Spanish (Nombre, PokedexNumber)

## Nested AGENTS.md Files

For area-specific conventions, see:

- **Backend API**: [`src/Backend/AGENTS.md`](src/Backend/AGENTS.md)
- **Frontend UI**: [`src/Frontend/AGENTS.md`](src/Frontend/AGENTS.md)
- **Database**: [`deploy/sql/AGENTS.md`](deploy/sql/AGENTS.md)
- **Auth & Services**: [`src/Backend/Services/AGENTS.md`](src/Backend/Services/AGENTS.md)

## Current State & Known Issues

### Working
- Login with JWT authentication
- Gallery grid displaying 151 Gen I Pokémon
- Search filtering by name
- Card backgrounds colored by Pokémon type
- Automated CI/CD deployment to VPS

### Known Issues
- Passwords stored in plain text (BCrypt migration planned)
- All users assigned "Admin" role (role system needed)
- N+1 query in PokemonService (one query per Pokémon for types)
- No registration endpoint (only seeded admin user)
- No default route (`/` shows 404)

## Planned Features

See `PLAN.md` for the complete roadmap. Key upcoming:
1. User registration with BCrypt password hashing
2. Fanart upload system with Cloudflare R2 storage
3. Per-Pokémon fanart galleries
4. Social features (likes, comments, follows)
5. Content moderation system
6. Discovery (trending, recent, personalized feed)
