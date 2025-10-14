package com.example.carrentweb.Strategy;

/**
 * Concrete strategy for bank transfer payments
 */
public class BankTransferPayment implements PaymentStrategy {
    private String accountNumber;
    private String bankName;

    public BankTransferPayment(String accountNumber, String bankName) {
        this.accountNumber = accountNumber;
        this.bankName = bankName;
    }

    @Override
    public boolean pay(double amount) {
        // Simulate bank transfer payment processing
        System.out.println("Processing bank transfer payment of $" + amount);
        System.out.println("Bank: " + bankName);
        System.out.println("Account: ****" + accountNumber.substring(accountNumber.length() - 4));

        // In a real implementation, this would integrate with banking APIs
        // For demo purposes, assume payment succeeds if amount > 0
        if (amount > 0) {
            System.out.println("Bank transfer payment successful");
            return true;
        } else {
            System.out.println("Bank transfer payment failed: Invalid amount");
            return false;
        }
    }
}