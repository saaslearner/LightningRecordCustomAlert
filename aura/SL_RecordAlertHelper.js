({
    //Utility method to display the Toast message.
    displayToast : function(title, messageType, message, alertType) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type" : messageType,
            "message": message,
            "mode": alertType
        });
        toastEvent.fire();		
    },
    
    //Parses field names from the message field
    parseFieldNames : function(message) {
        var fieldNameList = [];
        var mergedFieldExp = /\{{.*?\}}/g;
        var matchedList = message.match(mergedFieldExp);
        if(matchedList == null) {
            matchedList = [];
        }
        var i;
        for(i = 0; i < matchedList.length; i++) {
            var fieldName = matchedList[i].replace("{{", "");
            fieldName = fieldName.replace("}}", "");
            fieldNameList.push(fieldName);
        }
        return fieldNameList;
    },
    
    //Making the server call to fetch the dynamic message based on the Fields Referred
    getMessage : function(component, message, fieldNameList) {
    	
        var newMessage = '';
        var title = component.get("v.title");
        var alertType = component.get("v.alertType");
        var messageType = component.get("v.messageType");
    	var fieldValuesAction = component.get("c.getMessage");
        fieldValuesAction.setParams({ 
            objectName: component.get("v.sObjectName"),
            recordId: component.get("v.recordId"),
            message: message,
            fieldNameList: fieldNameList
        });
		
        fieldValuesAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                newMessage = response.getReturnValue();
                this.displayToast(title, messageType, newMessage, alertType);
            }
        });
		$A.enqueueAction(fieldValuesAction);
	}
})