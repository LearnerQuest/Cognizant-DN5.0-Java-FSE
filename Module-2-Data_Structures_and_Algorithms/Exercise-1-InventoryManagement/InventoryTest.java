public class InventoryTest {
    public static void main(String[] args) {
        InventoryManager manager = new InventoryManager();

        Product p1 = new Product(101, "Laptop", 10, 55000);
        Product p2 = new Product(102, "Mouse", 50, 500);
        Product p3 = new Product(103, "Keyboard", 30, 1200);

        manager.addProduct(p1);
        manager.addProduct(p2);
        manager.addProduct(p3);

        System.out.println();
        manager.displayInventory();

        System.out.println();
        manager.updateProduct(102, "Wireless Mouse", 40, 750);

        System.out.println();
        manager.displayInventory();

        System.out.println();
        manager.deleteProduct(103);

        System.out.println();
        manager.displayInventory();
    }
}