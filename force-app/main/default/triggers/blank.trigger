trigger blank on Account (before insert , before update) {
    for (account acc : Trigger.new) {
        if(String.isBlank(acc.Description)){
            acc.Description='new Account created';
        }
    }
}