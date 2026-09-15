/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : TransactionHandler
 * Author          : <YourName>
 * Created Date    : Sep 3, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Sep 3, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Sep 3, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */




public with sharing class TransactionHandler {

    public static void updateBalances(
        List<Transaction__c> newTransactions,
        Map<Id, Transaction__c> oldTransactions
    ) {

        // Stores balance changes for each Bank Account
        Map<Id, Decimal> accountChanges = new Map<Id, Decimal>();

        // Stores outstanding amount changes for each Loan
        Map<Id, Decimal> loanChanges = new Map<Id, Decimal>();


        /*
         * STEP 1
         * Reverse the OLD transaction effect.
         *
         * Important for:
         * - Update
         * - Delete
         */
        if (oldTransactions != null) {

            for (Transaction__c txn : oldTransactions.values()) {

                applyTransactionEffect(
                    txn,
                    accountChanges,
                    loanChanges,
                    -1
                );
            }
        }


        /*
         * STEP 2
         * Apply the NEW transaction effect.
         *
         * Important for:
         * - Insert
         * - Update
         * - Undelete
         */
        if (newTransactions != null) {

            for (Transaction__c txn : newTransactions) {

                applyTransactionEffect(
                    txn,
                    accountChanges,
                    loanChanges,
                    1
                );
            }
        }


        /*
         * STEP 3
         * Update Bank Account balances
         */
        updateBankAccountBalances(accountChanges);


        /*
         * STEP 4
         * Update Loan outstanding amounts
         */
        updateLoanOutstandingAmounts(loanChanges);
    }


    /*
     * Determines how one transaction affects
     * Bank Account and Loan.
     */
    private static void applyTransactionEffect(
        Transaction__c txn,
        Map<Id, Decimal> accountChanges,
        Map<Id, Decimal> loanChanges,
        Decimal multiplier
    ) {

        // Ignore invalid transactions
        if (txn == null) {
            return;
        }

        // Only Completed transactions affect balances
        if (txn.Transaction_Status__c != 'Completed') {
            return;
        }

        // Ignore transactions without amount
        if (txn.Amount__c == null) {
            return;
        }

        Decimal amount = txn.Amount__c;


        /*
         * ==============================
         * BANK ACCOUNT BALANCE
         * ==============================
         */

        if (txn.Bank_Account__c != null) {

            // Deposit increases account balance
            if (txn.Transaction_Type__c == 'Deposit') {

                addChange(
                    accountChanges,
                    txn.Bank_Account__c,
                    amount * multiplier
                );
            }


            // Withdrawal decreases account balance
            else if (txn.Transaction_Type__c == 'Withdrawal') {

                addChange(
                    accountChanges,
                    txn.Bank_Account__c,
                    -amount * multiplier
                );
            }


            // EMI Payment decreases account balance
            else if (txn.Transaction_Type__c == 'EMI Payment') {

                addChange(
                    accountChanges,
                    txn.Bank_Account__c,
                    -amount * multiplier
                );
            }
        }


        /*
         * ==============================
         * LOAN OUTSTANDING AMOUNT
         * ==============================
         */

        // EMI payment reduces outstanding loan amount
        if (txn.Loan__c != null &&
            txn.Transaction_Type__c == 'EMI Payment') {

            addChange(
                loanChanges,
                txn.Loan__c,
                -amount * multiplier
            );
        }
    }


    /*
     * Add a balance change to a Map.
     * This makes the trigger bulkified.
     */
    private static void addChange(
        Map<Id, Decimal> changes,
        Id recordId,
        Decimal amount
    ) {

        if (!changes.containsKey(recordId)) {

            changes.put(recordId, 0);
        }

        changes.put(
            recordId,
            changes.get(recordId) + amount
        );
    }


    /*
     * Update Bank Account Balance__c
     */
    private static void updateBankAccountBalances(
        Map<Id, Decimal> changes
    ) {

        if (changes.isEmpty()) {
            return;
        }


        List<Bank_Account__c> accounts = [
            SELECT Id, Balance__c
            FROM Bank_Account__c
            WHERE Id IN :changes.keySet()
            FOR UPDATE
        ];


        for (Bank_Account__c account : accounts) {

            Decimal currentBalance =
                account.Balance__c == null
                ? 0
                : account.Balance__c;


            account.Balance__c =
                currentBalance + changes.get(account.Id);
        }


        if (!accounts.isEmpty()) {
            update accounts;
        }
    }


    /*
     * Update Loan Outstanding_Amount__c
     */
    private static void updateLoanOutstandingAmounts(
        Map<Id, Decimal> changes
    ) {

        if (changes.isEmpty()) {
            return;
        }


        List<Loan__c> loans = [
            SELECT Id, Outstanding_Amount__c
            FROM Loan__c
            WHERE Id IN :changes.keySet()
            FOR UPDATE
        ];


        for (Loan__c loan : loans) {

            Decimal outstandingAmount =
                loan.Outstanding_Amount__c == null
                ? 0
                : loan.Outstanding_Amount__c;


            loan.Outstanding_Amount__c =
                outstandingAmount + changes.get(loan.Id);
        }


        if (!loans.isEmpty()) {
            update loans;
        }
    }
}