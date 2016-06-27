package android.connecthings.com.tuto.notification;

import android.connecthings.adtag.adtagEnum.FEED_STATUS;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.adtag.beacon.strategy.BeaconNotificationStrategy;

/**
 */
public class BeaconNotificationStrategyFilter implements BeaconNotificationStrategy {

    private long minNextTimeNotification;
    private int minTimeBetweenNotification;

    public BeaconNotificationStrategyFilter(int minTimeBetweenNotification) {
        this.minTimeBetweenNotification = minTimeBetweenNotification;
    }

    @Override
    public boolean deleteCurrentNotification(BeaconContent beaconContent, FEED_STATUS feed_status) {
        return minNextTimeNotification < System.currentTimeMillis();
    }

    @Override
    public boolean createNewNotification(BeaconContent beaconContent, FEED_STATUS feed_status) {
        return false;
    }

    @Override
    public void onNotificationCreated(boolean b, BeaconContent beaconContent) {

    }

    @Override
    public void onNotificationDeleted(boolean b, BeaconContent beaconContent, FEED_STATUS feed_status) {
        if(b){
            minNextTimeNotification = System.currentTimeMillis() + minTimeBetweenNotification;
        }
    }

    @Override
    public void onStartMonitoringRegion(BeaconContent beaconContent, FEED_STATUS feed_status) {

    }

    @Override
    public void onBackground() {

    }

    @Override
    public void onForeground() {

    }
}
