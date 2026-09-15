/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : CustomerCountController
 * Author          : <YourName>
 * Created Date    : Sep 2, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Sep 2, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Sep 2, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public with sharing class CustomerCountController {

    @AuraEnabled(cacheable=true)
    public static Integer getCustomerCount() {
        return [SELECT COUNT() FROM Customer__c];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getBankAccountCount() {
        return [SELECT COUNT() FROM Bank_Account__c];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getActiveLoanCount() {
        return [
            SELECT COUNT()
            FROM Loan__c
            WHERE Loan_Status__c = 'Active'
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getLoanApplicationCount() {
        return [SELECT COUNT() FROM Loan_Application__c];
    }

    @AuraEnabled(cacheable=true)
    public static Decimal getTotalLoanAmount() {
        AggregateResult result = [
            SELECT SUM(Loan_Amount__c) total
            FROM Loan__c
        ];

        if (result.get('total') == null) {
            return 0;
        }

        return (Decimal)result.get('total');
    }
}