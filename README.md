# PokeGallery

A fanart gallery platform where artists can upload, share, and discover Pokémon fanart. Each Pokémon has a dedicated gallery showcasing community-submitted artwork.

**[Live Demo](https://FeliGallery.kity.dev)**

## Features

- 🎨 **Per-Pokémon Galleries** — Browse fanart organized by Pokémon
- 📤 **Image Upload** — Upload fanart with automatic processing (resize, WebP conversion, BlurHash placeholders)
- 👤 **User Profiles** — Create a profile, showcase your art, follow other artists
- ❤️ **Social Features** — Like, comment, and discover trending fanart
- 🔍 **Search & Discovery** — Find fanart by Pokémon, artist, or tags
- 🛡️ **Content Moderation** — Admin dashboard for reviewing uploads

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | Angular 21 (standalone components), TypeScript 5.9, Tailwind CSS v4 |
| **Backend** | ASP.NET 8.0 Minimal API, C#, Dapper ORM |
| **Database** | SQL Server 2022 |
| **Storage** | Cloudflare R2 (S3-compatible) |
| **Auth** | JWT Bearer tokens (HMAC-SHA256) |
| **Containers** | Podman / Docker |
| **CI/CD** | GitHub Actions → GHCR → VPS deploy |
| **Testing** | Vitest (frontend), xUnit (backend) |

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
                    └──────────────┘      └──────────────┘
```

## Getting Started

### Prerequisites

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Node.js 24+](https://nodejs.org/) (LTS)
- [SQL Server](https://www.microsoft.com/en-us/sql-server) (local or Docker)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/pokegallery.git
   cd pokegallery
   ```

2. **Setup the database**
   ```bash
   # Using Docker (recommended)
   docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourPassword123!" \
     -p 1433:1433 --name sqlserver \
     -d mcr.microsoft.com/mssql/server:2022-latest

   # Run migrations
   docker exec -i sqlserver /opt/mssql-tools*/bin/sqlcmd \
     -S localhost -U sa -P "YourPassword123!" \
     -i /path/to/deploy/sql/init.sql
   ```

3. **Start the backend**
   ```bash
   cd src/Backend
   dotnet restore
   dotnet run
   # API available at http://localhost:5062
   ```

4. **Start the frontend**
   ```bash
   cd src/Frontend
   npm install
   npm start
   # App available at http://localhost:4200
   ```

### Default Credentials

- **Username**: `admin`
- **Password**: `admin123`

> ⚠️ Change these immediately in production.

## Project Structure

```
pokegallery/
├── .github/workflows/      # CI/CD pipelines
├── deploy/sql/              # Database migrations & seeds
├── docs/                    # Documentation & SQL scripts
├── src/
│   ├── Backend/             # ASP.NET 8.0 API
│   │   ├── Models/          # Data transfer objects
│   │   ├── Services/        # Business logic
│   │   └── Program.cs       # Entry point & endpoints
│   ├── Frontend/            # Angular 21 SPA
│   │   └── src/app/
│   │       ├── features/    # Feature modules (gallery, auth, etc.)
│   │       ├── shared/      # Shared services & components
│   │       └── guards/      # Route guards
│   └── DB/                  # SQL Server Data Tools project
└── compose.yml              # Production container orchestration
```

## API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/auth/register` | Register new user |
| `POST` | `/api/v1/auth/login` | Login, get JWT token |

### Pokémon
| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/pokemon` | List all Pokémon |
| `GET` | `/api/v1/pokemon/{id}` | Get Pokémon details |
| `GET` | `/api/v1/pokemon/{id}/fanarts` | Get fanarts for Pokémon |

### Fanarts
| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/v1/fanarts` | Upload fanart (auth required) |
| `GET` | `/api/v1/fanarts/{id}` | Get fanart details |
| `POST` | `/api/v1/fanarts/{id}/like` | Toggle like (auth required) |
| `POST` | `/api/v1/fanarts/{id}/comments` | Add comment (auth required) |

## Development

### Commands

```bash
# Frontend
cd src/Frontend
npm start              # Start dev server
npm test               # Run tests (Vitest)
npm run build          # Production build

# Backend
cd src/Backend
dotnet run             # Start dev server
dotnet test            # Run tests
dotnet build           # Build project
```

### Proxy Configuration

The frontend proxies API requests to the backend during development:

```
http://localhost:4200/api/* → http://localhost:5062/*
```

## Deployment

The application deploys automatically to a VPS using GitHub Actions:

1. Push to `master` branch
2. GitHub Actions builds Docker images
3. Images pushed to GitHub Container Registry (GHCR)
4. SSH into VPS and pull latest images
5. Podman Compose starts the services

See [`.github/workflows/deploy-vps.yml`](.github/workflows/deploy-vps.yml) for details.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation
- `style:` — Formatting, missing semicolons, etc.
- `refactor:` — Code refactoring
- `test:` — Adding tests
- `chore:` — Maintenance

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Pokémon data from [PokéAPI](https://pokeapi.co/)
- Pokémon is © Nintendo/Game Freak
- This is a fan project for educational purposes
