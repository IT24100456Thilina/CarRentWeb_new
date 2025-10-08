-- Alter Vehicles table to add registration number field
USE CarRentalDB;
GO

-- Add registration number column for fleet management
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Vehicles') AND name = 'registrationNumber')
BEGIN
    ALTER TABLE Vehicles ADD registrationNumber NVARCHAR(20) NULL;
END
GO

-- Update existing vehicles with default registration numbers
UPDATE Vehicles SET registrationNumber = 'ABC-' + CAST(vehicleId AS NVARCHAR(10)) + '-2024' WHERE registrationNumber IS NULL OR registrationNumber = '';
GO

-- Make registrationNumber NOT NULL after setting defaults
ALTER TABLE Vehicles ALTER COLUMN registrationNumber NVARCHAR(20) NOT NULL;
GO