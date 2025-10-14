-- Create BookingActionLogs table
CREATE TABLE BookingActionLogs (
    logId INT IDENTITY(1,1) PRIMARY KEY,
    bookingId INT NOT NULL,
    action NVARCHAR(20) NOT NULL, -- 'approve' or 'cancel'
    previousStatus NVARCHAR(20) NOT NULL,
    newStatus NVARCHAR(20) NOT NULL,
    actionBy INT NULL, -- UserId of staff who performed action (can be NULL for now)
    actionDate DATETIME NOT NULL DEFAULT GETDATE(),
    notes NVARCHAR(500) NULL,
    FOREIGN KEY (bookingId) REFERENCES Bookings(bookingId),
    FOREIGN KEY (actionBy) REFERENCES Users(userId)
);

-- Create indexes for better query performance
CREATE INDEX idx_booking_action_logs_bookingId ON BookingActionLogs(bookingId);
CREATE INDEX idx_booking_action_logs_actionDate ON BookingActionLogs(actionDate);

-- Sample select query
SELECT * FROM BookingActionLogs;