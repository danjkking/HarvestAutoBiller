/**
 * Created by dank on 8/14/18.
 */

global class scheduledBatchHarvestTimeEntry implements Schedulable {

    global void execute(SchedulableContext SC){
        batchHarvestTimeEntry TEntry = new batchHarvestTimeEntry();
        database.executeBatch(TEntry);
    }
}