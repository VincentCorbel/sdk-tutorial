package android.connecthings.com.tuto.quickstart;

import android.support.annotation.NonNull;

import com.connecthings.connectplace.actions.model.PlaceNotification;
import com.connecthings.connectplace.actions.notification.filters.NotificationFilter;
import com.connecthings.connectplace.common.utils.dataholder.DataHolder;

/**
 * Created by Connecthings on 07/11/2017.
 */
public class MyNotificationFilter implements NotificationFilter {
    private static final String MIN_NEXT_TIME_NOTIFICATION = "com.tuto.notification.minNextTimeNotification";
    private long minNextTimeNotification;
    private int minTimeBetweenNotification;

    public MyNotificationFilter(int minTimeBetweenNotification) {
        this.minTimeBetweenNotification = minTimeBetweenNotification;
    }

    @Override
    public String getName() {
        return MyNotificationFilter.class.getSimpleName();
    }

    @Override
    public boolean createNewNotification(@NonNull PlaceNotification placeNotification) {
        return minNextTimeNotification < System.currentTimeMillis();
    }

    @Override
    public boolean deleteCurrentNotification(@NonNull PlaceNotification placeNotification) {
        return true;
    }

    @Override
    public void onNotificationCreated(@NonNull PlaceNotification placeNotification, boolean b) {

    }

    @Override
    public void onNotificationDeleted(@NonNull PlaceNotification placeNotification, boolean deleted) {
        if (deleted) {
            minNextTimeNotification = System.currentTimeMillis() + minTimeBetweenNotification;
        }
    }

    @Override
    public void onBackground() {

    }

    @Override
    public void onForeground() {

    }

    @Override
    public void load(@NonNull DataHolder dataHolder) {
        minNextTimeNotification = dataHolder.getLong(MIN_NEXT_TIME_NOTIFICATION, 0);
    }

    @Override
    public void save(@NonNull DataHolder dataHolder) {
        dataHolder.putLong(MIN_NEXT_TIME_NOTIFICATION, minNextTimeNotification);
    }

    @Override
    public void updateParameters(@NonNull Object o) {

    }
}