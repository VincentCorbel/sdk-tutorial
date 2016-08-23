package android.connecthings.com.tuto.alert;

import android.connecthings.adtag.adtagEnum.FEED_STATUS;
import android.connecthings.adtag.model.sdk.BeaconAlertStrategyParameter;
import android.connecthings.adtag.model.sdk.BeaconContent;

import android.connecthings.com.tuto.alert.firstWay.TimeAlertStrategy;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;


import android.connecthings.util.adtag.beacon.strategy.Alert.Listener.BeaconAlertListener;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import android.widget.Button;
import android.widget.TextView;


public class ActivityMain extends AppCompatActivity implements BeaconAlertListener,View.OnClickListener{

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

    protected void onResume(){
        super.onResume();
        BLE_STATUS checkStatus = adtagBeaconManager.checkBleStatus();
        //Activate the bluetooth
        if(checkStatus == BLE_STATUS.DISABLED) {
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


    @Override
    public boolean createBeaconAlert(BeaconContent beaconContent) {

        currentBeaconContent = beaconContent;
        if(beaconContent.getAction().equals("popup")){
            tvBeaconAlert.setText(beaconContent.getAlertTitle());
            btnMore.setVisibility(View.VISIBLE);
            return true;
        }
        tvBeaconAlert.setText("No POPUP action for beacon");
        return false ;

    }

    @Override
    public boolean removeBeaconAlert(BeaconContent beaconContent, BeaconAlertStrategyParameter.BeaconRemoveStatus beaconRemoveStatus) {
        tvBeaconAlert.setText("Remove beacon alert action");

        btnMore.setVisibility(View.INVISIBLE);
        return true;
    }

    @Override
    public void onNetworkError(FEED_STATUS feed_status) {
        tvBeaconAlert.setText("Network connectivity problems");

    }
}
