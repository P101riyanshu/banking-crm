trigger contacttrigger on Contact (before insert) {
    If(Trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            contactApexlogic.updateMailingAddress(trigger.new);
        }
    }
}