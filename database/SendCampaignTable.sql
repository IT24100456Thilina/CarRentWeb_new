-- SendCampaign Table for tracking campaign sending processes
-- This table tracks when campaigns are queued, started, and completed sending

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

-- Indexes for better performance
CREATE INDEX idx_sendcampaign_campaignid ON SendCampaign(campaignId);
CREATE INDEX idx_sendcampaign_status ON SendCampaign(status);
CREATE INDEX idx_sendcampaign_queueddate ON SendCampaign(queuedDate DESC);

-- Sample data insertion
INSERT INTO SendCampaign (campaignId, status, totalRecipients, sentCount, failedCount, initiatedBy) VALUES
(1, 'completed', 150, 145, 5, 1),
(2, 'sending', 75, 45, 2, 1),
(3, 'queued', 200, 0, 0, 1);

-- Useful queries for the application

-- Get active sending processes
SELECT sc.*, c.subject, u.fullName as initiatedByName
FROM SendCampaign sc
JOIN Campaigns c ON sc.campaignId = c.campaignId
JOIN Users u ON sc.initiatedBy = u.userId
WHERE sc.status IN ('queued', 'sending')
ORDER BY sc.queuedDate DESC;

-- Get sending history for a campaign
SELECT * FROM SendCampaign
WHERE campaignId = ?
ORDER BY queuedDate DESC;

-- Get sending statistics
SELECT
    COUNT(*) as totalSends,
    SUM(totalRecipients) as totalRecipients,
    SUM(sentCount) as totalSent,
    SUM(failedCount) as totalFailed,
    AVG(CASE WHEN status = 'completed' THEN sentCount * 100.0 / NULLIF(totalRecipients, 0) END) as avgSuccessRate
FROM SendCampaign
WHERE status = 'completed';

-- Update send status
UPDATE SendCampaign
SET status = 'sending', startedDate = GETDATE()
WHERE sendId = ? AND status = 'queued';

UPDATE SendCampaign
SET status = 'completed', completedDate = GETDATE(), sentCount = ?, failedCount = ?
WHERE sendId = ?;

UPDATE SendCampaign
SET status = 'failed', completedDate = GETDATE(), errorMessage = ?
WHERE sendId = ?;