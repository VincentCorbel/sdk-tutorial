package android.connecthings.com.tuto.range;

import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ListView;
import android.widget.TextView;

import java.util.List;

public class MainActivity extends AppCompatActivity{

    private TextView tvBeaconNumber;
    private List<BeaconContent> previousBeaconContents;
    private BeaconArrayAdapter beaconArrayAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvBeaconNumber = (TextView) findViewById(R.id.tv_beacon_number);
        beaconArrayAdapter = new BeaconArrayAdapter(this);
        ((ListView) findViewById(R.id.list_beacons)).setAdapter(beaconArrayAdapter);
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
