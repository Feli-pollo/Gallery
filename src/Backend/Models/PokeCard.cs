namespace Backend.Models;

public class PokeCard
{
    public required string Nombre { get; set; }
    public required int PokedexNumber { get; set; }
    public string? Imagen { get; set; }
    public required List<PokeType> Type { get; set; }
}

public class PokeType
{
    public required int PokeTypeId { get; set; }
    public required string Type { get; set; }
    public required string Color { get; set; }
}