package android.connecthings.com.tuto.alert;

import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

/**
 */
public class ApplicationAlert extends Application {
    public void onCreate() {
        super.onCreate();

        AdtagInitializer
                .initInstance(this)
                .initUrlType(Url.UrlType.PROD)
                .initUser("__USER__", "__PASS__")
                .initCompany("__COMPANY_KEY__")
                .synchronize();

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        beaconManager.addAlertStrategy(new TimeAlertStrategySecondWay(30000 , 60000));
    }
}