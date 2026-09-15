public with sharing class LoanApplicationHandler {

    public static void checkDuplicateApplications(
        List<Loan_Application__c> newApplications
    ) {
        Set<Id> customerIds = new Set<Id>();

        for (Loan_Application__c application : newApplications) {
            if (application.Customer_c__c != null) {
                customerIds.add(application.Customer_c__c);
            }
        }

        if (customerIds.isEmpty()) {
            return;
        }

        List<Loan_Application__c> existingApplications = [
            SELECT Id, Customer_c__c, Application_Status__c
            FROM Loan_Application__c
            WHERE Customer_c__c IN :customerIds
            AND Application_Status__c IN ('Pending', 'Active')
        ];

        Set<Id> blockedCustomerIds = new Set<Id>();

        for (Loan_Application__c existingApplication : existingApplications) {
            blockedCustomerIds.add(existingApplication.Customer_c__c);
        }

        for (Loan_Application__c application : newApplications) {
            if (
                application.Customer_c__c != null &&
                (application.Application_Status__c == 'Pending' ||
                 application.Application_Status__c == 'Active') &&
                blockedCustomerIds.contains(application.Customer_c__c)
            ) {
                application.addError(
                    'This customer already has an Active or Pending Loan Application.'
                );
            }
        }
    }
}