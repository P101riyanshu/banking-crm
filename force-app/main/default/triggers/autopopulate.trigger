trigger autopopulate on Contact (before insert){
    if (Trigger.isBefore && Trigger.isInsert){
        for(Contact con : Trigger.new){
            if(String.isBlank(con.Title)){
                con.Department = 'General';
            }else if(con.Title == 'Manager'){
                con.Department = 'Management';
            }else if(con.Title == 'Developer'){
                con.Department = 'IT';
            }else if(con.Title == 'Tester'){
                con.Department = 'QA';
            }else if(con.Title == 'HR'){
                con.Department = 'Human Resources';
            }
        }
    }
}