// public with sharing class LoanApplication {

//     public static void createLoan(
//         List<Loan_Application__c> applications,
//         Map<Id, Loan_Application__c> oldMap
//     ) {

//         List<Loan__c> loansToCreate = new List<Loan__c>();

//         for (Loan_Application__c application : applications) {

//             // Check if application has just become Approved
//             if (
//                 application.Application_Status__c == 'Approved' &&
//                 oldMap.get(application.Id).Application_Status__c != 'Approved'
//             ) {

//                 Loan__c loan = new Loan__c();

//                 // Link Loan Application
//                 loan.Loan_Application__c = application.Id;

//                 // Link Customer
//                 loan.Customer_c__c = application.Customer_c__c;

//                 // Copy Loan Amount
//                 loan.Loan_Amount__c = application.Loan_Amount__c;

//                 // Set initial Outstanding Amount
//                 loan.Outstanding_Amount__c =
//                     application.Loan_Amount__c;

//                 // Set Loan Status
//                 loan.Loan_Status__c = 'Active';

//                 loansToCreate.add(loan);
//             }
//         }

//         if (!loansToCreate.isEmpty()) {
//             insert loansToCreate;
//         }
//     }
// }





public with sharing class LoanApplication {

    public static void createLoan(
        List<Loan_Application__c> applications,
        Map<Id, Loan_Application__c> oldMap
    ) {

        List<Loan__c> loansToCreate = new List<Loan__c>();

        Set<Id> customerIds = new Set<Id>();

        // Find newly approved applications
        for (Loan_Application__c app : applications) {

            if (
                app.Application_Status__c == 'Approved' &&
                oldMap.get(app.Id).Application_Status__c != 'Approved'
            ) {
                if (app.Customer_c__c != null) {
                    customerIds.add(app.Customer_c__c);
                }
            }
        }

        // Get customer names
        Map<Id, Customer__c> customerMap =
            new Map<Id, Customer__c>();

        if (!customerIds.isEmpty()) {
            customerMap = new Map<Id, Customer__c>([
                SELECT Id, Name
                FROM Customer__c
                WHERE Id IN :customerIds
            ]);
        }

        // Create Loan
        for (Loan_Application__c app : applications) {

            if (
                app.Application_Status__c == 'Approved' &&
                oldMap.get(app.Id).Application_Status__c != 'Approved'
            ) {

                Loan__c loan = new Loan__c();

                // Loan Name = Customer Name
                if (
                    app.Customer_c__c != null &&
                    customerMap.containsKey(app.Customer_c__c)
                ) {
                    loan.Name =
                        customerMap.get(app.Customer_c__c).Name;
                }

                // Customer
                loan.Customer_c__c = app.Customer_c__c;

                // Loan Application
                loan.Loan_Application__c = app.Id;

                // Loan Amount
                loan.Loan_Amount__c = app.Loan_Amount__c;

                // Interest Rate
                loan.Interest_Rate__c = app.Interest_Rate__c;

                // Tenure
                loan.Tenure__c = app.Tenure__c;

                // Loan Type
                loan.Loan_Type__c = app.Loan_Type__c;

                /*
                 * START DATE
                 * Date on which loan is approved.
                 */
                Date startDate = Date.today();

                loan.Start_Date__c = startDate;

                /*
                 * END DATE
                 * Start Date + Tenure months.
                 */
                if (app.Tenure__c != null) {

                    loan.End_Date__c =
                        startDate.addMonths(
                            Integer.valueOf(app.Tenure__c)
                        );
                }

                // Initial Outstanding Amount
                loan.Outstanding_Amount__c =
                    app.Loan_Amount__c;

                // Loan Status
                loan.Loan_Status__c = 'Active';

                loansToCreate.add(loan);
            }
        }

        // Insert Loans
        if (!loansToCreate.isEmpty()) {
            insert loansToCreate;
        }
    }
}