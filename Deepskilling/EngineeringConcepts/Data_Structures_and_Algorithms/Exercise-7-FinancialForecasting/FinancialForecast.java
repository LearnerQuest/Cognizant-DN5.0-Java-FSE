public class FinancialForecast {

    public static double predict(double currentValue, double growthRate, int years) {

        if (years == 0)
            return currentValue;

        return predict(currentValue * (1 + growthRate), growthRate, years - 1);
    }
}