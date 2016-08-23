package android.connecthings.com.tuto.notification;

import android.connecthings.adtag.analytics.model.AdtagLogData;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.adtag.beacon.model.welcomeNotification.BeaconWelcomeNotification;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {

    public static String FROM_NOTIFICATION = "com.connecthings.fromNotification";
    public static String FROM_NOTIFICATION_WELCOME="welcomeNotification";
    public static String FROM_NOTIFICATION_BEACON="beaconNotification";
    public static String BEACON_CONTENT = "com.connecthings.beaconContent";
    public static String BEACON_WELCOME = "com.connecthings.beaconWelcome";

    private BeaconContent beaconContent = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if( getIntent().getExtras() != null ){
            if( FROM_NOTIFICATION_BEACON.equals(getIntent().getExtras().getString(FROM_NOTIFICATION)) ) {
                ((TextView) findViewById(R.id.beacon_content)).setText(getString(R.string.beacon_notification));
                AdtagBeaconManager.getInstance().sendRedirectLog((BeaconContent)getIntent().getExtras().getParcelable(BEACON_CONTENT), AdtagLogData.REDIRECT_TYPE.NOTIFICATION, "NOTIFICATION");
            }else if( FROM_NOTIFICATION_WELCOME.equals(getIntent().getExtras().getString(FROM_NOTIFICATION)) ){
                ((TextView) findViewById(R.id.beacon_content)).setText(getString(R.string.beacon_notification_default));
                AdtagBeaconManager.getInstance().sendRedirectLog((BeaconWelcomeNotification) getIntent().getExtras().getParcelable(BEACON_WELCOME), "NOTIFICATION");
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
