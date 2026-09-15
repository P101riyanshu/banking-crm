public class contactcount{
    public static void updateTotalContacts(List<Contact>contactList){
        Set<Id>accountIds=new Set<Id>();
        for(Contact con : contactList){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        Map<Id, Account>accountMap=new Map<Id, Account>(
            [SELECT Id, Total_Contacts__c FROM Account WHERE Id IN :accountIds]
        );
        for(Contact con : contactList){
            Account acc = accountMap.get(con.AccountId);
            if(acc != null){
                if(acc.Total_Contacts__c == null){
                    acc.Total_Contacts__c = 0;
                }
                if(Trigger.isInsert){
                    acc.Total_Contacts__c++;
                }
                if(Trigger.isDelete){
                    acc.Total_Contacts__c--;
                }
            }
        }
        if(!accountMap.isEmpty()){
            update accountMap.values();
        }
    }
}