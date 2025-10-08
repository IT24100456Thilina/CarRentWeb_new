package com.example.carrentweb.Entity;

import java.math.BigDecimal;

public class Promotion {
    private int id;
    private String title;
    private String description;
    private String badge;
    private String discountCode;
    private String discountType; // 'percentage' or 'fixed'
    private BigDecimal discountValue;
    private String validTill; // ISO date string for simplicity
    private boolean active;
    private String type; // 'general', 'seasonal', 'loyalty', 'first_time'
    private String createdDate;

    public Promotion() {}

    public Promotion(int id, String title, String description, String badge, String discountCode,
                    String discountType, BigDecimal discountValue, String validTill, boolean active,
                    String type, String createdDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.badge = badge;
        this.discountCode = discountCode;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.validTill = validTill;
        this.active = active;
        this.type = type;
        this.createdDate = createdDate;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }

    public String getDiscountCode() { return discountCode; }
    public void setDiscountCode(String discountCode) { this.discountCode = discountCode; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public BigDecimal getDiscountValue() { return discountValue; }
    public void setDiscountValue(BigDecimal discountValue) { this.discountValue = discountValue; }

    public String getValidTill() { return validTill; }
    public void setValidTill(String validTill) { this.validTill = validTill; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getCreatedDate() { return createdDate; }
    public void setCreatedDate(String createdDate) { this.createdDate = createdDate; }
}




