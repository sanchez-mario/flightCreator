public without sharing class CustomLookupController {

    @AuraEnabled(cacheable=true)
    public static List<sObject> search(String searchTerm) {
        String searchQuery = 'SELECT Id, Name, IATA__c FROM Airport__c WHERE IATA__c LIKE \'%' + searchTerm + '%\' LIMIT 5';
        
        List<sObject> lookUpList = database.query(searchQuery);

        return lookUpList;
    }
}