package android.connecthings.com.tuto.quickstart;

import android.Manifest;
import android.app.Application;
import android.os.Build;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;

/**
 */
public class ApplicationQuickStart extends Application{

    public void onCreate(){
        super.onCreate();
        AdtagInitializer adtagInitializer = AdtagInitializer.getInstance().initContext(this).initUrlType(Url.UrlType.PROD)
                .initUser("__LOGIN__", "__PSWD__").initCompany("__COMPANY__");
        adtagInitializer.synchronize();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            adtagInitializer.addPermission(Manifest.permission.ACCESS_COARSE_LOCATION);
        }
    }

}
