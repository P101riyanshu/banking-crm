public class customclass2 {
    String name;
    Integer phone;
    
    List<Contact> count= new list<Contact>();
    Map<Name,Contact> count2 = new Map<Name,Contact>();
    
    public static void Display(){
        List<Contact> newlist=[select Name,Phone,Email From Contact limit 5];
        for(Contact con:newlist){
            System.debug('Contact Name: '+con.Name);
            System.debug('Contact Phone NO.: '+con.Phone);
            System.debug('Contact Email: '+con.Email);
        }
    }   
}