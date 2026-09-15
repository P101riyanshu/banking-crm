import { LightningElement, wire } from 'lwc';
import getBankAccountCount from '@salesforce/apex/CustomerCountController.getBankAccountCount';

export default class BankAccountCount extends LightningElement {
    accountCount = 0;

    @wire(getBankAccountCount)
    wiredAccounts({ data, error }) {
        if (data !== undefined) {
            this.accountCount = data;
        } else if (error) {
            console.error(error);
        }
    }
}