import { LightningElement, wire } from 'lwc';
import getLoanDetails from '@salesforce/apex/LoanDetailController.getLoanDetails';

export default class LoanDetail extends LightningElement {
    loan;
    error;

    @wire(getLoanDetails)
    wiredLoan({ error, data }) {
        if (data) {
            this.loan = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.loan = undefined;
        }
    }
}