package android.connecthings.com.tuto.notification;

import android.connecthings.adtag.analytics.model.AdtagLogData;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {

    public static String BEACON_CONTENT = "com.connecthings.beaconContent";

    private BeaconContent beaconContent = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if(getIntent().getExtras() != null){
            beaconContent = getIntent().getExtras().getParcelable(BEACON_CONTENT);
            if(beaconContent != null) {
                ((TextView) findViewById(R.id.beacon_content)).setText(getString(R.string.beacon_content, beaconContent.getNotificationTitle()));
                AdtagBeaconManager.getInstance().sendRedirectLog(beaconContent, AdtagLogData.REDIRECT_TYPE.NOTIFICATION, AdtagLogData.REDIRECT_TYPE.NOTIFICATION.toString());
            }
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
