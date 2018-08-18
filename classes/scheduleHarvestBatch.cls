/**
 * Created by dank on 8/14/18.
 */

global class scheduleHarvestBatch {

    public static final String cron_expr = '0 0 8 ? * *';
    public static final String cronName = 'Create Harvest Time Entry';

    global static String scheduleIt() {
        scheduledBatchHarvestTimeEntry job = new scheduledBatchHarvestTimeEntry();
        return system.schedule(cronName,cron_expr,job);
    }
}