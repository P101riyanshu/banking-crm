public class DuplicateRecordHandler {

    // ==========================================
    // CUSTOMER - DUPLICATE AADHAAR CHECK
    // ==========================================
    public static void checkDuplicateCustomers(
        List<Customer__c> customers
    ) {

        Set<Decimal> aadhaarNumbers = new Set<Decimal>();

        // Collect Aadhaar numbers
        for (Customer__c customer : customers) {

            if (customer.Aadhaar_Number__c != null) {
                aadhaarNumbers.add(
                    customer.Aadhaar_Number__c
                );
            }
        }

        if (aadhaarNumbers.isEmpty()) {
            return;
        }

        // Find existing customers
        Map<Decimal, Id> existingCustomers =
            new Map<Decimal, Id>();

        for (Customer__c customer : [
            SELECT Id, Aadhaar_Number__c
            FROM Customer__c
            WHERE Aadhaar_Number__c IN :aadhaarNumbers
        ]) {

            existingCustomers.put(
                customer.Aadhaar_Number__c,
                customer.Id
            );
        }

        // Check duplicates
        for (Customer__c customer : customers) {

            if (customer.Aadhaar_Number__c == null) {
                continue;
            }

            Decimal aadhaar =
                customer.Aadhaar_Number__c;

            if (existingCustomers.containsKey(aadhaar) &&
                existingCustomers.get(aadhaar) != customer.Id) {

                customer.Aadhaar_Number__c.addError(
                    'Duplicate Customer: This Aadhaar Number is already registered.'
                );
            }
        }
    }


    // ==========================================
    // BANK ACCOUNT - DUPLICATE ACCOUNT CHECK
    // ==========================================
    public static void checkDuplicateBankAccounts(
        List<Bank_Account__c> accounts
    ) {

        Set<Decimal> accountNumbers =
            new Set<Decimal>();

        // Collect Account Numbers
        for (Bank_Account__c account : accounts) {

            if (account.Account_Number__c != null) {

                accountNumbers.add(
                    account.Account_Number__c
                );
            }
        }

        if (accountNumbers.isEmpty()) {
            return;
        }

        // Find existing bank accounts
        Map<Decimal, Id> existingAccounts =
            new Map<Decimal, Id>();

        for (Bank_Account__c account : [
            SELECT Id, Account_Number__c
            FROM Bank_Account__c
            WHERE Account_Number__c IN :accountNumbers
        ]) {

            existingAccounts.put(
                account.Account_Number__c,
                account.Id
            );
        }

        // Check duplicates
        for (Bank_Account__c account : accounts) {

            if (account.Account_Number__c == null) {
                continue;
            }

            Decimal accountNumber =
                account.Account_Number__c;

            if (existingAccounts.containsKey(accountNumber) &&
                existingAccounts.get(accountNumber) != account.Id) {

                account.Account_Number__c.addError(
                    'Duplicate Bank Account: This Account Number already exists.'
                );
            }
        }
    }
}