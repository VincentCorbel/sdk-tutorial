package android.connecthings.com.tuto.permission;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.connecthings.adtag.adtagEnum.FEED_STATUS;
import com.connecthings.adtag.model.sdk.BeaconContent;
import com.connecthings.util.BLE_STATUS;
import com.connecthings.util.EasyIntent;
import com.connecthings.util.adtag.beacon.AdtagBeaconManager;
import com.connecthings.util.adtag.beacon.model.BeaconRange;
import com.connecthings.util.adtag.beacon.parser.AppleBeacon;

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
        testLocationPermission();
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


    private void testLocationPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M ) {
            boolean isPermissionGranted = checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED;
            if (isPermissionGranted) {
                hideLocationTv();
                switchToBeaconTv();
                testToGrantBluetoothAccess();
            }else{
                onRequestLocationPermission();
            }
            //sends the log about the permission status to the Adtag platform
            adtagBeaconManager.sendLogLocationPermissionAccepted(isPermissionGranted);
        }else{
            switchToBeaconTv();
            testToGrantBluetoothAccess();
        }
    }

    private void requestLocationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                //this method shows the permission dialog.
                //Note that the permission dialog won't be shown if the user denies the permission demand definitively
                requestPermissions(new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, PERMISSION_REQUEST_COARSE_LOCATION);
            }
        }
    }

    private void onRequestLocationPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M ) {
            if(shouldShowRequestPermissionRationale(Manifest.permission.ACCESS_COARSE_LOCATION)){
                //permission has been asked before and user denies it
                showLocationTv(R.string.tv_error_location_permission);
            }else{
                //permission has never been asked or has been asked and the user denies it definitively...
                requestLocationPermission();
                //show a message if never the user has denied it definitively
                locationPermissionIsDefinitivelyDenied = true;
                showLocationTv(R.string.tv_error_location_permission_definitive);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        if(requestCode == PERMISSION_REQUEST_COARSE_LOCATION){
            if (grantResults.length > 0){
                //Send log about the location permission
                boolean isPermissionGranted = grantResults[0] == PackageManager.PERMISSION_GRANTED;
                //sends the log about the permission status to the Adtag platform
                adtagBeaconManager.sendLogLocationPermissionAccepted(isPermissionGranted);
                if (isPermissionGranted) {
                    //the process goes on through the onResume method just after
                    //it's the onResume method through the call of testLocationPermission method that will launch the next action once the location permission is granted
                }else{
                    // permission was denied -> we ask it again
                    onRequestLocationPermission();
                }
            }else{
                // no result ? ask again the permission
                onRequestLocationPermission();
            }

        }
    }
}
