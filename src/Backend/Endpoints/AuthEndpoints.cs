using Backend.Models;
using Backend.Services;

namespace Backend.Endpoints;

public static class AuthEndpoints
{
    public static void MapAuthEndpoints(this WebApplication app)
    {
        var authGroup = app.MapGroup("/v1/auth")
            .WithTags("Authentication");

        authGroup.MapPost("/register", async (LoginService service, RegisterRequest request) =>
        {
            if (string.IsNullOrWhiteSpace(request.User) || string.IsNullOrWhiteSpace(request.Password))
            {
                return Results.BadRequest(new { error = "Username and password are required" });
            }

            if (string.IsNullOrWhiteSpace(request.Email))
            {
                return Results.BadRequest(new { error = "Email is required" });
            }

            if (request.Password.Length < 6)
            {
                return Results.BadRequest(new { error = "Password must be at least 6 characters" });
            }

            var success = await service.Register(request);

            if (!success)
            {
                return Results.Conflict(new { error = "Username already exists" });
            }

            return Results.Created("/api/v1/auth/me", new { message = "User registered successfully" });
        })
        .WithName("Register")
        .WithOpenApi();

        authGroup.MapPost("/login", async (LoginService service, Login login) =>
        {
            var result = await service.Login(login);

            if (result is null)
            {
                return Results.BadRequest(new { error = "Invalid username or password" });
            }

            return Results.Ok(result);
        })
        .WithName("Login")
        .WithOpenApi();

        authGroup.MapGet("/me", (HttpContext context) =>
        {
            var userId = context.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            var username = context.User.Identity?.Name;
            var role = context.User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value;

            return Results.Ok(new
            {
                userId,
                username,
                role
            });
        })
        .RequireAuthorization()
        .WithName("GetCurrentUser")
        .WithOpenApi();
    }
}
