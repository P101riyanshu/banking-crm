public class collectionnewapexclass {
    public static void getdetails(){
        //list of accounts ordered collection 
        List<Account> newAccount = new List<Account>();
        
        //Add account on the list
        Account acc1 = new Account(Name = 'Test Account',alt_email__C='test@gmail.com', YearStarted='2005');
        Account acc2 = new Account(Name = ' ABC Account',alt_email__C='abc@gamil.com', YearStarted='2010' );
        
        //Add Account into the list
        newAccount.add(acc1);
        newAccount.add(acc2);
        
        //set unordered collection of unique Element 
        Set<Id> accountId = new set<Id>();
        if(accountId!=null){
            for(Account acc:newAccount){
                accountId.add(acc.Id);
            }
        }
        
        //map collection of key value pair
        Map<Id,Account> accountmap = new Map<Id,Account>();
        
        //Iternate over Map for uniquely find account
        for(Account acc: newAccount){
            accountmap.put(acc.id,acc);
        }
        
        //reading data from list by using index
        if(!newAccount.isEmpty()){
            Account getFirstAccount = newAccount.get(0);
            Account getSecondAccount = newAccount.get(1);
            System.debug('First account in the list: '+getFirstAccount.Name);
            System.debug('First account in the list: '+getFirstAccount.alt_email__c);
            System.debug('First account in the list: '+getFirstAccount.YearStarted);
            System.debug('second account in the list: '+getSecondAccount.Name);
            System.debug('second account in the list: '+getSecondAccount.alt_email__c);
            System.debug('second account in the list: '+getSecondAccount.YearStarted);
        }
        
        //get id from set of account
        if(!accountId.isEmpty()){
            Id firstId = new list<Id>(accountid)[0];
            Id SecondId = new list<Id>(accountid)[1];
            System.debug('id of first account from set'+accountid.contains(firstId));
            System.debug('id of first account from set'+accountid.contains(SecondId));
        }
        
        
        //map to find the specific account from list of records
        if(!accountmap.isEmpty()){
            Id mapId = accountmap.keySet().iterator().next();
            Account newmapAccount = accountmap.get(mapId);
            system.debug('retrive the account from map: '+newmapAccount.name);
            system.debug('retrive the account from map: '+newmapAccount.alt_email__c);
            system.debug('retrive the account from map: '+newmapAccount.yearStarted);
        }
    }
}