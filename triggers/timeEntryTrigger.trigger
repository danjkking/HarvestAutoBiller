/**
 * Created by dank on 8/14/18.
 */

trigger timeEntryTrigger on Time_Entry__c (before insert, before update, before delete,
                                           after insert, after update,
                                           after delete, after undelete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            timeEntryTriggerHandler.beforeInsert(trigger.new);
        }
        if (Trigger.isUpdate) {
        }
        if (Trigger.isDelete) {
        }
    }

    if (Trigger.IsAfter) {
        if (Trigger.isInsert) {
        }
        if (Trigger.isUpdate) {
        }
        if (Trigger.isDelete) {
        }
    }
}