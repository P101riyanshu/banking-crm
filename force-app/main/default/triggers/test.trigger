trigger test on Account (before insert) {
for(Account acc: Trigger.new){
                acc.AnnualRevenue=10000;
                
        }
System.debug('Trigger is working');
}