public class SortingTest {
    public static void main(String[] args) {

        Order[] bubbleOrders = {
                new Order(101, "Aashi", 5500),
                new Order(102, "Riya", 2300),
                new Order(103, "Ankit", 9800),
                new Order(104, "Rahul", 1500),
                new Order(105, "Neha", 7200)
        };

        Order[] quickOrders = {
                new Order(101, "Aashi", 5500),
                new Order(102, "Riya", 2300),
                new Order(103, "Ankit", 9800),
                new Order(104, "Rahul", 1500),
                new Order(105, "Neha", 7200)
        };

        SortingService service = new SortingService();

        System.out.println("Orders sorted using Bubble Sort:");
        service.bubbleSort(bubbleOrders);
        service.displayOrders(bubbleOrders);

        System.out.println();

        System.out.println("Orders sorted using Quick Sort:");
        service.quickSort(quickOrders, 0, quickOrders.length - 1);
        service.displayOrders(quickOrders);
    }
}