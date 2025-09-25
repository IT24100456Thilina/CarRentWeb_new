package com.example.carrentweb.Entity;

public class Campaign {
    private int campaignId;
    private String subject;
    private String body;
    private String offer;
    private String segment; // e.g., "all", "active_customers", "new_customers"
    private String status; // "draft", "scheduled", "sent", "failed"
    private String createdDate;
    private String sentDate;
    private int sentCount;
    private int adminId;

    public Campaign() {}

    public Campaign(String subject, String body, String offer, String segment, int adminId) {
        this.subject = subject;
        this.body = body;
        this.offer = offer;
        this.segment = segment;
        this.status = "draft";
        this.adminId = adminId;
        this.sentCount = 0;
    }

    // Getters and Setters
    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }

    public String getOffer() { return offer; }
    public void setOffer(String offer) { this.offer = offer; }

    public String getSegment() { return segment; }
    public void setSegment(String segment) { this.segment = segment; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreatedDate() { return createdDate; }
    public void setCreatedDate(String createdDate) { this.createdDate = createdDate; }

    public String getSentDate() { return sentDate; }
    public void setSentDate(String sentDate) { this.sentDate = sentDate; }

    public int getSentCount() { return sentCount; }
    public void setSentCount(int sentCount) { this.sentCount = sentCount; }

    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }
}