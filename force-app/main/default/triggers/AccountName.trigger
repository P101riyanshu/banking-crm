trigger AccountName on Account (after insert, after update) {
    Set<id> sid = new Set<id>();
    System.debug('value store in set: '+sid);
    List<Contact> conLst = new List<Contact>();
    System.debug('value store in List: '+conlst);
    for(Account act:Trigger.new){
        System.debug('value store in trigger.new: '+act);
        sid.add(act.Id);
    }
    System.debug('Account unique id stored in set: '+sid);
    Map<Id, Account> accLst = new Map<Id, Account>([select Id, Profile__c, (select Id, Profile__c from Contacts) from Account where id In:sid]);
    for(Account a:Trigger.new)
    {
        List<Contact> con = accLst.get(a.id).contacts;
        for(Contact c:con){
            c.Profile__c=a.Profile__c;
            conLst.add(c);
            system.debug('Profile name is Contact: '+c.Profile__c);
        }
        system.debug('values stored in contact list with profile matching with account'+conlst);
    }
    update conlst;
    system.debug('update list in contact: '+conlst);
}