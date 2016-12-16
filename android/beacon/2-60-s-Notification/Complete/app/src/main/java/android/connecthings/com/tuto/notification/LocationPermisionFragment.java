package android.connecthings.com.tuto.notification;

import android.Manifest;
import android.connecthings.adtag.adtagEnum.FEED_STATUS;
import android.connecthings.adtag.model.sdk.BeaconContent;
import android.connecthings.util.BLE_STATUS;
import android.connecthings.util.EasyIntent;
import android.connecthings.util.adtag.beacon.AdtagBeaconManager;
import android.connecthings.util.adtag.beacon.parser.AppleBeacon;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.connecthings.altbeacon.beacon.Region;

import java.util.List;

/**
 */
public class LocationPermisionFragment extends Fragment implements View.OnClickListener{

    private static final int PERMISSION_REQUEST_COARSE_LOCATION = 1;

    private TextView  tvLocationPermission;
    private Button btnLocationPermission;
    private AdtagBeaconManager adtagBeaconManager;
    private boolean locationPermissionIsDefinitivelyDenied;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_location, container, false);
        tvLocationPermission = (TextView) v.findViewById(R.id.tv_location_permission);
        btnLocationPermission = (Button) v.findViewById(R.id.btn_location);
        btnLocationPermission.setOnClickListener(this);
        adtagBeaconManager = AdtagBeaconManager.getInstance();
        return v;
    }


    public void onResume(){
        super.onResume();
        BLE_STATUS checkStatus = adtagBeaconManager.checkBleStatus();
        //Activate the bluetooth
        if(checkStatus == BLE_STATUS.DISABLED && adtagBeaconManager.isBleAccessAuthorize()) {
            adtagBeaconManager.enableBluetooth();
        }
        testLocationPermission();
    }

    @Override
    public void onClick(View v) {
        if (locationPermissionIsDefinitivelyDenied) {
            EasyIntent.openApplicationSettings(this.getActivity());
        } else {
            requestLocationPermission();
        }
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

    public void testToGrantBluetoothAccess(){
        if(!adtagBeaconManager.isBleAccessAuthorize()){
            //Authorize the SDK to use the bluetooth
            adtagBeaconManager.saveBleAccessAuthorize(true);
        }
    }


    private void testLocationPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M ) {
            boolean isPermissionGranted = getActivity().checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED;
            if (isPermissionGranted) {
                hideLocationTv();
                testToGrantBluetoothAccess();
            }else{
                onRequestLocationPermission();
            }
            //sends the log about the permission status to the Adtag platform
            adtagBeaconManager.sendLogLocationPermissionAccepted(isPermissionGranted);
        }else{
            testToGrantBluetoothAccess();
        }
    }

    private void requestLocationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (getActivity().checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
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
