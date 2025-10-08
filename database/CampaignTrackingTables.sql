-- Campaign Email Tracking Tables
-- These tables track email opens and clicks for performance analytics

-- CampaignOpens Table (tracks when emails are opened)
CREATE TABLE CampaignOpens (
    openId INT IDENTITY(1,1) PRIMARY KEY,
    campaignId INT NOT NULL,
    recipientEmail NVARCHAR(100) NOT NULL,
    openedAt DATETIME NOT NULL DEFAULT GETDATE(),
    userAgent NVARCHAR(500) NULL,
    ipAddress NVARCHAR(45) NULL,
    FOREIGN KEY (campaignId) REFERENCES Campaigns(campaignId)
);

-- CampaignClicks Table (tracks when links in emails are clicked)
CREATE TABLE CampaignClicks (
    clickId INT IDENTITY(1,1) PRIMARY KEY,
    campaignId INT NOT NULL,
    recipientEmail NVARCHAR(100) NOT NULL,
    linkUrl NVARCHAR(1000) NOT NULL,
    clickedAt DATETIME NOT NULL DEFAULT GETDATE(),
    userAgent NVARCHAR(500) NULL,
    ipAddress NVARCHAR(45) NULL,
    FOREIGN KEY (campaignId) REFERENCES Campaigns(campaignId)
);

-- Indexes for better performance
CREATE INDEX idx_campaignopens_campaignid ON CampaignOpens(campaignId);
CREATE INDEX idx_campaignopens_email ON CampaignOpens(recipientEmail);
CREATE INDEX idx_campaignopens_openedat ON CampaignOpens(openedAt DESC);

CREATE INDEX idx_campaignclicks_campaignid ON CampaignClicks(campaignId);
CREATE INDEX idx_campaignclicks_email ON CampaignClicks(recipientEmail);
CREATE INDEX idx_campaignclicks_clickedat ON CampaignClicks(clickedAt DESC);
CREATE INDEX idx_campaignclicks_linkurl ON CampaignClicks(linkUrl);

-- Sample queries for analytics

-- Get open rate for a campaign
SELECT
    c.campaignId,
    c.subject,
    COUNT(DISTINCT co.recipientEmail) as uniqueOpens,
    cl.sentCount as totalSent,
    CASE WHEN cl.sentCount > 0 THEN CAST(COUNT(DISTINCT co.recipientEmail) AS DECIMAL(10,2)) / cl.sentCount * 100 ELSE 0 END as openRate
FROM Campaigns c
LEFT JOIN CampaignOpens co ON c.campaignId = co.campaignId
LEFT JOIN CampaignLogs cl ON c.campaignId = cl.campaignId AND cl.status = 'sent'
WHERE c.campaignId = ?
GROUP BY c.campaignId, c.subject, cl.sentCount;

-- Get click rate for a campaign
SELECT
    c.campaignId,
    c.subject,
    COUNT(DISTINCT cc.recipientEmail) as uniqueClicks,
    COUNT(cc.clickId) as totalClicks,
    cl.sentCount as totalSent,
    CASE WHEN cl.sentCount > 0 THEN CAST(COUNT(DISTINCT cc.recipientEmail) AS DECIMAL(10,2)) / cl.sentCount * 100 ELSE 0 END as clickRate
FROM Campaigns c
LEFT JOIN CampaignClicks cc ON c.campaignId = cc.campaignId
LEFT JOIN CampaignLogs cl ON c.campaignId = cl.campaignId AND cl.status = 'sent'
WHERE c.campaignId = ?
GROUP BY c.campaignId, c.subject, cl.sentCount;

-- Get detailed performance summary
SELECT
    c.campaignId,
    c.subject,
    c.sentDate,
    cl.sentCount as totalSent,
    COUNT(DISTINCT co.recipientEmail) as uniqueOpens,
    COUNT(DISTINCT cc.recipientEmail) as uniqueClicks,
    COUNT(cc.clickId) as totalClicks,
    CASE WHEN cl.sentCount > 0 THEN CAST(COUNT(DISTINCT co.recipientEmail) AS DECIMAL(10,2)) / cl.sentCount * 100 ELSE 0 END as openRate,
    CASE WHEN cl.sentCount > 0 THEN CAST(COUNT(DISTINCT cc.recipientEmail) AS DECIMAL(10,2)) / cl.sentCount * 100 ELSE 0 END as clickRate
FROM Campaigns c
LEFT JOIN CampaignLogs cl ON c.campaignId = cl.campaignId AND cl.status = 'sent'
LEFT JOIN CampaignOpens co ON c.campaignId = co.campaignId
LEFT JOIN CampaignClicks cc ON c.campaignId = cc.campaignId
WHERE c.status = 'sent'
GROUP BY c.campaignId, c.subject, c.sentDate, cl.sentCount
ORDER BY c.sentDate DESC;