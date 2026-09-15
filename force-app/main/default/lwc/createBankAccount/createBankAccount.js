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
            Account_Number__c: Number(this.accountNumber),
            Balance__c: this.balance ? Number(this.balance) : 0,
            Opening_Date__c: this.openingDate,
            Account_Status__c: this.accountStatus
        };

        console.log('Record ID:', this.recordId);
        console.log('Fields:', JSON.stringify(fields));

        const recordInput = {
            apiName: 'Bank_Account__c',
            fields
        };

        createRecord(recordInput)
            .then(result => {

                console.log('SUCCESS:', result);

                this.showToast(
                    'Success',
                    'Bank Account created successfully.',
                    'success'
                );

                this.dispatchEvent(
                    new CloseActionScreenEvent()
                );
            })
            .catch(error => {

                console.error(
                    'FULL ERROR:',
                    JSON.stringify(error)
                );

                let errorMessage =
                    'An unknown error occurred.';

                if (error.body) {

                    if (Array.isArray(error.body)) {
                        errorMessage = error.body
                            .map(item => item.message)
                            .join(', ');
                    }
                    else if (error.body.message) {
                        errorMessage = error.body.message;
                    }
                    else if (error.body.output) {
                        errorMessage =
                            JSON.stringify(error.body.output);
                    }
                }

                this.showToast(
                    'Error',
                    errorMessage,
                    'error'
                );
            });
    }

    handleCancel() {
        this.dispatchEvent(
            new CloseActionScreenEvent()
        );
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