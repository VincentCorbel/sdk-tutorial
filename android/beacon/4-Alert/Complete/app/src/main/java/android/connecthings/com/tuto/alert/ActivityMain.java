package android.connecthings.com.tuto.alert;

import android.connecthings.adtag.adtagEnum.FEED_STATUS;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.adtag.beacon.model.BeaconRange;
import android.connecthings.util.adtag.beacon.parser.AppleBeacon;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;

import org.altbeacon.beacon.Region;

import java.util.List;

public class ActivityMain extends AppCompatActivity implements BeaconRange, View.OnClickListener{

    private TextView tvBeaconAlert;
    private Button btnMore;
    private BeaconContent currentBeaconContent;
    private boolean isActionInProgress = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvBeaconAlert = (TextView) findViewById(R.id.tv_beacon_alert);
        btnMore = (Button) findViewById(R.id.btn_more);
        btnMore.setOnClickListener(this);
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
    public void onClick(View view) {
        Intent intent = new Intent(this, ActivityDetail.class);
        intent.putExtra(ActivityDetail.BEACON_CONTENT, currentBeaconContent);
        startActivity(intent);
    }

    @Override
    public void didRangeBeaconsInRegion(List<AppleBeacon> beacons, List<BeaconContent> beaconContents, Region region, BeaconContent.INFORMATION_STATUS informationStatus, FEED_STATUS feedStatus) {
        if(beaconContents.size()==0){
            tvBeaconAlert.setText(R.string.tv_waiting_no_beacon);
            isActionInProgress = false;
        }else if(!isActionInProgress){
            for (BeaconContent beaconContent : beaconContents) {
                //test if the beacon is ready to realize the action
                if (beaconContent.isReadyForAction()) {
                    //check the action associate with the beacon
                    //In this tutorial we manage only one action which is "popup"
                    if(beaconContent.getAction().equals("popup")){
                        tvBeaconAlert.setText(beaconContent.getAlertTitle());
                        btnMore.setVisibility(View.VISIBLE);
                        //Flag the beacon that an action is done
                        beaconContent.actionIsDone();
                        isActionInProgress = true;
                        currentBeaconContent = beaconContent;
                        return;
                    }
                }
            }
            tvBeaconAlert.setText(R.string.tv_waiting_no_beacon_action);
        }
    }

}
