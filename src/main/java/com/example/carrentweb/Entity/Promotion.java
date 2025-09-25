package com.example.carrentweb.Entity;

public class Promotion {
    private int id;
    private String title;
    private String description;
    private String badge;
    private String validTill; // ISO date string for simplicity

    public Promotion() {}

    public Promotion(int id, String title, String description, String badge, String validTill) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.badge = badge;
        this.validTill = validTill;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }
    public String getValidTill() { return validTill; }
    public void setValidTill(String validTill) { this.validTill = validTill; }
}




