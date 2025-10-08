-- Migration to add new fields to Promotions table
-- Add discountCode, discountType, discountValue, and type columns

USE CarRentalDB;
GO

-- Add new columns to Promotions table
ALTER TABLE Promotions
ADD discountCode NVARCHAR(50) NULL,
    discountType NVARCHAR(20) NOT NULL DEFAULT 'percentage',
    discountValue DECIMAL(10,2) NULL,
    [type] NVARCHAR(20) NOT NULL DEFAULT 'general';

GO

-- Update existing records to have default values
UPDATE Promotions
SET discountType = 'percentage',
    [type] = 'general'
WHERE discountType IS NULL OR [type] IS NULL;

GO

-- Add unique constraint on discountCode (excluding NULL values)
CREATE UNIQUE NONCLUSTERED INDEX UQ_Promotions_DiscountCode
ON Promotions(discountCode)
WHERE discountCode IS NOT NULL;

GO

-- Verify the changes
SELECT * FROM Promotions;

GO