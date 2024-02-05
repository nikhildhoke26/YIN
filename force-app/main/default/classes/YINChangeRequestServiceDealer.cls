/**
 * @description       : 
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI
 * @created date      : 04-01-2024
 * @last modified on  : 04-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
@RestResource(urlMapping='/apichangerequestdealerdetails/*')
global with sharing class YINChangeRequestServiceDealer implements YINIChangeRequestAPI{

    @HttpGet
    global static String getDealerAccount(){
        System.debug('In a Get Method');
        String recordId='';
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;

        recordId=req.requestURI.substring(req.requestURI.lastIndexof('/')+1);
        System.debug('Account recordID - '+ recordId);
        YINChangeRequestController.ChangeRequestWrapper crwrap=new YINChangeRequestController.ChangeRequestWrapper();   
        List<Account> crwrap1 = YINChangeRequestController.getDealerAcc(recordId);
        String value1=crwrap1.toString();  
        return value1;
    }

    
  //---------------------------------------------------------------------------------------//    
    
    
    global static String getPinCodeDetail(){
        // return empty string
        return '';
    }
    
    
    global static boolean createChangeRequest(){
        // return empty string
        return false;
    }

    
}