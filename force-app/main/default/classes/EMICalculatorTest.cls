@IsTest
private class EMICalculatorTest {

    @IsTest
    static void testEMICalculation() {

        Decimal result = EMICalculator.calculateEMI(
            100000,
            10,
            12
        );

        System.assert(result > 0, 'EMI should be greater than zero');
    }

    @IsTest
    static void testZeroInterest() {

        Decimal result = EMICalculator.calculateEMI(
            120000,
            0,
            12
        );

        System.assertEquals(
            10000,
            result
        );
    }

    @IsTest
    static void testInvalidTenure() {

        Decimal result = EMICalculator.calculateEMI(
            100000,
            10,
            0
        );

        System.assertEquals(
            0,
            result
        );
    }
}