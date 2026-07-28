-- Migration: Add new fields to Users table
-- Run this AFTER the initial schema is created

USE [FeliGalleryDB];
GO

-- Add Email column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'Email'
)
BEGIN
    ALTER TABLE dbo.Users ADD Email NVARCHAR(255) NULL;
END;
GO

-- Add DisplayName column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'DisplayName'
)
BEGIN
    ALTER TABLE dbo.Users ADD DisplayName NVARCHAR(100) NULL;
END;
GO

-- Add Bio column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'Bio'
)
BEGIN
    ALTER TABLE dbo.Users ADD Bio NVARCHAR(500) NULL;
END;
GO

-- Add AvatarUrl column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'AvatarUrl'
)
BEGIN
    ALTER TABLE dbo.Users ADD AvatarUrl NVARCHAR(500) NULL;
END;
GO

-- Add Role column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'Role'
)
BEGIN
    ALTER TABLE dbo.Users ADD Role NVARCHAR(20) NOT NULL DEFAULT 'user';
END;
GO

-- Add IsActive column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'IsActive'
)
BEGIN
    ALTER TABLE dbo.Users ADD IsActive BIT NOT NULL DEFAULT 1;
END;
GO

-- Add CreatedAt column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'CreatedAt'
)
BEGIN
    ALTER TABLE dbo.Users ADD CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME();
END;
GO

-- Add UpdatedAt column
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.Users')
    AND name = 'UpdatedAt'
)
BEGIN
    ALTER TABLE dbo.Users ADD UpdatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME();
END;
GO

-- NOTE: Existing plaintext passwords will be migrated to BCrypt on first login.
-- The application code handles this automatically by detecting non-BCrypt passwords,
-- verifying them as plaintext, then re-hashing with BCrypt.
GO

-- Update admin user role
UPDATE dbo.Users
SET Role = 'admin',
    DisplayName = [User],
    UpdatedAt = SYSUTCDATETIME()
WHERE [User] = N'admin';
GO
