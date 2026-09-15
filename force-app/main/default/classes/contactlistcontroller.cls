public class contactlistcontroller {
    public list<Contact> contactlist{get;set;}
    
    public contactlistcontroller(ApexPages.StandardController convalue){
        this.contactlist=[SELECT Id, Name, Birthdate, Email, Phone FROM Contact limit 10]; 
    }
}