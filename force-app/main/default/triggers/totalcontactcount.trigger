trigger totalcontactcount on Contact (before insert) {
    if (Trigger.isInsert) {
        contactcount.updateTotalContacts(Trigger.new);
    }
    if (Trigger.isDelete) {
        contactcount.updateTotalContacts(Trigger.old);
    }
}