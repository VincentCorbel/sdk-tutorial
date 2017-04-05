package android.connecthings.com.tuto.notification;

import android.app.Application;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.connection.Url;

public class ApplicationNotification extends Application {
    private static final String TAG = ApplicationNotification.class.getSimpleName();

    final String USER = "";
    final String PASS = "";
    final String COMPANY = "";

    public void onCreate() {
        super.onCreate();

        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.**PLATFORM**)
                .initUser("**LOGIN**", "**PASSWORD**").initCompany("***COMPANY***").synchronize();

        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        //Waits 5 min before showing a new beacon notification
        beaconManager.registerNotificationStrategy(new BeaconNotificationStrategyFilter(1000 * 60 * 5));
    }


}
