public with sharing class TotalLoansController {

    @AuraEnabled(cacheable=true)
    public static Integer getTotalLoans() {
        return [SELECT COUNT() FROM Loan__c];
    }
}