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

        AdtagInitializer
                .initInstance(this)
                .initUrlType(Url.UrlType.DEV)
                .initUser(USER, PASS)
                .initCompany(COMPANY)
                .synchronize();

        AdtagBeaconManager.getInstance().registerNotificationStrategy(new BeaconNotificationStrategyFilter(5 * 60 * 1000));
    }
}