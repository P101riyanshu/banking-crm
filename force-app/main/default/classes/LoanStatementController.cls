/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : LoanStatementController
 * Author          : <YourName>
 * Created Date    : Aug 24, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Aug 24, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Aug 24, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */
public with sharing class LoanStatementController {

    public Loan__c loan { get; set; }

    public LoanStatementController() {
        Id loanId = ApexPages.currentPage().getParameters().get('id');

        if (loanId != null) {
            loan = [
                SELECT Id,
                       Name,
                       Customer_c__r.Name,
                       Loan_Amount__c,
                       Interest_Rate__c,
                       Tenure__c,
                       EMI_Amount__c,
                       Total_Payable_Amount__c,
                       Total_Interest__c,
                       Loan_Status__c,
                       Start_Date__c,
                       End_Date__c
                FROM Loan__c
                WHERE Id = :loanId
                LIMIT 1
            ];
        }
    }
}