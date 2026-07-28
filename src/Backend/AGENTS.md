# Backend AGENTS.md — ASP.NET 8.0 Minimal API

## Overview

The backend is an ASP.NET 8.0 Minimal API using Dapper ORM for data access and JWT Bearer tokens for authentication. It serves as the REST API for the Angular frontend.

**Runtime**: .NET 8.0
**Port**: 5062 (dev), 8080 (container)
**Framework**: ASP.NET Core Minimal API (no controllers)

## Commands

```bash
cd src/Backend
dotnet restore                    # Install dependencies
dotnet run                        # Start dev server at http://localhost:5062
dotnet build                      # Build project
dotnet build --configuration Release  # Production build
```

## Project Structure

```
src/Backend/
├── Program.cs              # Entry point: DI, middleware, endpoint definitions
├── appsettings.json        # Base configuration
├── appsettings.Development.json  # Dev config (JWT keys, connection strings)
├── Backend.csproj          # Project file + NuGet dependencies
├── Dockerfile              # Multi-stage: SDK build → ASP.NET runtime
│
├── Models/                 # POCOs (Plain Old CLR Objects)
│   ├── PokeCard.cs         # Pokemon with nested types
│   ├── Login.cs            # Login request DTO
│   └── TokenResponse.cs    # JWT response DTO
│
└── Services/               # Business logic
    ├── PokemonService.cs   # GetPokemons() with type resolution
    └── LoginService.cs     # Login(), JWT generation
```

## Minimal API Conventions

### Defining Endpoints

All endpoints are defined in `Program.cs` using `app.MapGet()`, `app.MapPost()`, etc.

```csharp
// GET endpoint with authorization
app.MapGet("/pokemon", (PokemonService service) =>
{
    return service.GetPokemons();
})
.RequireAuthorization(policy => policy.RequireRole("Admin"));

// POST endpoint with request body
app.MapPost("/login", async (LoginService service, Login login) =>
{
    var result = await service.Login(login);
    if (result is null)
        return Results.BadRequest("Usuario o contraseña incorrectos");
    return Results.Ok(result);
});
```

### Response Patterns

- **Success**: `Results.Ok(data)` for 200, `Results.Created()` for 201
- **Error**: `Results.BadRequest("message")` for 400, `Results.NotFound()` for 404
- **Auth**: `Results.Unauthorized()` for 401, `Results.Forbid()` for 403

### Endpoint Naming

- Use kebab-case for URL segments: `/pokemon-by-type`, not `/pokemonByType`
- Group related endpoints: `/pokemon`, `/pokemon/{id}`, `/pokemon/{id}/fanarts`
- API versioning prefix: `/api/v1/...` (planned)

## Dependency Injection

### Service Registration Pattern

Services are registered as **Transient** in `Program.cs`:

```csharp
// In Program.cs
builder.Services.AddTransient<PokemonService>();
builder.Services.AddTransient<LoginService>();
```

### Database Connection

Single `SqlConnection` per request (Scoped lifetime):

```csharp
builder.Services.AddScoped<IDbConnection>(sp =>
{
    var configuration = sp.GetRequiredService<IConfiguration>();
    var connectionString = configuration.GetConnectionString("PokemonConection");
    return new SqlConnection(connectionString);
});
```

### Service Constructor Pattern

Services receive dependencies via constructor injection:

```csharp
public class PokemonService
{
    private IDbConnection _dbConnection;

    public PokemonService(IDbConnection db)
    {
        _dbConnection = db;
    }
}
```

## Dapper Data Access

### Basic Query

```csharp
// Simple SELECT
var sqlQuery = "SELECT * FROM Pokemon";
var pokemons = await _dbConnection.QueryAsync<PokeCard>(sqlQuery);
```

### Parameterized Query

```csharp
// Always use parameters to prevent SQL injection
var query = "SELECT TypeId FROM PokemonTypes WHERE PokedexNumber = @PokedexNumber";
var types = await _dbConnection.QueryAsync<int>(query, new { PokedexNumber = pokemonId });
```

### Single Row Query

```csharp
// Returns first row or default
var user = await _dbConnection.QueryFirstOrDefaultAsync<int>(
    "SELECT TOP 1 UserId FROM Users WHERE [User] = @User AND [Password] = @Password",
    new { User = login.User, Password = login.Password }
);
```

### Query Patterns

- **Always use parameterized queries** (`@Parameter` syntax)
- **Never concatenate strings** into SQL (injection risk)
- **Use `QueryAsync<T>`** for multiple rows
- **Use `QueryFirstOrDefaultAsync<T>`** for single rows
- **Use `ExecuteAsync`** for INSERT/UPDATE/DELETE

## Model Conventions

### Naming

- **Class names**: PascalCase (`PokeCard`, `TokenResponse`)
- **Property names**: PascalCase (`Nombre`, `PokedexNumber`)
- **Spanish names**: Match database column names exactly

### DTO Pattern

```csharp
namespace Backend.Models;

public class PokeCard
{
    public required string Nombre { get; set; }
    public required int PokedexNumber { get; set; }
    public string? Imagen { get; set; }           // Nullable for optional fields
    public required List<PokeType> Type { get; set; }  // Nested collection
}
```

### Required vs Optional

- `required` keyword for mandatory fields
- `?` suffix for nullable/optional fields

## Authentication & Authorization

### JWT Configuration

JWT is configured in `Program.cs` with these parameters:
- **Key**: Symmetric key from `Jwt:Key` config (64-char string)
- **Issuer**: `BackendPokemon`
- **Audience**: `AngularPokemon`
- **Expiration**: 1 hour
- **Algorithm**: HMAC-SHA256

### Protected Endpoints

```csharp
// Require authentication
.RequireAuthorization();

// Require specific role
.RequireAuthorization(policy => policy.RequireRole("Admin"));
```

### JWT Claims

Current claims in token:
- `ClaimTypes.Name` → Username
- `ClaimTypes.Role` → "Admin" (hardcoded — will be from DB)

See [`Services/AGENTS.md`](Services/AGENTS.md) for auth service patterns.

## Error Handling

### Current Pattern (Inline)

```csharp
app.MapPost("/login", async (LoginService service, Login login) =>
{
    var result = await service.Login(login);
    if (result is null)
        return Results.BadRequest("Usuario o contraseña incorrectos");
    return Results.Ok(result);
});
```

### Planned Pattern (ProblemDetails)

Will use RFC 7807 standard error responses:

```json
{
    "type": "https://tools.ietf.org/html/rfc9110#section-15.5.1",
    "title": "Not Found",
    "status": 404,
    "detail": "Fanart with id 42 not found"
}
```

## Configuration

### appsettings.json Structure

```json
{
    "ConnectionStrings": {
        "PokemonConection": "Server=...;Database=FeliGalleryDB;..."
    },
    "Jwt": {
        "Key": "...",
        "Issuer": "BackendPokemon",
        "Audience": "AngularPokemon"
    },
    "Cors": {
        "FrontendOrigin": "http://localhost:4200"
    }
}
```

### Environment Variables

Production secrets are injected via environment variables at deploy time (see `compose.yml`).

## CORS Configuration

Only the Angular frontend origin is allowed:

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AngularPolicy", policy =>
    {
        policy
            .WithOrigins(frontendOrigin)
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});
```

## Swagger / OpenAPI

Swagger UI is available at `/swagger` in all environments. JWT Bearer auth is registered as a security scheme for testing protected endpoints.

## Adding a New Endpoint

1. **Create model** in `Models/` if needed (request/response DTOs)
2. **Create service** in `Services/` for business logic
3. **Register service** in `Program.cs`: `builder.Services.AddTransient<NewService>()`
4. **Define endpoint** in `Program.cs`:
   ```csharp
   app.MapGet("/resource", (NewService service) =>
   {
       return service.GetData();
   })
   .RequireAuthorization();  // If auth needed
   ```

## NuGet Dependencies

| Package | Purpose |
|---------|---------|
| `Dapper` | Micro-ORM for SQL queries |
| `Microsoft.Data.SqlClient` | SQL Server driver |
| `Microsoft.AspNetCore.Authentication.JwtBearer` | JWT auth middleware |
| `Swashbuckle.AspNetCore` | Swagger/OpenAPI |
| `Microsoft.AspNetCore.OpenApi` | OpenAPI support |

## Known Issues

- **N+1 query** in `PokemonService.GetPokemons()`: One extra query per Pokémon for types (should be single JOIN)
- **Hardcoded role**: All users get "Admin" role regardless of DB role
- **No global error handling**: Errors return raw strings instead of ProblemDetails
- **Duplicate `UseHttpsRedirection()`**: Called twice in Program.cs
