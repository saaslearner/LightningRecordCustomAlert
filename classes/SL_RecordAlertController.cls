/********************************************************************************************************************  
Name:            SL_RecordAlertController.cls
Author:          ѕααѕƖєαяηєя (https://www.saaslearner.com/)
Description:     Apex controller for RecordAlert Lightning component
********************************************************************************************************************/

public class SL_RecordAlertController {
	
    @AuraEnabled(cacheable=true)
    public static String getMessage(String objectName, String recordId, String message, List<String> fieldNameList) {
        String fieldNamesConcatenated = '';
        String dynamicQuery = '';
        
		try{
			//iterating to get all the field names
			for(String fieldName : fieldNameList){
				fieldNamesConcatenated += ', ' + fieldName;
			}
			
			dynamicQuery =  'SELECT Id' + 
							fieldNamesConcatenated + 
							' FROM ' + objectName + 
							' WHERE Id = \'' + recordId + '\'';
			SObject record = Database.query(dynamicQuery);
			
			// replace fieldnames with actual values from the database
			for(String fieldName : fieldNameList) {
				String fieldValue = String.valueOf(record.get(fieldName));
				if(fieldValue == null) {
					fieldValue = '';
				}
				message = message.replace(fieldName, fieldValue);
			}
			
			//Removing all the curly braces from the message
			message = message.replaceAll('\\{\\{', '');
			message = message.replaceAll('\\}\\}', '');
			return message;
		}
		catch(Exception ex){
			//Follow the Error Handling framework as per your ORG.
			return '';
		}
    }
}