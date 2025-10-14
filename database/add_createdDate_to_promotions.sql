-- Add createdDate column to Promotions table if it doesn't exist

USE CarRentalDB;
GO

-- Check if column exists, if not add it
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Promotions' AND COLUMN_NAME = 'createdDate')
BEGIN
    ALTER TABLE Promotions
    ADD createdDate DATETIME NOT NULL DEFAULT GETDATE();
END
GO

-- Update existing records to have current timestamp if they have NULL
UPDATE Promotions
SET createdDate = GETDATE()
WHERE createdDate IS NULL;
GO

-- Verify
SELECT * FROM Promotions;
GO