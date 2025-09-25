package com.example.carrentweb.Entity;

public class Feedback {
    private int feedbackId;
    private Integer bookingId; // Optional
    private Integer userId; // Added userId field
    private String comments;
    private int rating;
    private String dateSubmitted; // Added dateSubmitted field

    public Feedback() {}

    public Feedback(Integer bookingId, String comments, int rating) {
        this.bookingId = bookingId;
        this.comments = comments;
        this.rating = rating;
    }

    public Feedback(Integer bookingId, Integer userId, String comments, int rating) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.comments = comments;
        this.rating = rating;
    }

    // Getters and Setters
    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public Integer getBookingId() { return bookingId; }
    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getDateSubmitted() { return dateSubmitted; }
    public void setDateSubmitted(String dateSubmitted) { this.dateSubmitted = dateSubmitted; }
}
