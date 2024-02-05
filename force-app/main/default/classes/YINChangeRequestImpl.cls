/**
 * @description       : Implementation Class
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI
 * @last modified on  : 11-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
public with sharing class YINChangeRequestImpl implements YINIChangeRequest{
    public virtual YIN_Change_Request__c getRecord(String recId){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(YIN_Change_Request__c.SObjectType);
        YINChangeRequestSelector selectorObj = (YINChangeRequestSelector)selector;
        return selectorObj.getChangeRequestDetails(recId);
    }
    public virtual boolean createRecord(YIN_Change_Request__c changeRequest){
        System.debug('@@changeRequest: ' + changeRequest);
        LIBISObjectUnitOfWork unitofWork = YINApplication.unitOfWork.newInstance();
        unitofWork.registerNew(changeRequest);
        unitofWork.commitWork();
        return true;
    }
    public virtual boolean updateRecord(YIN_Change_Request__c changeRequest){
        LIBISObjectUnitOfWork unitofWork = YINApplication.unitOfWork.newInstance();
        unitofWork.registerDirty(changeRequest);
        unitofWork.commitWork();
        return true;
    }
    public virtual List<YIN_Pincode__c> getPincodeDetails(String pincode){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(YIN_Pincode__c.SObjectType);
        YINPincodeSelector selectorObj = (YINPincodeSelector)selector;
        return selectorObj.getPincodeList(pincode);
    }

    public virtual List<Account> getDealerAccount(String dealerAccount){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(Account.SObjectType);
        YINAccountSelector selectorObj = (YINAccountSelector)selector;
        return selectorObj.getDelerAccounts(dealerAccount);
    }

    public virtual List<Account> getAccountsByERPCode(List<String> erpCodes){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(Account.SObjectType);
        YINAccountSelector selectorObj = (YINAccountSelector)selector;
        return selectorObj.getAccountsByERP(erpCodes);
    }

    /* public virtual boolean createContentDocLink(ContentDocumentLink cdLink){
        System.debug('@@changeRequest: ' + cdLink);
        LIBISObjectUnitOfWork unitofWork = YINApplication.unitOfWork.newInstance();
        unitofWork.registerUpsert(cdLink);
        unitofWork.commitWork();
        return true;
    } */

    public virtual boolean createContentDocLink(List<ContentDocumentLink> cdLink){
        System.debug('@@changeRequest: ' + cdLink);
        LIBISObjectUnitOfWork unitofWork = YINApplication.unitOfWork.newInstance();
        unitofWork.registerNew(cdLink);
        unitofWork.commitWork();
        return true;
    }

    public virtual List<YIN_Change_Request__c> getYCNDetails(String accId){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(YIN_Change_Request__c.SObjectType);
        YINChangeRequestSelector selectorObj = (YINChangeRequestSelector)selector;
        return selectorObj.getYCNChangeRequestDetails(accId);
    }

    public virtual List<Account> getShiptoPartyByAccount(List<String> accIds){
        LIBISObjectSelector selector =  YINApplication.selector.newInstance(Account.SObjectType);
        YINAccountSelector selectorObj = (YINAccountSelector)selector;
        return selectorObj.shiptoPartyByAccount(accIds);
    }
    
}