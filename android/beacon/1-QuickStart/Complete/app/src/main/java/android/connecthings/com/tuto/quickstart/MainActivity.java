package android.connecthings.com.tuto.quickstart;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.connecthings.connectplace.common.content.detection.InProximityInForeground;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;

import java.util.List;

public class MainActivity extends AppCompatActivity implements InProximityInForeground<AdtagPlaceInAppAction> {
    private TextView tvBeaconNumber;
    private List<AdtagPlaceInAppAction> previousListOfPlaceInAppAction;
    private BeaconArrayAdapter beaconArrayAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvBeaconNumber = findViewById(R.id.tv_beacon_number);
        beaconArrayAdapter = new BeaconArrayAdapter(this);
        ((ListView) findViewById(R.id.list_beacons)).setAdapter(beaconArrayAdapter);

        AdtagBeaconManager.getInstance().registerInProximityInForeground(this);
    }

    @Override
    public void proximityContentsInForeground(@NonNull List<AdtagPlaceInAppAction> placeInAppActions) {
        tvBeaconNumber.setText(getString(R.string.tv_beacon_number, placeInAppActions.size()));
        if (placeInAppActions.size() > 0) {
            findViewById(R.id.tv_beacon_next_step).setVisibility(View.VISIBLE);
        }
        if (previousListOfPlaceInAppAction == null || previousListOfPlaceInAppAction.size() != placeInAppActions.size() || !placeInAppActions.containsAll(previousListOfPlaceInAppAction)) {
            beaconArrayAdapter.setList(placeInAppActions);
        }
        previousListOfPlaceInAppAction = placeInAppActions;
    }
}
