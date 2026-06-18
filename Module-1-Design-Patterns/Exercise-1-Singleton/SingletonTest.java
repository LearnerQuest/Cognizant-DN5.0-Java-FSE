public class SingletonTest {
    public  static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        logger1.writelog("Firstmessage");
        Logger logger2 = Logger.getInstance();
        logger2.writelog("Second message");
        if(logger1 == logger2) {
            System.out.println("Logger1 and Logger2 refer to the same object.");
        } else {
            System.out.println("Different logger object were created.");
        }
    }
}


