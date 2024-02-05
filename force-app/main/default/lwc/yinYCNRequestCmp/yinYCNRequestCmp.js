/**
 * @description       : 
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI
 * @last modified on  : 10-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
import { LightningElement,api,track,wire } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getYCNDetail  from '@salesforce/apex/YINChangeRequestController.getYCNDetail';
import createRecord  from '@salesforce/apex/YINChangeRequestController.createRecord';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class YinYCNRequestCmp extends LightningElement {
@api recordId;
@track ShowLoding = false;
@track changeRequestObj = {};

    handleSubmit(){
        this.ShowLoding = true;
        const closeEvent = new CustomEvent('close');
        console.log('this.recID:', this.recordId);
        getYCNDetail({accId:this.recordId})
        .then(data=>{
            try {
                if (data.length > 0){
                    this.ShowLoding = false;
                    console.log('@@@In 1st if:',data.length);
                        this.showToastmessage('Warning','Your request for change YCN has been already sent!','Warning');
                        this.dispatchEvent(new CloseActionScreenEvent());
                        this.dispatchEvent(closeEvent);
            }
                else if (data.length == 0){
                    this.ShowLoding = false;
                    this.changeRequestObj.dealerId = this.recordId;
                    this.changeRequestObj.type = 'YCN';

                    createRecord({ jsonString:JSON.stringify(this.changeRequestObj)})
                     .then(result =>{
                        let obj = JSON.parse(result);
                        if(obj.status == 'success'){
                            this.showToastmessage('Success','Your request for change YCN has been sent successfully!','Success');
                            this.dispatchEvent(new CloseActionScreenEvent());
                            this.dispatchEvent(closeEvent);
                            
                        }
                     })   
                }
                if(error){
                    this.ShowLoding = false;
                    this.showToastmessage('error',error,'error');
                    this.dispatchEvent(new CloseActionScreenEvent());
                    this.dispatchEvent(closeEvent);

                }
            } catch (error) {
                this.ShowLoding = false;
                console.log('error:', error);
            }
        
        })
    }

    handleClose(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    showToastmessage(title,message,varient){
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: varient,
            }),
        );
    } 
}