/********************************************************************************************************************  
Name:            SL_RecordAlertControllerTest.cls
Author:          ѕααѕƖєαяηєя (https://www.saaslearner.com/)
Description:     Test class for Apex controller used in RecordAlert Lightning component
********************************************************************************************************************/
@isTest
public class SL_RecordAlertControllerTest {

    @testsetup static void prepareData() {
        Account account = new Account();
        account.Name = 'Test Account';
        account.NumberOfEmployees = 200;
        account.YearStarted = '2000';
        insert account;
    }
    
    @isTest
    public static void testPositive() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        String displayMessage = 'We started in {{YearStarted}} and have {{NumberOfEmployees}} employees in our company. We work with {{Industry}} industry.';
        String expectedMessage = 'We started in 2000 and have 200 employees in our company. We work with  industry.';
        List<String> fieldNameList = new List<String>{'NumberOfEmployees', 'YearStarted', 'Industry'};		
        
        String returnedMessage = SL_RecordAlertController.getMessage('Account', account.Id, displayMessage, fieldNameList);
        System.assertEquals(expectedMessage, returnedMessage);
    }
}