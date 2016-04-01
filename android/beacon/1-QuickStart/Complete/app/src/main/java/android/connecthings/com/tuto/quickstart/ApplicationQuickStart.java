package android.connecthings.com.tuto.quickstart;

import android.app.Application;
import android.connecthings.adtag.AdtagInitializer;
import android.connecthings.adtag.analytics.AdtagLogsManager;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.connection.Network;
import android.connecthings.util.connection.Url;
import android.widget.TextView;

/**
 */
public class ApplicationQuickStart extends Application{

    private static final String UUID = "_YourUUID_";



    public void onCreate(){
        super.onCreate();
        AdtagInitializer.initInstance(this).initUrlType(Url.UrlType.ITG)
                .initUser("_YourLogin_", "_YourPasssword_").initCompany("_YourCompany_");
        //Initiate the adtagLogManager that manages the way log are sent to the platform
        AdtagLogsManager.initInstance(this, Network.ALL, 200, 1000 * 60 * 2);
        //If youe need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);
        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid
        AdtagBeaconManager beaconManager = AdtagBeaconManager.initInstance(this, UUID);
        //Authorize the SDK to use the bluetooth
        beaconManager.saveBleAccessAuthorize(true);
    }

}
