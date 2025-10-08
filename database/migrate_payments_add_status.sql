-- Add status column to Payments table
ALTER TABLE Payments ADD status NVARCHAR(20) NOT NULL DEFAULT 'Paid';