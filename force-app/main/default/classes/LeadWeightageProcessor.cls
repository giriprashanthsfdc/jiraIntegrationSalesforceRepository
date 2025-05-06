public class LeadWeightageProcessor {

    /**
     * Method to calculate and update processing stage dynamically
     * @param fieldData Map containing field names and their respective values
     * @return Map<String, String> containing updated processing stage and status
     */
    public static Map<String, String> calculateProcessingStage(Map<String, Object> fieldData) {
        // Retrieve weightage configuration from Custom Metadata
        Map<String, Decimal> weightageConfig = getWeightageConfig();

        // Calculate the total weightage dynamically
        Decimal totalWeightage = 0;
        for (String fieldName : weightageConfig.keySet()) {
            if (fieldData.containsKey(fieldName)) {
                totalWeightage += ((Decimal) fieldData.get(fieldName)) * weightageConfig.get(fieldName);
            }
        }

        // Retrieve the threshold dynamically
        Decimal threshold = getThresholdValue();

        // Determine processing stage and status
        String processingStage;
        String status;

        if (totalWeightage > threshold) {
            processingStage = 'Enrichment';
            status = 'Successful';
        } else {
            processingStage = 'Initial';
            status = 'Pending';
        }

        // Return the updated values
        return new Map<String, String>{
            'ProcessingStage' => processingStage,
            'Status' => status
        };
    }

    /**
     * Helper method to retrieve weightage configuration from Custom Metadata
     * @return Map of field names and their respective weightage values
     */
    private static Map<String, Decimal> getWeightageConfig() {
        Map<String, Decimal> weightageConfig = new Map<String, Decimal>();

        // Query Custom Metadata for weightage configuration
        for (Weightage_Metadata__mdt metadata : [SELECT Field_Name__c, Weightage_Value__c FROM Weightage_Metadata__mdt WHERE Object_Name__c = 'Lead']) {
            weightageConfig.put(metadata.Field_Name__c, metadata.Weightage_Value__c);
        }

        return weightageConfig;
    }

    /**
     * Helper method to retrieve threshold value dynamically
     * @return Threshold value as Decimal
     */
    private static Decimal getThresholdValue() {
        // Fetch from Custom Metadata
        Threshold_Metadata__mdt thresholdMetadata = [SELECT Threshold_Value__c FROM Threshold_Metadata__mdt WHERE Object_Name__c = 'Lead' LIMIT 1];
        return thresholdMetadata.Threshold_Value__c;
    }
}