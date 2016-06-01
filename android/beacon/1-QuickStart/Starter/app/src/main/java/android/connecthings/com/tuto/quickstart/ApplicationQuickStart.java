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

    private static final String UUID = "B0462602-CBF5-4ABB-87DE-B05340DCCBC5";



    public void onCreate(){
        super.onCreate();
        //Intiate the AdtagInitializer

        //Initiate the adtagLogManager that manages the way log are sent to the platform

        //If you need more parameter - AdtagLogsManager.initInstance(this, Network.ALL,  50, 1000*60*2);

        //Initiate the beaconManager with the UUID of your beacons company. our beaconManager manage only one beacon Region based on the uuid

        //Authorize the SDK to use the bluetooth

    }

}
