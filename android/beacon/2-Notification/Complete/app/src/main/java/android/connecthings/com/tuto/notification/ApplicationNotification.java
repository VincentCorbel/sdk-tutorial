package android.connecthings.com.tuto.notification;

import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

public class ApplicationNotification extends Application {
    public void onCreate(){
        super.onCreate();

        AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("Lvi_cbeacon", "RGVZChwWe3LNqwBTY7qa")
                .initCompany("ccbeacondemo")
                .synchronize();

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        beaconManager.registeNotificationTask(new AsyncNotificationTask());
        beaconManager.registeNotificationBuilder(new MyNotificationBuilder(getApplicationContext()));
    }
}