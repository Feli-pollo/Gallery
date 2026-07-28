-- Seed all Pokémon types with their colors
USE [FeliGalleryDB];
GO

-- Insert all Pokémon types
MERGE dbo.[Type] AS target
USING (
    VALUES
    (1, N'NORMAL', '#A8A878'),
    (2, N'FUEGO', '#F08030'),
    (3, N'AGUA', '#6890F0'),
    (4, N'ELECTRIC', '#F8D030'),
    (5, N'GRASS', '#78C850'),
    (6, N'ICE', '#98D8D8'),
    (7, N'FIGHTING', '#C03028'),
    (8, N'POISON', '#A040A0'),
    (9, N'GROUND', '#E0C068'),
    (10, N'FLYING', '#A890F0'),
    (11, N'PSYCHIC', '#F85888'),
    (12, N'BUG', '#A8B820'),
    (13, N'ROCK', '#B8A038'),
    (14, N'GHOST', '#705898'),
    (15, N'DRAGON', '#7038F8'),
    (16, N'DARK', '#705848'),
    (17, N'STEEL', '#B8B8D0'),
    (18, N'FAIRY', '#EE99AC')
) AS source (TypeId, [Type], Color)
ON target.TypeId = source.TypeId
WHEN MATCHED THEN
    UPDATE SET [Type] = source.[Type], Color = source.Color
WHEN NOT MATCHED THEN
    INSERT (TypeId, [Type], Color)
    VALUES (source.TypeId, source.[Type], source.Color);
GO

-- Clear existing type assignments
DELETE FROM dbo.PokemonTypes;
GO

-- Assign types to all 151 Gen I Pokémon
-- Format: (PokedexNumber, TypeId)
INSERT INTO dbo.PokemonTypes (PokedexNumber, TypeId) VALUES
-- Bulbasaur: Grass/Poison
(1, 5), (1, 8),
-- Ivysaur: Grass/Poison
(2, 5), (2, 8),
-- Venusaur: Grass/Poison
(3, 5), (3, 8),
-- Charmander: Fire
(4, 2),
-- Charmeleon: Fire
(5, 2),
-- Charizard: Fire/Flying
(6, 2), (6, 10),
-- Squirtle: Water
(7, 3),
-- Wartortle: Water
(8, 3),
-- Blastoise: Water
(9, 3),
-- Caterpie: Bug
(10, 12),
-- Metapod: Bug
(11, 12),
-- Butterfree: Bug/Flying
(12, 12), (12, 10),
-- Weedle: Bug/Poison
(13, 12), (13, 8),
-- Kakuna: Bug/Poison
(14, 12), (14, 8),
-- Beedrill: Bug/Poison
(15, 12), (15, 8),
-- Pidgey: Normal/Flying
(16, 1), (16, 10),
-- Pidgeotto: Normal/Flying
(17, 1), (17, 10),
-- Pidgeot: Normal/Flying
(18, 1), (18, 10),
-- Rattata: Normal
(19, 1),
-- Raticate: Normal
(20, 1),
-- Spearow: Normal/Flying
(21, 1), (21, 10),
-- Fearow: Normal/Flying
(22, 1), (22, 10),
-- Ekans: Poison
(23, 8),
-- Arbok: Poison
(24, 8),
-- Pikachu: Electric
(25, 4),
-- Raichu: Electric
(26, 4),
-- Sandshrew: Ground
(27, 9),
-- Sandslash: Ground
(28, 9),
-- Nidoran♀: Poison
(29, 8),
-- Nidorina: Poison
(30, 8),
-- Nidoqueen: Poison/Ground
(31, 8), (31, 9),
-- Nidoran♂: Poison
(32, 8),
-- Nidorino: Poison
(33, 8),
-- Nidoking: Poison/Ground
(34, 8), (34, 9),
-- Clefairy: Fairy
(35, 18),
-- Clefable: Fairy
(36, 18),
-- Vulpix: Fire
(37, 2),
-- Ninetales: Fire
(38, 2),
-- Jigglypuff: Normal/Fairy
(39, 1), (39, 18),
-- Wigglytuff: Normal/Fairy
(40, 1), (40, 18),
-- Zubat: Poison/Flying
(41, 8), (41, 10),
-- Golbat: Poison/Flying
(42, 8), (42, 10),
-- Oddish: Grass/Poison
(43, 5), (43, 8),
-- Gloom: Grass/Poison
(44, 5), (44, 8),
-- Vileplume: Grass/Poison
(45, 5), (45, 8),
-- Paras: Bug/Grass
(46, 12), (46, 5),
-- Parasect: Bug/Grass
(47, 12), (47, 5),
-- Venonat: Bug/Poison
(48, 12), (48, 8),
-- Venomoth: Bug/Poison
(49, 12), (49, 8),
-- Diglett: Ground
(50, 9),
-- Dugtrio: Ground
(51, 9),
-- Meowth: Normal
(52, 1),
-- Persian: Normal
(53, 1),
-- Psyduck: Water
(54, 3),
-- Golduck: Water
(55, 3),
-- Mankey: Fighting
(56, 7),
-- Primeape: Fighting
(57, 7),
-- Growlithe: Fire
(58, 2),
-- Arcanine: Fire
(59, 2),
-- Poliwag: Water
(60, 3),
-- Poliwhirl: Water
(61, 3),
-- Poliwrath: Water/Fighting
(62, 3), (62, 7),
-- Abra: Psychic
(63, 11),
-- Kadabra: Psychic
(64, 11),
-- Alakazam: Psychic
(65, 11),
-- Machop: Fighting
(66, 7),
-- Machoke: Fighting
(67, 7),
-- Machamp: Fighting
(68, 7),
-- Bellsprout: Grass/Poison
(69, 5), (69, 8),
-- Weepinbell: Grass/Poison
(70, 5), (70, 8),
-- Victreebel: Grass/Poison
(71, 5), (71, 8),
-- Tentacool: Water/Poison
(72, 3), (72, 8),
-- Tentacruel: Water/Poison
(73, 3), (73, 8),
-- Geodude: Rock/Ground
(74, 13), (74, 9),
-- Graveler: Rock/Ground
(75, 13), (75, 9),
-- Golem: Rock/Ground
(76, 13), (76, 9),
-- Ponyta: Fire
(77, 2),
-- Rapidash: Fire
(78, 2),
-- Slowpoke: Water/Psychic
(79, 3), (79, 11),
-- Slowbro: Water/Psychic
(80, 3), (80, 11),
-- Magnemite: Electric/Steel
(81, 4), (81, 17),
-- Magneton: Electric/Steel
(82, 4), (82, 17),
-- Farfetch'd: Normal/Flying
(83, 1), (83, 10),
-- Doduo: Normal/Flying
(84, 1), (84, 10),
-- Dodrio: Normal/Flying
(85, 1), (85, 10),
-- Seel: Water
(86, 3),
-- Dewgong: Water/Ice
(87, 3), (87, 6),
-- Grimer: Poison
(88, 8),
-- Muk: Poison
(89, 8),
-- Shellder: Water
(90, 3),
-- Cloyster: Water/Ice
(91, 3), (91, 6),
-- Gastly: Ghost/Poison
(92, 14), (92, 8),
-- Haunter: Ghost/Poison
(93, 14), (93, 8),
-- Gengar: Ghost/Poison
(94, 14), (94, 8),
-- Onix: Rock/Ground
(95, 13), (95, 9),
-- Drowzee: Psychic
(96, 11),
-- Hypno: Psychic
(97, 11),
-- Krabby: Water
(98, 3),
-- Kingler: Water
(99, 3),
-- Voltorb: Electric
(100, 4),
-- Electrode: Electric
(101, 4),
-- Exeggcute: Grass/Psychic
(102, 5), (102, 11),
-- Exeggutor: Grass/Psychic
(103, 5), (103, 11),
-- Cubone: Ground
(104, 9),
-- Marowak: Ground
(105, 9),
-- Hitmonlee: Fighting
(106, 7),
-- Hitmonchan: Fighting
(107, 7),
-- Lickitung: Normal
(108, 1),
-- Koffing: Poison
(109, 8),
-- Weezing: Poison
(110, 8),
-- Rhyhorn: Ground/Rock
(111, 9), (111, 13),
-- Rhydon: Ground/Rock
(112, 9), (112, 13),
-- Chansey: Normal
(113, 1),
-- Tangela: Grass
(114, 5),
-- Kangaskhan: Normal
(115, 1),
-- Horsea: Water
(116, 3),
-- Seadra: Water
(117, 3),
-- Goldeen: Water
(118, 3),
-- Seaking: Water
(119, 3),
-- Staryu: Water
(120, 3),
-- Starmie: Water/Psychic
(121, 3), (121, 11),
-- Mr. Mime: Psychic/Fairy
(122, 11), (122, 18),
-- Scyther: Bug/Flying
(123, 12), (123, 10),
-- Jynx: Ice/Psychic
(124, 6), (124, 11),
-- Electabuzz: Electric
(125, 4),
-- Magmar: Fire
(126, 2),
-- Pinsir: Bug
(127, 12),
-- Tauros: Normal
(128, 1),
-- Magikarp: Water
(129, 3),
-- Gyarados: Water/Flying
(130, 3), (130, 10),
-- Lapras: Water/Ice
(131, 3), (131, 6),
-- Ditto: Normal
(132, 1),
-- Eevee: Normal
(133, 1),
-- Vaporeon: Water
(134, 3),
-- Jolteon: Electric
(135, 4),
-- Flareon: Fire
(136, 2),
-- Porygon: Normal
(137, 1),
-- Omanyte: Rock/Water
(138, 13), (138, 3),
-- Omastar: Rock/Water
(139, 13), (139, 3),
-- Kabuto: Rock/Water
(140, 13), (140, 3),
-- Kabutops: Rock/Water
(141, 13), (141, 3),
-- Aerodactyl: Rock/Flying
(142, 13), (142, 10),
-- Snorlax: Normal
(143, 1),
-- Articuno: Ice/Flying
(144, 6), (144, 10),
-- Zapdos: Electric/Flying
(145, 4), (145, 10),
-- Moltres: Fire/Flying
(146, 2), (146, 10),
-- Dratini: Dragon
(147, 15),
-- Dragonair: Dragon
(148, 15),
-- Dragonite: Dragon/Flying
(149, 15), (149, 10),
-- Mewtwo: Psychic
(150, 11),
-- Mew: Psychic
(151, 11);
GO

PRINT 'Types and assignments seeded successfully!';
GO
