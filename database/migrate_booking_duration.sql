-- Add duration fields to Bookings table
ALTER TABLE Bookings ADD durationType NVARCHAR(10) NULL DEFAULT 'day';
ALTER TABLE Bookings ADD durationValue INT NULL DEFAULT 1;
GO

-- Update existing bookings to have duration based on their start and end dates
UPDATE Bookings SET
    durationType = 'day',
    durationValue = DATEDIFF(day, startDate, endDate) + 1;
GO

-- Make the columns NOT NULL after populating existing data
ALTER TABLE Bookings ALTER COLUMN durationType NVARCHAR(10) NOT NULL;
ALTER TABLE Bookings ALTER COLUMN durationValue INT NOT NULL;
GO