-- Simple script to recreate Vehicles table with IDENTITY
-- Run these commands in SQL Server Management Studio
-- WARNING: This will drop existing data in Vehicles table

USE CarRentalDB;
GO

-- Drop foreign key if exists
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__Bookings__vehicleId__...' OR referenced_object_id = OBJECT_ID('Vehicles'))
BEGIN
    ALTER TABLE Bookings DROP CONSTRAINT FK__Bookings__vehicleId__...;
END
GO

-- Drop table
DROP TABLE Vehicles;
GO

-- Recreate with IDENTITY
CREATE TABLE Vehicles (
    vehicleId INT IDENTITY(1,1) PRIMARY KEY,
    vehicleName NVARCHAR(100) NOT NULL,
    vehicleType NVARCHAR(50) NOT NULL,
    dailyPrice DECIMAL(10,2) NOT NULL,
    available BIT NOT NULL DEFAULT 1,
    imageUrl NVARCHAR(255) NULL,
    description NVARCHAR(500) NULL
);
GO

-- Recreate foreign key
ALTER TABLE Bookings ADD CONSTRAINT FK_Bookings_Vehicles FOREIGN KEY (vehicleId) REFERENCES Vehicles(vehicleId);
GO

-- Insert sample data
SET IDENTITY_INSERT Vehicles ON;
INSERT INTO Vehicles (vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl) VALUES
(1, 'Toyota Corolla', 'Sedan', 45.00, 1, 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400&h=300&fit=crop&crop=center'),
(2, 'Honda Civic', 'Sedan', 50.00, 1, 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&h=300&fit=crop&crop=center'),
(3, 'Jeep Wrangler', 'SUV', 80.00, 1, 'https://images.unsplash.com/photo-1606220838315-056192d5e927?w=400&h=300&fit=crop&crop=center'),
(4, 'BMW X5', 'Luxury SUV', 120.00, 0, 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&h=300&fit=crop&crop=center'),
(5, 'Ford Transit', 'Van', 70.00, 1, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop&crop=center');
SET IDENTITY_INSERT Vehicles OFF;
GO