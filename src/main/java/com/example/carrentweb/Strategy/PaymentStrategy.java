package com.example.carrentweb.Strategy;

/**
 * Strategy interface for different payment methods
 */
public interface PaymentStrategy {
    /**
     * Process payment for the given amount
     * @param amount The amount to be paid
     * @return true if payment was successful, false otherwise
     */
    boolean pay(double amount);
}