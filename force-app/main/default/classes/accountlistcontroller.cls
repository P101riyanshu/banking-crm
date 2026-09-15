public class accountlistcontroller {
    public list<Account> accountlist{get;set;}
    
    public accountlistcontroller(ApexPages.StandardController accvalue){
        this.accountlist=[select Id,name,Industry,AnnualRevenue,Phone from Account where Industry= 'Biotechnology' order by Name ASC limit 10];
        
    }
}