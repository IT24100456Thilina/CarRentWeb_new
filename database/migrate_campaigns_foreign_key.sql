-- Migration script to fix Campaigns table foreign key constraint
-- The adminId should reference Staff(staffId), not Users(userId)

USE CarRentalDB;
GO

-- First, update existing data to use valid staffId (6)
UPDATE Campaigns SET adminId = 6 WHERE adminId NOT IN (SELECT staffId FROM Staff);
UPDATE SendCampaign SET initiatedBy = 6 WHERE initiatedBy NOT IN (SELECT staffId FROM Staff);
GO

-- Drop the existing incorrect foreign key constraints
ALTER TABLE Campaigns DROP CONSTRAINT FK__Campaigns__admin__2CF2ADDF;
ALTER TABLE SendCampaign DROP CONSTRAINT FK__SendCampa__initi__7D0E9093;
GO

-- Add the correct foreign key constraints referencing Staff table
ALTER TABLE Campaigns ADD CONSTRAINT FK_Campaigns_Staff FOREIGN KEY (adminId) REFERENCES Staff(staffId);
ALTER TABLE SendCampaign ADD CONSTRAINT FK_SendCampaign_Staff FOREIGN KEY (initiatedBy) REFERENCES Staff(staffId);
GO

-- Verify the changes
SELECT
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    tr.name AS ReferencedTable
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
WHERE tp.name IN ('Campaigns', 'SendCampaign')
ORDER BY tp.name, fk.name;

GO