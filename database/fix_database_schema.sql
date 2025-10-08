-- Complete database schema fix script
-- Run this in SQL Server Management Studio to fix all schema issues

USE CarRentalDB;
GO

-- 1. Add paymentDate column to Payments table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Payments') AND name = 'paymentDate')
BEGIN
    PRINT 'Adding paymentDate column to Payments table...';
    ALTER TABLE Payments ADD paymentDate DATETIME NOT NULL DEFAULT GETDATE();
END
ELSE
BEGIN
    PRINT 'paymentDate column already exists in Payments table.';
END
GO

-- Update any NULL paymentDate values
UPDATE Payments SET paymentDate = GETDATE() WHERE paymentDate IS NULL;
GO

-- 2. Create Staff table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Staff' AND xtype='U')
BEGIN
    PRINT 'Creating Staff table...';
    CREATE TABLE Staff (
        staffId INT IDENTITY(1,1) PRIMARY KEY,
        fullName NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL UNIQUE,
        phone NVARCHAR(20) NOT NULL,
        username NVARCHAR(50) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL,
        position NVARCHAR(50) NOT NULL,
        department NVARCHAR(50) NOT NULL,
        isActive BIT NOT NULL DEFAULT 1,
        hireDate DATETIME NOT NULL DEFAULT GETDATE(),
        createdDate DATETIME NOT NULL DEFAULT GETDATE(),
        updatedDate DATETIME NOT NULL DEFAULT GETDATE()
    );

    -- Insert sample staff data including accountant
    INSERT INTO Staff (fullName, email, phone, username, password, position, department, isActive) VALUES
    ('John Smith', 'john.smith@carrent.com', '+1234567891', 'jsmith', 'password123', 'Manager', 'Operations', 1),
    ('Sarah Johnson', 'sarah.johnson@carrent.com', '+1234567892', 'sjohnson', 'password123', 'Supervisor', 'Customer Service', 1),
    ('Mike Davis', 'mike.davis@carrent.com', '+1234567893', 'mdavis', 'password123', 'Staff', 'Maintenance', 1),
    ('Lisa Brown', 'lisa.brown@carrent.com', '+1234567894', 'lbrown', 'password123', 'Driver', 'Operations', 1),
    ('Emily Chen', 'emily.chen@carrent.com', '+1234567895', 'echen', 'password123', 'Accountant', 'Finance', 1);
END
ELSE
BEGIN
    PRINT 'Staff table already exists.';
    -- Check if accountant exists, if not add
    IF NOT EXISTS (SELECT * FROM Staff WHERE position = 'Accountant')
    BEGIN
        INSERT INTO Staff (fullName, email, phone, username, password, position, department, isActive) VALUES
        ('Emily Chen', 'emily.chen@carrent.com', '+1234567895', 'echen', 'password123', 'Accountant', 'Finance', 1);
        PRINT 'Added accountant to Staff table.';
    END
END
GO

-- 3. Verify tables exist and have correct structure
PRINT 'Verifying Payments table structure:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Payments'
ORDER BY ORDINAL_POSITION;

PRINT 'Verifying Staff table:';
SELECT * FROM Staff;

PRINT 'Checking sample payments:';
SELECT TOP 5 paymentId, bookingId, amount, paymentMethod, paymentDate FROM Payments;

PRINT 'Database schema fix completed successfully!';
GO