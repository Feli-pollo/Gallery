# Database AGENTS.md — SQL Server 2022

## Overview

The database is Microsoft SQL Server 2022 running in a container on the shared VPS network. It stores Pokémon data, user accounts, and will store fanart metadata.

**Database**: `FeliGalleryDB`
**Engine**: SQL Server 2022 (Express edition in container)
**ORM**: Dapper (micro-ORM with raw SQL)
**Port**: 1433 (default SQL Server)

## Connection

### Development

Connection string in `src/Backend/appsettings.Development.json`:

```json
{
    "ConnectionStrings": {
        "PokemonConection": "Server=localhost,1433;Database=FeliGalleryDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"
    }
}
```

### Production

Connection string injected via environment variable in `compose.yml`:

```yaml
environment:
  - ConnectionStrings__PokemonConection=Server=sqlserver,1433;Database=FeliGalleryDB;User Id=GalleryApp;Password=${FELIGALLERY_DB_PASSWORD};TrustServerCertificate=True;
```

## Schema

### Current Tables

```
┌──────────────────────────────────────────────┐
│  Pokemon                                     │
├──────────────────────────────────────────────┤
│  PokedexNumber  INT          PK              │
│  Nombre         NVARCHAR(30)                 │
│  Imagen         NVARCHAR(200)                │
└──────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│  [Type]                                      │
├──────────────────────────────────────────────┤
│  TypeId         INT          PK              │
│  [Type]         NVARCHAR(200)                │
│  Color          VARCHAR(7)   (hex, e.g. #FF0000)│
└──────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│  PokemonTypes (junction/bridge table)        │
├──────────────────────────────────────────────┤
│  PokedexNumber  INT          PK (composite)  │
│  TypeId         INT          PK (composite)  │
└──────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│  Users                                       │
├──────────────────────────────────────────────┤
│  UserId         INT IDENTITY PK              │
│  [User]         NVARCHAR(50)                 │
│  [Password]     NVARCHAR(250)                │
└──────────────────────────────────────────────┘
```

### Relationships

- `Pokemon` ↔ `Type`: **Many-to-many** via `PokemonTypes` junction table
- No foreign key constraints defined in DDL (relationships are conceptual)
- `Users` is independent (no FK to other tables)

### Column Naming Conventions

- **Spanish names**: `Nombre`, `PokedexNumber`, `Imagen`
- **PascalCase**: `PokedexNumber`, `TypeId`, `UserId`
- **Reserved words**: Bracket-escaped: `[Type]`, `[User]`, `[Password]`

## Dapper Query Patterns

### Basic SELECT

```csharp
// In PokemonService.cs
var sqlQuery = "SELECT * FROM Pokemon";
var pokemons = await _dbConnection.QueryAsync<PokeCard>(sqlQuery);
```

### Parameterized Query

```csharp
// Always use @Parameter syntax to prevent SQL injection
var query = "SELECT TypeId FROM PokemonTypes WHERE PokedexNumber = @PokedexNumber";
var types = await _dbConnection.QueryAsync<int>(query, new { PokedexNumber = pokemonId });
```

### Single Row

```csharp
var user = await _dbConnection.QueryFirstOrDefaultAsync<int>(
    "SELECT TOP 1 UserId FROM Users WHERE [User] = @User AND [Password] = @Password",
    new { User = login.User, Password = login.Password }
);
```

### INSERT / UPDATE / DELETE

```csharp
await _dbConnection.ExecuteAsync(
    "INSERT INTO Users ([User], [Password]) VALUES (@User, @Password)",
    new { User = "newuser", Password = "hashedpassword" }
);
```

### JOIN Query (Planned)

```csharp
// Better than N+1: single query with JOIN
var sql = @"
    SELECT p.*, t.TypeId, t.[Type], t.Color
    FROM Pokemon p
    LEFT JOIN PokemonTypes pt ON p.PokedexNumber = pt.PokedexNumber
    LEFT JOIN [Type] t ON pt.TypeId = t.TypeId";
```

## Migration Strategy

### Idempotent Migrations

All migrations use `IF OBJECT_ID IS NULL` checks to be idempotent (safe to run multiple times):

```sql
IF OBJECT_ID(N'dbo.Pokemon', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Pokemon
    (
        PokedexNumber INT NOT NULL,
        Nombre NVARCHAR(30) NULL,
        Imagen NVARCHAR(200) NULL,
        CONSTRAINT PK_Pokemon PRIMARY KEY CLUSTERED (PokedexNumber)
    );
END;
GO
```

### MERGE for Seed Data

Use `MERGE` to prevent duplicate inserts:

```sql
MERGE dbo.[Type] AS target
USING (
    VALUES
    (1, N'RAYO', '#FFF123'),
    (2, N'FUEGO', '#FF0000'),
    (3, N'AGUA', '#0000FF')
) AS source (TypeId, [Type], Color)
ON target.TypeId = source.TypeId
WHEN NOT MATCHED THEN
    INSERT (TypeId, [Type], Color)
    VALUES (source.TypeId, source.[Type], source.Color);
GO
```

### Variable Substitution

SQLCMD variables are used for deployment-time values:

```sql
IF NOT EXISTS (
    SELECT 1 FROM dbo.Users WHERE [User] = N'$(InitialAdminUser)'
)
BEGIN
    INSERT INTO dbo.Users ([User], [Password])
    VALUES (N'$(InitialAdminUser)', N'$(InitialAdminPassword)');
END;
GO
```

### Migration File Structure

```
deploy/sql/
├── init.sql                # Main script (executes everything)
├── SeedPokemons.sql        # 151 Gen I Pokémon data (referenced via :r)
```

**Planned structure** for new migrations:

```
deploy/sql/
├── init.sql                # Orchestrator (calls other scripts)
├── 001_base.sql            # Current tables (Pokemon, Type, Users)
├── 002_users_extend.sql    # New User fields (Email, Role, etc.)
├── 003_fanarts.sql         # Fanart tables
├── 004_social.sql          # Likes, Comments, Follows
└── 005_moderation.sql      # Reports, activity log
```

## Seed Data

### Pokémon Data

151 Gen I Pokémon with official artwork URLs from PokeAPI:

```sql
INSERT INTO dbo.Pokemon (PokedexNumber, Nombre, Imagen)
VALUES
    (1, N'Bulbasaur', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'),
    (2, N'Ivysaur', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png'),
    -- ... 149 more
```

Source: `docs/SQLScripts/SeedPokemons.sql`

### Type Data

Currently only 3 types (RAYO, FUEGO, AGUA). Will expand to all Pokémon types.

### User Data

Single admin user seeded via environment variables at deploy time.

## Database Initialization (Production)

The `db-init` container runs SQL migrations at deploy time:

```yaml
# compose.yml
db-init:
  image: mcr.microsoft.com/mssql/server:2022-latest
  entrypoint: /bin/bash
  command: >
    -c "
    /opt/mssql-tools*/bin/sqlcmd -S sqlserver -U sa -P $${SA_PASSWORD} -i /seed/init.sql
    "
  volumes:
    - ./deploy/sql:/seed
    - ./docs/SQLScripts:/seed
```

## Adding a New Table

1. **Create migration file**: `deploy/sql/00X_tablename.sql`
2. **Use idempotent pattern**:
   ```sql
   IF OBJECT_ID(N'dbo.TableName', N'U') IS NULL
   BEGIN
       CREATE TABLE dbo.TableName
       (
           Id INT IDENTITY(1,1) NOT NULL,
           Name NVARCHAR(100) NOT NULL,
           CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
           CONSTRAINT PK_TableName PRIMARY KEY CLUSTERED (Id)
       );
   END;
   GO
   ```
3. **Add indexes** for common query patterns
4. **Update init.sql** to call new migration
5. **Create C# model** in `src/Backend/Models/`
6. **Add Dapper queries** in service layer

## Query Best Practices

### DO

- Use parameterized queries (`@Parameter`)
- Use `QueryAsync<T>` for typed results
- Create indexes on columns used in WHERE/JOIN
- Use `TOP` to limit result sets
- Use `COUNT(*)` for existence checks

### DON'T

- Concatenate strings into SQL (injection risk)
- Use `SELECT *` in production (specify columns)
- Run queries in loops (N+1 problem)
- Store large blobs in database (use R2 for images)

## Environment Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `ConnectionStrings__PokemonConection` | Full connection string | `Server=sqlserver,...` |
| `FELIGALLERY_DB_PASSWORD` | App user password | `SecurePass123!` |
| `FELIGALLERY_MIGRATOR_PASSWORD` | Admin password for migrations | `AdminPass456!` |
| `SA_PASSWORD` | SQL Server SA password | `SaPass789!` |

## Known Issues

- **No foreign keys**: Relationships exist only in application code
- **N+1 query**: `GetPokemons()` makes one query per Pokémon for types
- **Incomplete type data**: Only 3 types seeded (RAYO, FUEGO, AGUA)
- **Spanish naming**: Table/column names in Spanish (convention, not issue)
