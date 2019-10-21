/**
 * @File Name          : RecordFileDownloaderController.cls
 * @Description        : 
 * @Author             : Abhimanyu Tanwar
 * @Group              : 
 * @Last Modified By   : Abhimanyu Tanwar
 * @Last Modified On   : 10/21/2019, 3:50:49 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/21/2019   Abhimanyu Tanwar     Initial Version
**/
public with sharing class RecordFileDownloaderController {

    @AuraEnabled
    public static List<Id> getfileIds(String recordId){
        Set<Id> contentDocumentIds = new Set<Id>();
        List<Id> contentVersionIds = new List<Id>();
        
        if(String.isNotBlank(recordId)) {
            for(ContentDocumentLink cdl : [SELECT ContentDocumentId,LinkedEntityId,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId =:recordId]) {
                contentDocumentIds.add(cdl.ContentDocumentId);
            }
        }

        if(contentDocumentIds.size() > 0) {
            for(ContentVersion cdv : [SELECT Id FROM ContentVersion WHERE isLatest = true AND ContentDocumentId IN :contentDocumentIds]) {
                contentVersionIds.add(cdv.Id);
            }
        }

        return contentVersionIds;
    }
}
