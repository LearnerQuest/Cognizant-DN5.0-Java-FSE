public class DecoratorPatternTest {
    public static void main(String[] args) {

        Notifier basicNotifier = new EmailNotifier();
        basicNotifier.send("Your account was logged in.");

        System.out.println();

        Notifier smsNotifier =
                new SMSNotifierDecorator(new EmailNotifier());

        smsNotifier.send("Your order has been shipped.");

        System.out.println();

        Notifier multiChannelNotifier =
                new SlackNotifierDecorator(
                        new SMSNotifierDecorator(
                                new EmailNotifier()
                        )
                );

        multiChannelNotifier.send("Payment received successfully.");
    }
}