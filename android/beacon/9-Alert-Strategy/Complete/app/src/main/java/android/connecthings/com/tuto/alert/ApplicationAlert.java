package android.connecthings.com.tuto.alert;

import android.app.Application;
import android.connecthings.adtag.AdtagInitializer;
import android.connecthings.adtag.analytics.AdtagLogsManager;
import android.connecthings.com.tuto.alert.firstWay.TimeAlertStrategy;
import android.connecthings.util.Log;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.adtag.beacon.bluetooth.permission.BluetoothManager;
import android.connecthings.util.adtag.beacon.model.welcomeNotification.FirstNotificationTesterTimer;
import android.connecthings.util.adtag.beacon.scanningPeriod.BeaconScanningPeriodManagerOptimizer;
import android.connecthings.util.connection.Network;
import android.connecthings.util.connection.Url;

/**
 */
public class ApplicationAlert extends Application{

    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.PROD)
                .initUser("User_cbeacon", "fSKbCEvCDCbYTDlk").initCompany("ccbeacondemo");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If youe need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, "B0462602-CBF5-4ABB-87DE-B05340DCCBC4");
        beaconManager.setEnableBluetoothWhenAppInBackground(BluetoothManager.BLUETOOTH_BACKGROUND_ACTIVATION_STATUS.ENABLE);
        //Register your additional strategy
        beaconManager.addAlertStrategy(new TimeAlertStrategy(60*1 , 30000));
    }

}
