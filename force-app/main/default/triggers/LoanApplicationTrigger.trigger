trigger LoanApplicationTrigger on Loan_Application__c (after update) {

    LoanApplication.createLoan(
        Trigger.new,
        Trigger.oldMap
    );
}