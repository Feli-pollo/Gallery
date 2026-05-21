CREATE TABLE [dbo].[Pokemon] (
    [PokedexNumber] INT            NOT NULL,
    [Nombre]        NVARCHAR (30)  NULL,
    [Imagen]        NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([PokedexNumber] ASC)
);


GO

