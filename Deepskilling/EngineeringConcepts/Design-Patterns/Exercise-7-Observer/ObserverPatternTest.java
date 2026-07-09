public class ObserverPatternTest {

    public static void main(String[] args) {

        StockMarket stockMarket = new StockMarket();

        Observer mobileApp = new MobileApp("Aashi");
        Observer webApp = new WebApp("Trader Dashboard");

        stockMarket.registerObserver(mobileApp);
        stockMarket.registerObserver(webApp);

        stockMarket.setStockPrice("TCS", 3850.50);

        System.out.println();

        stockMarket.deregisterObserver(webApp);

        stockMarket.setStockPrice("INFY", 1495.75);
    }
}