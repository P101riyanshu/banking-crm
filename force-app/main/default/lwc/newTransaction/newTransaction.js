import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateTransaction extends LightningElement {

    @api recordId;

    transactionType = '';
    amount = '';
    description = '';

    transactionTypeOptions = [
        { label: 'Deposit', value: 'Deposit' },
        { label: 'Withdrawal', value: 'Withdrawal' },
        { label: 'Transfer', value: 'Transfer' },
        { label: 'Payment', value: 'Payment' }
    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {

        const fields = {
            Bank_Account__c: this.recordId,
            Transaction_Type__c: this.transactionType,
            Amount__c: this.amount,
            Transaction_Status__c: 'Completed',
            Description__c: this.description
        };

        createRecord({
            apiName: 'Transaction__c',
            fields
        })
            .then(() => {
                this.showToast('Success', 'Transaction created successfully', 'success');
                this.dispatchEvent(new CloseActionScreenEvent());
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleCancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({ title, message, variant })
        );
    }
}