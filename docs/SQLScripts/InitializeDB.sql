USE [FeliGalleryDB]
GO
/****** Objeto: Table [dbo].[Pokemon] Fecha de script: 28/07/2026 09:39:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pokemon]
(
    [PokedexNumber] [int] NOT NULL,
    [Nombre] [nvarchar](30) NULL,
    [Imagen] [nvarchar](200) NULL,
    CONSTRAINT [PK_Pokemon] PRIMARY KEY CLUSTERED 
(
	[PokedexNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[PokemonTypes] Fecha de script: 28/07/2026 09:39:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PokemonTypes]
(
    [PokedexNumber] [int] NOT NULL,
    [TypeId] [int] NOT NULL,
    CONSTRAINT [PK_PokemonTypes] PRIMARY KEY CLUSTERED 
(
	[PokedexNumber] ASC,
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Type] Fecha de script: 28/07/2026 09:39:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type]
(
    [TypeId] [int] NOT NULL,
    [Type] [nvarchar](200) NULL,
    [Color] [varchar](7) NULL,
    CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Users] Fecha de script: 28/07/2026 09:39:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users]
(
    [UserId] [int] IDENTITY(1,1) NOT NULL,
    [User] [nvarchar](50) NOT NULL,
    [Password] [nvarchar](250) NOT NULL,
    [Email] [nvarchar](255) NULL,
    [DisplayName] [nvarchar](100) NULL,
    [Bio] [nvarchar](500) NULL,
    [AvatarUrl] [nvarchar](500) NULL,
    [Role] [nvarchar](20) NOT NULL,
    [IsActive] [bit] NOT NULL,
    [CreatedAt] [datetime2](7) NOT NULL,
    [UpdatedAt] [datetime2](7) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (1, N'Bulbasaur', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (2, N'Ivysaur', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (3, N'Venusaur', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (4, N'Charmander', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (5, N'Charmeleon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (6, N'Charizard', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (7, N'Squirtle', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (8, N'Wartortle', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (9, N'Blastoise', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (10, N'Caterpie', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (11, N'Metapod', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/11.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (12, N'Butterfree', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/12.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (13, N'Weedle', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/13.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (14, N'Kakuna', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/14.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (15, N'Beedrill', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/15.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (16, N'Pidgey', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/16.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (17, N'Pidgeotto', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/17.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (18, N'Pidgeot', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/18.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (19, N'Rattata', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/19.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (20, N'Raticate', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/20.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (21, N'Spearow', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/21.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (22, N'Fearow', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/22.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (23, N'Ekans', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/23.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (24, N'Arbok', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/24.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (25, N'Pikachu', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (26, N'Raichu', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/26.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (27, N'Sandshrew', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/27.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (28, N'Sandslash', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/28.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (29, N'Nidoran?', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/29.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (30, N'Nidorina', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/30.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (31, N'Nidoqueen', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/31.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (32, N'Nidoran?', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/32.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (33, N'Nidorino', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/33.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (34, N'Nidoking', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/34.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (35, N'Clefairy', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/35.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (36, N'Clefable', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/36.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (37, N'Vulpix', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/37.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (38, N'Ninetales', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/38.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (39, N'Jigglypuff', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/39.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (40, N'Wigglytuff', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/40.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (41, N'Zubat', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/41.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (42, N'Golbat', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/42.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (43, N'Oddish', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/43.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (44, N'Gloom', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/44.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (45, N'Vileplume', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/45.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (46, N'Paras', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/46.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (47, N'Parasect', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/47.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (48, N'Venonat', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/48.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (49, N'Venomoth', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/49.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (50, N'Diglett', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/50.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (51, N'Dugtrio', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/51.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (52, N'Meowth', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/52.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (53, N'Persian', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/53.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (54, N'Psyduck', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/54.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (55, N'Golduck', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/55.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (56, N'Mankey', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/56.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (57, N'Primeape', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/57.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (58, N'Growlithe', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/58.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (59, N'Arcanine', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/59.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (60, N'Poliwag', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/60.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (61, N'Poliwhirl', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/61.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (62, N'Poliwrath', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/62.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (63, N'Abra', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/63.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (64, N'Kadabra', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/64.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (65, N'Alakazam', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/65.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (66, N'Machop', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/66.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (67, N'Machoke', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/67.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (68, N'Machamp', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/68.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (69, N'Bellsprout', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/69.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (70, N'Weepinbell', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/70.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (71, N'Victreebel', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/71.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (72, N'Tentacool', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/72.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (73, N'Tentacruel', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/73.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (74, N'Geodude', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/74.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (75, N'Graveler', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/75.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (76, N'Golem', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/76.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (77, N'Ponyta', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/77.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (78, N'Rapidash', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/78.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (79, N'Slowpoke', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/79.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (80, N'Slowbro', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/80.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (81, N'Magnemite', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/81.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (82, N'Magneton', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/82.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (83, N'Farfetch''d', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/83.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (84, N'Doduo', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/84.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (85, N'Dodrio', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/85.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (86, N'Seel', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/86.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (87, N'Dewgong', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/87.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (88, N'Grimer', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/88.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (89, N'Muk', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/89.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (90, N'Shellder', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/90.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (91, N'Cloyster', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/91.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (92, N'Gastly', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/92.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (93, N'Haunter', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/93.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (94, N'Gengar', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (95, N'Onix', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/95.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (96, N'Drowzee', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/96.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (97, N'Hypno', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/97.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (98, N'Krabby', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/98.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (99, N'Kingler', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/99.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (100, N'Voltorb', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/100.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (101, N'Electrode', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/101.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (102, N'Exeggcute', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/102.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (103, N'Exeggutor', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/103.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (104, N'Cubone', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/104.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (105, N'Marowak', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/105.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (106, N'Hitmonlee', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/106.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (107, N'Hitmonchan', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/107.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (108, N'Lickitung', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/108.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (109, N'Koffing', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/109.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (110, N'Weezing', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/110.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (111, N'Rhyhorn', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/111.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (112, N'Rhydon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/112.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (113, N'Chansey', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/113.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (114, N'Tangela', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/114.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (115, N'Kangaskhan', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/115.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (116, N'Horsea', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/116.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (117, N'Seadra', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/117.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (118, N'Goldeen', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/118.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (119, N'Seaking', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/119.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (120, N'Staryu', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/120.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (121, N'Starmie', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/121.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (122, N'Mr. Mime', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/122.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (123, N'Scyther', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/123.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (124, N'Jynx', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/124.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (125, N'Electabuzz', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/125.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (126, N'Magmar', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/126.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (127, N'Pinsir', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/127.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (128, N'Tauros', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/128.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (129, N'Magikarp', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/129.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (130, N'Gyarados', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/130.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (131, N'Lapras', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/131.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (132, N'Ditto', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (133, N'Eevee', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (134, N'Vaporeon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/134.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (135, N'Jolteon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/135.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (136, N'Flareon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/136.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (137, N'Porygon', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/137.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (138, N'Omanyte', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/138.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (139, N'Omastar', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/139.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (140, N'Kabuto', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/140.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (141, N'Kabutops', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/141.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (142, N'Aerodactyl', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/142.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (143, N'Snorlax', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/143.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (144, N'Articuno', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/144.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (145, N'Zapdos', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/145.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (146, N'Moltres', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/146.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (147, N'Dratini', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/147.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (148, N'Dragonair', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/148.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (149, N'Dragonite', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/149.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (150, N'Mewtwo', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/150.png')
GO
INSERT [dbo].[Pokemon]
    ([PokedexNumber], [Nombre], [Imagen])
VALUES
    (151, N'Mew', N'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png')
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (1, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (1, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (2, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (2, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (3, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (3, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (4, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (5, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (6, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (6, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (7, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (8, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (9, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (10, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (11, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (12, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (12, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (13, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (13, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (14, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (14, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (15, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (15, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (16, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (16, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (17, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (17, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (18, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (18, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (19, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (20, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (21, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (21, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (22, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (22, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (23, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (24, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (25, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (26, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (27, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (28, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (29, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (30, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (31, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (31, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (32, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (33, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (34, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (34, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (35, 18)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (36, 18)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (37, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (38, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (39, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (39, 18)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (40, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (40, 18)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (41, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (41, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (42, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (42, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (43, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (43, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (44, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (44, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (45, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (45, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (46, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (46, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (47, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (47, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (48, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (48, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (49, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (49, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (50, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (51, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (52, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (53, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (54, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (55, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (56, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (57, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (58, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (59, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (60, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (61, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (62, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (62, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (63, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (64, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (65, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (66, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (67, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (68, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (69, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (69, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (70, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (70, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (71, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (71, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (72, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (72, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (73, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (73, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (74, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (74, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (75, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (75, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (76, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (76, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (77, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (78, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (79, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (79, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (80, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (80, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (81, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (81, 17)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (82, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (82, 17)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (83, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (83, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (84, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (84, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (85, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (85, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (86, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (87, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (87, 6)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (88, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (89, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (90, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (91, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (91, 6)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (92, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (92, 14)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (93, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (93, 14)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (94, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (94, 14)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (95, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (95, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (96, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (97, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (98, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (99, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (100, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (101, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (102, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (102, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (103, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (103, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (104, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (105, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (106, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (107, 7)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (108, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (109, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (110, 8)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (111, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (111, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (112, 9)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (112, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (113, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (114, 5)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (115, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (116, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (117, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (118, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (119, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (120, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (121, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (121, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (122, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (122, 18)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (123, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (123, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (124, 6)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (124, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (125, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (126, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (127, 12)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (128, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (129, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (130, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (130, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (131, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (131, 6)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (132, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (133, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (134, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (135, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (136, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (137, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (138, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (138, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (139, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (139, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (140, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (140, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (141, 3)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (141, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (142, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (142, 13)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (143, 1)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (144, 6)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (144, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (145, 4)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (145, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (146, 2)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (146, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (147, 15)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (148, 15)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (149, 10)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (149, 15)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (150, 11)
GO
INSERT [dbo].[PokemonTypes]
    ([PokedexNumber], [TypeId])
VALUES
    (151, 11)
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (1, N'NORMAL', N'#A8A878')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (2, N'FIRE', N'#F08030')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (3, N'WATER', N'#6890F0')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (4, N'ELECTRIC', N'#F8D030')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (5, N'GRASS', N'#78C850')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (6, N'ICE', N'#98D8D8')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (7, N'FIGHTING', N'#C03028')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (8, N'POISON', N'#A040A0')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (9, N'GROUND', N'#E0C068')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (10, N'FLYING', N'#A890F0')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (11, N'PSYCHIC', N'#F85888')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (12, N'BUG', N'#A8B820')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (13, N'ROCK', N'#B8A038')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (14, N'GHOST', N'#705898')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (15, N'DRAGON', N'#7038F8')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (16, N'DARK', N'#705848')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (17, N'STEEL', N'#B8B8D0')
GO
INSERT [dbo].[Type]
    ([TypeId], [Type], [Color])
VALUES
    (18, N'FAIRY', N'#EE99AC')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users]
    ([UserId], [User], [Password], [Email], [DisplayName], [Bio], [AvatarUrl], [Role], [IsActive], [CreatedAt], [UpdatedAt])
VALUES
    (1, N'admin', N'$2a$11$G2LkEPSHWNExLe3i62bqROmhcmAEhF478Vhyk4n9BAE3UYzpXqjHS', NULL, N'admin', NULL, NULL, N'admin', 1, CAST(N'2026-07-28T14:04:38.9270473' AS DateTime2), CAST(N'2026-07-28T14:04:38.9555379' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('user') FOR [Role]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (sysutcdatetime()) FOR [UpdatedAt]
GO
