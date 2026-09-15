public class employeerecord {
    public employee__c emp{get; set;}
    
    public employeerecord(){
        emp=new employee__c();
    }
    
    public Pagereference saveEmployee(){
        try{
            insert emp;  
            
            Pagereference pg = new ApexPages.StandardController(emp).view();
            pg.setRedirect(true);
            return pg;
        }
        Catch(Exception e){
            ApexPages.addMessages(e);
            return null;
        }
        
    }
}