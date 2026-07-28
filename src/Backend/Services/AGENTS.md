# Auth & Services AGENTS.md

## Overview

The backend uses JWT Bearer tokens for authentication. The `LoginService` handles user validation and token generation. Currently, passwords are stored in plain text (BCrypt migration planned).

## Service Pattern

### Registration

Services are registered as **Transient** in `Program.cs`:

```csharp
builder.Services.AddTransient<PokemonService>();
builder.Services.AddTransient<LoginService>();
```

**Transient**: New instance created each time it's requested. Good for stateless services.

### Constructor Injection

Services receive dependencies via constructor:

```csharp
public class LoginService
{
    private IDbConnection _dbConnection;
    private IConfiguration _config;

    public LoginService(IConfiguration config, IDbConnection db)
    {
        _config = config;
        _dbConnection = db;
    }
}
```

### Available Dependencies

- `IDbConnection` → Scoped `SqlConnection` (one per request)
- `IConfiguration` → App settings (JWT keys, connection strings)

## LoginService

### Current Implementation

**File**: `src/Backend/Services/LoginService.cs`

```csharp
public class LoginService
{
    public async Task<TokenResponse?> Login(Login login)
    {
        if (await IsValidUser(login))
        {
            var tokenString = GetToken(login);
            return new TokenResponse()
            {
                Token = tokenString,
                ExpirationDate = DateTime.UtcNow.AddHours(1)
            };
        }
        return null;
    }
}
```

### Login Flow

1. **Validate credentials**: Check if user/password exists in DB
2. **Generate JWT**: Create token with user claims
3. **Return response**: Token string + expiration date

### User Validation (Current — INSECURE)

```csharp
private async Task<bool> ExistInDb(Login login)
{
    var sqlQuery = "SELECT TOP 1 UserId FROM Users WHERE [User] = @User AND [Password] = @Password";
    var userId = await _dbConnection.QueryFirstOrDefaultAsync<int>(
        sqlQuery,
        new { User = login.User, Password = login.Password }
    );
    return userId > 0;
}
```

**Problem**: Compares plain text passwords. Will be replaced with BCrypt.

### JWT Token Generation

```csharp
private string GetToken(Login login)
{
    var claims = new[]
    {
        new Claim(ClaimTypes.Name, login.User),
        new Claim(ClaimTypes.Role, "Admin")  // Hardcoded — will be from DB
    };

    var jwtKey = _config["Jwt:Key"];
    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey!));
    var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

    var token = new JwtSecurityToken(
        issuer: _config["Jwt:Issuer"],
        audience: _config["Jwt:Audience"],
        claims: claims,
        expires: DateTime.Now.AddHours(1),
        signingCredentials: credentials
    );

    return new JwtSecurityTokenHandler().WriteToken(token);
}
```

### JWT Configuration

**Source**: `appsettings.Development.json`

```json
{
    "Jwt": {
        "Key": "YourSuperSecretKeyThatIsAtLeast32CharactersLongForSecurity!",
        "Issuer": "BackendPokemon",
        "Audience": "AngularPokemon"
    }
}
```

**Validation rules** (configured in `Program.cs`):
- Validate issuer: Yes
- Validate audience: Yes
- Validate signing key: Yes
- Validate lifetime: Yes (1-hour expiry)

## Auth Flow (Frontend → Backend)

### Login Flow

```
┌──────────────┐         ┌──────────────┐         ┌──────────────┐
│   Angular    │  POST   │   Backend    │  Query  │  SQL Server  │
│   Login      │────────▶│   /login     │────────▶│  Users       │
│   Page       │         │              │         │              │
└──────────────┘         └──────────────┘         └──────────────┘
      │                        │
      │    TokenResponse       │
      │◀───────────────────────│
      │                        │
      │  Store in localStorage │
      │  token + expiration    │
```

### Authenticated Request Flow

```
┌──────────────┐         ┌──────────────┐         ┌──────────────┐
│   Angular    │  GET    │   Nginx      │  Proxy  │  Backend     │
│   Gallery    │────────▶│              │────────▶│  /pokemon    │
│              │         │              │         │              │
└──────────────┘         └──────────────┘         └──────────────┘
      │                                               │
      │  authInterceptor adds                         │
      │  Authorization: Bearer {token}                │
      │                                               │
      │                    JWT Validation              │
      │◀──────────────────────────────────────────────│
```

## Frontend Auth Components

### Auth Guard

**File**: `src/Frontend/src/app/guards/auth-guard.ts`

```typescript
export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);
  const token = localStorage.getItem("token");
  if (token) {
    return true;
  }
  return router.createUrlTree(['/login']);
};
```

**Current issue**: Only checks if token exists, doesn't verify expiration.

### Auth Interceptor

**File**: `src/Frontend/src/app/interceptors/auth-interceptor.ts`

```typescript
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem("token");
  if (!token) {
    return next(req);
  }
  const authReq = req.clone({
    setHeaders: {
      Authorization: `Bearer ${token}`
    }
  });
  return next(authReq);
};
```

### Login Service (Frontend)

**File**: `src/Frontend/src/app/shared/login.service.ts`

```typescript
@Injectable({ providedIn: 'root' })
export class LoginService {
  private apiUrl = "/api/login";
  constructor(private http: HttpClient) { }

  login(login: any) {
    return this.http.post<any>(this.apiUrl, login, {
      observe: 'response'
    });
  }
}
```

### Storage

Tokens stored in `localStorage`:
- `token`: JWT string
- `expirationDate`: ISO date string

## Planned Improvements

### BCrypt Password Hashing

**Package**: `BCrypt.Net-Next`

```csharp
// Hash password (registration)
string hashedPassword = BCrypt.Net.BCrypt.HashPassword(plainPassword);

// Verify password (login)
bool isValid = BCrypt.Net.BCrypt.Verify(plainPassword, hashedPassword);
```

### Migration Strategy

1. Add `PasswordHash` column to `Users`
2. Script to hash existing passwords
3. Login: try BCrypt first, fallback to plain text + auto-migrate
4. After X days, drop old `Password` column

### Real Roles from Database

```sql
ALTER TABLE Users ADD Role NVARCHAR(20) NOT NULL DEFAULT 'user';
```

```csharp
// In GetToken()
var userRole = await GetUserRole(login.User);
var claims = new[]
{
    new Claim(ClaimTypes.Name, login.User),
    new Claim(ClaimTypes.Role, userRole)  // From DB, not hardcoded
};
```

### Refresh Tokens

```sql
CREATE TABLE RefreshTokens (
    TokenId INT IDENTITY PRIMARY KEY,
    UserId INT REFERENCES Users(UserId),
    Token NVARCHAR(500) UNIQUE,
    ExpiresAt DATETIME2,
    RevokedAt DATETIME2 NULL
);
```

## Adding a New Service

1. **Create file**: `src/Backend/Services/NewService.cs`
2. **Add namespace**: `namespace Backend.Services;`
3. **Inject dependencies**:
   ```csharp
   public class NewService
   {
       private IDbConnection _dbConnection;
       public NewService(IDbConnection db) { _dbConnection = db; }
   }
   ```
4. **Register in Program.cs**:
   ```csharp
   builder.Services.AddTransient<NewService>();
   ```
5. **Use in endpoint**:
   ```csharp
   app.MapGet("/resource", (NewService service) =>
   {
       return service.GetData();
   });
   ```

## Security Considerations

### Current (Needs Improvement)

- ❌ Plain text passwords in database
- ❌ Hardcoded "Admin" role for all users
- ❌ No rate limiting on login endpoint
- ❌ JWT key in development config file

### Planned

- ✅ BCrypt password hashing
- ✅ Roles from database
- ✅ Rate limiting (10 attempts/minute per IP)
- ✅ JWT key from environment variable only
- ✅ Refresh tokens for session management
- ✅ Token expiration check on frontend

## Endpoint Security

### Public Endpoints (No Auth)

```csharp
app.MapPost("/login", ...);      // Login
app.MapPost("/register", ...);   // Registration
app.MapGet("/pokemon", ...);     // Public Pokémon list
```

### Protected Endpoints (Auth Required)

```csharp
app.MapPost("/fanarts", ...)     // Upload fanart
    .RequireAuthorization();
```

### Admin Endpoints (Role Required)

```csharp
app.MapPost("/admin/fanarts/{id}/approve", ...)
    .RequireAuthorization(policy => policy.RequireRole("Admin"));
```
