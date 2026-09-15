public class contactApexlogic {
    public static void updateMailingAddress(List<Contact> newContact){
        Set<Id> acclist = new Set<Id>();
        List<Contact> newcontactRecords = new List<Contact>();
        
        System.debug('check the list first: '+newcontactRecords);
        system.debug('check the list first: '+acclist);
        for(Contact con: newContact){
            if(con.AccountId!=null && String.isBlank(con.MailingCity)){
                accList.add(con.AccountId);
                newContactRecords.add(con);
            }
            system.debug('list of records stored '+con);
            system.debug('Account id store '+acclist);
            
        }
        if(accList.isEmpty()){
            return;
        }
        Map<Id,Account> newAccount = new Map<Id,Account>([Select id,BillingAddress From Account where Id In:accList]);
        
        for(Contact con:newContactRecords){
            Account newAcc = newAccount.get(con.AccountId);
            if(newAcc != null && newAcc.BillingAddress !=null){
                //con.MailingAddress = newAcc.BillingAddress;
            }
        }
    } 
}