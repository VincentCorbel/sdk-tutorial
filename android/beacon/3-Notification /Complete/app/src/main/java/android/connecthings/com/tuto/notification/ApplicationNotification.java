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
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.ITG)
                .initUser("User_cbeacon", "fSKbCEvCDCbYTDlk").initCompany("ccbeacondemo");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If you need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "B0462602-CBF5-4ABB-87DE-B05340DCCBC5");
        AsyncBeaconNotificationImageCreator asyncBeaconNotificationCreator = new AsyncBeaconNotificationImageCreator(new MyBeaconNotificationImageBuilder(this));
        beaconManager.registerAsyncBeaconNotificationListener(asyncBeaconNotificationCreator);
    }

}
