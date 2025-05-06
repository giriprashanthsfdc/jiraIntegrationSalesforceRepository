public with sharing class LeadController {
    @AuraEnabled
    public static Lead saveLead(Lead lead) {
        try {
            upsert lead;
            return lead;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}