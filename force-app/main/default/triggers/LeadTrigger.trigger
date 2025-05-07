trigger LeadTrigger on Lead (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Lead record : Trigger.new) {
            Map<String, Object> fieldData = new Map<String, Object>{
                'Field1__c' => record.Field1__c,
                'Field2__c' => record.Field2__c
            };

            // Call the processor to calculate the processing stage and status
            Map<String, String> result = LeadWeightageProcessor.calculateProcessingStage(fieldData);

            // Update the record with the calculated values
            record.Processing_Stage__c = result.get('ProcessingStage');
            record.Status__c = result.get('Status');
        }
    }
}