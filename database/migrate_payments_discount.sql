-- Migration to add discount-related columns to Payments table
-- Add discountCode and originalAmount columns

USE CarRentalDB;
GO

-- Add discountCode column
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'discountCode')
BEGIN
    ALTER TABLE Payments ADD discountCode NVARCHAR(50) NULL;
END
GO

-- Add originalAmount column
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'originalAmount')
BEGIN
    ALTER TABLE Payments ADD originalAmount DECIMAL(10,2) NULL;
END
GO

-- Update existing records to set originalAmount = amount where it's NULL
UPDATE Payments SET originalAmount = amount WHERE originalAmount IS NULL;
GO

-- Verify the table structure
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Payments'
ORDER BY ORDINAL_POSITION;
GO

-- Verify data
SELECT TOP 5 * FROM Payments;
GO