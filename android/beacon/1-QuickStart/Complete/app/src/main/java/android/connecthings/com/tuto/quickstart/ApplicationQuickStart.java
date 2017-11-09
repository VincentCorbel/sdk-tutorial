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
        AdtagInitializer adtagInitializer = AdtagInitializer.getInstance().initContext(this).initUrlType(Url.UrlType.PROD)
                .initUser("__LOGIN__", "__PSWD__").initCompany("__COMPANY__");
        adtagInitializer.synchronize();


        adtagInitializer.addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);
    }

}