package android.connecthings.com.tuto.quickstart;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.connecthings.adtag.AdtagInitializer;
import com.connecthings.connectplace.common.content.detection.InProximityInForeground;
import com.connecthings.connectplace.common.utils.healthCheck.HealthStatus;
import com.connecthings.connectplace.common.utils.healthCheck.ProximityHealthCheckListener;
import com.connecthings.connectplace.common.utils.healthCheck.ServiceStatus;
import com.connecthings.connectplace.common.utils.healthCheck.Status;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.bridge.AdtagPlaceInAppAction;

import java.util.List;

public class MainActivity extends AppCompatActivity implements InProximityInForeground<AdtagPlaceInAppAction>, ProximityHealthCheckListener {

    private TextView tvBeaconNumber;
    private List<AdtagPlaceInAppAction> previousList;

    private BeaconArrayAdapter beaconArrayAdapter;
    private AdtagBeaconManager adtagBeaconManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        adtagBeaconManager = AdtagBeaconManager.getInstance();
        tvBeaconNumber = findViewById(R.id.tv_beacon_number);

        beaconArrayAdapter = new BeaconArrayAdapter(this);
        ((ListView) findViewById(R.id.list_beacons)).setAdapter(beaconArrayAdapter);
    }

    protected void onResume() {
        super.onResume();
        adtagBeaconManager.registerInProximityInForeground(this);
        AdtagInitializer.getInstance().registerProximityHealthCheckListener(this);
    }

    protected void onPause() {
        adtagBeaconManager.unregisterInProximityInForeground(this);
        AdtagInitializer.getInstance().unregisterProximityHealthCheckListener(this);
        super.onPause();
    }

    @Override
    public void proximityContentsInForeground(@NonNull List<AdtagPlaceInAppAction> list) {
        tvBeaconNumber.setText(getString(R.string.tv_beacon_number, list.size()));
        if (list.size() > 0) {
            findViewById(R.id.tv_beacon_next_step).setVisibility(View.VISIBLE);
        }
        if (previousList == null || previousList.size() != list.size() || !list.containsAll(previousList)) {
            beaconArrayAdapter.setList(list);
        }
        previousList = list;
    }

    @Override
    public void onProximityHealthCheckUpdate(HealthStatus healthStatus) {
        String errors = "";
        if (healthStatus.isDown()) {
            for (ServiceStatus serviceStatus : healthStatus.getServiceStatusMap().values()) {
                if (serviceStatus.isDown()) {
                    for (Status status : serviceStatus.getStatusList()) {
                        errors += status.getMessage() + "\n";
                    }
                }
            }
            tvBeaconNumber.setText(errors);
        } else {
            tvBeaconNumber.setText(errors);
        }
    }
}
