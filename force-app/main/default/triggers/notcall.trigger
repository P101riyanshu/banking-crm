trigger notcall on Contact (before insert, before update) {
    for(Contact con : Trigger.new) {
        if(con.LeadSource == 'Web') {
            con.donotcall__c = true;
        }
    }
}