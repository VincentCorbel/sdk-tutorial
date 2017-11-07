package android.connecthings.com.tuto.quickstart;

import android.Manifest;
import android.app.Application;
import android.os.Build;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

public class ApplicationQuickStart extends Application {
    public void onCreate(){
        super.onCreate();

        AdtagInitializer adtagInitializer = AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("Lvi_cbeacon", "RGVZChwWe3LNqwBTY7qa")
                .initCompany("ccbeacondemo");
        adtagInitializer.synchronize();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            adtagInitializer.addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);
        }

        AdtagBeaconManager.getInstance().registerNotificationFilter(new MyNotificationFilter(5 * 60 * 1000));
    }
}
