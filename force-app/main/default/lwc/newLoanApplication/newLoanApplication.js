import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateLoanApplication extends LightningElement {

    @api recordId;

    loanType = '';
    loanAmount = '';
    interestRate = '';
    tenure = '';
    purpose = '';

    loanTypeOptions = [
        { label: 'Personal Loan', value: 'Personal Loan' },
        { label: 'Home Loan', value: 'Home Loan' },
        { label: 'Vehicle Loan', value: 'Vehicle Loan' },
        { label: 'Education Loan', value: 'Education Loan' },
        { label: 'Business Loan', value: 'Business Loan' }
    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {

        const fields = {
            Customer_c__c: this.recordId,
            Loan_Amount__c: this.loanAmount,
            Interest_Rate__c: this.interestRate,
            Tenure__c: this.tenure,
            Purpose__c: this.purpose
        };

        const recordInput = {
            apiName: 'Loan_Application__c',
            fields
        };

        createRecord(recordInput)
            .then(() => {
                this.showToast('Success', 'Loan Application created successfully', 'success');
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
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}