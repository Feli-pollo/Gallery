namespace Backend.Models;

public class TokenResponse
{
    public required string Token { get; set; }
    public required DateTime ExpirationDate { get; set; }
}