package android.connecthings.com.tuto.notification;

import android.app.Notification;
import android.content.Context;
import android.support.annotation.NonNull;

import com.connecthings.util.adtag.beacon.model.welcomeNotification.AsyncBeaconWelcomeNotificationListener;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.AsyncBeaconWelcomeNotificationManager;
import com.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotification;

/**
 * Created by Connecthings on 27/01/17.
 */

public class MyAsyncBeaconWelcomeNotification implements AsyncBeaconWelcomeNotificationListener{

    private Context context;

    public MyAsyncBeaconWelcomeNotification(Context context) {
        this.context = context.getApplicationContext();
    }

    @Override
    public void createBeaconWelcomeNotification(@NonNull BeaconWelcomeNotification beaconWelcomeNotification, @NonNull AsyncBeaconWelcomeNotificationManager asyncBeaconWelcomeNotificationManager) {
        //Just a simple overview of the class to use...in syncrhone way...
        asyncBeaconWelcomeNotificationManager.displayBeaconWelcomeNotification(beaconWelcomeNotification, createNotification(beaconWelcomeNotification));
    }

    public Notification createNotification(BeaconWelcomeNotification beaconWelcomeNotification){
        return null;
    }
}
