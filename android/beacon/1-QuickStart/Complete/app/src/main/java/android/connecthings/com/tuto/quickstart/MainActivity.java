package android.connecthings.com.tuto.quickstart;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.connectplace.common.content.detection.InProximityInForeground;
import com.connecthings.connectplace.common.utils.error.ProximityErrorListener;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;
import com.connecthings.util.adtag.beacon.model.BeaconRange;

import java.util.List;

public class MainActivity extends AppCompatActivity implements InProximityInForeground<AdtagPlaceInAppAction>, ProximityErrorListener {

    private TextView tvBeaconNumber;
    private List<AdtagPlaceInAppAction> previousList;
    private BeaconArrayAdapter beaconArrayAdapter;
    private AdtagBeaconManager adtagBeaconManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        adtagBeaconManager = AdtagBeaconManager.getInstance();
        tvBeaconNumber = (TextView) findViewById(R.id.tv_beacon_number);
        beaconArrayAdapter = new BeaconArrayAdapter(this);
        ((ListView) findViewById(R.id.list_beacons)).setAdapter(beaconArrayAdapter);
    }

    protected void onResume(){
        super.onResume();
        adtagBeaconManager.registerInProximityInForeground(this);
        AdtagInitializer.getInstance().registerProximityErrorListener(this);
    }

    protected  void onPause() {
        adtagBeaconManager.unregisterInProximityInForeground(this);
        AdtagInitializer.getInstance().unregisterProximityErrorListener(this);
        super.onPause();
    }

    @Override
    public void proximityContentsInForeground(@NonNull List<AdtagPlaceInAppAction> list) {
        tvBeaconNumber.setText(getString(R.string.tv_beacon_number, list.size());
        if(list.size() > 0){
            findViewById(R.id.tv_beacon_next_step).setVisibility(View.VISIBLE);
        }
        //update the beaconList when beaconContents update
        if(previousList == null || previousList.size() != list.size() || !list.containsAll(previousList)){
            beaconArrayAdapter.setList(list);
        }
        previousList = list;
    }

    @Override
    public void onProximityError(int i, @NonNull String s) {
        tvBeaconNumber.setText(s);
    }
}
