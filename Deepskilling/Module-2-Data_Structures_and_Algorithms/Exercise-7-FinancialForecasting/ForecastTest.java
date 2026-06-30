import java.util.Scanner;

public class ForecastTest {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Current Value: ");
        double current = sc.nextDouble();

        System.out.print("Growth Rate (example 0.10): ");
        double rate = sc.nextDouble();

        System.out.print("Years: ");
        int years = sc.nextInt();

        double future = FinancialForecast.predict(current, rate, years);

        System.out.printf("Future Value = %.2f", future);

        sc.close();
    }
}