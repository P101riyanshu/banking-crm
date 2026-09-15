public class CustomStudentController{
    public String selectedCourseId{get;set;}
    public Course__c selectedCourse{get;set;}
    public List<SelectOption> courseOptions {get;set;}
    public CustomStudentController(){
        courseOptions = new List<SelectOption>();
        for(Course__c c :[SELECT Id, Name FROM Course__c]){
            courseOptions.add(
                new SelectOption(c.Id, c.Name)
            );
        }
    }
    public PageReference showCourse(){
        selectedCourse = [SELECT Fee__c, Duration__c FROM Course__c WHERE Id = :selectedCourseId];
        return null;
    }
    public PageReference registerStudent(){
        ApexPages.addMessage(
            new ApexPages.Message(
                ApexPages.Severity.CONFIRM,
                'Student successfully registered.'
            )
        );
        return null;
    }

}