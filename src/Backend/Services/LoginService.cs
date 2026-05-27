using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Backend.Models;
using Microsoft.IdentityModel.Tokens;
using Dapper;
using System.Data;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

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
        if (await IsValidUser(login))
        {
            var tokenString = GetToken(login);
            // REGRESAR UN TOKEN SI EL USUARIO ES VALIDO
            TokenResponse token = new TokenResponse()
            {
                Token = tokenString,
                ExpirationDate = DateTime.UtcNow.AddHours(1)
            };
            return token;
        }
        else
        {
            // REGRESAR UN NULL SI EL USUARIO NO ES VALIDO Y NO SE GENERO NINGUN TOKEN
            return null;
        }
    }

    private async Task<bool> IsValidUser(Login login)
    {
        // if (login.User == "Admin" && login.Password == "Admin123")
        if (await ExistInDb(login))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    private async Task<bool> ExistInDb(Login login)
    {
        var sqlQuery = "SELECT TOP 1 UserId FROM Users WHERE [User] = @User AND [Password] = @Password";
        var userId = await _dbConnection.QueryFirstOrDefaultAsync<int>(
            sqlQuery,
            new
            {
                User = login.User,
                Password = login.Password
            }
        );
        return userId > 0;
    }

    private string GetToken(Login login)
    {
        var tokenString = string.Empty;
        // AQUI SE GENERA EL TOKEN DE ACCESO
        var claims = new[]
        {
            new Claim(ClaimTypes.Name, login.User),
            new Claim(ClaimTypes.Role, "Admin")
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

        tokenString = new JwtSecurityTokenHandler().WriteToken(token);

        // JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler(); // Crear instancia de una clase
        // var tokenResltado = tokenHandler.WriteToken(token);
        // tokenString = tokenResltado;

        return tokenString;
    }
}