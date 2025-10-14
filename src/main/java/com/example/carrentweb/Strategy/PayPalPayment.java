package com.example.carrentweb.Strategy;

/**
 * Concrete strategy for PayPal payments
 */
public class PayPalPayment implements PaymentStrategy {
    private String email;

    public PayPalPayment(String email) {
        this.email = email;
    }

    @Override
    public boolean pay(double amount) {
        // Simulate PayPal payment processing
        System.out.println("Processing PayPal payment of $" + amount);
        System.out.println("PayPal account: " + email);

        // In a real implementation, this would integrate with PayPal API
        // For demo purposes, assume payment succeeds if amount > 0
        if (amount > 0) {
            System.out.println("PayPal payment successful");
            return true;
        } else {
            System.out.println("PayPal payment failed: Invalid amount");
            return false;
        }
    }
}