public with sharing class CustomerDetailsController {

    @AuraEnabled(cacheable=true)
    public static CustomerData getCustomerDetails() {

        Customer__c customer = [
            SELECT Id,
                   Name,
                   Email__c,
                   Phone__c,
                   Address__c,
                   Customer_Status__c
            FROM Customer__c
            LIMIT 1
        ];

        List<Bank_Account__c> accounts = [
            SELECT Account_Number__c
            FROM Bank_Account__c
            WHERE Customer_c__c = :customer.Id
            LIMIT 1
        ];

        CustomerData result = new CustomerData();
        result.customer = customer;

        if (!accounts.isEmpty()) {
            result.accountNumber = accounts[0].Account_Number__c;
        }

        return result;
    }

    public class CustomerData {

        @AuraEnabled
        public Customer__c customer;

        @AuraEnabled
        public Decimal accountNumber;
    }
}