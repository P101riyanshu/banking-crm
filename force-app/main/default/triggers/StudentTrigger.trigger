trigger StudentTrigger on Student__c (after insert,after update,after delete){
    StudentTriggerHandler.updateCourseCount(Trigger.new,Trigger.old);
}