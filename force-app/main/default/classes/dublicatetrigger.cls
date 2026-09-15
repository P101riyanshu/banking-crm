public class dublicatetrigger{
    public static void findDuplicateEmail(List<Contact> newContacts){
        Set<String> emailSet = new Set<String>();
        Set<String> duplicateEmails = new Set<String>();
        for (Contact con : newContacts){
            if (con.Email != null){
                if (emailSet.contains(con.Email)) {
                    duplicateEmails.add(con.Email);
                }
                emailSet.add(con.Email);
            }
        }
        Map<String, Contact> existingEmailMap = new Map<String, Contact>();
        for (Contact con : [
            SELECT Id, Email
            FROM Contact
            WHERE Email IN :emailSet
        ]) {
            existingEmailMap.put(con.Email, con);
        }
        for (Contact con : newContacts) {
            if (con.Email != null &&
                (existingEmailMap.containsKey(con.Email) ||
                 duplicateEmails.contains(con.Email))) {
                con.Email.addError(
                    'A Contact with this email already exists.'
                );
            }
        }
    }
}