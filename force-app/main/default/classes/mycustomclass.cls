public class mycustomclass {
    String name;
    Integer age;
    
    List<Account> markcount= new list<Account>();
    Map<Id,Account> newaccountmap = new Map<ID,Account>();
    
    public static void Display(){
        List<Account> newlist=[select Id,Name,AccountNumber From Account limit 5];
        for(Account acc:newlist){
            System.debug('Account Name: '+acc.Name);
            system.debug('Account number: '+acc.AccountNumber);
            
        }
    }   
}