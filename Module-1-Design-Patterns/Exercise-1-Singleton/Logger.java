public class Logger {
  private static volatile Logger instance;

  private Logger() {
    System.out.println("Logger intialized sucessfully.");
   }

   public static Logger getInstance() {
      if (instance == null) {
         synchronized (Logger.class) {
            if (instance == null) {
               instance = new Logger();
            }
         }
      }
      return instance;
   }

  public void writelog(String message) {
      System.out.println("[LOG] " + java.time.LocalTime.now() + " - " + message);
   }
}