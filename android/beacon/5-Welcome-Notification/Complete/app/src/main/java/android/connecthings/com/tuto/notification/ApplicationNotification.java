package android.connecthings.com.tuto.notification;

import android.app.Application;
import android.app.NotificationManager;
import android.app.PendingIntent;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.Log;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconNotification;
import com.connecthings.util.adtag.beacon.model.BeaconWelcomeNotificationListener;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.AsyncBeaconWelcomeNotificationImageCreator;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotification;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;
import android.content.Intent;
import android.media.RingtoneManager;
import android.support.v4.app.NotificationCompat;

/**
 */
public class ApplicationNotification extends Application {

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private static final int NOTIFICATION_WELCOME_BEACON_ID = 2;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.__PLATFORM__)
                .initUser("__LOGIN__", "__PSWD__").initCompany("__COMPANY__");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If you need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "__UUID__");

        BeaconWelcomeNotification beaconDefaultNotificationOn = new BeaconWelcomeNotification(BeaconWelcomeNotification.TYPE.NETWORK_ON,
                getString(R.string.beacon_welcome_on_title),
                getString(R.string.beacon_welcome_on_description),
                -1,
                R.drawable.wn_network_on,
                2 * 1000 * 60);
        beaconManager.addWelcomeNotification(beaconDefaultNotificationOn);
        BeaconWelcomeNotification beaconDefaultNotificationOff = new BeaconWelcomeNotification(BeaconWelcomeNotification.TYPE.NETWORK_ERROR,
                getString(R.string.beacon_welcome_off_title),
                getString(R.string.beacon_welcome_off_description),
                -1,
                R.drawable.wn_network_off,
                2*1000*60);
        beaconManager.addWelcomeNotification(beaconDefaultNotificationOff);
        AsyncBeaconWelcomeNotificationImageCreator asyncBeaconWelcomeNotificationCreator = new AsyncBeaconWelcomeNotificationImageCreator(new MyBeaconWelcomeNotificationImageBuilder(this), this.getResources());
        beaconManager.registerAsyncBeaconWelcomeNotificationListener(asyncBeaconWelcomeNotificationCreator);
    }

}
