package android.connecthings.com.tuto.permission;

import android.app.Application;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;

/**
 */
public class ApplicationPermission extends Application{

    public void onCreate(){
        super.onCreate();
       AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.__PLATFORM__)
               .initUser("__LOGIN__", "__PWS__").initCompany("__COMPANY__").synchronize();
    }





}
