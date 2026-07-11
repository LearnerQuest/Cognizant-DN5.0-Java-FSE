import java.util.Arrays;
import java.util.Comparator;

public class EcommerceSearchTest {
    public static void main(String[] args) {
        Product[] products = {
                new Product(101, "Laptop", "Electronics"),
                new Product(102, "Shoes", "Fashion"),
                new Product(103, "Mobile", "Electronics"),
                new Product(104, "Watch", "Accessories"),
                new Product(105, "Keyboard", "Electronics")
        };

        SearchService searchService = new SearchService();

        System.out.println("Linear Search Result:");
        Product linearResult = searchService.linearSearch(products, "Mobile");

        if (linearResult != null) {
            linearResult.displayProduct();
        } else {
            System.out.println("Product not found.");
        }

        Arrays.sort(products, Comparator.comparing(product -> product.productName.toLowerCase()));

        System.out.println("\nBinary Search Result:");
        Product binaryResult = searchService.binarySearch(products, "Mobile");

        if (binaryResult != null) {
            binaryResult.displayProduct();
        } else {
            System.out.println("Product not found.");
        }
    }
}
