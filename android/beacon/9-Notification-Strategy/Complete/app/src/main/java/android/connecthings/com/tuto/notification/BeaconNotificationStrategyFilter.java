package android.connecthings.com.tuto.notification;

import android.connecthings.adtag.adtagEnum.FEED_STATUS;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.adtag.beacon.strategy.BeaconNotificationStrategy;

/**
 *The aim is to avoid to create too much beacon notification, giving the feeling to a user to be spammed.
 *
 * A new notification can't be created before a minimum time after a notification has been deleted
 */
public class BeaconNotificationStrategyFilter implements BeaconNotificationStrategy{

    private int minTimeBetweenNotification;

    private long minNextTimeNotification;

    public BeaconNotificationStrategyFilter(int minTimeBetweenNotification){
        this.minTimeBetweenNotification = minTimeBetweenNotification;
    }


    @Override
    public boolean createNewNotification(BeaconContent beaconContent, FEED_STATUS feed_status) {
        return minNextTimeNotification < System.currentTimeMillis();
    }

    @Override
    public boolean deleteCurrentNotification(BeaconContent beaconContent, FEED_STATUS feed_status) {
        return true;
    }

    @Override
    public void onBackground() {}

    @Override
    public void onForeground() {}

    @Override
    public void onNotificationCreated(boolean created, BeaconContent beaconContent) {}

    @Override
    public void onNotificationDeleted(boolean deleted, BeaconContent beaconContent, FEED_STATUS feed_status) {
        if(deleted) {
            minNextTimeNotification = System.currentTimeMillis() + minTimeBetweenNotification;
        }
    }

    @Override
    public void onStartMonitoringRegion(BeaconContent beaconContent, FEED_STATUS feed_status) {

    }
}
