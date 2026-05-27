using System.Data;
using Backend.Models;
using Dapper;

namespace Backend.Services;

public class PokemonService
{
    private IDbConnection _dbConnection;
    public PokemonService(IDbConnection db)
    {
        _dbConnection = db;
    }

    public async Task<List<PokeCard>> GetPokemons()
    {
        List<PokeCard> pokemons;
        pokemons = [];

        var sqlQuery = "SELECT * FROM Pokemon";
        var pokeDB = await _dbConnection.QueryAsync<PokeCard>(sqlQuery);
        pokemons = pokeDB.ToList();
        // PokeCard bulbasaur = new PokeCard()
        // {
        //     Nombre = "Bulbasaur",
        //     PokedexNumber = 1,
        //     Imagen = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
        //     Type =
        //         [
        //         new PokeType { Type = "Grass", Color = "#9bcc50" },
        //         new PokeType { Type = "Poison", Color = "#b97fc9" }
        //         ]
        // };
        // pokemons.Add(bulbasaur);

        return pokemons;
    }
}