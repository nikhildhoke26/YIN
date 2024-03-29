/**
 * @description       : This class provides methods to query and filter Account records.
 * @author            : Saurabh Pandey
 * @group             : 
 * @last modified on  : 11-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
 **/
public with sharing class YINAccountSelector extends LibSObjectSelector {

    /**
     * @Description - Constructor for the AccountSelector class.
     * @return  - None.
     */
    public YINAccountSelector() {
        super(true, false, false, false);
    }
    
    /**
     * @Description - Get the SObjectType for the Account object.
     * @return  - Schema.SObjectType.
     */
    public Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }
    
    /**
     * @Description - Get a list of SObjectFields for the Account object.
     * @return  - List<Schema.SObjectField>.
     */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.Id,
            Account.Name,
            Account.Contact_Person_Email__c,
            // Account.Outstanding_Amount__c,
            Account.Security_Deposit__c,
            Account.Requested_Date__c,
           // Account.Sub_Classification__c,
           //Account.Key_Customer__c,
            //Account.Status__c,
            Account.City__r.id,
            Account.Area__r.id,
            Account.SFDC_Customer_Code__c,     //Amol Patil
            Account.ERP_Customer_Code__c,     //Amol Patil

            // Start Added by Sandeep Vishwakarma
        Account.BillingCity, 
        Account.BillingStreet, 
        Account.BillingState, 
        Account.BillingPostalCode, 
        Account.BillingCountry, 
        Account.BillingLatitude, 
        Account.BillingLongitude, 
        Account.BillingGeocodeAccuracy, 
        Account.BillingAddress, 
        Account.ShippingStreet, 
        Account.ShippingCity, 
        Account.ShippingState, 
        Account.ShippingPostalCode, 
        Account.ShippingCountry, 
        Account.ShippingLatitude, 
        Account.ShippingLongitude, 
        Account.ShippingGeocodeAccuracy, 
        Account.ShippingAddress, 
        Account.Phone, 
        Account.Website,
        Account.Customer_Group__c,
        Account.Location__c,
        Account.PAN_Status__c,
        Account.Is_Capping_Enable__c,
        Account.Is_Locking_Enable__c,
        Account.X1H_TCS__c,
        Account.ParentId,
        Account.Contact_Name__c,
        Account.Contact_Person_Email__c,
        Account.Contact_Person_Phone__c,
        Account.Primary_Contact_Number__c,
        Account.Total_Credit_Limit__c,
        Account.Available_Credit_Limit__c,
        Account.Credit_Days_Group_Dealer__c
        // End Adding by Sandeep Vishwakarma
        };
    }
    
    /**
     * @Description - Get the order by clause for query results.
     * @return  - String.
     */
    public override String getOrderBy() {
        return 'Name';
    }
    
    /**
     * @Description - Get a list of Account records based on specified filters.
     * @param List : filter1 (String), filter2 (String), subclass (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountList(String filter1, String filter2, String subclass) {
        return Database.query(
            newQueryFactory()
                .setCondition('Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by City.
     * @param List : cityId (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByCity(String cityId) {
        // Implement logic for filtering by city
        return Database.query(
            newQueryFactory()
                .setCondition('City__r.Id=:cityId AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by Area.
     * @param List : areaId (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByArea(String areaId) {
        // Implement logic for filtering by area
        return Database.query(
            newQueryFactory()
                .setCondition('Area__r.Id=:areaId AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        ); 
    }
    
    /**
     * @Description - Get a list of Account records filtered by City and Area.
     * @param List : cityId (String), areaId (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByCityAndArea(String cityId, String areaId) {
        // Implement logic for filtering by both city and area
        return Database.query(
            newQueryFactory()
                .setCondition('City__r.Id=:cityId AND Area__r.Id=:areaId  AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by Subclass.
     * @param List : subclass (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListBySubclass(String subclass) {
        // Implement logic for filtering by subclass
        return Database.query(
            newQueryFactory()
                .setCondition('Sub_Classification__c=:subclass AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by City, Area, and Subclass.
     * @param List : cityId (String), areaId (String), subclass (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByCityAndAreaAndSubclass(String cityId, String areaId, String subclass) {
        // Implement logic for filtering by city, area, and subclass
        return Database.query(
            newQueryFactory()
                .setCondition('City__r.Id=:cityId AND Area__r.Id=:areaId AND Sub_Classification__c=:subclass AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by City and Subclass.
     * @param List : cityId (String), subclass (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByCityAndSubclass(String cityId, String subclass) {
        // Implement logic for filtering by city and subclass
        return Database.query(
            newQueryFactory()
                .setCondition('City__r.Id=:cityId AND Sub_Classification__c=:subclass AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by Area and Subclass.
     * @param List : areaId (String), subclass (String).
     * @return  - List<Account>.
     */
    public List<Account> getAccountListByAreaAndSubclass(String areaId, String subclass) {
        // Implement logic for filtering by area and subclass
        return Database.query(
            newQueryFactory()
                .setCondition('Area__r.Id=:areaId AND Sub_Classification__c=:subclass AND Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')  
                .toSOQL()
        );
    }
    
    /**
     * @Description - Get a list of Account records filtered by Key Customer and Status.
     * @param List : None.
     * @return  - List<Account>.
     */
    public List<Account> getSubclassFromApex() {
        return Database.query(
            newQueryFactory()
                .setCondition('Key_Customer__c != null AND (Status__c = \'Active\' OR Status__c = \'Approved\' OR Status__c = \'Auto Approved\')')
                .toSOQL()
        );
    }
    
    /**
     * Added by:Amol Patil
     * @Description - Get a list of Account fields used for Change Request Module  .
     * @param List : None.
     * @return  - List<Account>.
     */
    public List<Account> getDelerAccounts(String dealerAcc) {
        return Database.query(
            newQueryFactory()
                    .selectField('Owner.Email')
                    .setCondition('Id=:dealerAcc')
                    .toSOQL()
        );
    }
        
    /**
     * Added by:Amol Patil
     * @Description - Get a list of Account IDs based on ERP Customer Code used for Change Request Module.  .
     * @param List : None.
     * @return  - List<Account>.
     */
    public List<Account> getAccountsByERP(List<String> erpCodes) {
        return Database.query(
            newQueryFactory()
                    .setCondition('ERP_Customer_Code__c In:erpCodes')
                    .toSOQL()
        );
    }

      /**
     * Added by:Saurabh Pandey
     * @Description - Get a list of Account fields based on Dealer Code.
     * @param List : List<String> dealerCodelist.
     * @return  - List<Account>.
     */
         public List<Account> getDealeridlist(List<String> dealerCodelist)  {
        // Implement logic for filtering by area and subclass
        return Database.query(
            newQueryFactory()
                // .selectField('Owner.Email')
                .setCondition('SFDC_Customer_Code__c IN:dealerCodelist')  
                .toSOQL()
        );
    }
      
      /**
     * Added by:Saurabh Pandey
     * @Description - Get a list of Account fields based on Dealer Code.
     * @param List :List<String> codeList
     * @return  - List<Account>.
     */  
         public List<Account> getDealerIdfromCode(List<String> codeList)  {
        // Implement logic for filtering by area and subclass
        return Database.query(
            newQueryFactory()
                .setCondition('SFDC_Customer_Code__c IN:codeList')  
                .toSOQL()
        );
    }
       
     /**
     * Added by:Saurabh Pandey
     * @Description - Get a list of Account Ids.
     * @param List :List<String> accIds
     * @return  - List<Account>.
     */
     public List<Account> getAccounts(List<String> accIds) {
        return Database.query(
            newQueryFactory()
            .selectField('Location__r.Location_Code__c')
            .setCondition('Id IN:accIds')
            .toSOQL()
        );
     }

     public  List<Account> selectShippingAccounts(String accounId){
        String query = newQueryFactory()
        .setCondition('ParentId=:accounId')
        .toSOQL();
        return Database.query(query);
     }

    public List<Account> getAccountsByErpCode(List<String> fieldNames) {
        return Database.query(
            newQueryFactory()
            .selectFields(fieldNames)
            .setCondition('ERP_Customer_Code__c!=null')
            .toSOQL()
        );
     }

     /**
     * Added by:Amol Patil
     * @Description - Get a list of shipto party Account for respective account ids.
     * @param List :List<String> accIds
     * @return  - List<Account>.
     */
    public List<Account> shiptoPartyByAccount(List<String> accIds) {
        return Database.query(
            newQueryFactory()
            .selectField('Account_Type__c')
            .setCondition('Account_Type__c = \'Ship To Party\' AND ParentId IN:accIds')
            .toSOQL()
        );
     }

}