trigger TransactionTrigger on Transaction__c (
    after insert,
    after update,
    after delete,
    after undelete
) {
    TransactionHandler.updateBalances(
        Trigger.new,
        Trigger.oldMap
    );
}