trigger CustomerDuplicateTrigger on Customer__c (
    before insert,
    before update
) {

    DuplicateRecordHandler.checkDuplicateCustomers(
        Trigger.new
    );
}