package com.example.carrentweb.Strategy;

/**
 * Demo class to demonstrate the Strategy Design Pattern for payments
 */
public class PaymentStrategyDemo {
    public static void main(String[] args) {
        System.out.println("=== Payment Strategy Pattern Demo ===\n");

        // Test Credit Card Payment
        System.out.println("1. Testing Credit Card Payment:");
        PaymentStrategy creditCard = new CreditCardPayment("4111111111111111", "12/26", "123");
        PaymentContext context = new PaymentContext(creditCard);
        context.executePayment(150.00);
        System.out.println();

        // Test PayPal Payment
        System.out.println("2. Testing PayPal Payment:");
        PaymentStrategy paypal = new PayPalPayment("customer@example.com");
        context.setPaymentStrategy(paypal);
        context.executePayment(75.50);
        System.out.println();

        // Test Bank Transfer Payment
        System.out.println("3. Testing Bank Transfer Payment:");
        PaymentStrategy bankTransfer = new BankTransferPayment("123456789012", "National Bank");
        context.setPaymentStrategy(bankTransfer);
        context.executePayment(200.00);
        System.out.println();

        // Test Factory Method
        System.out.println("4. Testing Factory Method Creation:");
        PaymentStrategy strategy1 = PaymentContext.createStrategy("credit card");
        if (strategy1 != null) {
            context.setPaymentStrategy(strategy1);
            context.executePayment(50.00);
        }

        PaymentStrategy strategy2 = PaymentContext.createStrategy("paypal");
        if (strategy2 != null) {
            context.setPaymentStrategy(strategy2);
            context.executePayment(25.00);
        }

        PaymentStrategy strategy3 = PaymentContext.createStrategy("bank transfer");
        if (strategy3 != null) {
            context.setPaymentStrategy(strategy3);
            context.executePayment(100.00);
        }

        System.out.println("\n=== Demo Complete ===");
    }
}