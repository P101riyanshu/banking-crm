import { LightningElement, wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountDetailController.getAccountDetails';

export default class AccountDetail extends LightningElement {
    account;
    error;

    @wire(getAccountDetails)
    wiredAccount({ error, data }) {
        if (data) {
            this.account = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.account = undefined;
        }
    }
}