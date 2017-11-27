package android.connecthings.com.tuto.notification;

import android.Manifest;
import android.app.Application;
import android.os.Build;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

public class ApplicationNotification extends Application {
    public void onCreate() {
        super.onCreate();

        AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("__LOGIN__", "__PSWD__")
                .initCompany("__COMPANY__")
                .synchronize();

        AdtagInitializer.getInstance().addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);

        //To configure the notification group filter. Need a configuration on AdTag as well.
        //AdtagInitializer.getInstance().initGroup("sdk-group-filter", "group-filter");
        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        beaconManager.registerEnterNotificationTask(new AsyncNotificationTask());
        beaconManager.registerEnterNotificationBuilder(new MyNotificationBuilder(getApplicationContext()));
        //To configure builder and asyncTask for the welcome notification process
        //beaconManager.registerEnterWelcomeNotificationTask(new AsyncNotificationTask());
        //beaconManager.registerEnterWelcomeNotificationBuilder(new MyNotificationBuilder(getApplicationContext()));
        beaconManager.registerNotificationFilter(new MyNotificationFilter(60 * 3 * 1000));
    }
}