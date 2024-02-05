/**
 * @description       : Fetching Chnage Request Records.
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI 
 * @last modified on  : 02-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
public with sharing class YINChangeRequestSelector extends LIBSObjectSelector{
    public YINChangeRequestSelector(){
        super(true,false,false,false);
    }

    public Schema.SObjectType getSObjectType(){
        return YIN_Change_Request__c.getSObjectType();  
    }
	
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            YIN_Change_Request__c.Id,
            YIN_Change_Request__c.Account__c,
            YIN_Change_Request__c.Billing_Address_1__c,
            YIN_Change_Request__c.Billing_Address_2__c,
            YIN_Change_Request__c.Chanage_Requested_By__c,
            YIN_Change_Request__c.City__c,
            YIN_Change_Request__c.Country__c,
            YIN_Change_Request__c.CreatedById,
            YIN_Change_Request__c.District__c,
            YIN_Change_Request__c.Email__c,
            YIN_Change_Request__c.Integration_Status__c,
            YIN_Change_Request__c.KYC_Status__c,
            YIN_Change_Request__c.Name,
            YIN_Change_Request__c.OwnerId,
            YIN_Change_Request__c.Pincode__c,
            YIN_Change_Request__c.State__c,
            YIN_Change_Request__c.Status__c,
            YIN_Change_Request__c.Sub_District__c,
            YIN_Change_Request__c.Territory__c,
            YIN_Change_Request__c.Type__c

        };
    }

    public YIN_Change_Request__c getChangeRequestDetails(String recId){
        return Database.query(
                newQueryFactory()
                        .setCondition('Id =:recId')
                        .toSOQL()
        );
}

    public List<YIN_Change_Request__c> getYCNChangeRequestDetails(String accId){
        return Database.query(
                newQueryFactory()
                        .setCondition('Account__c =:accId')
                        .toSOQL()
        );
}
    

}