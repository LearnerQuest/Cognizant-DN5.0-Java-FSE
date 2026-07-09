public class StrategyPatternTest {

    public static void main(String[] args) {

        PaymentContext paymentContext =
                new PaymentContext(new CreditCardPayment("Aashi Garg"));

        paymentContext.executePayment(2500);

        paymentContext.setPaymentStrategy(
                new PayPalPayment("aashi@example.com")
        );

        paymentContext.executePayment(1800);
    }
}