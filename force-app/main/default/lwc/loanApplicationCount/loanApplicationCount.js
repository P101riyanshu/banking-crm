import { LightningElement, wire } from 'lwc';
import getLoanApplicationCount from '@salesforce/apex/CustomerCountController.getLoanApplicationCount';

export default class LoanApplicationCount extends LightningElement {
    applicationCount = 0;

    @wire(getLoanApplicationCount)
    wiredApplications({ data, error }) {
        if (data !== undefined) {
            this.applicationCount = data;
        } else if (error) {
            console.error(error);
        }
    }
}