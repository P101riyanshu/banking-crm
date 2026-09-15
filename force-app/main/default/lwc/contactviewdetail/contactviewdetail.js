import { LightningElement ,api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Contactviewdetail extends LightningElement {
    @api recordId;
    @api objectApiName;

    handleSuccess(event){
        this.dispatchEvent(
            new ShowToastevent({
                title:'success',
                message:'Contact update by LDS functionality',
                varient:'success'
            })
        )
    }
}