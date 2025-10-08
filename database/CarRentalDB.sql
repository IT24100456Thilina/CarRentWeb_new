-- Car Rental Database Schema
-- SQL Server Database Creation Script

-- Create Database
CREATE DATABASE CarRentalDB;
GO

USE CarRentalDB;
GO

-- Users Table
CREATE TABLE Users (
    userId INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20) NOT NULL,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(50) NOT NULL,
    role NVARCHAR(20) NOT NULL DEFAULT 'customer'
);

-- Vehicles Table
CREATE TABLE Vehicles (
    vehicleId INT IDENTITY(1,1) PRIMARY KEY,
    vehicleName NVARCHAR(100) NOT NULL,
    vehicleType NVARCHAR(50) NOT NULL,
    dailyPrice DECIMAL(10,2) NOT NULL,
    available BIT NOT NULL DEFAULT 1,
    imageUrl NVARCHAR(255) NULL,
    description NVARCHAR(500) NULL
);

-- Bookings Table
CREATE TABLE Bookings (
    bookingId INT PRIMARY KEY IDENTITY(1,1),
    userId INT NOT NULL,
    vehicleId INT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (vehicleId) REFERENCES Vehicles(vehicleId)
);

-- Payments Table
CREATE TABLE Payments (
    paymentId INT IDENTITY(1,1) PRIMARY KEY,
    bookingId INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paymentMethod NVARCHAR(50) NOT NULL,
    paymentDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (bookingId) REFERENCES Bookings(bookingId)
);

-- Feedbacks Table
CREATE TABLE Feedbacks (
    feedbackId INT IDENTITY(1,1) PRIMARY KEY,
    bookingId INT NULL, -- optional
    userId INT NOT NULL, -- user who submitted the feedback
    comments NVARCHAR(500) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    dateSubmitted DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (bookingId) REFERENCES Bookings(bookingId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

-- Promotions Table
CREATE TABLE Promotions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(1000) NOT NULL,
    badge NVARCHAR(50) NULL,
    validTill DATE NULL,
    active BIT NOT NULL DEFAULT 1,
    createdDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Campaigns Table
CREATE TABLE Campaigns (
    campaignId INT IDENTITY(1,1) PRIMARY KEY,
    subject NVARCHAR(200) NOT NULL,
    body NVARCHAR(MAX) NOT NULL,
    offer NVARCHAR(500) NULL,
    segment NVARCHAR(50) NOT NULL DEFAULT 'all', -- 'all', 'active_customers', 'new_customers', etc.
    status NVARCHAR(20) NOT NULL DEFAULT 'draft', -- 'draft', 'scheduled', 'sent', 'failed'
    createdDate DATETIME NOT NULL DEFAULT GETDATE(),
    sentDate DATETIME NULL,
    sentCount INT NOT NULL DEFAULT 0,
    adminId INT NOT NULL,
    FOREIGN KEY (adminId) REFERENCES Users(userId)
);

-- Campaign Logs Table (for tracking email sending)
CREATE TABLE CampaignLogs (
    logId INT IDENTITY(1,1) PRIMARY KEY,
    campaignId INT NOT NULL,
    recipientEmail NVARCHAR(100) NOT NULL,
    status NVARCHAR(20) NOT NULL, -- 'sent', 'failed', 'bounced'
    sentDate DATETIME NOT NULL DEFAULT GETDATE(),
    errorMessage NVARCHAR(500) NULL,
    FOREIGN KEY (campaignId) REFERENCES Campaigns(campaignId)
);

-- SendCampaign Table (for tracking campaign sending processes)
CREATE TABLE SendCampaign (
    sendId INT IDENTITY(1,1) PRIMARY KEY,
    campaignId INT NOT NULL,
    status NVARCHAR(20) NOT NULL DEFAULT 'queued', -- 'queued', 'sending', 'completed', 'failed'
    queuedDate DATETIME NOT NULL DEFAULT GETDATE(),
    startedDate DATETIME NULL,
    completedDate DATETIME NULL,
    totalRecipients INT NOT NULL DEFAULT 0,
    sentCount INT NOT NULL DEFAULT 0,
    failedCount INT NOT NULL DEFAULT 0,
    errorMessage NVARCHAR(500) NULL,
    initiatedBy INT NOT NULL, -- admin userId who initiated the send
    FOREIGN KEY (campaignId) REFERENCES Campaigns(campaignId),
    FOREIGN KEY (initiatedBy) REFERENCES Users(userId)
);

-- Sample Data Insertion
-- Insert sample users
INSERT INTO Users (fullName, email, phone, username, password, role) VALUES
('Admin User', 'admin@carrent.com', '+1234567890', 'admin', 'admin123', 'admin'),
('John Doe', 'john@example.com', '+1987654321', 'johndoe', 'password123', 'customer'),
('Jane Smith', 'jane@example.com', '+1123456789', 'janesmith', 'password123', 'customer');

-- Insert sample vehicles
SET IDENTITY_INSERT Vehicles ON;
INSERT INTO Vehicles (vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl, description) VALUES
(1, 'Toyota Corolla', 'Sedan', 45.00, 1, 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400&h=300&fit=crop&crop=center', 'A reliable and fuel-efficient sedan perfect for city driving and long trips.'),
(2, 'Honda Civic', 'Sedan', 50.00, 1, 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&h=300&fit=crop&crop=center', 'A comfortable and stylish sedan with excellent fuel economy and modern features.'),
(3, 'Jeep Wrangler', 'SUV', 80.00, 1, 'https://images.unsplash.com/photo-1606220838315-056192d5e927?w=400&h=300&fit=crop&crop=center', 'A rugged and capable SUV ideal for off-road adventures and outdoor activities.'),
(4, 'BMW X5', 'Luxury SUV', 120.00, 0, 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&h=300&fit=crop&crop=center', 'A luxury SUV offering premium comfort, advanced technology, and superior performance.'),
(5, 'Ford Transit', 'Van', 70.00, 1, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop&crop=center', 'A spacious van perfect for group travel, moving, or transporting cargo.');
SET IDENTITY_INSERT Vehicles OFF;

-- Insert sample bookings
INSERT INTO Bookings (userId, vehicleId, startDate, endDate, status) VALUES
(2, 1, '2025-09-01', '2025-09-03', 'Completed'), -- John Doe, Toyota Corolla
(3, 2, '2025-09-05', '2025-09-07', 'Completed'), -- Jane Smith, Honda Civic
(2, 3, '2025-09-10', '2025-09-12', 'Completed'), -- John Doe, Jeep Wrangler
(3, 1, '2025-09-15', '2025-09-17', 'Completed'), -- Jane Smith, Toyota Corolla
(2, 5, '2025-09-20', '2025-09-22', 'Completed'), -- John Doe, Ford Transit
(3, 3, '2025-09-25', '2025-09-27', 'Completed'), -- Jane Smith, Jeep Wrangler
(2, 2, '2025-10-01', '2025-10-03', 'Completed'), -- John Doe, Honda Civic (current month)
(3, 5, '2025-10-05', '2025-10-07', 'Completed'); -- Jane Smith, Ford Transit (current month)

-- Insert sample payments
INSERT INTO Payments (bookingId, amount, paymentMethod, paymentDate) VALUES
(1, 90.00, 'Credit Card', '2025-09-01 10:00:00'), -- 2 days * 45
(2, 100.00, 'PayPal', '2025-09-05 14:30:00'), -- 2 days * 50
(3, 160.00, 'Credit Card', '2025-09-10 09:15:00'), -- 2 days * 80
(4, 90.00, 'Bank Transfer', '2025-09-15 16:45:00'), -- 2 days * 45
(5, 140.00, 'Credit Card', '2025-09-20 11:20:00'), -- 2 days * 70
(6, 160.00, 'PayPal', '2025-09-25 13:10:00'), -- 2 days * 80
(7, 100.00, 'Credit Card', '2025-10-01 08:30:00'), -- 2 days * 50
(8, 140.00, 'Bank Transfer', '2025-10-05 15:00:00'); -- 2 days * 70

-- Insert sample promotions
INSERT INTO Promotions (title, description, badge, validTill, active) VALUES
('Weekend Special', 'Get 15% off on all weekend rentals. Book Friday to Sunday and enjoy the savings!', 'HOT', '2025-12-31', 1),
('Early Bird Discount', 'Book 14+ days in advance and save 10% on your rental. Perfect for planning ahead!', 'NEW', '2025-12-31', 1),
('Loyal Customer Reward', 'Returning customers get 5% off on every booking. Thank you for choosing us!', 'LOYALTY', '2025-12-31', 1);

-- Insert sample feedback
INSERT INTO Feedbacks (bookingId, comments, rating) VALUES
(NULL, 'Excellent service! The Toyota Corolla was in perfect condition and the booking process was seamless. Highly recommend CarGO for anyone looking for reliable car rentals.', 5),
(NULL, 'Great experience overall. The Honda Civic was clean and well-maintained. Customer support was responsive and helpful throughout the rental period.', 4),
(NULL, 'Amazing fleet and professional service. The Jeep Wrangler performed perfectly for our weekend trip. Will definitely book again!', 5),
(NULL, 'Good value for money. The vehicle was as described and pickup/drop-off was convenient. Minor delay in paperwork but overall satisfied.', 4);

-- Sample data for SendCampaign
INSERT INTO SendCampaign (campaignId, status, totalRecipients, sentCount, failedCount, initiatedBy) VALUES
(1, 'completed', 2, 2, 0, 1);

-- Select statements to verify data
SELECT 'Users Table:' as Table_Name;
SELECT * FROM Users;

SELECT 'Vehicles Table:' as Table_Name;
SELECT * FROM Vehicles;

SELECT 'Bookings Table:' as Table_Name;
SELECT * FROM Bookings;

SELECT 'Payments Table:' as Table_Name;
SELECT * FROM Payments;

SELECT 'Feedbacks Table:' as Table_Name;
SELECT * FROM Feedbacks;

SELECT 'Promotions Table:' as Table_Name;
SELECT * FROM Promotions;

SELECT 'Campaigns Table:' as Table_Name;
SELECT * FROM Campaigns;

SELECT 'CampaignLogs Table:' as Table_Name;
SELECT * FROM CampaignLogs;

SELECT 'SendCampaign Table:' as Table_Name;
SELECT * FROM SendCampaign;

-- Useful queries for the application
-- Get available vehicles
SELECT * FROM Vehicles WHERE available = 1 ORDER BY vehicleType, dailyPrice;

-- Get active promotions
SELECT * FROM Promotions WHERE active = 1 AND (validTill IS NULL OR validTill >= GETDATE()) ORDER BY id DESC;

-- Get user bookings with vehicle details
SELECT b.*, v.vehicleName, v.vehicleType, v.dailyPrice
FROM Bookings b
JOIN Vehicles v ON b.vehicleId = v.vehicleId
WHERE b.userId = ?; -- Replace ? with actual userId

-- Get user payments with booking details
SELECT p.*, b.startDate, b.endDate, v.vehicleName
FROM Payments p
JOIN Bookings b ON p.bookingId = b.bookingId
JOIN Vehicles v ON b.vehicleId = v.vehicleId
WHERE b.userId = ?; -- Replace ? with actual userId

-- Get user feedback
SELECT f.*, b.startDate, b.endDate, v.vehicleName
FROM Feedbacks f
LEFT JOIN Bookings b ON f.bookingId = b.bookingId
LEFT JOIN Vehicles v ON b.vehicleId = v.vehicleId
WHERE f.userId = ?; -- Replace ? with actual userId

-- Campaign-related queries

-- Get active sending processes
SELECT sc.*, c.subject, u.fullName as initiatedByName
FROM SendCampaign sc
JOIN Campaigns c ON sc.campaignId = c.campaignId
JOIN Users u ON sc.initiatedBy = u.userId
WHERE sc.status IN ('queued', 'sending')
ORDER BY sc.queuedDate DESC;

-- Get sending history for a campaign
SELECT sc.*, u.fullName as initiatedByName
FROM SendCampaign sc
JOIN Users u ON sc.initiatedBy = u.userId
WHERE sc.campaignId = ?
ORDER BY sc.queuedDate DESC;

-- Get campaign sending statistics
SELECT
    COUNT(*) as totalSends,
    SUM(totalRecipients) as totalRecipients,
    SUM(sentCount) as totalSent,
    SUM(failedCount) as totalFailed,
    AVG(CASE WHEN status = 'completed' THEN sentCount * 100.0 / NULLIF(totalRecipients, 0) END) as avgSuccessRate
FROM SendCampaign
WHERE status = 'completed';

GO