/**
  @description       : Email,Phone And Address Change Request.
  @author            : Amol Patil/amol.patil@skinternational.com
  @group             : SkI 
  @last modified on  : 10-01-2024
  @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
import { LightningElement,track,api,wire} from 'lwc';
import customCSS from '@salesforce/resourceUrl/customCSS';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
// import getRecord  from '@salesforce/apex/YINChangeRequestController.getRecord';
import createRecord  from '@salesforce/apex/YINChangeRequestController.createRecord';
// import updateRecord  from '@salesforce/apex/YINChangeRequestController.updateRecord';
import getPinCodeDetail  from '@salesforce/apex/YINChangeRequestController.getPinCodeDetail';
import getDealerAcc  from '@salesforce/apex/YINChangeRequestController.getDealerAcc';

export default class YinChangeRequest extends NavigationMixin(LightningElement) {
    valueSelected1 = true;
    valueSelected2 = false;
    valueSelected3 = false;
    valueSelected4 = false;
    showButtons = true;
    @track ShowLoding = true;
    value5 = 'email';
    @track changeRequestObj = {};
    @api recordId;
    @track crType = 'Email';
    @track uploadedFileName;

    connectedCallback() {
        this.changeRequestObj.type = this.crType;
        this.ShowLoding = false;
    }

    get options5() {
        return [
            { label: 'Email', value: 'email' },
            { label: 'Phone', value: 'phone' },
            { label: 'Change Billing Address', value: 'changeBilingaddress'},
            { label: 'Change Shipping Address',value: 'changeshippingaddress'},
            { label: 'New Shipping Address',value: 'newshippingaddress'},
        ];
    };

    matchingInfo = {
        primaryField: { fieldPath: "Pincode__c" }
    };

    displayInfo = {
        additionalFields: ["Pincode__c"]
    };

    filter = {
        criteria: [
            {
                fieldPath: "Pincode__c",
                operator: "ne",
                value: "",
            }
        ],
    };

    async handleRadioChange(event) {
        this.ShowLoding = true;
        this.cleardata();
        this.value5 = event.detail.value;
        this.crType = event.target.options.find(opt => opt.value === event.detail.value).label;
        this.changeRequestObj.type = this.crType;
        console.log('@@@@:', this.crType)
        if(this.value5 =='email'){
            this.valueSelected1 = true;
            this.valueSelected2 = false;
            this.valueSelected3 = false;
            this.valueSelected4 = false;
            this.showButtons = true;
            this.ShowLoding = false;
        }
        else if(this.value5 =='phone'){
            this.valueSelected1 = false;
            this.valueSelected2 = true;
            this.valueSelected3 = false;
            this.valueSelected4 = false;
            this.showButtons = true;
            this.ShowLoding = false;
        }
        else if(this.value5 =='changeBilingaddress'){
            this.valueSelected1 = false;
            this.valueSelected2 = false;
            this.valueSelected3 = true;
            this.valueSelected4 = false;
            this.showButtons = false;
            this.handleRemoveAttachment();
            let objArrey = await this.fetchDealerAccounts();
            console.log('Inside Fetch Account:',objArrey );
            this.changeRequestObj.Name = objArrey[0].Name;
            this.changeRequestObj.dealerName = objArrey[0].Name;
            this.changeRequestObj.dealerCode = objArrey[0].SFDC_Customer_Code__c;
            this.ShowLoding = false;
        
        }
        else if(this.value5 =='changeshippingaddress'){
            this.valueSelected1 = false;
            this.valueSelected2 = false;
            this.valueSelected3 = false;
            this.valueSelected4 = true;
            this.showButtons = false;
            this.handleRemoveAttachment();
            this.shippinglable = 'Change';
            let objArrey = await this.fetchDealerAccounts();
            this.changeRequestObj.dealerName = objArrey[0].Name;
            this.changeRequestObj.dealerCode = objArrey[0].SFDC_Customer_Code__c;
            this.ShowLoding = false;
        }
        else if(this.value5 =='newshippingaddress'){
            this.valueSelected1 = false;
            this.valueSelected2 = false;
            this.valueSelected3 = false;
            this.valueSelected4 = true;
            this.showButtons = false;
            this.handleRemoveAttachment();
            this.shippinglable = 'New';
            let objArrey = await this.fetchDealerAccounts();
            this.changeRequestObj.dealerName = objArrey[0].Name;
            this.changeRequestObj.dealerCode = objArrey[0].SFDC_Customer_Code__c;
            this.ShowLoding = false;
        }
    };

    renderedCallback() {
        Promise.all([
            loadStyle(this, customCSS)
        ]);
    }

    handleNavigation(epId,emailId,phoneNo){
        let compDetails = {
            componentDef: "c:yinEnterAadhaarVerificationCmp",
            attributes: {
            securityId:epId,
            emailId1:emailId,
            phoneNo1: phoneNo,
            module:'changeRequest'  
              
            }
        }
        let encodedComponentDef = btoa(JSON.stringify(compDetails));
        this[NavigationMixin.Navigate]({
        type: 'standard__webPage',
      attributes: {
       url: '/one/one.app#' + encodedComponentDef
       }
     }) 
    }

    async fetchDealerAccounts(){
        console.log('@@@recordId:', this.recordId);
       return await getDealerAcc ({dealerAccount:this.recordId});

    }

    async handlePincode(e){
        console.log('e.target.value:', e.detail.recordId);
        this.changeRequestObj.pincode = e.detail.recordId;
        if(this.changeRequestObj.pincode != null){
            let pincodes = await getPinCodeDetail({pincode:this.changeRequestObj.pincode})
            this.changeRequestObj.city=pincodes[0].City__r.Name;
            this.changeRequestObj.state=pincodes[0].State__r.Name;
            this.changeRequestObj.country=pincodes[0].Country__r.Name;
            this.changeRequestObj.district=pincodes[0].District__r.Name;
            this.changeRequestObj.subDistrict=pincodes[0].Sub_District__r.Name;
            this.changeRequestObj.cityId=pincodes[0].City__c;
            this.changeRequestObj.stateId=pincodes[0].State__c;
            this.changeRequestObj.countryId=pincodes[0].Country__c;
            this.changeRequestObj.districtId=pincodes[0].District__c;
            this.changeRequestObj.subDistrictId=pincodes[0].Sub_District__c;
            this.changeRequestObj.pincodeId=pincodes[0].Id; 
        }else if(this.changeRequestObj.pincode === null){
             this.clearPincodeDetails();
        }
    }

    clearPincodeDetails() {
        this.changeRequestObj.city = null;
        this.changeRequestObj.state = null;
        this.changeRequestObj.country = null;
        this.changeRequestObj.district = null;
        this.changeRequestObj.subDistrict = null;
        this.changeRequestObj.cityId = null;
        this.changeRequestObj.stateId = null;
        this.changeRequestObj.countryId = null;
        this.changeRequestObj.districtId = null;
        this.changeRequestObj.subDistrictId = null;
        this.changeRequestObj.pincodeId = null;
    }
      

    
    handleAddress(e){
        if(e.target.label == 'Billing Address 1' || e.target.label == 'Shipping Address 1'){
            this.changeRequestObj.address1 = e.target.value;
        }else  if(e.target.label == 'Billing Address 2' || e.target.label == 'Shipping Address 2'){
            this.changeRequestObj.address2 = e.target.value;
        }
    }

    handleNameChange(e){
        if(e.target.label == 'Name'){
            this.changeRequestObj.Name = e.target.value;
        }else if(e.target.label == 'Name2'){
            this.changeRequestObj.Name2 = e.target.value;
        }
    }

    handleContactChange(e){
        this.changeRequestObj.contactName = e.target.value;
    }

    handlePhoneChange(e){
        this.changeRequestObj.phoneNo = e.target.value;
    }

    handleEmailChange(e){
        this.changeRequestObj.emailId = e.target.value;
    }

    handleLocationChange(e){
        this.changeRequestObj.location = e.target.value;
    }

    handleGSTChange(e){
        this.changeRequestObj.gstRegistration = e.target.value;
    }

    handleWebsiteChange(e){
        this.changeRequestObj.website = e.target.value;
    }

    cleardata(){
        this.changeRequestObj = {};
    }

async handleSubmit() {
    this.ShowLoding = true;
    const closeEvent = new CustomEvent('close');
    try {
        console.log('@@crType===', JSON.stringify(this.changeRequestObj))
        console.log('!@!@!@@:', this.changeRequestObj.attachmentId);
        this.changeRequestObj.dealerId = this.recordId;
        if (!this.changeRequestObj.attachmentId && (this.value5 == 'changeBilingaddress' ||this.value5 == 'changeshippingaddress' ||this.value5 == 'newshippingaddress')) {
            this.ShowLoding = false;
            this.showToastmessage('Error', 'Please upload an attachment', 'error');
            return;
        }else if (!this.changeRequestObj.pincode && (this.value5 == 'changeBilingaddress' ||this.value5 == 'changeshippingaddress' ||this.value5 == 'newshippingaddress')) {
            this.ShowLoding = false;
            this.showToastmessage('Error', 'Please select valid Pincode', 'error');
            return;
        }else if (!this.changeRequestObj.address1 && (this.value5 == 'changeBilingaddress' ||this.value5 == 'changeshippingaddress' ||this.value5 == 'newshippingaddress')) {
            this.ShowLoding = false;
            this.showToastmessage('Error', 'Please enter Address', 'error');
            return;
        }

        let result = await createRecord({
            jsonString: JSON.stringify(this.changeRequestObj)
            // contentDocumentId: this.changeRequestObj.attachmentId
        });
        let obj = JSON.parse(result);

        if (obj.status == 'success') {
            this.ShowLoding = false;

            if (this.value5 == 'email') {
                this.showToastmessage('Success', 'Email Address Change Successfully', 'Success');
                this.handleNavigation(this.recordId, this.changeRequestObj.emailId, this.changeRequestObj.phoneNo);
           
            } else if (this.value5 == 'phone') {
                console.log('inside Phone:');
                this.showToastmessage('Success', 'Phone Number Change Successfully', 'Success');
                this.handleNavigation(this.recordId, this.changeRequestObj.emailId, this.changeRequestObj.phoneNo);
            
            } else if (this.value5 == 'changeBilingaddress' ) {
                    this.showToastmessage('Success', 'Billing Address Change Successfully', 'Success');
                    this.dispatchEvent(new CloseActionScreenEvent());
                    this.dispatchEvent(closeEvent);
                
            } else if (this.value5 == 'changeshippingaddress') {
                this.showToastmessage('Success', 'Shipping Address Change Successfully', 'Success');
                this.dispatchEvent(new CloseActionScreenEvent());
                this.dispatchEvent(closeEvent);

            } else if (this.value5 == 'newshippingaddress') {
                this.showToastmessage('Success', 'Shipping Address Created Successfully', 'Success');
                this.dispatchEvent(new CloseActionScreenEvent());
                this.dispatchEvent(closeEvent);
            }
        } else {
            this.ShowLoding = false;
            this.showToastmessage('Error', 'Failed to Create Record', 'error');
            this.dispatchEvent(new CloseActionScreenEvent());
            this.dispatchEvent(closeEvent);
        }
    } catch (error) {
        console.log(' inside Catch block:', error);
        this.ShowLoding = false;
        this.showToastmessage('Error', error, 'error');
    }
}

    handleUploadFinished(event){
        console.log('Inside File Upload:',JSON.stringify(event.detail.files[0]));
        this.changeRequestObj.attachmentId = event.detail.files[0].documentId;
        this.changeRequestObj.attachmentName = event.detail.files[0].name;
        this.uploadedFileName = event.detail.files[0].name;
    }

    handleRemoveAttachment() {
        this.changeRequestObj.attachmentId = null;
        this.changeRequestObj.attachmentName = null;
        this.uploadedFileName = null;
    }

    handleClose(){
        const closeEvent = new CustomEvent('close');
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(closeEvent);
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