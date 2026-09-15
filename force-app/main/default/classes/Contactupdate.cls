public class Contactupdate {
    public static void accountnumberUpdate(List<contact> newcontact , Map<Id,Contact> mapContact){
        Set<Id> accountnumber = new Set<Id>();
        Map<Id,Decimal> oldnumber  = new Map<Id,Decimal>();
        
        System.debug('create new set :'+accountnumber);
        System.debug('create new map: '+oldnumber);
        
        For(Contact con:newcontact){
            Contact oldContact = mapContact.get(con.Id);
            if(con.contactaccountnumber__c!=null && con.contactaccountnumber__c!=oldContact.contactaccountnumber__c){
                accountnumber.add(con.Id);
                oldnumber.put(con.Id, oldContact.contactaccountnumber__c);
                System.debug('Accountnumber is updated');
            }
        }
        List<Contact> contactToUpdate = new List<Contact>();
        for(Contact con : newcontact){
            if(accountnumber.contains(con.Id)){
                Contact updateCon = new Contact();
                updateCon.Id = con.Id;
                updateCon.ContactAccountNumber__c = con.ContactAccountNumber__c;
                contactToUpdate.add(updateCon);
                System.debug('account number is added');
            }}
        system.debug('trigger work is complete');
    }
}