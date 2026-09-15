public class StudentDashboardController {

    public List<Student__c> students {get;set;}
    public String searchText {get;set;}
    public Boolean qualifiedOnly {get;set;}

    public StudentDashboardController(){
        loadStudents();
    }

    public void loadStudents(){

        String query='SELECT Id, Name, Percentage__c, Status__c, Course__r.Name FROM Student__c';

        List<String> conditions = new List<String>();

        if(searchText!=null && searchText!=''){
            conditions.add('Name LIKE \'%'+String.escapeSingleQuotes(searchText)+'%\'');
        }

        if(qualifiedOnly==true){
            conditions.add('Percentage__c >= 60');
        }

        if(!conditions.isEmpty()){
            query += ' WHERE '+String.join(conditions,' AND ');
        }

        students=Database.query(query);
    }

    public void search(){
        loadStudents();
    }

    public void resetFilter(){
        searchText='';
        qualifiedOnly=false;
        loadStudents();
    }

    public Integer getTotalStudents(){
        return [SELECT COUNT() FROM Student__c];
    }

    public Integer getQualifiedStudents(){
        return [SELECT COUNT() FROM Student__c WHERE Percentage__c>=60];
    }

    public Decimal getAveragePercentage(){
        AggregateResult ar=[SELECT AVG(Percentage__c) avgPer FROM Student__c];
        return (Decimal)ar.get('avgPer');
    }

    public Integer getScholarshipStudents(){
        return [SELECT COUNT() FROM Student__c WHERE Percentage__c>=85];
    }

    public String getGrade(Student__c s){

        if(s.Percentage__c>=90) return 'A';
        if(s.Percentage__c>=75) return 'B';
        if(s.Percentage__c>=60) return 'C';

        return 'D';
    }

}