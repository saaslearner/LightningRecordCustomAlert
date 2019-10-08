({
	//Client Side Method called during initial loading
    doInit : function(component, event, helper) {
		var sObjectName = component.get("v.sObjectName");
        var title = component.get("v.title");
        var alertType = component.get("v.alertType");
        var messageType = component.get("v.messageType");
        var message = component.get("v.message");
        var fieldNameList = helper.parseFieldNames(message);
        if(fieldNameList.length > 0) {
            message = helper.getMessage(component, message, fieldNameList);
        }
        else {
            helper.displayToast(title, messageType, message, alertType);
        }
	}
})