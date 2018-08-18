/**
 * Created by dank on 8/14/18.
 */

public with sharing class timeEntryTriggerHandler {

    public static void beforeInsert(List<Time_Entry__c> newTimeEntries){

        List<Id> ctdIds = new List<Id>();

        for(cronJobDetail existingCronTriggerDetail :[SELECT Id, Name
                                                      FROM cronJobDetail
                                                      WHERE Name = :scheduleHarvestBatch.cronName]){
            ctdIds.add(existingCronTriggerDetail.Id);
        }

        List<cronTrigger> cTs = new List<cronTrigger>();

        if(ctdIds.size()>0){
            cTs = [SELECT Id, CronJobDetailId, State FROM cronTrigger WHERE CronJobDetailId IN :ctdIds AND State != 'DELETED'];
        }

        if(cTs.size()==0){
            scheduleHarvestBatch.scheduleIt();
        }
    }
}