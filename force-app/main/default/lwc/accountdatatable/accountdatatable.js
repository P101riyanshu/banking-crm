// import { LightningElement,track,wire} from 'lwc';
// import { gql, graphql, refreshGraphQL } from 'lightning/uiGraphQLApi';
// import { getListRecordbyName} from 'ligthning/uListApi';
// import CONTACT_OBJECT from '@salesforce/schema/Contact';
// const COLUMNS = [
//     { label: 'firstname', fieldName: 'FirstName', type: 'text' },
//     { label: 'lastname', fieldName: 'LastName', type: 'text' },
//     { label: 'phone', fieldName: 'Phone', type: 'phone' },
//     { label: 'title', fieldName: 'Title', type: 'text' },
//     { label: 'email', fieldName: 'Email', type: 'email' }
// ];
// export default class Accountdatatable extends LightningElement {
// columns = COLUMNS;
// @track contactsData=[];
// error;
// @api recordId;
// @wire(getListRecordbyName,{
//     objectApiName: CONTACT_OBJECT.objectApiName,
//     listViewApiName:'AllContacts'
// })
// wiredListRecords({error,data})

// if(data){
//     this.contactsData = data.records.records.map(record=>({
//     firstname:record.fieldName.FirstName.value,
//     lastname:record.fieldName.LastName.value,
//     phone:record.fieldName.Phone.value,
//     title:record.fieldName.Title.value,
//     email:record.fieldName.Email.value,      
// }));
// this.error = undefined; 
// }
// else if(error){
//     this.error=error;
//     this.contactsData=[];

// }

// }











// import { LightningElement, api, track, wire } from 'lwc';
// import { getListRecordsByName } from 'lightning/uiListsApi';
// import CONTACT_OBJECT from '@salesforce/schema/Contact';

// const COLUMNS = [
//     { label: 'firstname', fieldName: 'firstname', type: 'text' },
//     { label: 'lastname', fieldName: 'lastname', type: 'text' },
//     { label: 'phone', fieldName: 'phone', type: 'phone' },
//     { label: 'title', fieldName: 'title', type: 'text' },
//     { label: 'email', fieldName: 'email', type: 'email' }
// ];

// export default class Accountdatatable extends LightningElement {
//     columns = COLUMNS;

//     @track contactsData = [];
//     error;

//     @api recordId;

//     @wire(getListRecordsByName, {
//         objectApiName: CONTACT_OBJECT.objectApiName,
//         listViewApiName: 'AllContacts'
//     })
//     wiredListRecords({ error, data }) {
//         if (data) {
//             this.contactsData = data.records.map(record => ({
//                 firstname: record.fields.FirstName.value,
//                 lastname: record.fields.LastName.value,
//                 phone: record.fields.Phone?.value,
//                 title: record.fields.Title?.value,
//                 email: record.fields.Email?.value
//             }));

//             this.error = undefined;
//         } else if (error) {
//             this.error = error;
//             this.contactsData = [];
//         }
//     }
// }








import { LightningElement, wire } from 'lwc';
import { getListRecordsByName } from 'lightning/uiListsApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

const COLUMNS = [
    { label: 'First Name', fieldName: 'firstname', type: 'text' },
    { label: 'Last Name', fieldName: 'lastname', type: 'text' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Title', fieldName: 'title', type: 'text' },
    { label: 'Email', fieldName: 'email', type: 'email' }
];

export default class Accountdatatable extends LightningElement {

    columns = COLUMNS;
    contactsData = [];
    error;

    @wire(getListRecordsByName, {
        objectApiName: CONTACT_OBJECT.objectApiName,
        listViewApiName: 'AllContacts',
        fields: [
            'Contact.FirstName',
            'Contact.LastName',
            'Contact.Phone',
            'Contact.Title',
            'Contact.Email'
        ]
    })
    wiredListRecords({ data, error }) {

        if (data) {
            this.contactsData = data.records.map(record => ({
                Id: record.id,
                firstname: record.fields.FirstName?.value || '',
                lastname: record.fields.LastName?.value || '',
                phone: record.fields.Phone?.value || '',
                title: record.fields.Title?.value || '',
                email: record.fields.Email?.value || ''
            }));

            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contactsData = [];
            console.error(error);
        }
    }

    get variable() {
        return this.contactsData.length > 0;
    }
}