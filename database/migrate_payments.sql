-- Migration script to add paymentDate column to Payments table
-- Run this in SQL Server Management Studio if the column is missing

USE CarRentalDB;
GO

-- Check if paymentDate column exists, if not add it
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'paymentDate')
BEGIN
    ALTER TABLE Payments ADD paymentDate DATETIME NOT NULL DEFAULT GETDATE();
END
GO

-- Update existing records to have current timestamp if paymentDate is NULL
UPDATE Payments SET paymentDate = GETDATE() WHERE paymentDate IS NULL;
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