import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateLoan extends LightningElement {

    @api recordId;

    loanAmount = '';
    interestRate = '';
    tenure = '';
    emiAmount = '';

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {

        const fields = {
            Loan_Application__c: this.recordId,
            Loan_Amount__c: this.loanAmount,
            Interest_Rate__c: this.interestRate,
            Tenure__c: this.tenure,
            EMI_Amount__c: this.emiAmount,
            Loan_Status__c: 'Active'
        };

        createRecord({
            apiName: 'Loan__c',
            fields
        })
            .then(() => {
                this.showToast('Success', 'Loan created successfully', 'success');
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