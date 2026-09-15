trigger checkdublicateemail on Contact (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        dublicatetrigger.findDuplicateEmail(Trigger.new);
    }
}