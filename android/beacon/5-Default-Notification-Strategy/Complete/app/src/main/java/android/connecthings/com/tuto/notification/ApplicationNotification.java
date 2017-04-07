package android.connecthings.com.tuto.notification;

import android.app.Application;
import android.app.NotificationManager;
import android.app.PendingIntent;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.altbeacon.beacon.BeaconManager;
import com.connecthings.util.Log;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconNotification;
import com.connecthings.util.adtag.beacon.strategy.notification.BeaconNotificationStrategySpamMaxFilter;
import com.connecthings.util.adtag.beacon.strategy.notification.BeaconNotificationStrategySpamRegionFilter;
import com.connecthings.util.adtag.beacon.strategy.notification.BeaconNotificationStrategySpamTimeFilter;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;
import android.content.Intent;
import android.media.RingtoneManager;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;

/**
 */
public class ApplicationNotification extends Application {

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.__PLATFORM__)
                .initUser("__USER__", "__PSW__").initCompany("__COMPANY__").synchronize();
        /**
         * *************    NOTIFICATION STRATEGY   ***********************
         */
        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        //Register the strategy to the beaocn Manager
        // The strategy must be registered as well to custom strategies list on the Adtag Platform to be activated
        beaconManager.registerNotificationStrategy(new BeaconNotificationStrategySpamRegionFilter("beacon-notification", "title"));

    }

}
