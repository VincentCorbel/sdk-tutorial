package android.connecthings.com.tuto.notification;

import com.connecthings.connectplace.actions.model.PlaceNotificationImage;
import com.connecthings.connectplace.actions.notification.builder.interfaces.DisplayPlaceNotificationListener;
import com.connecthings.connectplace.actions.notification.builder.interfaces.NotificationTask;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceNotification;

/**
 * Created by Connecthings on 20/01/17.
 */
public class AsyncNotificationTask implements NotificationTask<AdtagPlaceNotification> {
    @Override
    public void launchNotificationTask(AdtagPlaceNotification placeNotification, DisplayPlaceNotificationListener displayPlaceNotificationListener) {
        displayPlaceNotificationListener.displayPlaceNotification(new PlaceNotificationImage(placeNotification));
    }
}