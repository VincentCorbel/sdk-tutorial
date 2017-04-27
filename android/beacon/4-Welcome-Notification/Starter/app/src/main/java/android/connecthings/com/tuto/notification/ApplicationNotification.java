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

/**
 */
public class ApplicationNotification extends Application{

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private static final int NOTIFICATION_WELCOME_BEACON_ID = 2;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.PROD).initUser("**LOGIN**", "**PSW**").initCompany("**COMPANY**").synchronize();
        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
    }


}