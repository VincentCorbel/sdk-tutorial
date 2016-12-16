package android.connecthings.com.tuto.quickstart;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.connecthings.adtag.adtagEnum.FEED_STATUS;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconRange;
import com.connecthings.util.adtag.beacon.parser.AppleBeacon;

import java.util.List;

public class MainActivity extends AppCompatActivity implements BeaconRange{

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

    @Override
    public void didRangeBeacons(List<AppleBeacon> beacons, List<BeaconContent> beaconContents, BeaconContent.INFORMATION_STATUS informationStatus, FEED_STATUS feedStatus) {
        tvBeaconNumber.setText(getString(R.string.tv_beacon_number, feedStatus, beacons.size(), beaconContents.size()));
        if(beaconContents.size() > 0 && beaconContents.size() == beacons.size()){
            findViewById(R.id.tv_beacon_next_step).setVisibility(View.VISIBLE);
        }
        //update the beaconList when beaconContents update
        if(previousBeaconContents == null || previousBeaconContents.size() != beaconContents.size() || !beaconContents.containsAll(previousBeaconContents)){
            beaconArrayAdapter.setList(beaconContents);
        }
        previousBeaconContents = beaconContents;
    }
}
