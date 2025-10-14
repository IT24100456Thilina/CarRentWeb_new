package com.example.carrentweb.Strategy;

/**
 * Concrete strategy for credit card payments
 */
public class CreditCardPayment implements PaymentStrategy {
    private String cardNumber;
    private String expiryDate;
    private String cvv;

    public CreditCardPayment(String cardNumber, String expiryDate, String cvv) {
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
    }

    @Override
    public boolean pay(double amount) {
        // Simulate credit card payment processing
        System.out.println("Processing credit card payment of $" + amount);
        System.out.println("Card: **** **** **** " + cardNumber.substring(cardNumber.length() - 4));

        // In a real implementation, this would integrate with a payment gateway
        // For demo purposes, assume payment succeeds if amount > 0
        if (amount > 0) {
            System.out.println("Credit card payment successful");
            return true;
        } else {
            System.out.println("Credit card payment failed: Invalid amount");
            return false;
        }
    }
}