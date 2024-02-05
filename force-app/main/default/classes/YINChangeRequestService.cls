/**
 * @description       : 
 * @author            : Amol Patil/amol.patil@skinternational.com
 * @group             : SKI
 * @created date      : 04-01-2024
 * @last modified on  : 10-01-2024
 * @last modified by  : Amol Patil/amol.patil@skinternational.com
**/
@RestResource(urlMapping='/apichangerequest/*')
global with sharing class YINChangeRequestService implements YINIChangeRequestAPI{
    
    @HttpPost
    global static String createChangeRequest(){
        String requestBody='';
        RestRequest req = RestContext.request;  
        RestResponse res = RestContext.response; 
        if(test.isRunningTest() == false){
            requestBody = req.requestBody.toString();
        }
        
        YINChangeRequestController.ChangeRequestWrapper crwrap = new YINChangeRequestController.ChangeRequestWrapper();  
        String response = YINChangeRequestController.createRecord(requestBody);
        
        return response;
    }
  
}