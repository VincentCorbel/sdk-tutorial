package android.connecthings.com.tuto.notification;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.support.v4.app.NotificationCompat;

import com.connecthings.util.adtag.beacon.model.BeaconIntent;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotificationImage;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotificationImageBuilder;

/**
 * Created by Connecthings on 27/01/17.
 */

public class MyBeaconWelcomeNotificationImageBuilder implements BeaconWelcomeNotificationImageBuilder{

    private Context context;

    public MyBeaconWelcomeNotificationImageBuilder(Context context) {
        this.context = context.getApplicationContext();
    }

    @Override
    public Notification buildWelcomeBeaconNotification(BeaconWelcomeNotificationImage beaconWelcomeNotificationImage) {
        PackageManager packageManager = context.getPackageManager();
        Intent intentPackage = packageManager.getLaunchIntentForPackage(context.getPackageName());
        if(beaconWelcomeNotificationImage.isDeepLinkEmpty()) {
            intentPackage.addCategory(Intent.CATEGORY_HOME);
            intentPackage.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }else{
            intentPackage = new Intent(Intent.ACTION_VIEW, Uri.parse(beaconWelcomeNotificationImage.getDeepLink()));
        }
        //Configure the Intent to permit to the SDK to generate the analytics
        //if your activity needs to accees to the welcomeNotification, it's possible using intent.getBundle.getParcelable(BeaconIntent.WELCOME_NOTIFICATION_CONTENT);
        BeaconIntent.configureWelcomeNotificationIntent(intentPackage, beaconWelcomeNotificationImage.getWelcomeNotification());


        PendingIntent intent = PendingIntent.getActivity(context, 0,
                intentPackage,  PendingIntent.FLAG_UPDATE_CURRENT);

        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(context);
        mNotificationBuilder.setContentTitle(beaconWelcomeNotificationImage.getTitle());
        mNotificationBuilder.setContentText(beaconWelcomeNotificationImage.getDescription());
        mNotificationBuilder.setContentIntent(intent);
        mNotificationBuilder.setSmallIcon(R.drawable.icon_beacon_welcome_notification);
        mNotificationBuilder.setAutoCancel(true);
        if(beaconWelcomeNotificationImage.hasImage()){
            NotificationCompat.BigPictureStyle style = new NotificationCompat
                    .BigPictureStyle()
                    .bigPicture(beaconWelcomeNotificationImage.getImage());
            if(beaconWelcomeNotificationImage.hasThumbnail()){
                style.bigLargeIcon(beaconWelcomeNotificationImage
                        .getThumbnail());
            }
            mNotificationBuilder.setStyle(style);
        }
        return mNotificationBuilder.build();
    }
}
