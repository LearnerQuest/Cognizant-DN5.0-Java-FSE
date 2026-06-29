public class AdapterPatternTest {
    public static void main(String[] args) {

        PaymentProcessor payPalPayment =
                new PayPalAdapter(new PayPalGateway());

        payPalPayment.processPayment(1500);

        PaymentProcessor stripePayment =
                new StripeAdapter(new StripeGateway());

        stripePayment.processPayment(2500);
    }
}