/**
 * @description       : 
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : 
 * @last modified on  : 23-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
public interface YINIChangeRequest {
    YIN_Change_Request__c getRecord(String recId);
    boolean createRecord(YIN_Change_Request__c changeRequest);
    boolean updateRecord(YIN_Change_Request__c changeRequest);
    List<YIN_Pincode__c> getPincodeDetails(String pincode); 
    List<Account> getDealerAccount(String dealerAccount);
    List<Account> getAccountsByERPCode(List<String> erpCodes);
    //List<YIN_Change_Request__c> getYCNDetails(String accId);
    //boolean createContentDocLink(ContentDocumentLink cdLink);
    boolean createContentDocLink(List<ContentDocumentLink> cdLink);
    List<Account> getShiptoPartyByAccount(List<String> accIds);
    List<Account> getshipToDetails(String shipToId);
    //CustomNotificationType getCustomNotification(String devName);
    //List<EmailTemplate> getEmailTemplate(String developerName);
    // RecordType getRecordTypeByObject(String objectType,String developerName);
}