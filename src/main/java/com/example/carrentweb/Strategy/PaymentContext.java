package com.example.carrentweb.Strategy;

/**
 * Context class that uses the PaymentStrategy to process payments
 */
public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public PaymentContext(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    /**
     * Execute payment using the current strategy
     * @param amount The amount to pay
     * @return true if payment was successful
     */
    public boolean executePayment(double amount) {
        if (paymentStrategy == null) {
            System.out.println("No payment strategy selected");
            return false;
        }
        return paymentStrategy.pay(amount);
    }

    /**
     * Factory method to create payment strategy based on method name
     * @param method The payment method name
     * @return PaymentStrategy instance or null if method not supported
     */
    public static PaymentStrategy createStrategy(String method) {
        switch (method.toLowerCase()) {
            case "credit card":
            case "creditcard":
                // For demo purposes, using dummy data
                // In real implementation, this data would come from user input
                return new CreditCardPayment("1234567890123456", "12/25", "123");
            case "paypal":
                return new PayPalPayment("user@example.com");
            case "bank transfer":
            case "banktransfer":
                return new BankTransferPayment("1234567890", "Sample Bank");
            default:
                return null;
        }
    }
}