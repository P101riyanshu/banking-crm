trigger ContactBeforeInsert on Contact (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        ContactTriggerHandler.checkDuplicateEmail(Trigger.new);
    }

}