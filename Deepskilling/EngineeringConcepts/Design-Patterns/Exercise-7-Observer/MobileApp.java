public class MobileApp implements Observer {

    private String userName;

    public MobileApp(String userName) {
        this.userName = userName;
    }

    public void update(String stockName, double price) {
        System.out.println("Mobile notification for " + userName +
                ": " + stockName + " price updated to Rs. " + price);
    }
}