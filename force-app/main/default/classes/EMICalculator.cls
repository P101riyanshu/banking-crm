public class EMICalculator {

    public static Decimal calculateEMI(
        Decimal loanAmount,
        Decimal annualInterestRate,
        Integer tenureMonths
    ) {
        // Validate input
        if (loanAmount == null || tenureMonths == null || tenureMonths <= 0) {
            return 0;
        }

        // Zero interest loan
        if (annualInterestRate == null || annualInterestRate == 0) {
            return (loanAmount / tenureMonths).setScale(2);
        }

        // Monthly interest rate
        Decimal monthlyRate = annualInterestRate / 12 / 100;

        // EMI calculation
        Double powerValue = Math.pow(
            1 + Double.valueOf(monthlyRate),
            tenureMonths
        );

        Decimal emi =
            loanAmount * monthlyRate * Decimal.valueOf(powerValue) /
            (Decimal.valueOf(powerValue) - 1);

        return emi.setScale(2);
    }
}