package android.connecthings.com.tuto.permission;

import android.Manifest;
import com.connecthings.adtag.adtagEnum.FEED_STATUS;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.EasyIntent;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconRange;
import com.connecthings.util.adtag.beacon.parser.AppleBeacon;
import android.content.pm.PackageManager;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.connecthings.altbeacon.beacon.Region;

import java.util.List;

public class MainActivity extends AppCompatActivity implements BeaconRange, View.OnClickListener{

    private static final int PERMISSION_REQUEST_COARSE_LOCATION = 1;

    private TextView tvBeaconNumber, tvLocationPermission, tvBluetoothPermission;
    private Button btnLocationPermission, btnBluetoothPermission;
    private AdtagBeaconManager adtagBeaconManager;
    private boolean locationPermissionIsDefinitivelyDenied;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvBeaconNumber = (TextView) findViewById(R.id.tv_beacon_number);
        tvLocationPermission = (TextView) findViewById(R.id.tv_location_permission);
        tvBluetoothPermission = (TextView) findViewById(R.id.tv_bluetooth_permission);
        btnLocationPermission = (Button) findViewById(R.id.btn_location);
        btnBluetoothPermission = (Button) findViewById(R.id.btn_bluetooth);
        btnLocationPermission.setOnClickListener(this);
        btnBluetoothPermission.setOnClickListener(this);
        adtagBeaconManager = AdtagBeaconManager.getInstance();
        locationPermissionIsDefinitivelyDenied = false;
    }

    protected void onResume(){
        super.onResume();
        AdtagBeaconManager beaconManager = AdtagBeaconManager.getInstance();
        BLE_STATUS checkStatus = beaconManager.checkBleStatus();
        //Activate the bluetooth
        if(checkStatus == BLE_STATUS.DISABLED && beaconManager.isBleAccessAuthorize()) {
            beaconManager.enableBluetooth();
        }
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.btn_bluetooth){
            BleDialog.newInstance().show(getFragmentManager(), BleDialog.TAG);
        }else {
            if (locationPermissionIsDefinitivelyDenied) {
                EasyIntent.openApplicationSettings(this);
            } else {
                requestLocationPermission();
            }
        }
    }

    @Override
    public void didRangeBeacons(List<AppleBeacon> beacons, List<BeaconContent> beaconContents, BeaconContent.INFORMATION_STATUS informationStatus, FEED_STATUS feedStatus) {
        tvBeaconNumber.setText(getString(R.string.tv_beacon_number, feedStatus, beacons.size(), beaconContents.size()));
        if(beaconContents.size() > 0 && beaconContents.size() == beacons.size()){
            findViewById(R.id.tv_beacon_next_step).setVisibility(View.VISIBLE);
        }
    }

    public void showBluetoothTv(){
        btnBluetoothPermission.setVisibility(View.VISIBLE);
        tvBluetoothPermission.setVisibility(View.VISIBLE);
    }

    private void hideBluetoothTv(){
        btnBluetoothPermission.setVisibility(View.GONE);
        tvBluetoothPermission.setVisibility(View.GONE);
    }

    private void showLocationTv(int idString){
        btnLocationPermission.setVisibility(View.VISIBLE);
        tvLocationPermission.setVisibility(View.VISIBLE);
        tvLocationPermission.setText(idString);
    }

    private void hideLocationTv(){
        btnLocationPermission.setVisibility(View.GONE);
        tvLocationPermission.setVisibility(View.GONE);
    }


    private void switchToBeaconTv(){
        hideLocationTv();
        hideBluetoothTv();
        tvBeaconNumber.setVisibility(View.VISIBLE);
    }

    public void testToGrantBluetoothAccess(){
        if(!adtagBeaconManager.isBleAccessAuthorize()){
            //Authorize the SDK to use the bluetooth
            adtagBeaconManager.saveBleAccessAuthorize(true);
            switchToBeaconTv();
        }
    }

}
