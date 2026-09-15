trigger ContacafterTrigger on Contact (After update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            ContactAfterApex.emailUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}