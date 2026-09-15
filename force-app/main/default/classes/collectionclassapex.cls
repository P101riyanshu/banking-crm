public class collectionclassapex {
    public static void getAccounts(){
        //list of accounts ordered collection 
        List<Account> newAccount = new List<Account>();
        
        //Add account on the list
        Account acc1 = new Account(Name = 'Test Account');
        Account acc2 = new Account(Name = ' ABC Account');
        
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
            System.debug('First account in the list'+getFirstAccount.Name);
        }
        
        //get id from set of account
        if(!accountId.isEmpty()){
            Id firstId = new list<Id>(accountid)[0];
            System.debug('id of first account from set'+accountid.contains(firstId));
        }
        
        
        //map to find the specific account from list of records
        if(!accountmap.isEmpty()){
            Id mapId = accountmap.keySet().iterator().next();
            Account newmapAccount = accountmap.get(mapId);
            system.debug('retrive the account from map: '+newmapAccount.name);
        }
    }
}