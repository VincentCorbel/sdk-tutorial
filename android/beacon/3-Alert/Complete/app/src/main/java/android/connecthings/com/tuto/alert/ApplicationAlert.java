package android.connecthings.com.tuto.alert;

import android.Manifest;
import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.connection.Url;

public class ApplicationAlert extends Application{
    public void onCreate(){
        super.onCreate();

        AdtagInitializer.getInstance().
                initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("Lvi_cbeacon", "RGVZChwWe3LNqwBTY7qa")
                .initCompany("ccbeacondemo")
                .synchronize();

        AdtagInitializer.getInstance().addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);
    }
}