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

    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
       AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.**PLATFORM**)
                .initUser("**USER**", "**PSW**").initCompany("**COMPANY**");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If you need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "**UUID**");

        //If you want to implement your own AsyncBeaconNotificationListener
        //beaconManager.registerAsyncBeaconNotificationListener(new AsyncBeaconNotificationCreator(this));
    }


}
