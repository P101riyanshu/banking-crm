import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateBankAccount extends LightningElement {

    @api recordId;

    handleSubmit(event) {

        event.preventDefault();

        const fields = event.detail.fields;

        // Automatically connect the new Bank Account
        // to the current Customer record
        fields.Customer_c__c = this.recordId;

        this.template
            .querySelector('lightning-record-edit-form')
            .submit(fields);
    }

    handleSuccess() {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Bank Account created successfully.',
                variant: 'success'
            })
        );

        this.dispatchEvent(
            new CloseActionScreenEvent()
        );
    }

    handleError(event) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: event.detail.message,
                variant: 'error'
            })
        );
    }

    handleCancel() {

        this.dispatchEvent(
            new CloseActionScreenEvent()
        );
    }
}