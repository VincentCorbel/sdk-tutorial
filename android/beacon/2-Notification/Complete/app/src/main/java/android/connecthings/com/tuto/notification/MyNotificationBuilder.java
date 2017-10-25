package android.connecthings.com.tuto.notification;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;

import com.connecthings.connectplace.actions.model.PlaceNotification;
import com.connecthings.connectplace.actions.model.PlaceNotificationImage;
import com.connecthings.connectplace.actions.notification.builder.interfaces.NotificationBuilder;

import java.util.UUID;

/**
 * Created by Connecthings on 20/01/17.
 */
public class MyNotificationBuilder implements NotificationBuilder {
    private Context context;
    private String channelId = UUID.randomUUID().toString();

    public MyNotificationBuilder(Context context) {
        this.context = context.getApplicationContext();
    }

    @Override
    public NotificationCompat.Builder generateNotificationBuilder(PlaceNotificationImage placeNotificationImage) {
        PlaceNotification placeNotification = placeNotificationImage.getPlaceNotification();

        NotificationCompat.Builder mNotificationBuilder = new NotificationCompat.Builder(context, channelId);
        mNotificationBuilder.setContentTitle(placeNotification.getTitle());
        mNotificationBuilder.setContentText(placeNotification.getDescription());

        if (placeNotification.hasImage()) {
            NotificationCompat.BigPictureStyle style = new NotificationCompat
                    .BigPictureStyle()
                    .bigPicture(placeNotificationImage.getImageBitmap());
            if (placeNotification.hasThumbnail()) {
                style.bigLargeIcon(placeNotificationImage.getThumbnailBitmap());
            }
            mNotificationBuilder.setStyle(style);
        }

        mNotificationBuilder.setSmallIcon(R.drawable.icon_notification_ble_ask_permission);
        mNotificationBuilder.setAutoCancel(true);
        return mNotificationBuilder;
    }

    @Override
    public Intent generateIntentPackage(PlaceNotificationImage placeNotificationImage) {
        PackageManager packageManager = this.context.getPackageManager();
        Intent intentPackage;
        if (TextUtils.isEmpty(placeNotificationImage.getDeepLink())) {
            intentPackage = packageManager.getLaunchIntentForPackage(this.context.getPackageName());
            intentPackage.addCategory(Intent.CATEGORY_HOME);
        } else {
            intentPackage = new Intent(Intent.ACTION_VIEW, Uri.parse(placeNotificationImage.getDeepLink()));
        }
        intentPackage.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        return intentPackage;
    }
}