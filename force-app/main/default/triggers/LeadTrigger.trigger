trigger LeadTrigger on Lead (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        LeadTriggerHandler.handleBeforeInsertOrUpdate(Trigger.new);
    }
}