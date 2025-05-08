public with sharing class LeadController {
    @AuraEnabled
    public static void saveLeadRecord(Lead lead) {
        insert lead;
    }
}