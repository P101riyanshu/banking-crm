import { LightningElement, wire } from 'lwc';
import getTotalLoanAmount from '@salesforce/apex/CustomerCountController.getTotalLoanAmount';

export default class TotalLoanAmount extends LightningElement {
    loanAmount = 0;

    @wire(getTotalLoanAmount)
    wiredAmount({ data, error }) {
        if (data !== undefined) {
            this.loanAmount = data;
        } else if (error) {
            console.error(error);
        }
    }
}