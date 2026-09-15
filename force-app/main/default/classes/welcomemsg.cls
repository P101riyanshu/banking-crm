public class welcomemsg {
    public static void createWelcomeTask(List<Contact>newContacts){
        List<Task>taskList = new List<Task>();
        for(Contact con : newContacts){
            Task t = new Task();
            t.Subject = 'Welcome Call';
            t.Status = 'Not Started';
            t.Priority = 'Normal';
            t.ActivityDate = Date.today().addDays(2);
            t.WhoId = con.Id;
            taskList.add(t);
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}