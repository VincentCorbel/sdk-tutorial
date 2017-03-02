package android.connecthings.com.tuto.notification;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;

import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.adtag.beacon.model.BeaconIntent;
import com.connecthings.util.adtag.beacon.model.notification.AsyncBeaconNotificationListener;
import com.connecthings.util.adtag.beacon.model.notification.AsyncBeaconNotificationManager;
import com.connecthings.util.adtag.beacon.model.notification.BeaconContentImage;

/**
 * Created by Connecthings on 20/01/17.
 */
public class AsyncBeaconNotificationCreator implements AsyncBeaconNotificationListener{

    private Context mContext;

    public AsyncBeaconNotificationCreator(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public void createBeaconNotification(@NonNull BeaconContent beaconContent, @NonNull AsyncBeaconNotificationManager asyncBeaconNotificationManager) {
        //Very simple use case with no async at all, just to show some codes
        //Use the asyncBeaconNotificationManager to display your notification when your async job finishes
        asyncBeaconNotificationManager.displayBeaconNotification(beaconContent, buildBeaconNotification(beaconContent));
    }

    public Notification buildBeaconNotification(BeaconContent beaconContent) {
        PackageManager packageManager = this.mContext.getPackageManager();
        Intent intentPackage = null;
        if(TextUtils.isEmpty(beaconContent.getUri())) {
            intentPackage = packageManager.getLaunchIntentForPackage(this.mContext.getPackageName());
            intentPackage.addCategory(Intent.CATEGORY_HOME);
        }else{
            intentPackage = new Intent(Intent.ACTION_VIEW, Uri.parse(beaconContent.getUri()));
        }
        intentPackage.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        BeaconIntent.configureNotificationIntent(intentPackage, beaconContent);

        PendingIntent intent = PendingIntent.getActivity(this.mContext, 0,
                intentPackage,  PendingIntent.FLAG_UPDATE_CURRENT);

        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(this.mContext);
        mNotificationBuilder.setContentTitle(beaconContent.getNotificationTitle());
        mNotificationBuilder.setContentText(beaconContent.getNotificationDescription());
        mNotificationBuilder.setContentIntent(intent);
        mNotificationBuilder.setSmallIcon(R.drawable.icon_beacon_notification);
        mNotificationBuilder.setAutoCancel(true);
        return mNotificationBuilder.build();
    }

}
