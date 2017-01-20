package android.connecthings.com.tuto.notification;

import com.connecthings.adtag.analytics.model.AdtagLogData;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconIntent;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private BeaconContent beaconContent = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if(getIntent().getExtras() != null && getIntent().getExtras().getString(BeaconIntent.REDIRECT_TYPE, "").equals(AdtagLogData.REDIRECT_TYPE.NOTIFICATION)){
            ((TextView) findViewById(R.id.beacon_content)).setText(getString(R.string.beacon_content));
        }
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
