import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreateServiceRequest extends LightningElement {

    @api recordId;

    requestType = '';
    description = '';
    priority = 'Medium';

    requestTypeOptions = [
        { label: 'Account Service', value: 'Account Service' },
        { label: 'Card Service', value: 'Card Service' },
        { label: 'Loan Service', value: 'Loan Service' },
        { label: 'General Request', value: 'General Request' }
    ];

    priorityOptions = [
        { label: 'Low', value: 'Low' },
        { label: 'Medium', value: 'Medium' },
        { label: 'High', value: 'High' }
    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleSave() {

        const fields = {
            Customer__c: this.recordId,
            Request_Type__c: this.requestType,
            Description__c: this.description,
            Priority__c: this.priority,
            Status__c: 'Open'
        };

        createRecord({
            apiName: 'Service_Request__c',
            fields
        })
            .then(() => {
                this.showToast('Success', 'Service Request created successfully', 'success');
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