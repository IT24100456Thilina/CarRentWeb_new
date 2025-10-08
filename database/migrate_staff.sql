-- Migration script to create Staff table if it doesn't exist
-- Run this in SQL Server Management Studio

USE CarRentalDB;
GO

-- Check if Staff table exists, if not create it
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Staff' AND xtype='U')
BEGIN
    -- Staff Table
    CREATE TABLE Staff (
        staffId INT IDENTITY(1,1) PRIMARY KEY,
        fullName NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL UNIQUE,
        phone NVARCHAR(20) NOT NULL,
        username NVARCHAR(50) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL, -- Increased length for hashed passwords
        position NVARCHAR(50) NOT NULL,
        department NVARCHAR(50) NOT NULL,
        isActive BIT NOT NULL DEFAULT 1,
        hireDate DATETIME NOT NULL DEFAULT GETDATE(),
        createdDate DATETIME NOT NULL DEFAULT GETDATE(),
        updatedDate DATETIME NOT NULL DEFAULT GETDATE()
    );

    -- Sample Data Insertion
    INSERT INTO Staff (fullName, email, phone, username, password, position, department, isActive) VALUES
    ('John Smith', 'john.smith@carrent.com', '+1234567891', 'jsmith', 'password123', 'Manager', 'Operations', 1),
    ('Sarah Johnson', 'sarah.johnson@carrent.com', '+1234567892', 'sjohnson', 'password123', 'Supervisor', 'Customer Service', 1),
    ('Mike Davis', 'mike.davis@carrent.com', '+1234567893', 'mdavis', 'password123', 'Staff', 'Maintenance', 1),
    ('Lisa Brown', 'lisa.brown@carrent.com', '+1234567894', 'lbrown', 'password123', 'Driver', 'Operations', 1),
    ('Emily Chen', 'emily.chen@carrent.com', '+1234567895', 'echen', 'password123', 'Accountant', 'Finance', 1);
END
GO

-- Verify the table
SELECT 'Staff Table:' as Table_Name;
SELECT * FROM Staff;
GO