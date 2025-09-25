package com.example.carrentweb.Entity;

public class Feedback {
    private int feedbackId;
    private Integer bookingId; // Optional
    private String comments;
    private int rating;

    public Feedback() {}

    public Feedback(Integer bookingId, String comments, int rating) {
        this.bookingId = bookingId;
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
}
