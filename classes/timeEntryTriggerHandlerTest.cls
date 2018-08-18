/**
 * Created by dank on 8/14/18.
 */

@IsTest
private class timeEntryTriggerHandlerTest {

    @isTest
    static void testSetup() {

        Time_Entry__c newTE = new Time_Entry__c();

        newTE.Name = 'test';
        newTE.User_Agent__c = 'danjkking@gmail.com';
        newTE.Hours__c = '8';
        newTE.User_ID__c = '1';
        newTE.Account_ID__c = '1';
        newTE.Project_ID__c = '1';
        newTE.Task_ID__c = '1';
        newTE.Access_Token__c = '1';

        insert newTE;

        Time_Entry__c newTE2 = new Time_Entry__c();

        newTE2.Name = 'test';
        newTE2.User_Agent__c = 'danjkking@gmail.com';
        newTE2.Hours__c = '8';
        newTE2.User_ID__c = '1';
        newTE2.Account_ID__c = '1';
        newTE2.Project_ID__c = '1';
        newTE2.Task_ID__c = '1';
        newTE2.Access_Token__c = '1';
        newTE2.Notes__c = '1';

        insert newTE2;

        testCallout();
    }

    static void testCallout() {

        Time_Entry__c newTE = [SELECT Id, Name, User_Agent__c, Hours__c, User_ID__c, Account_ID__c, Project_ID__c, Task_ID__c, Access_Token__c
                               FROM Time_Entry__c
                               LIMIT 1][0];

        Test.setMock(HttpCalloutMock.class, new mockHarvestHTTPResponseGenerator());

        Test.startTest();
        batchHarvestTimeEntry TEntry = new batchHarvestTimeEntry();
        database.executeBatch(TEntry);
        Test.stopTest();
    }
}