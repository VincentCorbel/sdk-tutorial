package android.connecthings.com.tuto.quickstart;

import android.Manifest;
import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.connection.Url;

public class ApplicationQuickStart extends Application {
    public void onCreate() {
        super.onCreate();

        AdtagInitializer adtagInitializer = AdtagInitializer.getInstance()
                .initContext(this)
                .initUrlType(Url.UrlType.PROD)
                .initUser("__USER__", "__PASSWORD__")
                .initCompany("__COMPANY__");

        adtagInitializer.synchronize();
        adtagInitializer.addPermissionToAsk(Manifest.permission.ACCESS_FINE_LOCATION);
    }
}