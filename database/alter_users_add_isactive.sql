-- Add isActive column to Users table
USE CarRentalDB;
GO

ALTER TABLE Users ADD isActive BIT NOT NULL DEFAULT 1;
GO

-- Update existing users to be active
UPDATE Users SET isActive = 1 WHERE isActive IS NULL;
GO

SELECT 'Users table updated with isActive column' as Status;