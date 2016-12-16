package android.connecthings.com.tuto.notification;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;


public class MainActivity extends AppCompatActivity {

    public static String BEACON_CONTENT = "com.connecthings.beaconContent";

    private BeaconContent beaconContent = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    protected void onResume(){
        super.onResume();
        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        BLE_STATUS checkStatus = beaconManager.checkBleStatus();
        //Activate the bluetooth
        if(checkStatus == BLE_STATUS.DISABLED) {
            if (beaconManager.isBleAccessAuthorize()) {
                beaconManager.enableBluetooth();
            }
        }
    }

}
