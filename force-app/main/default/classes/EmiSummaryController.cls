public with sharing class EmiSummaryController {

    @AuraEnabled(cacheable=true)
    public static Loan__c getEmiSummary() {

        List<Loan__c> loans = [
            SELECT Id,
                   EMI_Amount__c,
                   Total_Payable_Amount__c,
                   Total_Interest__c,
                   Tenure__c
            FROM Loan__c
            LIMIT 1
        ];

        return loans.isEmpty() ? null : loans[0];
    }
}