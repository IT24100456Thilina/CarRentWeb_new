-- Sample data for existing CarRentalDB
USE CarRentalDB;
GO

-- Insert sample bookings (if not already exist)
IF NOT EXISTS (SELECT 1 FROM Bookings WHERE bookingId = 1)
BEGIN
    INSERT INTO Bookings (userId, vehicleId, startDate, endDate, status) VALUES
    (2, 1, '2025-09-01', '2025-09-03', 'Completed'), -- John Doe, Toyota Corolla
    (3, 2, '2025-09-05', '2025-09-07', 'Completed'), -- Jane Smith, Honda Civic
    (2, 3, '2025-09-10', '2025-09-12', 'Completed'), -- John Doe, Jeep Wrangler
    (3, 1, '2025-09-15', '2025-09-17', 'Completed'), -- Jane Smith, Toyota Corolla
    (2, 5, '2025-09-20', '2025-09-22', 'Completed'), -- John Doe, Ford Transit
    (3, 3, '2025-09-25', '2025-09-27', 'Completed'), -- Jane Smith, Jeep Wrangler
    (2, 2, '2025-10-01', '2025-10-03', 'Completed'), -- John Doe, Honda Civic (current month)
    (3, 5, '2025-10-05', '2025-10-07', 'Completed'); -- Jane Smith, Ford Transit (current month)
END

-- Insert test booking with specific ID 1123
SET IDENTITY_INSERT Bookings ON;
IF NOT EXISTS (SELECT 1 FROM Bookings WHERE bookingId = 1123)
BEGIN
    INSERT INTO Bookings (bookingId, userId, vehicleId, startDate, endDate, status) VALUES
    (1123, 2, 1, '2025-10-07', '2025-10-09', 'Completed'); -- John Doe, Toyota Corolla
END
SET IDENTITY_INSERT Bookings OFF;

-- Insert sample payments (if not already exist)
IF NOT EXISTS (SELECT 1 FROM Payments WHERE paymentId = 1)
BEGIN
    INSERT INTO Payments (bookingId, amount, paymentMethod, paymentDate) VALUES
    (1, 90.00, 'Credit Card', '2025-09-01 10:00:00'), -- 2 days * 45
    (2, 100.00, 'PayPal', '2025-09-05 14:30:00'), -- 2 days * 50
    (3, 160.00, 'Credit Card', '2025-09-10 09:15:00'), -- 2 days * 80
    (4, 90.00, 'Bank Transfer', '2025-09-15 16:45:00'), -- 2 days * 45
    (5, 140.00, 'Credit Card', '2025-09-20 11:20:00'), -- 2 days * 70
    (6, 160.00, 'PayPal', '2025-09-25 13:10:00'), -- 2 days * 80
    (7, 100.00, 'Credit Card', '2025-10-01 08:30:00'), -- 2 days * 50
    (8, 140.00, 'Bank Transfer', '2025-10-05 15:00:00'), -- 2 days * 70
    (1123, 90.00, 'Credit Card', '2025-10-07 10:00:00'); -- Payment for booking 1123 (2 days * 45)
END

-- Verify data
SELECT 'Bookings Table:' as Table_Name;
SELECT * FROM Bookings;

SELECT 'Payments Table:' as Table_Name;
SELECT * FROM Payments;

GO