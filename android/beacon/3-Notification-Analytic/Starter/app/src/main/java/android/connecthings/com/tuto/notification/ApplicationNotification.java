package android.connecthings.com.tuto.notification;

import android.app.Application;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.connecthings.adtag.AdtagInitializer;
import android.connecthings.adtag.analytics.AdtagLogsManager;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.Log;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.adtag.beacon.model.BeaconNotification;
import android.connecthings.util.connection.Network;
import android.connecthings.util.connection.Url;
import android.content.Intent;
import android.media.RingtoneManager;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;

/**
 */
public class ApplicationNotification extends Application implements BeaconNotification{

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.**PLATFORM**)
                .initUser("**USER**", "**PSW**").initCompany("**COMPANY**");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If youe need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "**UUID**");
        //Authorize the SDK to use the bluetooth
        beaconManager.saveBleAccessAuthorize(true);
        beaconManager.updateBeaconNotification(this);
    }

    public int createNotification(BeaconContent beaconContent) {
        Log.d(TAG, "create notification");
        if(TextUtils.isEmpty(beaconContent.getAlertTitle()) || TextUtils.isEmpty(beaconContent.getAlertDescription())){
            return -1;
        }
        //example of notification code
        if(mNotificationManager==null){
            mNotificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        }
        Intent notifyIntent = new Intent(Intent.ACTION_MAIN);
        notifyIntent.setClass(getApplicationContext(), MainActivity.class);


        PendingIntent intent = PendingIntent.getActivity(this, 0,
                notifyIntent,  PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(this);
        mNotificationBuilder.setContentTitle(beaconContent.getNotificationTitle());
        mNotificationBuilder.setContentText(beaconContent.getNotificationDescription());
        mNotificationBuilder.setContentIntent(intent);
        mNotificationBuilder.setSmallIcon(R.mipmap.ic_launcher);
        mNotificationBuilder.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION));
        mNotificationBuilder.setAutoCancel(true);
        mNotificationBuilder.setVibrate(new long[]{1000, 1000 ,1000});
        mNotificationManager.notify(NOTIFICATION_BEACON_ID, mNotificationBuilder.build());
        return NOTIFICATION_BEACON_ID;
    }

}
