-- Migration script to add description column to Vehicles table
-- This fixes the bill loading error where the application tries to select vehicle description

USE CarRentalDB;
GO

-- Add description column to Vehicles table
ALTER TABLE Vehicles ADD description NVARCHAR(500) NULL;
GO

-- Update existing vehicles with default descriptions
UPDATE Vehicles SET description = 'A compact and efficient micro car, perfect for city driving and fuel savings.' WHERE vehicleName = 'micro';
UPDATE Vehicles SET description = 'A reliable sedan with excellent performance and modern features.' WHERE vehicleName = 'premio';
UPDATE Vehicles SET description = 'A stylish and compact hatchback with great fuel efficiency.' WHERE vehicleName = 'vitz';
UPDATE Vehicles SET description = 'An electric vehicle offering sustainable and eco-friendly transportation.' WHERE vehicleName = 'BYD';
UPDATE Vehicles SET description = 'A comfortable sedan with modern technology and smooth ride.' WHERE vehicleName = 'civic';
GO

-- Verify the changes
SELECT vehicleId, vehicleName, description FROM Vehicles;
GO