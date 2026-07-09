public class WebApp implements Observer {

    private String dashboardName;

    public WebApp(String dashboardName) {
        this.dashboardName = dashboardName;
    }

    public void update(String stockName, double price) {
        System.out.println("Web dashboard " + dashboardName +
                ": " + stockName + " price updated to Rs. " + price);
    }
}