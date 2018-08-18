/**
 * Created by dank on 8/14/18.
 */

global class batchHarvestTimeEntry implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {

        String query = 'SELECT Id, Spent_Date__c, Day__c, Hours__c, User_ID__c, Account_ID__c, User_Agent__c, Project_ID__c, Task_ID__c, Notes__c, Access_Token__c, '+
                       'Sunday__c, Monday__c, Tuesday__c, Wednesday__c, Thursday__c, Friday__c, Saturday__c '+
                       'FROM Time_Entry__c '+
                       'LIMIT 100';

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Time_Entry__c> timeEntries) {

        system.debug(timeEntries);

        for(Time_Entry__c tEntry :timeEntries){

            if((tEntry.Day__c == '1' && tEntry.Sunday__c == true) ||
               (tEntry.Day__c == '2' && tEntry.Monday__c == true) ||
               (tEntry.Day__c == '3' && tEntry.Tuesday__c == true) ||
               (tEntry.Day__c == '4' && tEntry.Wednesday__c == true) ||
               (tEntry.Day__c == '5' && tEntry.Thursday__c == true) ||
               (tEntry.Day__c == '6' && tEntry.Friday__c == true) ||
               (tEntry.Day__c == '7' && tEntry.Saturday__c == true)){
                Integer userID = integer.valueOf(tEntry.User_ID__c);
                Integer projectID = integer.valueOf(tEntry.Project_ID__c);
                Integer taskID = integer.valueOf(tEntry.Task_ID__c);
                Integer hours = integer.valueOf(tEntry.Hours__c);
                String notes = string.valueOf(tEntry.Notes__c);

                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeNumberField('user_id', userID);
                gen.writeNumberField('project_id', projectID);
                gen.writeNumberField('task_id', taskID);
                gen.writeStringField('spent_date', tEntry.Spent_Date__c);
                gen.writeNumberField('hours', hours);

                if(string.isNotBlank(notes)){
                    gen.writeStringField('notes', notes);
                }

                gen.writeEndObject();
                String jsonS = gen.getAsString();
                System.debug('json '+jsonS);

                Http httpProtocol = new Http();

                HttpRequest request = new HttpRequest();

                request.setHeader('Authorization', 'Bearer ' + tEntry.Access_Token__c);
                request.setHeader('Harvest-Account-Id', tEntry.Account_ID__c);
                request.setHeader('User-Agent', 'DanK\'s Harvest App (' + tEntry.User_Agent__c + ')');
                request.setHeader('Content-Type', 'application/json');
                request.setHeader('accept', 'application/json');

                request.setEndPoint('https://api.harvestapp.com/v2/time_entries');
                request.setMethod('POST');
                request.setBody(jsonS);

                HttpResponse response = httpProtocol.send(request);

                system.debug('response '+response);
            }
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}