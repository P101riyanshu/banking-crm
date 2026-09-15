public with sharing class AccountDetailController {

    @AuraEnabled(cacheable=true)
    public static Bank_Account__c getAccountDetails() {

        List<Bank_Account__c> accounts = [
            SELECT Id,
                   Account_Number__c,
                   Account_Type__c,
                   Balance__c,
                   Account_Status__c
            FROM Bank_Account__c
            LIMIT 1
        ];

        if (!accounts.isEmpty()) {
            return accounts[0];
        }

        return null;
    }
}