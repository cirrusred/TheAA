({
	invoke : function(component, event, helper) {

        var record = component.get("v.recId");
        var redirect = $A.get("e.force:navigateToSObject");

        redirect.setParams({
            "recordId": record,
            "slideDevName": "Detail"
        });

        redirect.fire();
    }
})