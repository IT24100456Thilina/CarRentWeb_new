-- Migration script to add IDENTITY to vehicleId in existing Vehicles table
-- Run this in SQL Server after backing up your data

USE CarRentalDB;
GO

-- Step 1: Drop foreign key constraint (find the exact name if different)
-- Default name for FK from Bookings to Vehicles on vehicleId
DECLARE @fk_name NVARCHAR(255);
SELECT @fk_name = CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Bookings' AND CONSTRAINT_TYPE = 'FOREIGN KEY';

IF @fk_name IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Bookings DROP CONSTRAINT ' + @fk_name);
END

-- Step 2: Create new table with IDENTITY
CREATE TABLE Vehicles_New (
    vehicleId INT IDENTITY(1,1) PRIMARY KEY,
    vehicleName NVARCHAR(100) NOT NULL,
    vehicleType NVARCHAR(50) NOT NULL,
    dailyPrice DECIMAL(10,2) NOT NULL,
    available BIT NOT NULL DEFAULT 1,
    imageUrl NVARCHAR(255) NULL
);

-- Step 3: Copy data from old table
SET IDENTITY_INSERT Vehicles_New ON;
INSERT INTO Vehicles_New (vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl)
SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl
FROM Vehicles;
SET IDENTITY_INSERT Vehicles_New OFF;

-- Step 4: Drop old table
DROP TABLE Vehicles;

-- Step 5: Rename new table
EXEC sp_rename 'Vehicles_New', 'Vehicles';

-- Step 6: Recreate foreign key
ALTER TABLE Bookings ADD CONSTRAINT FK_Bookings_Vehicles FOREIGN KEY (vehicleId) REFERENCES Vehicles(vehicleId);

-- Verify
SELECT * FROM Vehicles;
GO