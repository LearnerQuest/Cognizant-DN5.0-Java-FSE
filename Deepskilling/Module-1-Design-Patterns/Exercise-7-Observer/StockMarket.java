import java.util.ArrayList;
import java.util.List;

public class StockMarket implements Stock {

    private List<Observer> observers = new ArrayList<>();
    private String stockName;
    private double price;

    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    public void deregisterObserver(Observer observer) {
        observers.remove(observer);
    }

    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(stockName, price);
        }
    }

    public void setStockPrice(String stockName, double price) {
        this.stockName = stockName;
        this.price = price;
        notifyObservers();
    }
}