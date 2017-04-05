package android.connecthings.com.tuto.notification;

import android.app.Application;
import android.app.NotificationManager;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.notification.AsyncBeaconNotificationImageCreator;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;

/**
 */
public class ApplicationNotification extends Application {

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.PROD)
                .initUser("__USER__", "__PSWD__").initCompany("__COMPANY__").synchronize();

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        AsyncBeaconNotificationImageCreator asyncBeaconNotificationCreator = new AsyncBeaconNotificationImageCreator(this, new MyBeaconNotificationImageBuilder(this));
        beaconManager.registerAsyncBeaconNotificationListener(asyncBeaconNotificationCreator);
    }

}
