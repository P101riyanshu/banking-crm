import { LightningElement, wire } from 'lwc';
import getCustomerCount from '@salesforce/apex/CustomerCountController.getCustomerCount';

export default class CustomerCount extends LightningElement {
    customerCount = 0;

    @wire(getCustomerCount)
    wiredCount({ data, error }) {
        if (data !== undefined) {
            this.customerCount = data;
        } else if (error) {
            console.error(error);
        }
    }
}