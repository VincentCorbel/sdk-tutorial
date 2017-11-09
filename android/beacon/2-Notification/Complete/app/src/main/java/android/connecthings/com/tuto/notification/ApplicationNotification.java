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
                .initUrlType(Url.UrlType.PROD)
                .initUser("user", "pass")
                .initCompany("company")
                .synchronize();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            AdtagInitializer.getInstance().addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);
        }

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        beaconManager.registeNotificationTask(new AsyncNotificationTask());
        beaconManager.registeNotificationBuilder(new MyNotificationBuilder(getApplicationContext()));
    }
}