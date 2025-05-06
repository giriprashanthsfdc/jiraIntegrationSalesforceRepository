({
    saveLead: function (component) {
        const leadRecord = component.get("v.leadRecord");

        // Call Apex to save the Lead
        const action = component.get("c.saveLead");
        action.setParams({ lead: leadRecord });

        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.isSaved", true);
            } else {
                console.error("Failed to save Lead:", response.getError());
            }
        });

        $A.enqueueAction(action);
    }
});