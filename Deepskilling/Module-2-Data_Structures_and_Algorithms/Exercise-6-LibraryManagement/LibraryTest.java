import java.util.Arrays;
import java.util.Comparator;

public class LibraryTest {

    public static void main(String[] args) {

        Book[] books = {

                new Book(101, "Java", "James Gosling"),
                new Book(102, "C", "Dennis Ritchie"),
                new Book(103, "Python", "Guido"),
                new Book(104, "DSA", "Robert Lafore")

        };

        System.out.println("Linear Search:");

        Book result1 = LinearSearch.search(books, "Python");

        if (result1 != null)
            result1.display();
        else
            System.out.println("Book not found");

        Arrays.sort(books, Comparator.comparing(b -> b.title));

        System.out.println("\nBinary Search:");

        Book result2 = BinarySearch.search(books, "Python");

        if (result2 != null)
            result2.display();
        else
            System.out.println("Book not found");
    }
}