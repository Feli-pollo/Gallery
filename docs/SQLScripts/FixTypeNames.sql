-- Fix type names to be all in English
USE [FeliGalleryDB];
GO

-- Update Spanish type names to English
UPDATE dbo.[Type] SET [Type] = 'FIRE' WHERE [Type] = 'FUEGO';
UPDATE dbo.[Type] SET [Type] = 'WATER' WHERE [Type] = 'AGUA';
UPDATE dbo.[Type] SET [Type] = 'ELECTRIC' WHERE [Type] = 'RAYO';
UPDATE dbo.[Type] SET [Type] = 'GRASS' WHERE [Type] = 'PLANTA';
UPDATE dbo.[Type] SET [Type] = 'ICE' WHERE [Type] = 'HIELO';
UPDATE dbo.[Type] SET [Type] = 'FIGHTING' WHERE [Type] = 'LUCHA';
UPDATE dbo.[Type] SET [Type] = 'POISON' WHERE [Type] = 'VENENO';
UPDATE dbo.[Type] SET [Type] = 'GROUND' WHERE [Type] = 'TIERRA';
UPDATE dbo.[Type] SET [Type] = 'FLYING' WHERE [Type] = 'VOLADOR';
UPDATE dbo.[Type] SET [Type] = 'PSYCHIC' WHERE [Type] = 'PSIQUICO';
UPDATE dbo.[Type] SET [Type] = 'BUG' WHERE [Type] = 'BICHO';
UPDATE dbo.[Type] SET [Type] = 'ROCK' WHERE [Type] = 'ROCA';
UPDATE dbo.[Type] SET [Type] = 'GHOST' WHERE [Type] = 'FANTASMA';
UPDATE dbo.[Type] SET [Type] = 'DRAGON' WHERE [Type] = 'DRAGON';
UPDATE dbo.[Type] SET [Type] = 'DARK' WHERE [Type] = 'SINIESTRO';
UPDATE dbo.[Type] SET [Type] = 'STEEL' WHERE [Type] = 'ACERO';
UPDATE dbo.[Type] SET [Type] = 'FAIRY' WHERE [Type] = 'HADA';
GO

PRINT 'Types updated to English successfully!';
GO
