trigger BankAccountDuplicateTrigger on Bank_Account__c (
    before insert,
    before update
) {

    DuplicateRecordHandler.checkDuplicateBankAccounts(
        Trigger.new
    );
}