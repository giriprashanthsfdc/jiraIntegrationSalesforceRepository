public class LeadTriggerHandler {
    public static void handleBeforeInsertOrUpdate(List<Lead> leads) {
        WeightageProcessor.processLeads(leads);
    }
}