@isTest
public class WeightageProcessorTest {
    @isTest
    static void testProcessLeads() {
        // Create Custom Metadata records
        FieldWeightage__mdt field1 = new FieldWeightage__mdt(
            DeveloperName = 'Company',
            Field_API_Name__c = 'Company',
            Weightage__c = 50
        );
        insert field1;

        FieldWeightage__mdt field2 = new FieldWeightage__mdt(
            DeveloperName = 'Email',
            Field_API_Name__c = 'Email',
            Weightage__c = 50
        );
        insert field2;

        // Create test Lead
        Lead testLead = new Lead(FirstName = 'John', LastName = 'Doe', Company = 'Test Company', Email = 'john.doe@example.com');
        insert testLead;

        // Verify field weightage calculation
        testLead = [SELECT Processing_Stage__c, Status__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('Qualified', testLead.Processing_Stage__c);
        System.assertEquals('Hot', testLead.Status__c);
    }
}