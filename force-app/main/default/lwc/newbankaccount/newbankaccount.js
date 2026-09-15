import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateBankAccount extends LightningElement {

    @api recordId;

    accountType = '';
    accountNumber = '';
    balance = '';
    openingDate = '';
    accountStatus = 'Active';

    accountTypeOptions = [
        { label: 'Savings Account', value: 'Savings Account' },
        { label: 'Current Account', value: 'Current Account' },
        { label: 'Fixed Deposit Account', value: 'Fixed Deposit Account' },
        { label: 'Salary Account', value: 'Salary Account' }
    ];

    statusOptions = [
        { label: 'Active', value: 'Active' },
        { label: 'Inactive', value: 'Inactive' }
    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {

        if (!this.accountType || !this.accountNumber || !this.openingDate) {
            this.showToast(
                'Error',
                'Please fill all required fields.',
                'error'
            );
            return;
        }

        const fields = {
            Name: this.accountNumber,
            Customer_c__c: this.recordId,
            Account_Type__c: this.accountType,
            Account_Number__c: this.accountNumber,
            Balance__c: this.balance,
            Opening_Date__c: this.openingDate,
            Account_Status__c: this.accountStatus
        };

        const recordInput = {
            apiName: 'Bank_Account__c',
            fields: fields
        };

        createRecord(recordInput)
            .then(() => {
                this.showToast(
                    'Success',
                    'Bank Account created successfully.',
                    'success'
                );

                this.dispatchEvent(new CloseActionScreenEvent());
            })
            .catch(error => {
                this.showToast(
                    'Error',
                    error.body?.message || 'An error occurred while creating the account.',
                    'error'
                );
            });
    }

    handleCancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}