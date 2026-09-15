import { LightningElement } from 'lwc';
export default class Lwccomponent extends LightningElement {
handleEdit(){
    console.log('Edit action click');
}
handleSave(){
    console.log('Save action click');
}
handleSubmit(){
    console.log('Submit action click');
}
}