package android.connecthings.com.tuto.notification;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;

import com.connecthings.util.adtag.beacon.model.BeaconIntent;
import com.connecthings.util.adtag.beacon.model.notification.BeaconContentImage;
import com.connecthings.util.adtag.beacon.model.notification.BeaconImageNotificationBuilder;

/**
 * Created by Connecthings on 20/01/17.
 */
public class MyBeaconNotificationImageBuilder implements BeaconImageNotificationBuilder {

    private Context mContext;

    public MyBeaconNotificationImageBuilder(Context mContext) {
        this.mContext = mContext.getApplicationContext();
    }

    @Override
    public Notification buildBeaconNotification(BeaconContentImage beaconContentImage) {
        PackageManager packageManager = this.mContext.getPackageManager();
        Intent intentPackage = null;
        if(TextUtils.isEmpty(beaconContentImage.getUri())) {
            intentPackage = packageManager.getLaunchIntentForPackage(this.mContext.getPackageName());
            intentPackage.addCategory(Intent.CATEGORY_HOME);
        }else{
            intentPackage = new Intent(Intent.ACTION_VIEW, Uri.parse(beaconContentImage.getUri()));
        }
        intentPackage.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        //!!! Automatic configuration of the Intent that permits to the SDK to generate analytics
        BeaconIntent.configureNotificationIntent(intentPackage, beaconContentImage.getBeaconContent());

        PendingIntent intent = PendingIntent.getActivity(this.mContext, 0,
                intentPackage,  PendingIntent.FLAG_UPDATE_CURRENT);

        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(this.mContext);
        mNotificationBuilder.setContentTitle(beaconContentImage.getNotificationTitle());
        mNotificationBuilder.setContentText(beaconContentImage.getNotificationDescription());
        if(beaconContentImage.hasImage()){
            NotificationCompat.BigPictureStyle style = new NotificationCompat
                    .BigPictureStyle()
                    .bigPicture(beaconContentImage.getImage());
            if(beaconContentImage.hasThumbnail()){
                style.bigLargeIcon(beaconContentImage.getThumbnail());
            }
            mNotificationBuilder.setStyle(style);
        }
        mNotificationBuilder.setContentIntent(intent);
        mNotificationBuilder.setSmallIcon(R.drawable.icon_beacon_notification);
        mNotificationBuilder.setAutoCancel(true);

        return mNotificationBuilder.build();
    }
}
