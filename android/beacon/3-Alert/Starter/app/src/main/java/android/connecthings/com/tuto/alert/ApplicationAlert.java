package android.connecthings.com.tuto.alert;

import android.Manifest;
import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

public class ApplicationAlert extends Application{
    public void onCreate(){
        super.onCreate();

        AdtagInitializer.getInstance().
                initContext(this)
                .initUrlType(Url.UrlType.PRE_PROD)
                .initUser("__LOGIN__", "__PSWD__")
                .initCompany("__COMPANY__")
                .synchronize();

        AdtagInitializer.getInstance().addPermissionToAsk(Manifest.permission.ACCESS_COARSE_LOCATION);
    }
}