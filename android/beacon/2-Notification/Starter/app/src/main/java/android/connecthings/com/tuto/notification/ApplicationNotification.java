package android.connecthings.com.tuto.notification;

import android.Manifest;
import android.app.Application;

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

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
    }
}