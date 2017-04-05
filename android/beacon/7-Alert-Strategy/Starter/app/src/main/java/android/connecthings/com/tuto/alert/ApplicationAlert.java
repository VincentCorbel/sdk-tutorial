package android.connecthings.com.tuto.alert;

import android.app.Application;
import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.analytics.AdtagLogsManager;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.permission.bluetooth.BluetoothManager;
import com.connecthings.util.connection.Network;
import com.connecthings.util.connection.Url;

/**
 */
public class ApplicationAlert extends Application{

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.****)
                .initUser("__LOGIN__", "__PASSWORD__").initCompany("__COMPANY__").synchronize();
    }

}
