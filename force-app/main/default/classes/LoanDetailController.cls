public with sharing class LoanDetailController {

    @AuraEnabled(cacheable=true)
    public static Loan__c getLoanDetails() {

        List<Loan__c> loans = [
            SELECT Id,
                   Loan_Amount__c,
                   Interest_Rate__c,
                   Tenure__c,
                   Loan_Status__c
            FROM Loan__c
            LIMIT 1
        ];

        if (!loans.isEmpty()) {
            return loans[0];
        }

        return null;
    }
}