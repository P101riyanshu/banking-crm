import { LightningElement, wire } from 'lwc';

import bankingLogo from '@salesforce/resourceUrl/bankingLogo';
import USER_NAME from '@salesforce/schema/User.Name';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';

export default class BankingHeader extends LightningElement {

    logoUrl = bankingLogo;
    userId = Id;
    userName = '';
    greeting = '';

    @wire(getRecord, {
        recordId: '$userId',
        fields: [USER_NAME]
    })
    userRecord({ data, error }) {
        if (data) {
            this.userName = data.fields.Name.value;
        } else if (error) {
            console.error('Error loading user:', error);
        }
    }

    connectedCallback() {
        const hour = new Date().getHours();

        if (hour < 12) {
            this.greeting = 'Good morning';
        } else if (hour < 17) {
            this.greeting = 'Good afternoon';
        } else {
            this.greeting = 'Good evening';
        }
    }
}