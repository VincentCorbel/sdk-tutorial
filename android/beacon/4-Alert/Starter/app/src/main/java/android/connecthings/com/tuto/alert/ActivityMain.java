package android.connecthings.com.tuto.alert;

import com.connecthings.adtag.adtagEnum.FEED_STATUS;
import com.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import com.connecthings.adtag.model.sdk.BeaconContent;

import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.strategy.alert.Listener.BeaconAlertListener;


import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import android.widget.Button;
import android.widget.TextView;


public class ActivityMain extends AppCompatActivity implements View.OnClickListener {

    private TextView tvBeaconAlert;
    private Button btnMore;
    private BeaconContent currentBeaconContent;

    private AdtagBeaconManager adtagBeaconManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvBeaconAlert = (TextView) findViewById(R.id.tv_beacon_alert);
        btnMore = (Button) findViewById(R.id.btn_more);
        btnMore.setOnClickListener(this);
        adtagBeaconManager = AdtagBeaconManager.getInstance();
    }

    protected void onResume() {
        super.onResume();
        BLE_STATUS checkStatus = adtagBeaconManager.checkBleStatus();
        //Activate the bluetooth
        if (checkStatus == BLE_STATUS.DISABLED) {
            if (adtagBeaconManager.isBleAccessAuthorize()) {
                adtagBeaconManager.enableBluetooth();
            }
        }
    }

    @Override
    public void onClick(View view) {
        Intent intent = new Intent(this, ActivityDetail.class);
        intent.putExtra(ActivityDetail.BEACON_CONTENT, currentBeaconContent);
        startActivity(intent);
    }


}
