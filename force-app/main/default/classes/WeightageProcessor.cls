public class WeightageProcessor {
    public static void processLeads(List<Lead> leads) {
        // Fetch Custom Metadata for field weightage configuration
        Map<String, Decimal> fieldWeightageMap = getFieldWeightageConfig();

        // Iterate through Leads and calculate total weightage
        for (Lead lead : leads) {
            Decimal totalWeightage = calculateTotalWeightage(lead, fieldWeightageMap);

            // Update Processing Stage and Status based on thresholds
            lead.Processing_Stage__c = getProcessingStage(totalWeightage);
            lead.Status__c = getStatus(totalWeightage);
        }
    }

    private static Map<String, Decimal> getFieldWeightageConfig() {
        Map<String, Decimal> fieldWeightageMap = new Map<String, Decimal>();
        for (FieldWeightage__mdt config : FieldWeightage__mdt.getAll().values()) {
            fieldWeightageMap.put(config.Field_API_Name__c, config.Weightage__c);
        }
        return fieldWeightageMap;
    }

    private static Decimal calculateTotalWeightage(Lead lead, Map<String, Decimal> fieldWeightageMap) {
        Decimal totalWeightage = 0;
        for (String fieldName : fieldWeightageMap.keySet()) {
            try {
                Object fieldValue = lead.get(fieldName);
                if (fieldValue != null) {
                    totalWeightage += fieldWeightageMap.get(fieldName);
                }
            } catch (Exception e) {
                System.debug('Field not found or inaccessible: ' + fieldName);
            }
        }
        return totalWeightage;
    }

    private static String getProcessingStage(Decimal totalWeightage) {
        if (totalWeightage >= 100) {
            return 'Qualified';
        } else if (totalWeightage >= 50) {
            return 'In Progress';
        } else {
            return 'New';
        }
    }

    private static String getStatus(Decimal totalWeightage) {
        if (totalWeightage >= 100) {
            return 'Hot';
        } else if (totalWeightage >= 50) {
            return 'Warm';
        } else {
            return 'Cold';
        }
    }
}