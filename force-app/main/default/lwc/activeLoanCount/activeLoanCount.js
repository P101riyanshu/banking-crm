import { LightningElement, wire } from 'lwc';
import getActiveLoanCount from '@salesforce/apex/CustomerCountController.getActiveLoanCount';

export default class ActiveLoanCount extends LightningElement {
    loanCount = 0;

    @wire(getActiveLoanCount)
    wiredLoans({ data, error }) {
        if (data !== undefined) {
            this.loanCount = data;
        } else if (error) {
            console.error(error);
        }
    }
}