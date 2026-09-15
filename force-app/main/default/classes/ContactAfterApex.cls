public class ContactAfterApex {
    public static void emailUpdate(List<contact> newcontact , Map<Id,Contact> mapContact){
        Set<Id> newEmailContact = new Set<Id>();
        Map<Id,String> oldMapEmailContact = new Map<Id,String>();
        
        System.debug('create new set :'+newEmailContact);
        System.debug('create new map: '+oldMapEmailContact);
        
        For(Contact con:newcontact){
            Contact oldContact = mapContact.get(con.Id);
            if(con.Email!=null && con.Email!=oldContact.Email){
                newEmailContact.add(con.Id);
                oldMapEmailContact.put(con.Id, oldContact.Email);
                System.debug('email is updated');
            }
        }
        List<Case> newcase = new List<Case>();
        List<case> relatedCases =[Select id,ContactId,ContactEmail from Case where Id In:newEmailContact];
        
        for(case c:relatedCases){
                if(oldMapEmailContact.containskey(c.ContactId)){
                    newCase.add(c);
                }
            }
        if(!relatedCases.isEmpty()){
            update relatedCases;
        }
        
    }
}