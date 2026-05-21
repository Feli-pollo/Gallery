CREATE TABLE [dbo].[PokemonTypes] (
    [PokedexNumber] INT NOT NULL,
    [TypeId]        INT NOT NULL,
    CONSTRAINT [PK_PokemonTypes] PRIMARY KEY CLUSTERED ([PokedexNumber] ASC, [TypeId] ASC)
);


GO

