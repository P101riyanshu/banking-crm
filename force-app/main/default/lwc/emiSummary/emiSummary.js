import { LightningElement, wire } from 'lwc';
import getEmiSummary from '@salesforce/apex/EmiSummaryController.getEmiSummary';

export default class EmiSummary extends LightningElement {
    loan;
    error;

    @wire(getEmiSummary)
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