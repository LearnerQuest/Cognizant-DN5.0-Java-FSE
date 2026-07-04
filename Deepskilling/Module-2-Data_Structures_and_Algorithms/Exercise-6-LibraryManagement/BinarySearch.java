public class BinarySearch {

    public static Book search(Book[] books, String title) {

        int left = 0;
        int right = books.length - 1;

        while (left <= right) {

            int mid = (left + right) / 2;

            int compare = books[mid].title.compareToIgnoreCase(title);

            if (compare == 0)
                return books[mid];

            else if (compare < 0)
                left = mid + 1;

            else
                right = mid - 1;
        }

        return null;
    }
}