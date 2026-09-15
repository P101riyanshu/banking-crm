public class studentExtension{
    public Student__c student{get;set;}
    //public Course__c Course;
    public StudentExtension(ApexPages.StandardController sc){
        //student=(Student__c)controller.getRecord();
        //course=(Course__c)controller.getRecord();
         Id studentId = sc.getId();
        //student = [Select Id,Percentage__c,Course__c,Course__r.Duration__c from Student__c where Id = :controller.getId()];
               student = [SELECT Id, Name, Percentage__c,Course__r.Duration__c FROM Student__c WHERE Id = :studentId ];
    }
    public String getWelcomeMessage(){
        return 'Welcome to ABC Training Institute';
    }
    public String getGrade(){
        if(student.Percentage__c>=90)
            return ' Grade: A';
        else if(student.Percentage__c>=75)
            return 'Grade: B';
        else if(student.Percentage__c>=60)
            return 'Grade:C';
        else
            return 'Grade:D';
    }
    public String getScholarshipStatus(){
        if(student.Percentage__c>=85)
            return 'Scholarship: Eligible';
        return 'Scholarship: Not Eligible';
    }
    
    public String getCourseCategory() {
    if(student.Course__r.Duration__c > 8)
        return 'Advanced';
    return 'Standard';
    }
}