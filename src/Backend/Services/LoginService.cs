using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Backend.Models;
using Microsoft.IdentityModel.Tokens;
using Dapper;
using System.Data;

namespace Backend.Services;

public class LoginService
{
    private IDbConnection _dbConnection;
    private IConfiguration _config;

    public LoginService(IConfiguration config, IDbConnection db)
    {
        _config = config;
        _dbConnection = db;
    }

    public async Task<TokenResponse?> Login(Login login)
    {
        var user = await GetUserFromDb(login.User);

        if (user is null)
        {
            return null;
        }

        bool isValidPassword = false;

        // Check if password is already BCrypt hashed
        if (user.PasswordHash.StartsWith("$2a$") || user.PasswordHash.StartsWith("$2b$"))
        {
            isValidPassword = BCrypt.Net.BCrypt.Verify(login.Password, user.PasswordHash);
        }
        else
        {
            // Legacy plaintext password - verify and migrate to BCrypt
            if (user.PasswordHash == login.Password)
            {
                isValidPassword = true;
                // Migrate to BCrypt
                await MigratePasswordToBCrypt(user.UserId, login.Password);
            }
        }

        if (!isValidPassword)
        {
            return null;
        }

        var tokenString = GetToken(user);

        return new TokenResponse()
        {
            Token = tokenString,
            ExpirationDate = DateTime.UtcNow.AddHours(1)
        };
    }

    private async Task MigratePasswordToBCrypt(int userId, string plainPassword)
    {
        var hashedPassword = BCrypt.Net.BCrypt.HashPassword(plainPassword);
        var sql = "UPDATE Users SET [Password] = @PasswordHash WHERE UserId = @UserId";
        await _dbConnection.ExecuteAsync(sql, new { PasswordHash = hashedPassword, UserId = userId });
    }

    public async Task<bool> Register(RegisterRequest request)
    {
        var existingUser = await GetUserFromDb(request.User);
        if (existingUser is not null)
        {
            return false;
        }

        var passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);

        var sql = @"INSERT INTO Users ([User], [Password], Email, DisplayName, Role)
                    VALUES (@User, @PasswordHash, @Email, @DisplayName, 'user')";

        var rowsAffected = await _dbConnection.ExecuteAsync(sql, new
        {
            User = request.User,
            PasswordHash = passwordHash,
            Email = request.Email,
            DisplayName = request.DisplayName ?? request.User
        });

        return rowsAffected > 0;
    }

    public static string HashPassword(string password)
    {
        return BCrypt.Net.BCrypt.HashPassword(password);
    }

    private async Task<UserData?> GetUserFromDb(string username)
    {
        var sql = @"SELECT TOP 1 UserId, [User], [Password] AS PasswordHash, Email, DisplayName, Role
                    FROM Users
                    WHERE [User] = @User";

        return await _dbConnection.QueryFirstOrDefaultAsync<UserData>(sql, new { User = username });
    }

    private string GetToken(UserData user)
    {
        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),
            new Claim(ClaimTypes.Name, user.User),
            new Claim(ClaimTypes.Role, user.Role ?? "user")
        };

        var jwtKey = _config["Jwt:Key"];
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey!));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: _config["Jwt:Issuer"],
            audience: _config["Jwt:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

public class UserData
{
    public int UserId { get; set; }
    public required string User { get; set; }
    public required string PasswordHash { get; set; }
    public string? Email { get; set; }
    public string? DisplayName { get; set; }
    public string? Role { get; set; }
}
