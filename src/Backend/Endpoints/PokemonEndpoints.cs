using Backend.Services;

namespace Backend.Endpoints;

public static class PokemonEndpoints
{
    public static void MapPokemonEndpoints(this WebApplication app)
    {
        var pokemonGroup = app.MapGroup("/v1/pokemon")
            .WithTags("Pokemon");

        pokemonGroup.MapGet("/", async (PokemonService service) =>
        {
            return await service.GetPokemons();
        })
        .WithName("GetAllPokemon")
        .WithOpenApi();

        pokemonGroup.MapGet("/by-type/{type}", async (PokemonService service, string type) =>
        {
            return await service.GetPokemons();
        })
        .WithName("GetPokemonByType")
        .WithOpenApi();
    }
}
