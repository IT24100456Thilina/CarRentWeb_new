-- Rename the table from BookingActionLogs1 to BookingActionLogs
USE CarRentalDB;
GO

EXEC sp_rename 'BookingActionLogs1', 'BookingActionLogs';
GO

-- Verify the table has been renamed
SELECT * FROM BookingActionLogs;