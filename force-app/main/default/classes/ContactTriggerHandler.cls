public class ContactTriggerHandler {

    public static void checkDuplicateEmail(List<Contact> newContacts){
        Set<String> emailSet = new Set<String>();
        for(Contact con : newContacts){
            if(con.Email != null){
                emailSet.add(con.Email);
            }
        }
        Set<String> existingEmails = new Set<String>();
        for(Contact con : [
            SELECT Id, Email
            FROM Contact
            WHERE Email IN :emailSet
        ]){
            existingEmails.add(con.Email);
        }
        for(Contact con : newContacts){
            if(existingEmails.contains(con.Email)){
                con.addError('Contact with this email already exists.');
            }
        }

    }

}