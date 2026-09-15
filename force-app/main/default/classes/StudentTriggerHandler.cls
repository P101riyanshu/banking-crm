public class StudentTriggerHandler{
    public static void updateCourseCount(List<Student__c> newList,List<Student__c> oldList){
        Set<Id> courseIds = new Set<Id>();
        if (newList != null) {
            for (Student__c s : newList) {
                if (s.Course__c != null)
                    courseIds.add(s.Course__c);
            }
            System.debug('my coursestudentcount trigger is working');
        }
        if (oldList != null) {
            for (Student__c s : oldList) {
                if (s.Course__c != null)
                    courseIds.add(s.Course__c);
            }
        }
        Map<Id, Course__c> courses = new Map<Id, Course__c>(
            [SELECT Id, Enrolled_Student__c
             FROM Course__c
             WHERE Id IN :courseIds]
        );
        if (Trigger.isInsert) {
            for (Student__c s : newList) {
                if (s.Course__c != null) {
                    courses.get(s.Course__c).Enrolled_Student__c++;
                }
            }
        }
        if (Trigger.isDelete) {
            for (Student__c s : oldList) {
                if (s.Course__c != null &&
                    courses.get(s.Course__c).Enrolled_Student__c > 0) {

                    courses.get(s.Course__c).Enrolled_Student__c--;
                }
            }
        }
        if (Trigger.isUpdate) {
            for (Integer i = 0; i < newList.size(); i++) {
                if (newList[i].Course__c != oldList[i].Course__c) {
                    if (oldList[i].Course__c != null &&
                        courses.get(oldList[i].Course__c).Enrolled_Student__c > 0) {
                        courses.get(oldList[i].Course__c).Enrolled_Student__c--;
                    }
                    if (newList[i].Course__c != null) {
                        courses.get(newList[i].Course__c).Enrolled_Student__c++;
                    }
                }
            }
        }
        update courses.values();
    }
}