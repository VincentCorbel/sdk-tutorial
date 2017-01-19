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
import com.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotification;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;
import android.content.Intent;
import android.media.RingtoneManager;
import android.support.v4.app.NotificationCompat;

/**
 */
public class ApplicationNotification extends Application implements BeaconNotification, BeaconWelcomeNotificationListener{

    private static final String TAG = "ApplicationNotification";
    private static final int NOTIFICATION_BEACON_ID = 1;
    private static final int NOTIFICATION_WELCOME_BEACON_ID = 2;
    private NotificationManager mNotificationManager;

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.**PLATFORM***)
                .initUser("***LOGIN***", "***PWS***").initCompany("***COMPANY***");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If youe need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "***UUID***");
        beaconManager.registerBeaconNotificationListener(this);

        BeaconWelcomeNotification beaconDefaultNotificationOn = new BeaconWelcomeNotification(BeaconWelcomeNotification.TYPE.NETWORK_ON,
                getString(R.string.beacon_welcome_on_title),
                getString(R.string.beacon_welcome_on_description),
                2 * 1000 * 60);
        beaconManager.addWelcomeNotification(beaconDefaultNotificationOn);
        BeaconWelcomeNotification beaconDefaultNotificationOff = new BeaconWelcomeNotification(BeaconWelcomeNotification.TYPE.NETWORK_ERROR,
                getString(R.string.beacon_welcome_off_title),
                getString(R.string.beacon_welcome_off_description),
                2*1000*60);
        beaconManager.addWelcomeNotification(beaconDefaultNotificationOff);
        beaconManager.registerBeaconWelcomeNotificationListener(this);
    }

    public int createNotification(BeaconContent beaconContent) {
        /**
         * NOT Mandatory if you don't need to personalise the beacon notificaiton.
         * The SDK comes with a default implementation of the BeaconNotification
         */
        Log.d(TAG, "create notification");
        //example of notification code
        if(mNotificationManager==null){
            mNotificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        }
        Intent notifyIntent = new Intent(Intent.ACTION_MAIN);
        notifyIntent.setClass(getApplicationContext(), MainActivity.class);
        notifyIntent.putExtra(MainActivity.FROM_NOTIFICATION, MainActivity.FROM_NOTIFICATION_BEACON);
        notifyIntent.putExtra(MainActivity.BEACON_WELCOME, beaconContent);
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

    @Override
    public int createWelcomeNotification(BeaconWelcomeNotification beaconDefaultNotification) {
        /**
         * NOT Mandatory if you don't need to personalise the welcome notificaiton.
         * The SDK comes with a default implementation of the BeaconWelcomeNotificationListener
         */
        if(mNotificationManager==null){
            mNotificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        }
        Intent notifyIntent = new Intent(Intent.ACTION_MAIN);
        notifyIntent.setClass(getApplicationContext(), MainActivity.class);
        notifyIntent.putExtra(MainActivity.FROM_NOTIFICATION, MainActivity.FROM_NOTIFICATION_WELCOME);
        notifyIntent.putExtra(MainActivity.BEACON_WELCOME, beaconDefaultNotification);
        PendingIntent intent = PendingIntent.getActivity(this, 0,
                notifyIntent,  PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(this);
        mNotificationBuilder.setContentTitle(beaconDefaultNotification.getTitle());
        mNotificationBuilder.setContentText(beaconDefaultNotification.getDescription());
        mNotificationBuilder.setContentIntent(intent);
        mNotificationBuilder.setSmallIcon(R.mipmap.ic_launcher);
        mNotificationBuilder.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION));
        mNotificationBuilder.setAutoCancel(true);
        mNotificationBuilder.setVibrate(new long[]{1000, 1000 ,1000});
        mNotificationManager.notify(NOTIFICATION_WELCOME_BEACON_ID, mNotificationBuilder.build());
        return NOTIFICATION_WELCOME_BEACON_ID;
    }
}
