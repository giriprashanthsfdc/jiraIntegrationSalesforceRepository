({
    saveLeadHelper: function (component) {
        const lead = component.get("v.lead");

        const action = component.get("c.saveLeadRecord");
        action.setParams({ lead: lead });

        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.message", "Lead saved successfully!");
                component.set("v.lead", { sobjectType: "Lead" }); // Reset form
            } else {
                component.set("v.message", "Error saving Lead: " + response.getError()[0].message);
            }
        });

        $A.enqueueAction(action);
    }
})