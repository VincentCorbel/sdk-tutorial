package android.connecthings.com.tuto.notification;

import com.connecthings.connectplace.actions.model.PlaceNotification;
import com.connecthings.connectplace.actions.model.PlaceNotificationImage;
import com.connecthings.connectplace.actions.notification.builder.interfaces.DisplayPlaceNotificationListener;
import com.connecthings.connectplace.actions.notification.builder.interfaces.NotificationTask;

/**
 * Created by Connecthings on 20/01/17.
 */
public class AsyncNotificationTask implements NotificationTask {
    @Override
    public void launchNotificationTask(PlaceNotification placeNotification, DisplayPlaceNotificationListener displayPlaceNotificationListener) {
        // Very simple use case with no async at all, just to show some codes. Use the asyncBeaconNotificationManager to display
        // your notification when your async job finishes.
        displayPlaceNotificationListener.displayPlaceNotification(new PlaceNotificationImage(placeNotification));
    }
}