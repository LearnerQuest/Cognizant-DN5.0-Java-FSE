public class ProxyPatternTest {

    public static void main(String[] args) {

        Image image = new ProxyImage("profile_photo.jpg");

        System.out.println("Image object created, but image is not loaded yet.");

        image.display();

        System.out.println();

        image.display();
    }
}