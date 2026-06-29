public class SearchService {

    public Product linearSearch(Product[] products, String productName) {
        for (Product product : products) {
            if (product.productName.equalsIgnoreCase(productName)) {
                return product;
            }
        }
        return null;
    }

    public Product binarySearch(Product[] products, String productName) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            int result = products[mid].productName.compareToIgnoreCase(productName);

            if (result == 0) {
                return products[mid];
            } else if (result < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
}