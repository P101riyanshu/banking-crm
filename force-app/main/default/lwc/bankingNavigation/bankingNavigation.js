// import { LightningElement } from 'lwc';
// import { NavigationMixin } from 'lightning/navigation';

// export default class BankingNavigation extends NavigationMixin(LightningElement) {

//     showEMI = false;

//     // Toggle EMI Calculator
//     showEMICalculator() {
//         this.showEMI = !this.showEMI;
//     }

//     // Navigate to Customers
//     openCustomers() {
//         this.navigateToObject('Customer__c');
//     }

//     // Navigate to Bank Accounts
//     openBankAccounts() {
//         this.navigateToObject('Bank_Account__c');
//     }

//     // Navigate to Loan Applications
//     openLoanApplications() {
//         this.navigateToObject('Loan_Application__c');
//     }

//     // Navigate to Loans
//     openLoans() {
//         this.navigateToObject('Loan__c');
//     }

//     // Navigate to Transactions
//     openTransactions() {
//         this.navigateToObject('Transaction__c');
//     }

//     // Navigate to Service Requests
//     openServiceRequests() {
//         this.navigateToObject('Service_Request__c');
//     }



//     openDashboard() {

//         const dashboardId = 'YOUR_DASHBOARD_ID';

//         this[NavigationMixin.Navigate]({
//             type: 'standard__webPage',
//             attributes: {
//                 url: `/lightning/r/Dashboard/${dashboardId}/view`
//             }
//         });
//     }






//     // Common navigation method
//     navigateToObject(objectApiName) {
//         this[NavigationMixin.Navigate]({
//             type: 'standard__objectPage',
//             attributes: {
//                 objectApiName: objectApiName,
//                 actionName: 'list'
//             }
//         });
//     }
// }



























import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class BankingNavigation extends NavigationMixin(LightningElement) {

    showEMI = false;

    // EMI Calculator - open / close
    toggleEMI() {
        this.showEMI = !this.showEMI;
    }

    // Customers
    openCustomers() {
        this.navigateToObject('Customer__c');
    }

    // Bank Accounts
    openBankAccounts() {
        this.navigateToObject('Bank_Account__c');
    }

    // Loan Applications
    openLoanApplications() {
        this.navigateToObject('Loan_Application__c');
    }

    // Loans
    openLoans() {
        this.navigateToObject('Loan__c');
    }

    // Transactions
    openTransactions() {
        this.navigateToObject('Transaction__c');
    }

    // Service Requests
    openServiceRequests() {
        this.navigateToObject('Service_Request__c');
    }

    // Banking Analytics Dashboard
    openDashboard() {

        const dashboardId = '01Zg5000004f0L7EAI';

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: dashboardId,
                objectApiName: 'Dashboard',
                actionName: 'view'
            }
        });
    }

    // Common object navigation
    navigateToObject(objectApiName) {

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: objectApiName,
                actionName: 'list'
            }
        });
    }
}