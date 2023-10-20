({
    fetchAccountRecord: function(component, recordId) {
        var action = component.get("c.getAccountRecord"); // Replace 'getAccountRecord' with your Apex method name
        action.setParams({
            accountId: recordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var account = response.getReturnValue();
                component.set("v.account", account);
                component.set("v.isLoading", false);
            } else {
                // Handle error or display a message
            }
        });
        
        $A.enqueueAction(action);
    }
})