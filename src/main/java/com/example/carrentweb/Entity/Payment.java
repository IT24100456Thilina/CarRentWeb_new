package com.example.carrentweb.Entity;

public class Payment {
    private int paymentId;
    private int bookingId;
    private double amount;
    private String paymentMethod;
    private String paymentDate; // Added paymentDate field

    public Payment() {}

    public Payment(int bookingId, double amount, String paymentMethod) {
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
    }

    public Payment(int bookingId, double amount, String paymentMethod, String paymentDate) {
        this.bookingId = bookingId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
    }

    // Getters and Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
}
