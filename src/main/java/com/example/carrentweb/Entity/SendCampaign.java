package com.example.carrentweb.Entity;

public class SendCampaign {
    private int sendId;
    private int campaignId;
    private String status; // 'queued', 'sending', 'completed', 'failed'
    private String queuedDate;
    private String startedDate;
    private String completedDate;
    private int totalRecipients;
    private int sentCount;
    private int failedCount;
    private String errorMessage;
    private int initiatedBy; // admin userId

    public SendCampaign() {}

    public SendCampaign(int campaignId, int totalRecipients, int initiatedBy) {
        this.campaignId = campaignId;
        this.status = "queued";
        this.totalRecipients = totalRecipients;
        this.sentCount = 0;
        this.failedCount = 0;
        this.initiatedBy = initiatedBy;
    }

    // Getters and Setters
    public int getSendId() { return sendId; }
    public void setSendId(int sendId) { this.sendId = sendId; }

    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getQueuedDate() { return queuedDate; }
    public void setQueuedDate(String queuedDate) { this.queuedDate = queuedDate; }

    public String getStartedDate() { return startedDate; }
    public void setStartedDate(String startedDate) { this.startedDate = startedDate; }

    public String getCompletedDate() { return completedDate; }
    public void setCompletedDate(String completedDate) { this.completedDate = completedDate; }

    public int getTotalRecipients() { return totalRecipients; }
    public void setTotalRecipients(int totalRecipients) { this.totalRecipients = totalRecipients; }

    public int getSentCount() { return sentCount; }
    public void setSentCount(int sentCount) { this.sentCount = sentCount; }

    public int getFailedCount() { return failedCount; }
    public void setFailedCount(int failedCount) { this.failedCount = failedCount; }

    public String getErrorMessage() { return errorMessage; }
    public void setErrorMessage(String errorMessage) { this.errorMessage = errorMessage; }

    public int getInitiatedBy() { return initiatedBy; }
    public void setInitiatedBy(int initiatedBy) { this.initiatedBy = initiatedBy; }
}