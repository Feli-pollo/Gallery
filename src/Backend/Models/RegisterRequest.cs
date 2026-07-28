namespace Backend.Models;

public class RegisterRequest
{
    public required string User { get; set; }
    public required string Password { get; set; }
    public required string Email { get; set; }
    public string? DisplayName { get; set; }
}
