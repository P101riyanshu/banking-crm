import { LightningElement, wire } from 'lwc';
import getCustomerDetails from '@salesforce/apex/CustomerDetailsController.getCustomerDetails';

export default class CustomerDetails extends LightningElement {
    customer;
    accountNumber;
    error;

    @wire(getCustomerDetails)
    wiredCustomer({ error, data }) {
        if (data) {
            this.customer = data.customer;
            this.accountNumber = data.accountNumber;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.customer = undefined;
        }
    }
}