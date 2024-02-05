/**
 * @description       : 
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI
 * @last modified on  : 10-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
public virtual with sharing class YINContentVersionCreatorImp implements YINIContentVersionCreator {
     public virtual List<contentversion> getContentVersion(Set<Id> cvList,List<String> fields){
        LibISObjectSelector selector =  YINApplication.selector.newInstance(ContentVersion.SObjectType);
        YINContentVersionSelector cvObj = (YINContentVersionSelector)selector;
        return cvObj.selectCVBySelectiveFields(cvList,fields);
    }
    public virtual List<Account> getAccount(List<String> fieldNames){
        LibISObjectSelector selector =  YINApplication.selector.newInstance(Account.SObjectType);
        YINAccountSelector accObj = (YINAccountSelector)selector;
        return accObj.getAccountsByErpCode(fieldNames);
    }
    public virtual List<CollaborationGroup> getCollaborationGroup(){
        LibISObjectSelector selector =  YINApplication.selector.newInstance(CollaborationGroup.SObjectType);
        YINCollaborationGroupSelector colGrpObj = (YINCollaborationGroupSelector)selector;
        return colGrpObj.getGroups();
    }
    public virtual String updateCV(List<contentversion> cvList,List<ContentDocumentLink> cdlList,List<ContentDocument> deleteCDList){
        String str = '';
        try{
            LibISObjectUnitOfWork unitOfWork = YINApplication.unitOfWork.newInstance();
            unitOfWork.registerDirty(cvList);
            unitOfWork.registerNew(cdlList);
            unitOfWork.registerDeleted(deleteCDList);
            unitOfWork.commitWork();
            str = 'success';
        }catch (Exception e) {
            str = 'error';
            System.debug(' Exception is - '+ e.getMessage());
            System.debug(' Exception at - '+ e.getLineNumber());
        }
        return str;
    }
    public virtual List<ContentDocument> getCDocID(List<String> cdList){
        LibISObjectSelector selector =  YINApplication.selector.newInstance(ContentDocument.SObjectType);
        YINContentDocumentSelector cdObj = (YINContentDocumentSelector)selector;
        return cdObj.getContentDocList(cdList);
    }
    //Added by Amol
    public virtual List<contentversion> createContentVersion(List<contentversion> cvList){
            LibISObjectUnitOfWork unitOfWork = YINApplication.unitOfWork.newInstance();
            unitOfWork.registerNew(cvList);
            unitOfWork.commitWork();
            return cvList;
    }
    //Added by Amol
    public virtual List<contentversion> getContentDocID(List<Id> contentVersionId){
        LibISObjectSelector selector =  YINApplication.selector.newInstance(contentversion.SObjectType);
        YINContentVersionSelector accObj = (YINContentVersionSelector)selector;
        return accObj.getContentDocumentID(contentVersionId);
    }
}