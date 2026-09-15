trigger welcomemsg on Contact (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        welcomemsg.createWelcomeTask(Trigger.new);
    }
}